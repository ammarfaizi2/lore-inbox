Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbRCCDT5>; Fri, 2 Mar 2001 22:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130253AbRCCDTh>; Fri, 2 Mar 2001 22:19:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30480 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130241AbRCCDTZ>;
	Fri, 2 Mar 2001 22:19:25 -0500
Date: Sat, 3 Mar 2001 04:19:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Mario Hermann <ario@eikon.tum.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: report bug: System reboots when accessing a loop-device over a second loop-device with 2.4.2-ac7
Message-ID: <20010303041922.C1535@suse.de>
In-Reply-To: <3A9E66BB.70FB0C75@eikon.tum.de> <20010301172145.T21518@suse.de> <3A9FADAB.F37E5449@eikon.tum.de> <20010302162824.H408@suse.de> <3A9FDD80.FD075386@eikon.tum.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <3A9FDD80.FD075386@eikon.tum.de>; from ario@eikon.tum.de on Fri, Mar 02, 2001 at 06:50:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 02 2001, Mario Hermann wrote:
> But with old 2.2 - Material stored on DVD-RAM. 
> 
>   losetup -e blowfish /dev/loop0 /dev/sr3
>   lsoetup -e serpent /dev/loop1 /dev/loop0
> 
> it doesn't work.

(replied to Mario earlier, for reference here's the patch).

Yet another miscount and IV off, I apparently missed the latter
when the other IV calculations were fixed. I've verified block
crypto here now.

-- 
Jens Axboe


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=loop-ac10-1

--- /opt/kernel/linux-2.4.2-ac10/drivers/block/loop.c	Sat Mar  3 04:16:23 2001
+++ drivers/block/loop.c	Sat Mar  3 04:18:54 2001
@@ -345,8 +345,6 @@
 		struct buffer_head *rbh = bh->b_private;
 
 		rbh->b_end_io(rbh, uptodate);
-		if (atomic_dec_and_test(&lo->lo_pending))
-			up(&lo->lo_bh_mutex);
 		loop_put_buffer(bh);
 	} else
 		loop_add_bh(lo, bh);
@@ -479,6 +477,7 @@
 
 		IV = (bh->b_rsector / (bh->b_size >> 9));
 		IV += lo->lo_offset / bh->b_size;
+		IV >>= 2;
 
 		ret = lo_do_transfer(lo, READ, bh->b_data, rbh->b_data,
 				     bh->b_size, IV);

--eAbsdosE1cNLO4uF--
