Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271242AbRH1PB3>; Tue, 28 Aug 2001 11:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271283AbRH1PBK>; Tue, 28 Aug 2001 11:01:10 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:48575 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271278AbRH1PBE> convert rfc822-to-8bit; Tue, 28 Aug 2001 11:01:04 -0400
Date: Tue, 28 Aug 2001 16:02:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Christian Borntraeger <CBORNTRA@de.ibm.com>
cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: VM: Bad swap entry 0044cb00
In-Reply-To: <OFB30CAF04.8B81270C-ONC1256AB6.004C780A@de.ibm.com>
Message-ID: <Pine.LNX.4.21.0108281555500.990-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, Christian Borntraeger wrote:
> 
> I am also interested in getting this patch as I face the same problem on an
> S/390, but with Kernel 2.4.7
> It is a SMP machine.
> I don´t know, if you can get informations about this issue from non-intel
> platforms, but we should try.

Please try the (untested) patch below, which I hope will identify the
failing function, giving the return address back to its caller - please
mail me the message(s), and your System.map entries immediately before
and immediately after the "from" address reported.  Patch is based on
2.4.7, but should apply okay (at different offsets) to anything since.

Thanks,
Hugh

--- 247/mm/swapfile.c	Wed Jul  4 19:50:38 2001
+++ 247tmp/mm/swapfile.c	Tue Aug 28 15:37:26 2001
@@ -191,12 +191,12 @@
 	printk("swap_free: offset exceeds max\n");
 	goto out;
 bad_free:
-	printk("VM: Bad swap entry %08lx\n", entry.val);
+	printk("swap_free from %p: Bad swap entry %08lx\n", __builtin_return_address(0), entry.val);
 	goto out;
 bad_count:
 	swap_device_unlock(p);
 	swap_list_unlock();
-	printk(KERN_ERR "VM: Bad count %hd current count %hd\n", count, p->swap_map[offset]);
+	printk(KERN_ERR "swap_free: Bad count %hd current count %hd\n", count, p->swap_map[offset]);
 	goto out;
 }
 
@@ -867,7 +867,7 @@
 	else {
 		static int overflow = 0;
 		if (overflow++ < 5)
-			printk("VM: swap entry overflow\n");
+			printk("swap_dup: swap entry overflow\n");
 		p->swap_map[offset] = SWAP_MAP_MAX;
 	}
 	swap_device_unlock(p);
@@ -876,13 +876,13 @@
 	return result;
 
 bad_file:
-	printk("Bad swap file entry %08lx\n", entry.val);
+	printk("swap_dup: Bad swap file entry %08lx\n", entry.val);
 	goto out;
 bad_offset:
-	printk("Bad swap offset entry %08lx\n", entry.val);
+	printk("swap_dup: Bad swap offset entry %08lx\n", entry.val);
 	goto out;
 bad_unused:
-	printk("Unused swap offset entry in swap_dup %08lx\n", entry.val);
+	printk("swap_dup from %p: Unused swap offset entry %08lx\n", __builtin_return_address(0), entry.val);
 	goto out;
 }
 
@@ -917,13 +917,13 @@
 	printk(KERN_ERR "swap_count: null entry!\n");
 	goto out;
 bad_file:
-	printk("Bad swap file entry %08lx\n", entry.val);
+	printk("swap_count: Bad swap file entry %08lx\n", entry.val);
 	goto out;
 bad_offset:
-	printk("Bad swap offset entry %08lx\n", entry.val);
+	printk("swap_count: Bad swap offset entry %08lx\n", entry.val);
 	goto out;
 bad_unused:
-	printk("Unused swap offset entry in swap_count %08lx\n", entry.val);
+	printk("swap_count from %p: Unused swap offset entry in swap_count %08lx\n", __builtin_return_address(0), entry.val);
 	goto out;
 }
 
@@ -938,7 +938,7 @@
 
 	type = SWP_TYPE(entry);
 	if (type >= nr_swapfiles) {
-		printk("Internal error: bad swap-device\n");
+		printk("rw_swap_page: Internal error: bad swap-device\n");
 		return;
 	}
 
@@ -949,7 +949,7 @@
 		return;
 	}
 	if (p->swap_map && !p->swap_map[*offset]) {
-		printk("VM: Bad swap entry %08lx\n", entry.val);
+		printk("rw_swap_page from %p: Bad swap entry %08lx\n", __builtin_return_address(0), entry.val);
 		return;
 	}
 	if (!(p->flags & SWP_USED)) {

