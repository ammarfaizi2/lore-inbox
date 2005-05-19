Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVESPpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVESPpL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVESPpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:45:11 -0400
Received: from ultra7.eskimo.com ([204.122.16.70]:43537 "EHLO
	ultra7.eskimo.com") by vger.kernel.org with ESMTP id S262518AbVESPoz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:44:55 -0400
Date: Thu, 19 May 2005 08:44:38 -0700
From: Elladan <elladan@eskimo.com>
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
Cc: elladan@eskimo.com, Valdis.Kletnieks@vt.edu, fs@ercist.iscas.ac.cn,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
Message-ID: <20050519154438.GG7537@eskimo.com>
References: <200505162035.j4GKZVCc018357@turing-police.cc.vt.edu> <20050517.063931.91280786.okuyamak@dd.iij4u.or.jp> <20050516223058.GG18792@eskimo.com> <20050518.062640.06257517.okuyamak@dd.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518.062640.06257517.okuyamak@dd.iij4u.or.jp>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 06:26:40AM +0900, Kenichi Okuyama wrote:
> >>>>> "J" == Elladan  <elladan@eskimo.com> writes:
> 
> J> This is basically the problem people have had with removable storage for
> J> years...  You can't really solve it perfectly, since as you note one
> J> could always place the storage in another machine and change it.
> 
> Unfortunately, this problem does happen even on case of
> non-removable storage. HDD will break, and will ( accidentally ) be
> removed from OS perspective. FS does not treat them differently.
> 
> In old days, HDD nor any device had a way to detect problem at all,
> except for detecting timeout. THAT was the reason why old OS used to
> use cache for read/write even after human detected HW failure.
> They simply DID NOT KNOW about HW failure, and therefore
> optimistically assumed cache image was still valid.
> 
> But look at USB case. If you look at /var/log/messages, you will
> find USB device driver detecting your cable-unplug as soon as you
> unplugged it.
> 
> File System should not ASSUME HW to be healthy without asking to
> Device Driver about it. It is device driver who is responsible for
> health check of HW, not FS.

This isn't an issue that can be fixed perfectly.  If you just pull a USB
device out, data damage is likely.  However, if the device isn't
modified before re-inserting, attempting to finish the write will often
work fine.

Other OS's, even older ones, typically do have a near-immediate
notification that the device has gone away.  For example, old floppy
disk based systems such as the Amiga may have had manual eject, but they
did have the capability to detect floppy disk presence.  Yelling at the
user is a way to (possibly) complete the IO and prevent FS corruption.
Sometimes it works, sometimes it doesn't.  If you hold the last few
seconds of IO in memory as well as the remaining dirty buffers, the
probability of avoiding corruption (provided the device wasn't placed in
another machine) is fairly good.

You're right though, other than possibly having some start/stop support,
this does not need much FS support.  It's a driver and UI issue for the
most part.

To implement some of the fancier versions of this, such as being able to
pull out a floppy, place a different one in a drive, and have two apps
using two floppies at once (as some systems have implemented) this would
require placing a volume manager on top of the device driver as well,
and implementing this sort of logic in there.  The problem there is that
the volume manager needs to understand the disk label well enough to
identify a particular device.

-J
