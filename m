Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVEPWzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVEPWzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVEPWzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:55:21 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:449 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261958AbVEPWyb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:54:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qHAnr/CyFa572jBZI2FeIefaxY3a+jIcZtuEjvlmGBVfgF/aamdf3uAjqbUq8NxeOvSi8YDFMwEO2Xvfq0dpECyqSTbfX39pbkSdWmZJKDXEmxkgY40L9M9LKHKIeqJAAWJJ64KLNAdYJEaMr7gVbjTZJNXPHoeWUrVj4hr06Vs=
Message-ID: <2cd57c90050516155413b18b41@mail.gmail.com>
Date: Tue, 17 May 2005 06:54:28 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
Cc: Valdis.Kletnieks@vt.edu, fs@ercist.iscas.ac.cn,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20050517.051113.132843723.okuyamak@dd.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1116263665.2434.69.camel@CoolQ>
	 <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
	 <20050517.051113.132843723.okuyamak@dd.iij4u.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/05, Kenichi Okuyama <okuyamak@dd.iij4u.or.jp> wrote:
> Dear Valdis,
> 
> >>>>> "VK" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:
> >> 1. For EXT3 partition , we mount it as RW, but when I/O occurs, the
> >> I/O related functions return EROFS(ReadOnly?), while other FSes
> >> return EIO.
> VK> Only the request that actually caused the I/O error (and thus causing the
> VK> system to re-mount the ext3 partition R/O) should get EIO. EROFS is
> VK> the proper error for subsequent requests - because they're being rejected
> VK> because the filesystem is R/O.
> 
> I don't see your point.
> 
> According to QuFuPing's test, USB cable was UNPLUGGED. That means,
> device is gone, and device driver instantly (well.. within second or
> two) detected that fact.  How could ext3 mounted device that does
> not exist, as Read Only?
> 
> 
> >> 2. Assume a program doing the following: open - write(async) - close
> >> When user-mode app calls sys_write, for EXT2/JFS, no error
> >> returns, for EXT3, EROFS returns, for XFS/ReiserFS, EIO returns.
> VK> Remember that the request that actually hits an error could be from a
> VK> process that isn't even in existence anymore, if the page has been sitting
> VK> in the cache for a while and we're finally sending it to disk.
> 
> I don't see the reason why cache is still available.
> # I mean why such a implementation is valid.
> 
> If storage is known to be lost by device driver, we should not use
> that cache anymore.
> 
> Think about what the cached data means.
> 
> Cache image is the data image which original data exist in some
> device. Image on memory can be used as cache because consistency is
> managed by device driver.
> 
> If device no longer exist within reach of OS, device driver will not
> be able to manage the consistency between cache image and what
> device really have. Hence, if device driver lost control over
> device somehow, CACHE IMAGE SHOULD BECOME INVALID.
> 
> So, even for asynchronous IO, or read, or open, or close which only
> may require cached image, IF DEVICE DRIVER HAVE ALREADY DETECTED THE
> HW FAIURE ( please keep in mind that I did not add case which device
> driver did not detcted HW failure yet. I think this is important to
> meet the ASYNC requirement ), system should invalidate the cache
> image related to that storage before hand. That means, even for
> asynchronous IO request, file system should, at least, ask device
> driver if they have ALREADY detectED any HW failure.
> # And that means, device driver should have such interface.
> 
> Since device driver have already detected HW failure, whether you
> really will cause IO or not doesn't matter, EIO should be the
> correct return of error for this case.
> 
> EXT3 should never succeed in remounting lost device as Read Only.


Two kinds of HW failure,

   1. still readable, only write failure. 
   2. unreadable, unwriteable.

For the first case, if mount option errors=remount-ro is given or implied,
EROFS is appropriate, otherwise EIO.  For the second case, always EIO.

The current VFS design does not try to hide the problems from its
underlying fs'.
No need to make it transparent. Userland programs need to consider
both EROFS and EIO.


-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
