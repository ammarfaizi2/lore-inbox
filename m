Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUE0IJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUE0IJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 04:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUE0IJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 04:09:53 -0400
Received: from h013.c000.snv.cp.net ([209.228.32.77]:2462 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S261723AbUE0IJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 04:09:48 -0400
X-Sent: 27 May 2004 08:09:46 GMT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: nathans@sgi.com
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
From: dag@bakke.com
Subject: Re: xfsdump hangs - 2.6.6 && 2.6.7-rc1-bk3
X-Sent-From: dag@bakke.com
Date: Thu, 27 May 2004 01:09:46 -0700 (PDT)
X-Mailer: Web Mail 5.6.3-1
Message-Id: <20040527010946.9778.h018.c000.wm@mail.bakke.com.criticalpath.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One failure, one success, one question  :-)

On Thu, 27 May 2004 15:58:29 +1000, Nathan Scott wrote:

> 
> On Wed, May 26, 2004 at 09:13:14AM -0700, dag@bakke.com wrote:
> > 
> > I experience hangs with xfsdump, when dumping my rootfs to a USB 2.0
> > ...
> > http://thaifood.homeip.net/xfsdumphang/xfsdump.dmesg.txt 
> > ...
> 
> The xfsdump stack trace in there is the important one.
> Can you try this patch and let me know how it goes?
> 
> --- fs/xfs/linux/xfs_buf.c.orig	2004-05-27 14:06:59.992936144 +1000
> +++ fs/xfs/linux/xfs_buf.c	2004-05-27 14:08:21.548537808 +1000
> @@ -370,8 +370,12 @@
>  	      retry:
>  		page = find_or_create_page(mapping, first + i, gfp_mask);
>  		if (unlikely(page == NULL)) {
> -			if (flags & PBF_READ_AHEAD)
> +			if (flags & PBF_READ_AHEAD) {
> +				for (--i; i >= 0; i--)
> +					page_cache_release(bp->pb_pages[i]);
> +				_pagebuf_free_pages(bp);
>  				return -ENOMEM;
> +			}
>  
>  			/*
>  			 * This could deadlock.

xfsdump completes "successfully", but prematurely. And I get an oops.

Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c02381b3
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: 3c589_cs
CPU:    0
EIP:    0060:[<c02381b3>]    Not tainted
EFLAGS: 00010206   (2.6.7-rc1-bk3) 
EIP is at _pagebuf_lookup_pages+0x2b3/0x2e0
eax: ffffffff   ebx: 0000ffff   ecx: cba8db84   edx: 00000000
esi: cba8dac0   edi: 000389b4   ebp: 00002000   esp: cefa5cc8
ds: 007b   es: 007b   ss: 0068
Process xfsdump (pid: 5769, threadinfo=cefa4000 task=cf54b6f0)
Stack: cffa6afc 000389b4 00001200 00000000 cefa4000 00000000 00000000
000389b4 
       00000002 00001200 00000000 00001000 00000009 cffa6afc cba8dac0
cba8dac0 
       00019011 00000002 c023867b cba8dac0 00019011 00000000 00002000
00019011 
Call Trace:
 [<c023867b>] pagebuf_get+0x19b/0x1b0
 [<c01f05e1>] xfs_btree_reada_bufs+0x71/0x90
 [<c0217668>] xfs_bulkstat+0xd18/0x1000
 [<c023c43b>] xfs_ioc_bulkstat+0x10b/0x1f0
 [<c0216360>] xfs_bulkstat_one+0x0/0x5f0
 [<c023c0bd>] xfs_ioctl+0x68d/0x840
 [<c0105865>] setup_rt_frame+0x1b5/0x2d0
 [<c022f9f7>] xfs_inactive_free_eofblocks+0x107/0x2d0
 [<c01657e1>] dput+0x31/0x220
 [<c023acad>] linvfs_ioctl+0x3d/0x70
 [<c0105865>] setup_rt_frame+0x1b5/0x2d0
 [<c0105865>] setup_rt_frame+0x1b5/0x2d0
 [<c0160d60>] sys_ioctl+0x100/0x270
 [<c0105865>] setup_rt_frame+0x1b5/0x2d0
 [<c014e1d1>] sys_close+0x61/0xa0
 [<c0105d59>] sysenter_past_esp+0x52/0x71
 [<c0105865>] setup_rt_frame+0x1b5/0x2d0

Code: 8b 02 f6 c4 08 75 f0 8b 42 04 40 74 14 83 42 04 ff 0f 98 c0 
 
xfsrestore: restore complete: 403 seconds elapsed
xfsrestore: Restore Status: SUCCESS

Filesystem            Size  Used Avail Use% Mounted on
/dev/hda3             3.3G  2.0G  1.3G  62% /
/dev/scsi/host0/bus0/target0/lun0/part3
                      9.4G  562M  8.8G   6% /mnt/target



But: his patch from hch Works For Me:

--- 1.111/fs/xfs/linux/xfs_buf.c	2004-04-28 06:45:14 +02:00
+++ edited/fs/xfs/linux/xfs_buf.c	2004-05-26 18:58:14 +02:00
@@ -370,8 +370,12 @@
 	      retry:
 		page = find_or_create_page(mapping, first + i, gfp_mask);
 		if (unlikely(page == NULL)) {
-			if (flags & PBF_READ_AHEAD)
+			if (flags & PBF_READ_AHEAD) {
+				bp->pb_page_count = i;
+				for (i = 0; i < bp->pb_page_count; i++)
+					unlock_page(bp->pb_pages[i]);
 				return -ENOMEM;
+			}
 
 			/*
 			 * This could deadlock.


Tested two dumps now, and both completes successfully. And for real.
I have yet to boot on the new root fs, though. :-)

The one remaining question is: why does xfsrestore print
xfsrestore: WARNING: open_by_handle of mnt failed:Bad file descriptor
xfsrestore: WARNING: open_by_handle of bin failed:Bad file descriptor
xfsrestore: WARNING: open_by_handle of dev/rd failed:Bad file descriptor
xfsrestore: WARNING: open_by_handle of dev/ida failed:Bad file descriptor
xfsrestore: WARNING: open_by_handle of dev failed:Bad file descriptor
xfsrestore: WARNING: open_by_handle of sys failed:Bad file descriptor
xfsrestore: WARNING: open_by_handle of tftpboot failed:Bad file descriptor

etc. etc. for what appears to be every directory in the source fs? This
is at the end of the dump, just prior to the 

xfsrestore: restore complete: 403 seconds elapsed
xfsrestore: Restore Status: SUCCESS

message?
