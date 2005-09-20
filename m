Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVITHv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVITHv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVITHv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:51:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:674 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964907AbVITHv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:51:57 -0400
Date: Tue, 20 Sep 2005 09:51:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050920075133.GB4074@elf.ucw.cz>
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432E5024.20709@namesys.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> V3 is obsoleted by V4 in every way.  V3 is old code that should be
> marked as deprecated as soon as V4 has passed mass testing.   V4 is far
> superior in its coding style also.  Having V3 in and V4 out is at this
> point just stupid. 

Really? Last time I checked, even V3's fsck was not too great. [In
fact I never could make it run stable enough to even _test_ it
properly].

Do you have working fsck for V4? Until then, you should not claim that
users should switch. Journalling does not help you, if you have
unexpected kernel problem or hardware trouble, fsck _is_ mandatory.

Can V4 survive few hours of test below?
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
if you have sharp zaurus hardware you don't need... you know my address
