Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314775AbSDVVBh>; Mon, 22 Apr 2002 17:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314776AbSDVVBg>; Mon, 22 Apr 2002 17:01:36 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:12425 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314775AbSDVVBd>; Mon, 22 Apr 2002 17:01:33 -0400
Message-ID: <3CC47A27.4000803@us.ibm.com>
Date: Mon, 22 Apr 2002 14:01:27 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: locking in sync_old_buffers
Content-Type: multipart/mixed;
 boundary="------------030607030804060301020301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030607030804060301020301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

BKL hold times in sync_old_buffers aren't good.  This is one of the last 
places that we see millisecond-scale BKL hold times.
  0.09%  8.1% 4598us(9648us)  105us( 231us)(0.00%)        37 91.9%  8.1% 
    0%    sync_old_buffers+0x1c

So, I'll ask the eternal question that plagues us all, why is the BKL 
held here?  I saw some discussions referring to races prevented by BKL here:
http://groups.google.com/groups?selm=linux.kernel.Pine.GSO.4.21.0103212354420.2632-100000%40weyl.math.psu.edu&output=gplain
 From Al:
> Ehh... Linus, the main problem is in get_super(). Want a nice race?
> sys_ustat() vs. sys_umount(). The former does get_super(), finds
> struct super_block and does nothing to guarantee that it will stay.
> Then it calls ->statfs(). In the meanwhile, you umount the thing
> and do rmmod. Oops..

With the addition of sb_lock and refcounting on the sb, are these races 
still there?  sync_supers() and sync_unlocked_inodes() both hold sb_lock.

If we just remove the BKL from sync_old_buffers() the long hold time 
goes from BKL to sb_lock.  But, sb_lock is dropped and reacquired a few 
times in that code, so latency should be better than BKL.  BKL wouldn't 
have been released except in those places where it had to drop the locks 
and sleep.

Patch to do it is attached, but I'm not holding my breath.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------030607030804060301020301
Content-Type: text/plain;
 name="sync_old_buffers-remove_bkl-2.5.8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sync_old_buffers-remove_bkl-2.5.8.patch"

--- linux-2.5.8-clean/fs/buffer.c	Mon Apr 22 13:45:34 2002
+++ linux/fs/buffer.c	Mon Apr 22 13:45:49 2002
@@ -2612,10 +2612,8 @@
 
 static void sync_old_buffers(unsigned long dummy)
 {
-	lock_kernel();
 	sync_unlocked_inodes();
 	sync_supers();
-	unlock_kernel();
 
 	for (;;) {
 		struct buffer_head *bh;

--------------030607030804060301020301--

