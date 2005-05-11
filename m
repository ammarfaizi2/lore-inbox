Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVEKHKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVEKHKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVEKHKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:10:47 -0400
Received: from colino.net ([213.41.131.56]:1012 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261905AbVEKHKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:10:01 -0400
Date: Wed, 11 May 2005 09:09:47 +0200
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [2.6.12-rc4] network wlan connection goes
 down
Message-ID: <20050511090947.581b80a4@colin.toulouse>
In-Reply-To: <200505100707.13356.david-b@pacbell.net>
References: <20050509162454.1c1c09a9@colin.toulouse>
	<200505090812.49090.david-b@pacbell.net>
	<20050510104349.7aca4227@colin.toulouse>
	<200505100707.13356.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 1.9.9 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005 07:07:13 -0700
David Brownell <david-b@pacbell.net> wrote:

Hi David,

> Hmm, well nothing looks wrong at the OHCI level.  It's possible that
> the data toggle got screwed up somehow; there are devices where the
> hardware doesn't reset it when it should.  If that's the case, there'd
> likely be some rx or tx error (does "ifconfig" show any?  dmesg?) and
> the wlan driver's recovery would need updating to ensure that the
> various endpoints get properly reset given those quirks.

ifconfig and dmesg don't show anything. However, the latest news is
that I rebooted (to 2.6.12-rc4 too), and it didn't reproduce. After a
few hours (plenty enough of time to get this bug), I tried to sleep and
resume the laptop a few times, I'll see if it bugs again now. Maybe
that's sleep related; as you say the usb layer looks fine...

> If you can report what the "iwconfig essid ..." command does down
> at the USB level, that should help sort things out. 

basically my iwconfig command looks like
    iwconfig mode managed essid AP channel 11 key restricted aa:bb:cc...

this results in calls to zd1201_set_mode(), zd1201_set_essid(),
zd1201_set_freq(), zd1201_set_encode() (Once each, in this order). Each
of those, at the USB level, does some register reading/writing
(zd1201_setconfig16(), zd1201_getconfig16() and friends) and at the
end, calls zd1201_mac_reset(zd), which disables and reenables the chip
using some zd1201 commands sent down an urb.
I guess this zd1201_mac_reset() call is what "fixes" it.

> It's possible that the network TX timeout mechanism might be a good
> place to kick in some driver recovery scheme. 

There's a tx_timeout callback, but it does log to dmesg and none of
these lines appear.

But I think that the problem probably lies in a complex interaction of
sleep code and usb code, and simply finding a way to reset the
zd1201 chip when it misbehaves, instead of finding the root cause,
isn't the solution. In other words, I'll get a hard time finding this
solution :)

Thanks,
-- 
Colin
