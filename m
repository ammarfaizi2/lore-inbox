Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUAYXi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbUAYXi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:38:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:14469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265314AbUAYXi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:38:27 -0500
Date: Sun, 25 Jan 2004 15:38:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bart Samwel <bart@samwel.tk>
Cc: felix-kernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-Id: <20040125153803.4d7e1015.akpm@osdl.org>
In-Reply-To: <4014516D.5070409@samwel.tk>
References: <20040124181026.GA22100@codeblau.de>
	<20040124153551.24e74f63.akpm@osdl.org>
	<40144A36.5090709@samwel.tk>
	<20040125150914.1583d487.akpm@osdl.org>
	<4014516D.5070409@samwel.tk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel <bart@samwel.tk> wrote:
>
> > 
> > Linux caches disk data on a per-file basis.  So if you preload pagecache
> > via the /dev/hda1 "file", that is of no benefit to the /etc/passwd file. 
> > Each one has its own unique pagecache.  When reading pages for /etc/passwd
> > we don't go looking for the same disk blocks in the cache of /dev/hda1.
> > 
> > Which is why the userspace cache preloading needs to know the pathnames of
> > all the relevant files - it needs to open and read each one, applying
> > knowledge of disk layout while doing it.
> 
> Hmmm, that explains why this didn't work. :( So if I wanted to do this 
> completely from user space using only block_dump data I'd probably have 
> to go through all files and find out if they had any blocks in common 
> with my preload set -- presuming there is a way to find that out, which 
> there probably isn't. That  makes this idea pretty much useless, I'm 
> sorry to have bothered you with it.
> 

You could certainly do that.  Given disk block #N you need to search all
files on the disk asking "who owns this block".  The FIBMAP ioctl can be
used on most filesystems (ext2, ext3, others..) to find out which blocks a
file is using.   See bmap.c in

http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

Unfortunately you cannot determine a directory's blocks in this way. 
Ext3's directories live in the /dev/hda1 pagecache anyway.  ext2's
directories each have their own pagecache.

