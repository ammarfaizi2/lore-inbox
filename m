Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283303AbRLDTwW>; Tue, 4 Dec 2001 14:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283393AbRLDTvJ>; Tue, 4 Dec 2001 14:51:09 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:34729 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S283381AbRLDTua>; Tue, 4 Dec 2001 14:50:30 -0500
Message-ID: <3C0D2843.5060708@antefacto.com>
Date: Tue, 04 Dec 2001 19:47:15 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Roy S.C. Ho" <scho1208@yahoo.com>, david@gibson.dropbear.id.au,
        tachino@open.nm.fujitsu.co.jp
CC: linux-kernel@vger.kernel.org
Subject: Re: question about kernel 2.4 ramdisk
In-Reply-To: <20011204190109.68826.qmail@web21101.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wrt the ramfs leak (the referenced patch below worked for me),
is the ramfs usage limits patch + this fix going into
the official 2.4 soon as it was in the ac series for ages?

thanks,
Padraig.

-------- Original Message --------
Subject: Re: ramfs leak
Date: Mon, 12 Nov 2001 11:47:41 +0900
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: wcm@catnap.com (W Christopher Martin)
CC: linux-kernel@vger.kernel.org, padraig@antefacto.com (Padraig Brady)

Hello,

At Fri, 9 Nov 2001 15:40:43 -0500 (EST),
W Christopher Martin wrote:
 >
 > Padraig Brady writes:
 > > When I remove files from a ramfs the space is not reclaimed?
 > > What am I doing wrong? Details below.
 >
 > Nothing.  We've noticed the same thing.  It's a bug and was
 > first reported back in July, but no one has provided a fix yet.
 > I've had a brief look at the source code, but nothing obvious
 > pops out at me.

I think you should use tmpfs instead of ramfs, but if you really want to 
use ramfs,
the patch below may fix the problem.

diff -Nur linux-2.4.13-ac7.org/fs/ramfs/inode.c 
linux-2.4.13-ac7/fs/ramfs/inode.c
--- linux-2.4.13-ac7.org/fs/ramfs/inode.c	Mon Nov 12 11:00:47 2001
+++ linux-2.4.13-ac7/fs/ramfs/inode.c	Mon Nov 12 11:26:40 2001
@@ -182,12 +182,9 @@
  {
  	struct ramfs_sb_info *rsb = RAMFS_SB(inode->i_sb);

- 
if (! Page_Uptodate(page))
- 
	return;
-
  	lock_rsb(rsb);
-
- 
ClearPageDirty(page);
+ 
if (Page_Uptodate(page))
+ 
	ClearPageDirty(page);
  	
  	rsb->free_pages++;
  	inode->i_blocks -= IBLOCKS_PER_PAGE;

Roy S.C. Ho wrote:

> Hi, I am using linux kernel 2.4.2 and I have 1 GB ram.
> I tried to boot the system with a ramdisk size of
> 600MB. It was ok when I did "mke2fs" on it, but when I
> mounted it, it failed (Magic number mismatch). I tried
> this several times and found that all ramdisk sizes
> larger than 513MB could cause trouble. Could anyone
> please kindly give me some hints? I would like to have
> a larger ramdisk (around 800MB).
> 
> (note: I tried ramfs but it seems to have memory
> leakage when files are deleted and created frequently;
> tmpfs is ok, but the pages may be swapped, which is
> not desirable in my case...)


does the patch attached fix your problem with ramfs?

 
> Thank you very much!
> 
> Regards,
> Roy


