Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVEPWfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVEPWfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVEPWd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:33:27 -0400
Received: from ultra7.eskimo.com ([204.122.16.70]:57861 "EHLO
	ultra7.eskimo.com") by vger.kernel.org with ESMTP id S261963AbVEPWc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:32:28 -0400
Date: Mon, 16 May 2005 15:30:58 -0700
From: Elladan <elladan@eskimo.com>
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
Cc: Valdis.Kletnieks@vt.edu, fs@ercist.iscas.ac.cn,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
Message-ID: <20050516223058.GG18792@eskimo.com>
References: <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu> <20050517.051113.132843723.okuyamak@dd.iij4u.or.jp> <200505162035.j4GKZVCc018357@turing-police.cc.vt.edu> <20050517.063931.91280786.okuyamak@dd.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517.063931.91280786.okuyamak@dd.iij4u.or.jp>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 06:39:31AM +0900, Kenichi Okuyama wrote:
> >>>>> "Valdis" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:
> 
> Valdis> Why?  If the disk disappeared out from under us because it was an unplugged USB
> Valdis> device, there's at least a possibility of it reappearing via hotplug - presumably
> Valdis> if you verify the UUID that it's the *same* file system, hotplug could do a
> Valdis> 'mount -o remount' and recover the situation....
> 
> I don't think that's good idea.
> 
> USB storage is gone. And it SEEMS to came back.
> But how do you know that it's images were not changed.
> 
> Blocks you have cached might have different image. If you remount
> the file system, the cache image should be updated as well.
> 
> But very fact that *cache image should be updated* means, old cache
> image was invalid. And when did it become invalid?

[...]
 
> You'll, at least, see that there is some inconsistency about cache
> handling when we *umount->mount* and *remount*.

This is basically the problem people have had with removable storage for
years...  You can't really solve it perfectly, since as you note one
could always place the storage in another machine and change it.

But I think it's instructive to note what most other systems have done
in this situation...  The solution seems similar in most cases, from eg.
Mac, Amiga, DOS, Windows, etc.

The typical solution is, when a removable device is yanked when dirty
blocks exist, is to keep the dirty blocks around, and put the device
into some sort of pending-reinsert state.

Then most systems typically display a large message to the user of the
form: "You idiot!  Put the disk/cd/flash/etc. back in!"

The cache and dirty blocks would then only be cleared on a user cancel.
If the same device (according to some ID test) reappears, then it's
reactivated and usage continues normally.

Obviously, this sort of approach requires some user interaction to get
right.  It has the distinct advantage of not throwing away the data the
user wrote after an inadvertant disconnect, for example if they thought
the device was done writing when it really wasn't.  It can also keep
from corrupting the FS metadata.

The downside is that it might not really work, if there wasn't a good
way to know when sectors actually are in stable storage, since a few
blocks could be lost around the time the device was pulled.

-J
