Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWE1TXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWE1TXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 15:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWE1TXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 15:23:38 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:55126 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750761AbWE1TXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 15:23:37 -0400
Message-ID: <4479F8B5.90906@tls.msk.ru>
Date: Sun, 28 May 2006 23:23:33 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/32] Adaptive readahead V14
References: <348745084.15239@ustc.edu.cn> <44788C8A.2070900@tls.msk.ru> <348818092.32485@ustc.edu.cn>
In-Reply-To: <348818092.32485@ustc.edu.cn>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> 
> It's not quite reasonable for readahead to worry about media errors.
> If the media fails, fix it. Or it will hurt read sooner or later.

Well... In reality, it is just the opposite.

Suppose there's a CD-rom with a scratch/etc, one sector is unreadable.
In order to "fix" it, one have to read it and write to another CD-rom,
or something.. or just ignore the error (if it's just a skip in a video
stream).  Let's assume the unreadable block is number U.

But current behavior is just insane.  An application requests block
number N, which is before U. Kernel tries to read-ahead blocks N..U.
Cdrom drive tries to read it, re-read it.. for some time.  Finally,
when all the N..U-1 blocks are read, kernel returns block number N
(as requested) to an application, successefully.

Now an app requests block number N+1, and kernel tries to read
blocks N+1..U+1.  Retrying again as in previous step.

And so on, up to when an app requests block number U-1.  And when,
finally, it requests block U, it receives read error.

So, kernel currentry tries to re-read the same failing block as
many times as the current readahead value (256 (times?) by default).

This whole process already killed my cdrom drive (I posted about it
to LKML several months ago) - literally, the drive has fried, and
does not work anymore.  Ofcourse that problem was a bug in firmware
(or whatever) of the drive *too*, but.. main problem with that is
current readahead logic as described above.

With that logic, an app also becomes unkillable (at least for some
time) -- ie, even when I knew something's wrong and the CDrom should
not behave like it was, I wasn't able to stop it until I powered the
machine off (just unplugged the power cable) - but.. too late.

Yes, bad media is just that - a bad thing.  But it's not a reason to
force power unplug to stop the process, and not a reason to burn a
drive (or anything else).  And this is where readahead comes into
play - it IS read-ahead logic who's responsible for the situation.

And there's alot of scratched/whatever CD-Rom drives out there -
unreadable CDrom (or a floppy which is already ancient, or some
other media) - you can't just say to every user out there that
linux isn't compatible with all people's stuff and those people
should "fix" it before ever trying to insert it into their linux
machine...

Thanks.

/mjt
