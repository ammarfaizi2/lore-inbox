Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTF0H1T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 03:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTF0H1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 03:27:19 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:24590 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263971AbTF0H1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 03:27:17 -0400
Subject: Re: PATCH - ALPS glidepoint/dualpoint driver for 2.5.7x
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <16123.44602.150927.280989@gargle.gargle.HOWL>
References: <16123.44602.150927.280989@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1056699687.599.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 27 Jun 2003 09:41:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-27 at 04:38, Neil Brown wrote:
> Hi,
>  The following adds support for the ALPS glidepoint/dualpoint pointing
>  devices to the mouse driver in 2.5.7x
> 
>  It "works-for-me" but there are issues that probably need to be
>  addressed.
> 
>  1/ The code is based on other code fragments I have collected off the
>    internet.  I have found no documentation and the one request I made to
>    ALPS has so-far been unanswered.  So I cannot be sure it is right,
>    but as I say it seems to work.
> 
>  2/ It appears (but see 1) that it is not possible to reliably detect
>     an ALPS device.  There is a sequence where you send 3 SetRes2:1
>     commands, and then a GetStatus command and you get something which
>     isn't really a status, but I don't know what range of status
>     values mean "ALPS".  I tried checking for "any status which must
>     be wrong" i.e. any status that say the device is in 1:1 mode, or
>     is enabled etc.  But a Logitech mouse seem to respond
>     interestingly to that sequence too.
> 
>     Also, there is no guarantee that the reply will come from the ALPS
>     device.  For example, on my Dell Latitude D800, if I have a
>     logitech mouse plugged in the expansion port, the GetStatus reply
>     comes from the logitech and not the ALPS.  So it would seem that
>     reliable detection is impossible.
> 
>     So the current code always sends the ALPS set-absolute-mode
>     sequence (4 disables before the enable) unless a
>     non-3-byte-protocol device was detected.
> 
>     There are two consequences of always assuming an ALPS that may not
>     be good.
>      1) The mouse always claims to generate various ABS events even
>        when there might not be any ABS-generating device behind the
>        mouse.
>      2) The driver could misinterpret a normal mouse event that
>        overflowed in the negative direction for both X and Y as part
>        of an ALPS absolute event.  This is because ALPS absolute
>        events are detected by checking if the top 5 bits of the first
>        byte are all one.   I doubt this is a real problem as double
>        overflows are very unlikely (aren't they?)
> 
>   3/ I haven't set the Min and Max absolute values (though both X and
>      Y seem to range from 0 to 100 in practice on my notebook).
>      This was because declaring a Min and Max causes the mousedev
>      driver to scale values to fit a supposed screen size, and I don't
>      think that is really appropriate for a touchpad.  Would there be
>      some other way to decide when to scale?  I would like to be able
>      to include Min and Max so that a post-processor (possibly in
>      mousedev) would be able to differentiate edge based activity
>      (scroll regions, corner taps, etc).
> 
> 
>   This patch also includes a fix for mousedev_event that allows it to
>   work sensibly with a touchpad in absolute mode.  With a touchpad, if
>   you lift your finger and place it down again you don't want that to
>   be interpreted as movement, but mousedev_event currently will.
>   I have changed it so that if ABS_PRESSURE is an available event,
>   then a new ABS_{X,Y} event while the current ABS_PRESSURE is zero
>   will not generate any movement.

Is there any trick to force enabling ALPS support? I'm using a NEC
Chrom@ laptop with an ALPS GlidePoint touchpad, 2.5.73-mm1 and your
patch, but I can't seem to get the enhanced functionality of my
touchpad, like using the edges of the touchpad to simulate the wheel or
else. It seems to behave like a normal PS/2 mouse.

Also, on dmesg, I can't see any reference to an ALPS input device being
detected. Any ideas?

Thanks!

