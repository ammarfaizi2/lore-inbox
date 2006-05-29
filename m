Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWE2DBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWE2DBz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 23:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWE2DBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 23:01:55 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:27043 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751123AbWE2DBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 23:01:55 -0400
Message-ID: <348871711.21712@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 29 May 2006 11:01:53 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 00/32] Adaptive readahead V14
Message-ID: <20060529030152.GA5994@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
References: <348745084.15239@ustc.edu.cn> <44788C8A.2070900@tls.msk.ru> <348818092.32485@ustc.edu.cn> <4479F8B5.90906@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4479F8B5.90906@tls.msk.ru>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2006 at 11:23:33PM +0400, Michael Tokarev wrote:
> Wu Fengguang wrote:
> > 
> > It's not quite reasonable for readahead to worry about media errors.
> > If the media fails, fix it. Or it will hurt read sooner or later.
> 
> Well... In reality, it is just the opposite.
> 
> Suppose there's a CD-rom with a scratch/etc, one sector is unreadable.
> In order to "fix" it, one have to read it and write to another CD-rom,
> or something.. or just ignore the error (if it's just a skip in a video
> stream).  Let's assume the unreadable block is number U.
> 
> But current behavior is just insane.  An application requests block
> number N, which is before U. Kernel tries to read-ahead blocks N..U.
> Cdrom drive tries to read it, re-read it.. for some time.  Finally,
> when all the N..U-1 blocks are read, kernel returns block number N
> (as requested) to an application, successefully.
> 
> Now an app requests block number N+1, and kernel tries to read
> blocks N+1..U+1.  Retrying again as in previous step.
> 
> And so on, up to when an app requests block number U-1.  And when,
> finally, it requests block U, it receives read error.
> 
> So, kernel currentry tries to re-read the same failing block as
> many times as the current readahead value (256 (times?) by default).

Good insight... But I'm not sure about it.

Jens, will a bad sector cause the _whole_ request to fail?
Or only the page that contains the bad sector?

> This whole process already killed my cdrom drive (I posted about it
> to LKML several months ago) - literally, the drive has fried, and
> does not work anymore.  Ofcourse that problem was a bug in firmware
> (or whatever) of the drive *too*, but.. main problem with that is
> current readahead logic as described above.
> 
> With that logic, an app also becomes unkillable (at least for some
> time) -- ie, even when I knew something's wrong and the CDrom should
> not behave like it was, I wasn't able to stop it until I powered the
> machine off (just unplugged the power cable) - but.. too late.
> 
> Yes, bad media is just that - a bad thing.  But it's not a reason to
> force power unplug to stop the process, and not a reason to burn a
> drive (or anything else).  And this is where readahead comes into
> play - it IS read-ahead logic who's responsible for the situation.
> 
> And there's alot of scratched/whatever CD-Rom drives out there -
> unreadable CDrom (or a floppy which is already ancient, or some
> other media) - you can't just say to every user out there that
> linux isn't compatible with all people's stuff and those people
> should "fix" it before ever trying to insert it into their linux
> machine...
> 
> Thanks.
> 
> /mjt
