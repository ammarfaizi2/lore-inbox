Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVEQV2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVEQV2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVEQV2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:28:20 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:27617 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261962AbVEQV1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:27:06 -0400
Date: Wed, 18 May 2005 06:26:40 +0900 (JST)
Message-Id: <20050518.062640.06257517.okuyamak@dd.iij4u.or.jp>
To: elladan@eskimo.com
Cc: Valdis.Kletnieks@vt.edu, fs@ercist.iscas.ac.cn,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <20050516223058.GG18792@eskimo.com>
References: <200505162035.j4GKZVCc018357@turing-police.cc.vt.edu>
	<20050517.063931.91280786.okuyamak@dd.iij4u.or.jp>
	<20050516223058.GG18792@eskimo.com>
X-Mailer: Mew version 4.0.65 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "J" == Elladan  <elladan@eskimo.com> writes:

J> On Tue, May 17, 2005 at 06:39:31AM +0900, Kenichi Okuyama wrote:
>> >>>>> "Valdis" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:
>> 
Valdis> Why?  If the disk disappeared out from under us because it was an unplugged USB
Valdis> device, there's at least a possibility of it reappearing via hotplug - presumably
Valdis> if you verify the UUID that it's the *same* file system, hotplug could do a
Valdis> 'mount -o remount' and recover the situation....
>> 
>> I don't think that's good idea.
>> 
>> USB storage is gone. And it SEEMS to came back.
>> But how do you know that it's images were not changed.
>> 
>> Blocks you have cached might have different image. If you remount
>> the file system, the cache image should be updated as well.
>> 
>> But very fact that *cache image should be updated* means, old cache
>> image was invalid. And when did it become invalid?

J> [...]
 
>> You'll, at least, see that there is some inconsistency about cache
>> handling when we *umount->mount* and *remount*.

J> This is basically the problem people have had with removable storage for
J> years...  You can't really solve it perfectly, since as you note one
J> could always place the storage in another machine and change it.

Unfortunately, this problem does happen even on case of
non-removable storage. HDD will break, and will ( accidentally ) be
removed from OS perspective. FS does not treat them differently.


In old days, HDD nor any device had a way to detect problem at all,
except for detecting timeout. THAT was the reason why old OS used to
use cache for read/write even after human detected HW failure.
They simply DID NOT KNOW about HW failure, and therefore
optimistically assumed cache image was still valid.

But look at USB case. If you look at /var/log/messages, you will
find USB device driver detecting your cable-unplug as soon as you
unplugged it.

File System should not ASSUME HW to be healthy without asking to
Device Driver about it. It is device driver who is responsible for
health check of HW, not FS.


J> But I think it's instructive to note what most other systems have done
J> in this situation...  The solution seems similar in most cases, from eg.
J> Mac, Amiga, DOS, Windows, etc.

I do agree about this.
Yes, everyone is crossing the street even signals are red.
In old days, there was excuse. Today, I don't beleive so.


J> The typical solution is, when a removable device is yanked when dirty
J> blocks exist, is to keep the dirty blocks around, and put the device
J> into some sort of pending-reinsert state.

You should not call "IMPLEMENTATION without CAREFUL THOUGHT" as SOLUTION.


OK. Let me say it this way.

If THIS is how Linux is implemented, it should be implemented like
so among ALL the FS, for application should not care about what FS
they are standing on.

That is, someone (Linus?) have to declare this as DESIGN of Linux.
Thing should not simply be implementation dependent.


Don't take me wrong. I'm saying Linux is great.
Because Linux is great, this new problem arised.


In legacy system, like *BSD, there was only one FS supported as for
local FS. Or at least for their major use.
# Though FreeBSD do support VFAT, you won't want to implement
# DB on top of VFAT. It must be UFS for this use.

Since only one FS was default local FS, how it is implemented was
also single. Hence, how it is implemented, was one and only way that
OS serves to you.


But in case of Linux, there are:
    EXT2, EXT3, JFS, XFS, ReiserFS
at LEAST for default local FS. There was no such OS like this.
And very fact that they are ALL default, means user will ask ALL of
these FS to react exactly the same for same HW failure, unless that
FS somehow have a way to recover in 100%, transparently.


There is no wonder why there is no standard about this. This is NEW
issue that no other OS really needed to face in past. It's not old
issue.

And That's the reason, I believe, that Qu Fuping arised this problem.


J> Then most systems typically display a large message to the user of the
J> form: "You idiot!  Put the disk/cd/flash/etc. back in!"

Like in Solaris 10, you mean.

I don't see the reason why this is good solution.  OS is giving up
the control over HW, and yet not stopping the service related to
that HW.  This is nothing more than risk.


Human action and software action are not of same scale speed.  I
mean, Human need several second (if not minute) before he can do a
thing, when he sees this message. On other hand, Application can ask
for, like 1000 requests within second.

If OS did not stop the service related to lost Storage immediately,
those several thousands of requests will be replied with result of
success. And at some point later, all of the sudden, they become
invalid.

I don't think this is RELIABLE service.  Rather, I will worry about
chance of security vulneability.


regards,
----
Kenichi Okuyama
