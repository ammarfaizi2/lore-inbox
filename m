Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVHOVsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVHOVsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVHOVsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:48:24 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:44467 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964990AbVHOVsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:48:23 -0400
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: rc6 keeps hanging and blanking displays where rc4-mm1 works fine.
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
	<20050805104025.GA14688@aitel.hist.no>
	<21d7e99705080503515e3045d5@mail.gmail.com>
	<42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no>
	<Pine.LNX.4.58.0508120937140.3295@g5.osdl.org>
	<43008C9C.60806@aitel.hist.no>
	<Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
	<Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
	<20050815174555.GA16842@aitel.hist.no>
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Date: 15 Aug 2005 22:48:21 +0100
In-Reply-To: <20050815174555.GA16842@aitel.hist.no>
Message-ID: <r6wtmm98ii.fsf@skye.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is there any way to make git tell exactly where between rc4 and rc5
>> each kernel is, so I can name the bzimages accordingly?
>
> You'd have to use the raw commit names, since these things don't have any 
> symbolic names. You can get that by just doing
> 
> 	cat .git/HEAD

Also, don't name the local version something like
2.6.13-rc6:e63b6d5ac1e17d0d9e5112bd9c0e5f17199b23da otherwise LILO
complains.  For example, this bit in lilo.conf

image=/boot/vmlinuz-2.6.12:b5e43913cfe95a18ad8929585a0bb58e46cf3390
        label=bisect1

produces when you run lilo:

  :BIOS syntax is no longer supported. Please use a DISK section
  Fatal: Not a number: "b5e43913cfe95a18ad8929585a0bb58e46cf3390"

So in my kernel tree used for bisections, 'localversion' contains

-b5e43913cfe95a18ad8929585a0bb58e46cf3390

I don't fully understand when git (doing the checkout that is implict
in git bisect) will overwrite or not overwrite local files, or when it
will create files not in a previous version, or delete files not in a
current version.  So, to be sure I'm getting a clean compile from
exactly the source files I want (probably overkill), I use 'git
bisect' to get the SHA1 id's, and then do:

#!/bin/bash
sha1=`cat .git/HEAD`
dest="/usr/src/bisect/$sha1"
cg-export $dest $sha1
cp dot-config-to-test $dest/.config
cd $dest
echo "-$sha1" > localversion
# accept defaults for all new config options:
yes "" | make oldconfig
make -j 4 >& compile.log &
