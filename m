Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWFOJvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWFOJvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWFOJvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:51:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49094 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932459AbWFOJvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:51:09 -0400
Date: Thu, 15 Jun 2006 11:50:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Jeff Garzik <jeff@garzik.org>, Matthew Frost <artusemrys@sbcglobal.net>,
       Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060615095008.GI9423@elf.ucw.cz>
References: <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060612220605.GD4950@ucw.cz> <986ed62e0606140731u4c42a2adv42c072bf270e4874@mail.gmail.com> <20060614213431.GF4950@ucw.cz> <986ed62e0606141728m6e5b6dbbw7cfb5bd4b82052c1@mail.gmail.com> <20060615091539.GF9423@elf.ucw.cz> <986ed62e0606150240t6f96b2baya52b9f0515da2e47@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606150240t6f96b2baya52b9f0515da2e47@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> >Passes 8 hours of me trying to intentionally break it with weird,
> >> >artifical disk corruption.
> >> >
> >> >I even have script somewhere.
> >>
> >> Ok, thanks for clarifying.
> >
> >You can get a copy, it would be interesting to know how JFS/XFS does.
> 
> Ok, I would be interested in getting a copy. (Maybe it would be good
> to post it in public so that other people can try it too.)

It needs some hand-tuning to do maximum damage to the filesystem, yet
keeping filesystem "recognizable". It also depends on fsck returning
reasonable error codes...
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
	mkfs.$FS test
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
	fsck.$FS -fy fsck.damaged
	RESULT=$?
	if [ $RESULT != 1 -a $RESULT != 2 -a $RESULT != 0 ]; then
		echo "Fsck failed in bad way (result = $RESULT)"
		exit
		fi
	echo Second check...
	fsck.$FS -fy fsck.damaged
	RESULT=$?
	if [ $RESULT != 0 ]; then
		echo "Fsck lied about its success (result = $RESULT)"
		exit
		fi
	done


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
