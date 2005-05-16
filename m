Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVEPVpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVEPVpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVEPVne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:43:34 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:53198 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261904AbVEPVjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:39:52 -0400
Date: Tue, 17 May 2005 06:39:31 +0900 (JST)
Message-Id: <20050517.063931.91280786.okuyamak@dd.iij4u.or.jp>
To: Valdis.Kletnieks@vt.edu
Cc: fs@ercist.iscas.ac.cn, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFD] What error should FS return when I/O failure occurs? 
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <200505162035.j4GKZVCc018357@turing-police.cc.vt.edu>
References: <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
	<20050517.051113.132843723.okuyamak@dd.iij4u.or.jp>
	<200505162035.j4GKZVCc018357@turing-police.cc.vt.edu>
X-Mailer: Mew version 4.0.65 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Valdis" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:

Valdis> On Tue, 17 May 2005 05:11:13 +0900, Kenichi Okuyama said:
>> According to QuFuPing's test, USB cable was UNPLUGGED. That means,
>> device is gone, and device driver instantly (well.. within second or
>> two) detected that fact.  How could ext3 mounted device that does
>> not exist, as Read Only?

Valdis> I thought we were talking about write requests - which were getting short-circuited
Valdis> because the file system was R/O before we even tried to talk to the actual
Valdis> file system.  No sense in queueing a write I/O when it's known to be R/O.

Wrong. Did you check what Qu have said?

1) USB storage exist as READ/WRITE mounted.
2) Then he unplugged USB cable, making USB storage unavailble.
3) EXT3 FS reported the error EROFS.

So, it is at the time somewhere between "after USB cable unplug" and
"write(2) return" that EXT3 remounted the file system as RO.
It was not RO from beginning.


Valdis> If you're trying to *read* from the now-absent disk and encounter a page
Valdis> that's not already in the cache, yes, you'll probably be returning an EIO.
>> I don't see the reason why cache is still available.
>> # I mean why such a implementation is valid.
>> 
>> If storage is known to be lost by device driver, we should not use
>> that cache anymore.

Valdis> Why?  If the disk disappeared out from under us because it was an unplugged USB
Valdis> device, there's at least a possibility of it reappearing via hotplug - presumably
Valdis> if you verify the UUID that it's the *same* file system, hotplug could do a
Valdis> 'mount -o remount' and recover the situation....

I don't think that's good idea.

USB storage is gone. And it SEEMS to came back.
But how do you know that it's images were not changed.

Blocks you have cached might have different image. If you remount
the file system, the cache image should be updated as well.

But very fact that *cache image should be updated* means, old cache
image was invalid. And when did it become invalid?

When it was gone.

Think about thing this way. There was USB storage and it's cached
image. Storage is somewhat gone. It never returned before reboot.
Was cache image valid after storage gone? Ofcourse not. That cache
is nothing more than old data which came from LOST, and NEVER COMING
BACK device.

If device did come back but with change, we must read the data from
storage again. Old cache image was useless, and was harmful.
If device did come back without change, we can read the data from
storage again.

No need to keep the cache image, taking risk of cache not being
valid, especially while you have no control over the storage.


By the way.

Try umount, and then mount it again manually for any device.  You'll
find all the cache images for that file system are gone.
If your assumption about cache is correct, why isn't this
umount/remount feature keeping the cache image?

You'll, at least, see that there is some inconsistency about cache
handling when we *umount->mount* and *remount*.

regards,
---- 
Kenichi OKuyama
