Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSGLTuZ>; Fri, 12 Jul 2002 15:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316824AbSGLTuY>; Fri, 12 Jul 2002 15:50:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11014 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316822AbSGLTuU>;
	Fri, 12 Jul 2002 15:50:20 -0400
Message-ID: <3D2F3331.376FB6D2@zip.com.au>
Date: Fri, 12 Jul 2002 12:51:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+ext3@arm.linux.org.uk>
CC: Alec Smith <alec@shadowstar.net>, linux-kernel@vger.kernel.org,
       ext3-users@redhat.com, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ext3 corruption
References: <Pine.LNX.4.44.0207121127001.7507-100000@bugs.home.shadowstar.net> <20020712165233.B10576@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Jul 12, 2002 at 11:32:44AM -0400, Alec Smith wrote:
> > Over the last month or so, I've noticed the following error showing up
> > repeatedly in my system logs under kernel 2.4.18-ac3 and more recently
> > under 2.4.19-rc1:
> >
> > EXT3-fs error (device ide0(3,3)) in ext3_new_inode: error 28
> 
> Erm, that looks like the old "out of inodes, return -ENOSPC and mark the
> filesystem read only" bug I found several months ago.  iirc, there have
> been 3 recent issues (in the last three months) that I'm aware of:
> 
> 1. running out of free blocks.
> 2. running out of free inodes.
> 3. i_nlink accounting goofup.
> 
> I've got patches from akpm for (1) and (3), but not (2).  I'd be nice to
> have all three solved for 2.4.19.

Whoa.  Thanks for the reminder.  Fixed in 2.5, fixed in ext3
CVS, forgotten in Linux.

Marcelo, please.  The patch makes ext3 return -ENOSPC when it
runs out of inodes rather than remounting the fs readonly
or forcing a panic.


--- 2.4.19-rc1/fs/ext3/ialloc.c~ext3-ialloc	Fri Jul 12 12:47:58 2002
+++ 2.4.19-rc1-akpm/fs/ext3/ialloc.c	Fri Jul 12 12:48:06 2002
@@ -392,7 +392,7 @@ repeat:
 
 	err = -ENOSPC;
 	if (!gdp)
-		goto fail;
+		goto out;
 
 	err = -EIO;
 	bitmap_nr = load_inode_bitmap (sb, i);
@@ -523,9 +523,10 @@ repeat:
 	return inode;
 
 fail:
+	ext3_std_error(sb, err);
+out:
 	unlock_super(sb);
 	iput(inode);
-	ext3_std_error(sb, err);
 	return ERR_PTR(err);
 }
 

-
