Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbULPUyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbULPUyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbULPUyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:54:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27110 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262012AbULPUyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:54:46 -0500
Subject: Re: recovering data from a corrupt ext3?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Stromberg <strombrg@dcs.nac.uci.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <pan.2004.12.16.18.20.43.438752@dcs.nac.uci.edu>
References: <pan.2004.12.16.18.20.43.438752@dcs.nac.uci.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103226657.21806.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 19:50:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 18:20, Dan Stromberg wrote:
> 1) Is there a better tool for ext3 data recovery?

You can use e2fsdebug to poke around a bit and to follow inodes. You
might want to start lower down the stack however and check the LVM
claims to be the right size for the file system and any partition data
looks right.

> 2) If there isn't, is there a document that provides an overview of the
> ext3 on-disk filesystem structure, so that I might write a tool for doing
> the recovery?  (I wrote one once for the atari 800 floppy disk filesystem).

This is the stuff e2fsdebug essentially knows about - ext3 is ext2 with
journal so both are very similar.

> 1) What kind of alignment assumptions can I make about the various data
> structures?  EG, if I can assume that a bunch of directory entries always
> start on a 512 byte boundary, that'll speed up directory entry hunting
> considerably.

Superblocks give you all the basic layout information. The disk is split
into cylinder groups which in turn are split into inode and data zones.
Lookups are essentially

	directory entry -> inode number -> inode block

	inode block -> data (first few blocks direct, next indirected once,
then twice ..)


The superblocks will at least be disk block aligned so a good starting
point might be to find the superblocks on the disk itself without LVM in
the way. That should tell you the start/end/layout of the fs and you may
even be able to then pull those blocks into a file and loopback mount
the copy

