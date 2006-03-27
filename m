Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWC0Rnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWC0Rnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWC0Rnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:43:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751041AbWC0Rni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:43:38 -0500
Date: Mon, 27 Mar 2006 09:43:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: Douglas Gilbert <dougg@torque.net>, Bodo Eggert <7eggert@gmx.de>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
In-Reply-To: <20060327172530.GH3486@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0603270936290.15714@g5.osdl.org>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
 <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org> <4427FEC9.4010803@torque.net>
 <Pine.LNX.4.64.0603270854570.15714@g5.osdl.org> <20060327172530.GH3486@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Mar 2006, Matthew Wilcox wrote:
> > compare against. What you should compare against is
> > 
> > 	/dev/cdrom
> > 	/sys/bus/ide/devices/0.0/block:hda/dev
> > 	/dev/uuid/3d9e6e8dfaa3d116
> > 	..
> > 
> > and a million OTHER ways to specify which device you're interested in.
> > 
> > The fact is, they can potentially all do the SCSI command set. And a "SCSI 
> > ID" makes absolutely zero sense for them (those three devices may be the 
> > same device, they may not be, they might be on another machine, who 
> > knows..)
> 
> If this ioctl is generally supported, then you'll be able to find out if
> they're all the same ;-)

Sorry, but no. You didn't read the other example in my email.

Many (most) Linux devices will actually have 0:0:0:0 in that field. 
Because the SCSI ID simply doesn't make sense to them, and they have none. 
So it's _not_ a unique ID.

For example, look at linux/block/scsi_ioctl.c, and realize that because I 
wanted to make sure that you could run "cdrecord dev=/dev/hdc", it does a 
few ioctl's that cdrecord wanted. In particular, it does 
SCSI_IOCTL_GET_IDLUN and SCSI_IOCTL_GET_BUS_NUMBER. Take a look at what it 
actually returns, and how it explicitly does NOT try to claim that those 
numbers "mean" anything.

The fact is, BUS/ID/LUN crap really doesn't make sense for the majority of 
devices out there. Never has, never will. The fact that old-fashioned SCSI 
devices think of themselves that way has absolutely zero to do with 
reality today.

If you want to know whether two devices are the same or not, you should do 
a "stat()" on the device node, and look at "st->rdev". No, it's not in any 
way guaranteed either, but it's actually a hell of a better rule than 
looking at ID/LUN information.

Trying to make more people use UUID's is the way to _really_ distinguish 
devices from each other.

			Linus
