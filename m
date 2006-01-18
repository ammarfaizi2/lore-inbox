Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWARMzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWARMzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWARMzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:55:04 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:18364 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932516AbWARMzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:55:03 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: "'Andrew Morton'" <akpm@osdl.org>,
       "'Andreas Dilger'" <adilger@clusterfs.com>,
       <trond.myklebust@fys.uio.no>
Cc: <torvalds@osdl.org>, <viro@zeniv.linux.org.uk>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 2/3] Fix problems on multi-TB filesystem and file
Date: Wed, 18 Jan 2006 21:54:36 +0900
Message-ID: <000101c61c2e$59230b20$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20060113131947.05ee9ffc.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > On the other hand, for a fairly fat .config which has 17 filesystems in
> > > .vmlinux:
> > >
> > >    text    data     bss     dec     hex filename
> > > 4633032 1011304  248288 5892624  59ea10 vmlinux		CONFIG_LSF=y
> > > 4633680 1011304  248288 5893272  59ec98 vmlinux		CONFIG_LSF=n
> > >
> > > It's probably less 0.5 kbytes for usual embedded .config.
> > > I just don't think the benefit of CONFIG_LSF outweighs its costs.

I looked into the number of struct inode on slab of x86
in cases i_blocks is both 4 bytes and 8 bytes.
As the following tables, the number of inodes per slab is the same
in both cases.  So at least on x86, there seems to be no influence for
the memory usage by extending inode->i_blocks.

In default configuration (CONFIG_QUOTA=ON, CONFIG_INOTIFY=ON):
-------------------------------------------------------------
In case inode->i_blocks is unsigned long
                size of inode(byte)     the number per slab
ext2_inode_info        588                       6
ext3_inode_info        612                       6

In case inode->i_blocks is unsigned long long
                size of inode(byte)    the number per slab
ext2_inode_info        592                       6
ext3_inode_info        616                       6
--------------------------------------------------------------

CONFIG_QUOTA=OFF, CONFIG_INOTIFY=OFF:
-------------------------------------------------------------
In case inode->i_blocks is unsigned long
                size of inode(byte)    the number per slab
ext2_inode_info             540                  7
ext3_inode_info             564                  7

In case inode->i_blocks is unsigned long long
                size of inode(byte)    the number per slab
ext2_inode_info             544                  7
ext3_inode_info             568                  7
--------------------------------------------------------------

> > Two options exist IMHO:
> > - remove the new CONFIG_* parameters and stick with CONFIG_LBD (this could
> >   still use a separate type from sector_t if desired) to reduce the amount
> >   of testing combinations needed
> > - make the new CONFIG_* default to on and allow it to be disabled with
> >   CONFIG_BASE_SMALL
>
> Well yes, but we still have the printk problem.
>
> CONFIG_LFS would become a specialised option for embedded systems and
> for the minority of people who self-compile kernels.  I just don't
> think that's worth the maintainability hassle.

I added CONFIG_LSF to use large filesystem over network with >2TB file
even on a small system as CONFIG_LBD disable.  And I heard that some
people dislike network filesystems depending on block device.

Trond, do you have comments about integrating CONFIG_LFS and
CONFIG_LBD?

-- Takashi Sato


