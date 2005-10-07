Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVJGKq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVJGKq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 06:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVJGKq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 06:46:59 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:38528 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751157AbVJGKq6 (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 7 Oct 2005 06:46:58 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17222.18470.744354.727641@gargle.gargle.HOWL>
Date: Fri, 7 Oct 2005 14:04:22 +0400
To: Block Device <blockdevice@gmail.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: Block I/O Mystery
Newsgroups: gmane.linux.kernel
In-Reply-To: <64c763540510062301v2ac65a47p953038b8b674cf1d@mail.gmail.com>
References: <64c763540510062301v2ac65a47p953038b8b674cf1d@mail.gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Block Device writes:
 > Hi,
 >     I am trying to write to inode blocks without using the VFS layer
 > (filp_open, f_op->write)
 >     etc.
 >     I could use __bread to read the inode blocks correctly. But when I'm
 >     trying to write a block after changing it I face a strange problem.
 >     My changes do not show up when I cat the file but if I use dd command on
 >    the block device it shows my writes.
 > 
 >    Steps I performed :
 > 

Blocks read by bread() and friends are cached in block device (not you
:-) struct address_space. File data are cached in the per-inode struct
address_space.

 >    a) Created a file of 8K ( 2blocks ) and filled it with 'a'.

Now 2 pages are cached in memory in address_space associated with inode.

 >    b) Read the blocks using __bread and print(k)ed the contents.
 >        This worked correctly.

This reads blocks directly from the disk (igrnoing cached copy), and
caches them in block device address_space.

 >    c) Called __getblk for a file block, locked the buffer, made
 > changes to it (memcpy),
 >        marked buffer dirty, unlocked it and called sync_dirty_buffer.

This makes changes to the block cached in block device address_space.

 >    d) If I try to see contents of the file ( cat or vi ) they are
 > shown unchanged, but if I

vi uses read(1), and, hence, will fetch data from inode address_space,
where original pages still live.

 >        use dd on the raw device or use step b) to read a block the
 > changes made @ c)
 >       are seen.

And this will read from block device cache.

 > 
 >  Also, if I unmount the filesystem and mount it again the changes are
 > visible through cat, vi etc.
 > 
 > Can someone explain what exactly is going wrong ?

You are bypassing normal file sysetm caching and results can be
unpredictable.

 > 
 > I'm using the 2.6.13 kernel.
 > 
 > Thanks & Regards
 > -BD

Nikita.
