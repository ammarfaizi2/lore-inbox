Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVF2Sha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVF2Sha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVF2Sh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:37:29 -0400
Received: from station-6.events.itd.umich.edu ([141.211.252.135]:11447 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262415AbVF2Sg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:36:57 -0400
Date: Wed, 29 Jun 2005 18:36:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, David Masover <ninja@slaphack.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050629163639.GC13336@elf.ucw.cz>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB7B32.4010100@slaphack.com> <20050624124943.GA75817@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624124943.GA75817@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I was able to recover from bad blocks, though of course no Reiser that I
> > know of has had bad block relocation built in...  But I got all my files
> > off of it, fortunately.
> 
> My experience shows that you've been very, very lucky.  I hope r4 is
> better in that regard.
> 
> If you want to try with r3, take a well-used partition[1] and copy it
> at block level to another partition or a file.  Then zero some random
> spans of blocks in the copy and reiserfsck --rebuild-tree it.  My
> experience is that you'll usually get the files names and directory
> tree but their contents will have been scattered all over the place.

Actually it would be nice to have a script to automate this, and test
various filesystems for robustness :-). I done something similar, and
it uncovered few bugs in ext2fsck and vfatfsck; perhaps it is time to
try it on other filesystems, too?
								Pavel

#!/bin/bash
#
# fscktest
#
# Usage: 
#	 Make sure output is logged somewhere
#        First, run fscktest -p as root
#	 Then you can run fscktest as normal user...
#

prepare() {
	SIZE=100000
	echo "Creating file..."
	cat /dev/zero | head -c $[$SIZE*1024] > test
	echo "Making filesystem..."
	/sbin/mkfs.$FS test
	echo "Mounting..."
	mount test -o loop /mnt || exit "Cant mount"
	echo "Copying files..."
	cp -a /bin /mnt
	cp -a /usr/bin /mnt
	cp -a /usr/src/linux /mnt
	echo "Syncing..."
	sync
	echo "Unmounting..."
	umount /mnt
	echo "Moving..."
	mv test fsck.okay
	echo "All done."
}

FS=ext2
if [ .$1 == .-p ]; then
	prepare
	exit
	fi
RUN=0
while true; do
	RUN=$[$RUN+1]
	echo "Run #$RUN"
	echo Preparing...
	cat fsck.okay > fsck.damaged
	echo Damaging...
	dd if=/dev/urandom of=fsck.damaged count=10240 seek=7 conv=notrunc
	cp fsck.damaged fsck.test
	echo First check...
	/sbin/fsck.$FS -fy fsck.damaged
	RESULT=$?
	if [ $RESULT != 1 -a $RESULT != 2 -a $RESULT != 0 ]; then
		echo "Fsck failed in bad way (result = $RESULT)"
		exit
		fi
	echo Second check...
	/sbin/fsck.$FS -fy fsck.damaged
	RESULT=$?
	if [ $RESULT != 0 ]; then
		echo "Fsck lied about its success (result = $RESULT)"
		exit
		fi
	done

-- 
teflon -- maybe it is a trademark, but it should not be.
