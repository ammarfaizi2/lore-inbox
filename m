Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132057AbQK3J6O>; Thu, 30 Nov 2000 04:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132120AbQK3J6E>; Thu, 30 Nov 2000 04:58:04 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:54288 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S132057AbQK3J54>; Thu, 30 Nov 2000 04:57:56 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>, V Ganesh <ganesh@veritas.com>
Date: Thu, 30 Nov 2000 20:24:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14886.7367.247491.267120@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-LVM@EZ-Darmstadt.Telekom.de,
        mingo@redhat.com
Subject: [PATCH] Re: [bug] infinite loop in generic_make_request()
In-Reply-To: message from V Ganesh on Thursday November 30
In-Reply-To: <200011300702.MAA26287@vxindia.veritas.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 30, ganesh@veritas.com wrote:
> [cc'ed to maintainers of md and lvm]
> 
> hi,
> in generic_make_request(), the following code handles stacking:
> 
> do {
>        q = blk_get_queue(bh->b_rdev);
>        if (!q) {
>                         printk(...)
>                         buffer_IO_error(bh);
>                         break;
>        }
> } while (q->make_request_fn(q, rw, bh));
> 
> however, make_request_fn may return -1 in case of errors. one such fn is
> raid0_make_request(). this causes generic_make_request() to loop endlessly.
> lvm returns 1 unconditionally, so it would also loop if an error occured in
> lvm_map(). other bdevs might have the same problem.
> I think a better mechanism would be to mandate that make_request_fn ought
> to call bh->b_end_io() in case of errors and return 0.
> 
> ganesh

Good catch, thanks.  Below is a patch to fix md drivers (md.c,
linear.c and raid0.c).

NeilBrown



--- ./drivers/md/md.c	2000/11/30 08:23:51	1.2
+++ ./drivers/md/md.c	2000/11/30 09:20:05	1.3
@@ -179,7 +179,7 @@
 		return mddev->pers->make_request(mddev, rw, bh);
 	else {
 		buffer_IO_error(bh);
-		return -1;
+		return 0;
 	}
 }
 
--- ./drivers/md/linear.c	2000/11/30 08:23:51	1.2
+++ ./drivers/md/linear.c	2000/11/30 09:20:05	1.3
@@ -136,7 +136,8 @@
 		if (!hash->dev1) {
 			printk ("linear_make_request : hash->dev1==NULL for block %ld\n",
 						block);
-			return -1;
+			buffer_IO_error(bh);
+			return 0;
 		}
 		tmp_dev = hash->dev1;
 	} else
@@ -145,7 +146,8 @@
 	if (block >= (tmp_dev->size + tmp_dev->offset)
 				|| block < tmp_dev->offset) {
 		printk ("linear_make_request: Block %ld out of bounds on dev %s size %ld offset %ld\n", block, kdevname(tmp_dev->dev), tmp_dev->size, tmp_dev->offset);
-		return -1;
+		buffer_IO_error(bh);
+		return 0;
 	}
 	bh->b_rdev = tmp_dev->dev;
 	bh->b_rsector = bh->b_rsector - (tmp_dev->offset << 1);
--- ./drivers/md/raid0.c	2000/11/30 08:23:51	1.2
+++ ./drivers/md/raid0.c	2000/11/30 09:20:05	1.3
@@ -275,16 +275,18 @@
 
 bad_map:
 	printk ("raid0_make_request bug: can't convert block across chunks or bigger than %dk %ld %d\n", chunk_size, bh->b_rsector, bh->b_size >> 10);
-	return -1;
+	goto outerr;
 bad_hash:
 	printk("raid0_make_request bug: hash==NULL for block %ld\n", block);
-	return -1;
+	goto outerr;
 bad_zone0:
 	printk ("raid0_make_request bug: hash->zone0==NULL for block %ld\n", block);
-	return -1;
+	goto outerr;
 bad_zone1:
 	printk ("raid0_make_request bug: hash->zone1==NULL for block %ld\n", block);
-	return -1;
+ outerr:
+	buffer_IO_error(bh);
+	return 0;
 }
 			   
 static int raid0_status (char *page, mddev_t *mddev)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
