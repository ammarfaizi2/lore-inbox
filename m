Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135257AbRDRTPx>; Wed, 18 Apr 2001 15:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135261AbRDRTPq>; Wed, 18 Apr 2001 15:15:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11411 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135257AbRDRTPe>;
	Wed, 18 Apr 2001 15:15:34 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15069.59324.464040.192327@pizda.ninka.net>
Date: Wed, 18 Apr 2001 12:15:08 -0700 (PDT)
To: Rik van Riel <riel@conectiva.com.br>
Cc: Laurent Chavet <lchavet@av.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Very bad behavior of kswapd
In-Reply-To: <Pine.LNX.4.33.0104181551290.17635-100000@duckman.distro.conectiva>
In-Reply-To: <3ADD64DD.5D8428BA@av.com>
	<Pine.LNX.4.33.0104181551290.17635-100000@duckman.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel writes:
 > > Watch top: when this program needs the memory that kswapd keep
 > > in cache they go both at 100% cpu (on SMP) but still the size of
 > > the program only grows at about 100KB/s, why is kswapd releasing
 > > it so slowly and taking so much CPU ?
 > 
 > Because kswapd still has to scan all the (unfreeable) memory
 > of the big process to determine it isn't freeable.

This is not the only badly performing case actually.  When one of ones
swap partitions gets close to full, kswapd basically sits endlessly in
get_swap_page() due to all the broken linear scan algorithms.  I've
tried to fix some of this with the patch below.

This may not be the case Laurent is seeing but it is a problem that
needs fixing.

--- ../vanilla/linux/include/linux/swap.h	Fri Apr 13 17:08:16 2001
+++ include/linux/swap.h	Sat Apr 14 00:10:02 2001
@@ -43,8 +43,22 @@
 
 #define SWAP_CLUSTER_MAX 32
 
-#define SWAP_MAP_MAX	0x7fff
-#define SWAP_MAP_BAD	0x8000
+#define SWAPFILE_CLUSTER 256
+
+struct swap_cluster_struct {
+	struct list_head	list;
+	int			nr_free;	/* 0 --> SWAPFILE_CLUSTER */
+	unsigned int		start_offset;
+};
+
+#define SWAP_MAP_MAX	0x7fffffff
+#define SWAP_MAP_BAD	0x80000000
+
+struct swap_map_struct {
+	struct list_head	list;
+	unsigned int		offset;
+	unsigned int		count;
+};
 
 struct swap_info_struct {
 	unsigned int flags;
@@ -52,11 +66,15 @@
 	spinlock_t sdev_lock;
 	struct dentry * swap_file;
 	struct vfsmount *swap_vfsmnt;
-	unsigned short * swap_map;
-	unsigned int lowest_bit;
-	unsigned int highest_bit;
-	unsigned int cluster_next;
-	unsigned int cluster_nr;
+	struct swap_map_struct * swap_maps;
+	struct list_head swap_map_free_list;
+
+	struct swap_cluster_struct * swap_clusters;
+	struct list_head swap_cluster_free_list;
+
+	struct swap_cluster_struct * curr_cluster;
+	unsigned int cluster_offset_next;
+
 	int prio;			/* swap priority */
 	int pages;
 	unsigned long max;
--- ../vanilla/linux/mm/swapfile.c	Thu Mar 22 09:22:15 2001
+++ mm/swapfile.c	Sat Apr 14 01:07:40 2001
@@ -24,62 +24,60 @@
 
 struct swap_info_struct swap_info[MAX_SWAPFILES];
 
-#define SWAPFILE_CLUSTER 256
-
-static inline int scan_swap_map(struct swap_info_struct *si, unsigned short count)
+static unsigned int scan_swap_map(struct swap_info_struct *si, unsigned int count)
 {
-	unsigned long offset;
-	/* 
-	 * We try to cluster swap pages by allocating them
-	 * sequentially in swap.  Once we've allocated
-	 * SWAPFILE_CLUSTER pages this way, however, we resort to
-	 * first-free allocation, starting a new cluster.  This
-	 * prevents us from scattering swap pages all over the entire
-	 * swap partition, so that we reduce overall disk seek times
-	 * between swap pages.  -- sct */
-	if (si->cluster_nr) {
-		while (si->cluster_next <= si->highest_bit) {
-			offset = si->cluster_next++;
-			if (si->swap_map[offset])
-				continue;
-			si->cluster_nr--;
-			goto got_page;
-		}
-	}
-	si->cluster_nr = SWAPFILE_CLUSTER;
+	struct swap_map_struct *map;
+	struct list_head *head, *tmp;
 
-	/* try to find an empty (even not aligned) cluster. */
-	offset = si->lowest_bit;
- check_next_cluster:
-	if (offset+SWAPFILE_CLUSTER-1 <= si->highest_bit)
-	{
-		int nr;
-		for (nr = offset; nr < offset+SWAPFILE_CLUSTER; nr++)
-			if (si->swap_map[nr])
-			{
-				offset = nr+1;
-				goto check_next_cluster;
-			}
-		/* We found a completly empty cluster, so start
-		 * using it.
+	/* Any swap entries left at all? */
+	if (list_empty(&si->swap_map_free_list))
+		return 0;
+
+get_from_cluster:
+
+	/* Currently allocating from a cluster? */
+	if (si->curr_cluster != NULL) {
+		struct swap_cluster_struct *cluster = si->curr_cluster;
+		unsigned int offset = si->cluster_offset_next;
+
+		/* Note that this test cannot be made with cluster->nr_free
+		 * because it is possible for a swap entry to be freed before
+		 * we are done allocating from this cluster.
 		 */
-		goto got_page;
+		if (si->cluster_offset_next++ == SWAPFILE_CLUSTER)
+			si->curr_cluster = NULL;
+
+		cluster->nr_free--;
+
+		map = &si->swap_maps[offset];
+		goto finish_alloc;
 	}
-	/* No luck, so now go finegrined as usual. -Andrea */
-	for (offset = si->lowest_bit; offset <= si->highest_bit ; offset++) {
-		if (si->swap_map[offset])
-			continue;
-	got_page:
-		if (offset == si->lowest_bit)
-			si->lowest_bit++;
-		if (offset == si->highest_bit)
-			si->highest_bit--;
-		si->swap_map[offset] = count;
-		nr_swap_pages--;
-		si->cluster_next = offset+1;
-		return offset;
+
+	/* Can we start a new cluster? */
+	head = &si->swap_cluster_free_list;
+	if (!list_empty(head)) {
+		struct swap_cluster_struct *cluster;
+
+		tmp = head->next;
+		cluster = list_entry(tmp, struct swap_cluster_struct, list);
+		list_del(tmp);
+		si->cluster_offset_next = cluster->start_offset;
+		si->curr_cluster = cluster;
+		goto get_from_cluster;
 	}
-	return 0;
+
+	/* Fragmented, no clusters, get individual entry. */
+	head = &si->swap_map_free_list;
+	tmp = head->next;
+	map = list_entry(tmp, struct swap_map_struct, list);
+	si->swap_clusters[map->offset / SWAPFILE_CLUSTER].nr_free--;
+
+finish_alloc:
+
+	list_del(&map->list);
+	map->count = count;
+	nr_swap_pages--;
+	return map->offset;
 }
 
 swp_entry_t __get_swap_page(unsigned short count)
@@ -145,6 +143,7 @@
 void __swap_free(swp_entry_t entry, unsigned short count)
 {
 	struct swap_info_struct * p;
+	struct swap_map_struct * map;
 	unsigned long offset, type;
 
 	if (!entry.val)
@@ -159,21 +158,37 @@
 	offset = SWP_OFFSET(entry);
 	if (offset >= p->max)
 		goto bad_offset;
-	if (!p->swap_map[offset])
+	map = p->swap_maps + offset;
+
+	if (!map->count)
 		goto bad_free;
 	swap_list_lock();
 	if (p->prio > swap_info[swap_list.next].prio)
 		swap_list.next = type;
 	swap_device_lock(p);
-	if (p->swap_map[offset] < SWAP_MAP_MAX) {
-		if (p->swap_map[offset] < count)
+	if (map->count < SWAP_MAP_MAX) {
+		if (map->count < count)
 			goto bad_count;
-		if (!(p->swap_map[offset] -= count)) {
-			if (offset < p->lowest_bit)
-				p->lowest_bit = offset;
-			if (offset > p->highest_bit)
-				p->highest_bit = offset;
+		if (!(map->count -= count)) {
+			unsigned int clust_nr = offset / SWAPFILE_CLUSTER;
+			struct swap_cluster_struct *cluster;
+
+			/* Add to tail so that clusters are more likely to
+			 * build up.
+			 */
+			list_add_tail(&map->list, &p->swap_map_free_list);
 			nr_swap_pages++;
+
+			cluster = p->swap_clusters + clust_nr;
+			if (cluster->nr_free++ == SWAPFILE_CLUSTER) {
+				if (p->curr_cluster == cluster)
+					BUG();
+
+				list_add(&cluster->list,
+					 &p->swap_cluster_free_list);
+			}
+			if (cluster->nr_free > SWAPFILE_CLUSTER)
+				BUG();
 		}
 	}
 	swap_device_unlock(p);
@@ -196,7 +211,8 @@
 bad_count:
 	swap_device_unlock(p);
 	swap_list_unlock();
-	printk(KERN_ERR "VM: Bad count %hd current count %hd\n", count, p->swap_map[offset]);
+	printk(KERN_ERR "VM: Bad count %hd current count %hd\n", count,
+	       p->swap_maps[offset].count);
 	goto out;
 }
 
@@ -347,15 +363,16 @@
 		 */
 		swap_device_lock(si);
 		for (i = 1; i < si->max ; i++) {
-			if (si->swap_map[i] > 0 && si->swap_map[i] != SWAP_MAP_BAD) {
+			if (si->swap_maps[i].count > 0 &&
+			    si->swap_maps[i].count != SWAP_MAP_BAD) {
 				/*
 				 * Prevent swaphandle from being completely
 				 * unused by swap_free while we are trying
 				 * to read in the page - this prevents warning
 				 * messages from rw_swap_page_base.
 				 */
-				if (si->swap_map[i] != SWAP_MAP_MAX)
-					si->swap_map[i]++;
+				if (si->swap_maps[i].count != SWAP_MAP_MAX)
+					si->swap_maps[i].count++;
 				swap_device_unlock(si);
 				goto found_entry;
 			}
@@ -390,12 +407,28 @@
 		swap_free(entry);
 		swap_list_lock();
 		swap_device_lock(si);
-		if (si->swap_map[i] > 0) {
-			if (si->swap_map[i] != SWAP_MAP_MAX)
+		if (si->swap_maps[i].count > 0) {
+			unsigned int clust_nr = i / SWAPFILE_CLUSTER;
+			struct swap_cluster_struct *cluster;
+
+			if (si->swap_maps[i].count != SWAP_MAP_MAX)
 				printk("VM: Undead swap entry %08lx\n", 
-								entry.val);
+				       entry.val);
 			nr_swap_pages++;
-			si->swap_map[i] = 0;
+			list_add_tail(&si->swap_maps[i].list, &si->swap_map_free_list);
+			si->swap_maps[i].count = 0;
+
+			/* Keep the cluster state sane just in case
+			 * swap_off fails.
+			 */
+			cluster = si->swap_clusters + clust_nr;
+			if (cluster->nr_free++ == SWAPFILE_CLUSTER) {
+				if (si->curr_cluster == cluster)
+					BUG();
+
+				list_add(&cluster->list,
+					 &si->swap_cluster_free_list);
+			}
 		}
 		swap_device_unlock(si);
 		swap_list_unlock();
@@ -478,8 +511,13 @@
 	nd.mnt = p->swap_vfsmnt;
 	p->swap_vfsmnt = NULL;
 	p->swap_device = 0;
-	vfree(p->swap_map);
-	p->swap_map = NULL;
+	vfree(p->swap_maps);
+	p->swap_maps = NULL;
+	INIT_LIST_HEAD(&p->swap_map_free_list);
+	vfree(p->swap_clusters);
+	p->swap_clusters = NULL;
+	INIT_LIST_HEAD(&p->swap_cluster_free_list);
+	p->curr_cluster = NULL;
 	p->flags = 0;
 	err = 0;
 
@@ -514,7 +552,7 @@
 
 			usedswap = 0;
 			for (j = 0; j < ptr->max; ++j)
-				switch (ptr->swap_map[j]) {
+				switch (ptr->swap_maps[j].count) {
 					case SWAP_MAP_BAD:
 					case 0:
 						continue;
@@ -578,10 +616,11 @@
 	p->swap_file = NULL;
 	p->swap_vfsmnt = NULL;
 	p->swap_device = 0;
-	p->swap_map = NULL;
-	p->lowest_bit = 0;
-	p->highest_bit = 0;
-	p->cluster_nr = 0;
+	p->swap_maps = NULL;
+	INIT_LIST_HEAD(&p->swap_map_free_list);
+	p->swap_clusters = NULL;
+	INIT_LIST_HEAD(&p->swap_cluster_free_list);
+	p->curr_cluster = NULL;
 	p->sdev_lock = SPIN_LOCK_UNLOCKED;
 	p->max = 1;
 	p->next = -1;
@@ -666,28 +705,28 @@
 	case 1:
 		memset(((char *) swap_header)+PAGE_SIZE-10,0,10);
 		j = 0;
-		p->lowest_bit = 0;
-		p->highest_bit = 0;
 		for (i = 1 ; i < 8*PAGE_SIZE ; i++) {
 			if (test_bit(i,(char *) swap_header)) {
-				if (!p->lowest_bit)
-					p->lowest_bit = i;
-				p->highest_bit = i;
 				p->max = i+1;
 				j++;
 			}
 		}
 		nr_good_pages = j;
-		p->swap_map = vmalloc(p->max * sizeof(short));
-		if (!p->swap_map) {
+		p->swap_maps = vmalloc(p->max * sizeof(struct swap_map_struct));
+		if (!p->swap_maps) {
 			error = -ENOMEM;		
 			goto bad_swap;
 		}
 		for (i = 1 ; i < p->max ; i++) {
-			if (test_bit(i,(char *) swap_header))
-				p->swap_map[i] = 0;
-			else
-				p->swap_map[i] = SWAP_MAP_BAD;
+			p->swap_maps[i].offset = i;
+			INIT_LIST_HEAD(&p->swap_maps[i].list);
+			if (test_bit(i,(char *) swap_header)) {
+				p->swap_maps[i].count = 0;
+				list_add_tail(&p->swap_maps[i].list,
+					      &p->swap_map_free_list);
+			} else {
+				p->swap_maps[i].count = SWAP_MAP_BAD;
+			}
 		}
 		break;
 
@@ -702,8 +741,6 @@
 			goto bad_swap;
 		}
 
-		p->lowest_bit  = 1;
-		p->highest_bit = swap_header->info.last_page - 1;
 		p->max	       = swap_header->info.last_page;
 
 		maxpages = SWP_OFFSET(SWP_ENTRY(0,~0UL));
@@ -715,19 +752,27 @@
 			goto bad_swap;
 		
 		/* OK, set up the swap map and apply the bad block list */
-		if (!(p->swap_map = vmalloc (p->max * sizeof(short)))) {
+		if (!(p->swap_maps = vmalloc (p->max * sizeof(struct swap_map_struct)))) {
 			error = -ENOMEM;
 			goto bad_swap;
 		}
 
 		error = 0;
-		memset(p->swap_map, 0, p->max * sizeof(short));
+		for (i = 0; i < p->max; i++) {
+			INIT_LIST_HEAD(&p->swap_maps[i].list);
+			p->swap_maps[i].offset = i;
+			p->swap_maps[i].count = 0;
+			list_add_tail(&p->swap_maps[i].list,
+				      &p->swap_map_free_list);
+		}
 		for (i=0; i<swap_header->info.nr_badpages; i++) {
 			int page = swap_header->info.badpages[i];
-			if (page <= 0 || page >= swap_header->info.last_page)
+			if (page <= 0 || page >= swap_header->info.last_page) {
 				error = -EINVAL;
-			else
-				p->swap_map[page] = SWAP_MAP_BAD;
+			} else {
+				p->swap_maps[page].count = SWAP_MAP_BAD;
+				list_del(&p->swap_maps[page].list);
+			}
 		}
 		nr_good_pages = swap_header->info.last_page -
 				swap_header->info.nr_badpages -
@@ -736,6 +781,34 @@
 			goto bad_swap;
 	}
 	
+	p->swap_clusters = vmalloc((p->max / SWAPFILE_CLUSTER)
+				   * sizeof(struct swap_cluster_struct));
+	if (!p->swap_clusters) {
+		error = -ENOMEM;
+		goto bad_swap;
+	}
+	for (i = 0; i < (p->max / SWAPFILE_CLUSTER); i++) {
+		INIT_LIST_HEAD(&p->swap_clusters[i].list);
+		p->swap_clusters[i].nr_free = 0;
+		p->swap_clusters[i].start_offset = (i * SWAPFILE_CLUSTER);
+	}
+
+	/* Swap entry zero can never be allocated, therefore
+	 * swap cluster zero can never be either.
+	 */
+	for (i = 1; i < p->max; i++) {
+		int cluster = i / SWAPFILE_CLUSTER;
+
+		if (p->swap_maps[i].count != SWAP_MAP_BAD) {
+			if (p->swap_clusters[cluster].nr_free++ == SWAPFILE_CLUSTER)
+				list_add(&p->swap_clusters[cluster].list,
+					 &p->swap_cluster_free_list);
+
+			if (p->swap_clusters[cluster].nr_free > SWAPFILE_CLUSTER)
+				BUG();
+		}
+	}
+
 	if (swapfilesize && p->max > swapfilesize) {
 		printk(KERN_WARNING
 		       "Swap area shorter than signature indicates\n");
@@ -747,7 +820,8 @@
 		error = -EINVAL;
 		goto bad_swap;
 	}
-	p->swap_map[0] = SWAP_MAP_BAD;
+	p->swap_maps[0].count = SWAP_MAP_BAD;
+	list_del(&p->swap_maps[0].list);
 	p->flags = SWP_WRITEOK;
 	p->pages = nr_good_pages;
 	swap_list_lock();
@@ -776,14 +850,22 @@
 	if (bdev)
 		blkdev_put(bdev, BDEV_SWAP);
 bad_swap_2:
-	if (p->swap_map)
-		vfree(p->swap_map);
+	if (p->swap_maps) {
+		vfree(p->swap_maps);
+		p->swap_maps = NULL;
+		INIT_LIST_HEAD(&p->swap_map_free_list);
+	}
+	if (p->swap_clusters) {
+		vfree(p->swap_clusters);
+		p->swap_clusters = NULL;
+		INIT_LIST_HEAD(&p->swap_cluster_free_list);
+		p->curr_cluster = NULL;
+	}
 	nd.mnt = p->swap_vfsmnt;
 	nd.dentry = p->swap_file;
 	p->swap_device = 0;
 	p->swap_file = NULL;
 	p->swap_vfsmnt = NULL;
-	p->swap_map = NULL;
 	p->flags = 0;
 	if (!(swap_flags & SWAP_FLAG_PREFER))
 		++least_priority;
@@ -806,7 +888,7 @@
 		if ((swap_info[i].flags & SWP_WRITEOK) != SWP_WRITEOK)
 			continue;
 		for (j = 0; j < swap_info[i].max; ++j) {
-			switch (swap_info[i].swap_map[j]) {
+			switch (swap_info[i].swap_maps[j].count) {
 				case SWAP_MAP_BAD:
 					continue;
 				case 0:
@@ -825,7 +907,7 @@
  * Verify that a swap entry is valid and increment its swap map count.
  * Kernel_lock is held, which guarantees existance of swap device.
  *
- * Note: if swap_map[] reaches SWAP_MAP_MAX the entries are treated as
+ * Note: if swap_maps[].count reaches SWAP_MAP_MAX the entries are treated as
  * "permanent", but will be reclaimed by the next swapoff.
  */
 int swap_duplicate(swp_entry_t entry)
@@ -844,19 +926,19 @@
 	offset = SWP_OFFSET(entry);
 	if (offset >= p->max)
 		goto bad_offset;
-	if (!p->swap_map[offset])
+	if (!p->swap_maps[offset].count)
 		goto bad_unused;
 	/*
 	 * Entry is valid, so increment the map count.
 	 */
 	swap_device_lock(p);
-	if (p->swap_map[offset] < SWAP_MAP_MAX)
-		p->swap_map[offset]++;
+	if (p->swap_maps[offset].count < SWAP_MAP_MAX)
+		p->swap_maps[offset].count++;
 	else {
 		static int overflow = 0;
 		if (overflow++ < 5)
 			printk("VM: swap entry overflow\n");
-		p->swap_map[offset] = SWAP_MAP_MAX;
+		p->swap_maps[offset].count = SWAP_MAP_MAX;
 	}
 	swap_device_unlock(p);
 	result = 1;
@@ -895,9 +977,9 @@
 	offset = SWP_OFFSET(entry);
 	if (offset >= p->max)
 		goto bad_offset;
-	if (!p->swap_map[offset])
+	if (!p->swap_maps[offset].count)
 		goto bad_unused;
-	retval = p->swap_map[offset];
+	retval = p->swap_maps[offset].count;
 out:
 	return retval;
 
@@ -936,7 +1018,7 @@
 		printk("rw_swap_page: weirdness\n");
 		return;
 	}
-	if (p->swap_map && !p->swap_map[*offset]) {
+	if (p->swap_maps && !p->swap_maps[*offset].count) {
 		printk("VM: Bad swap entry %08lx\n", entry.val);
 		return;
 	}
@@ -975,11 +1057,11 @@
 		if (toff >= swapdev->max)
 			break;
 		/* Don't read in bad or busy pages */
-		if (!swapdev->swap_map[toff])
+		if (!swapdev->swap_maps[toff].count)
 			break;
-		if (swapdev->swap_map[toff] == SWAP_MAP_BAD)
+		if (swapdev->swap_maps[toff].count == SWAP_MAP_BAD)
 			break;
-		swapdev->swap_map[toff]++;
+		swapdev->swap_maps[toff].count++;
 		toff++;
 		ret++;
 	} while (--i);
