Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVEPUQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVEPUQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEPUQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:16:22 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:17602 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261850AbVEPULi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:11:38 -0400
Date: Tue, 17 May 2005 05:11:13 +0900 (JST)
Message-Id: <20050517.051113.132843723.okuyamak@dd.iij4u.or.jp>
To: Valdis.Kletnieks@vt.edu
Cc: fs@ercist.iscas.ac.cn, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFD] What error should FS return when I/O failure occurs? 
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
References: <1116263665.2434.69.camel@CoolQ>
	<200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
X-Mailer: Mew version 4.0.65 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Valdis,

>>>>> "VK" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:
>> 1. For EXT3 partition , we mount it as RW, but when I/O occurs, the
>> I/O related functions return EROFS(ReadOnly?), while other FSes
>> return EIO.
VK> Only the request that actually caused the I/O error (and thus causing the
VK> system to re-mount the ext3 partition R/O) should get EIO. EROFS is
VK> the proper error for subsequent requests - because they're being rejected
VK> because the filesystem is R/O.

I don't see your point.

According to QuFuPing's test, USB cable was UNPLUGGED. That means,
device is gone, and device driver instantly (well.. within second or
two) detected that fact.  How could ext3 mounted device that does
not exist, as Read Only?



>> 2. Assume a program doing the following: open - write(async) - close
>> When user-mode app calls sys_write, for EXT2/JFS, no error 
>> returns, for EXT3, EROFS returns, for XFS/ReiserFS, EIO returns.
VK> Remember that the request that actually hits an error could be from a
VK> process that isn't even in existence anymore, if the page has been sitting
VK> in the cache for a while and we're finally sending it to disk.

I don't see the reason why cache is still available.
# I mean why such a implementation is valid.

If storage is known to be lost by device driver, we should not use
that cache anymore.


Think about what the cached data means.

Cache image is the data image which original data exist in some
device. Image on memory can be used as cache because consistency is
managed by device driver.

If device no longer exist within reach of OS, device driver will not
be able to manage the consistency between cache image and what
device really have. Hence, if device driver lost control over
device somehow, CACHE IMAGE SHOULD BECOME INVALID.


So, even for asynchronous IO, or read, or open, or close which only
may require cached image, IF DEVICE DRIVER HAVE ALREADY DETECTED THE
HW FAIURE ( please keep in mind that I did not add case which device
driver did not detcted HW failure yet. I think this is important to
meet the ASYNC requirement ), system should invalidate the cache
image related to that storage before hand. That means, even for
asynchronous IO request, file system should, at least, ask device
driver if they have ALREADY detectED any HW failure.
# And that means, device driver should have such interface.

Since device driver have already detected HW failure, whether you
really will cause IO or not doesn't matter, EIO should be the
correct return of error for this case.

EXT3 should never succeed in remounting lost device as Read Only.

regards,
---- 
Kenichi Okuyama
