Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTLZKWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 05:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbTLZKWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 05:22:20 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:28834 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265162AbTLZKWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 05:22:18 -0500
Date: Fri, 26 Dec 2003 11:22:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Monro <davidm@amberdata.demon.co.uk>
Cc: John Bradford <john@grabjohn.com>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: handling an oddball PS/2 keyboard (w/ patch)
Message-ID: <20031226102210.GA11127@ucw.cz>
References: <3FEA5044.5090106@amberdata.demon.co.uk> <20031225063936.GA15560@win.tue.nl> <200312251316.hBPDG7LT000163@81-2-122-30.bradfords.org.uk> <3FEAFDF3.80008@amberdata.demon.co.uk> <3FEB972B.4010406@amberdata.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEB972B.4010406@amberdata.demon.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 02:04:27AM +0000, David Monro wrote:
> David Monro wrote:
> >John Bradford wrote:
> >
> [..]
> >>There might be no need for such a workaround - a lot of PS/2 
> >>devices which were not intended for PCs work fine in set 3, 
> >>particularly if
> [..]
> 
> Ok I've turned my brain on and looked at the difference between set2 and
> set3... and its trivial! The NCD N-97 returns set3 keycodes even when
> its told to be in set2. Thanks very much for making me look at that!
> 
> So my first thought was to just pass the atkbd_set=3 option to the
> kernel. Which doesn't work - I still get set2. Looking at atkbd.c it
> really doesn't handle _translated_ set3 at all - for one thing
> atkbd_set_3() forces set2 if we have a translating i8042 (ie normality),

This is intentional. Set3 was never meant to be translated. If you want
to use it, just pass i8042_direct=1 to the kernel (or the i8042 module).
Then you get untranslated Set3. If you're using a Set3 keyboard with a
mainboard that cannot handle Untranslation and Set3 correctly, well,
then choose a different keyboard or mainboard, they're not compatible.

> and for another it still does e0/e1 translation for set3 - which imho is 
> wrong.

Indeed this is wrong, but needed for many keyboards, which incorrectly
use the e0 prefix even in set3. However, this shoul pose no problem for
keyboards which use proper set3.

> Both of these can be avoided by passing the i8042_direct option to the
> i8042 module however, since that puts the i8042 into non-translating 
> mode. However this can have undesirable side effects - for example my 
> bios appears to re-enable translating mode if I suspend/resume.

This can be fixed by restoring the i8042 chip configuration upon resume
(fix planned, I think Dmitry has one already).

> So. Short term solution is just to pass atkbd_set=3 and i8042_direct=1 
> to the kernel, and live without suspend/resume (and that should work for 
> John as well).
> 
> Longer term: fix atkbd.c to handle translated set3 correctly, and then 
> just use atkbd_set=3. Vojtech: I've included a patch which I think does 
> this, and works for me; do you think it looks reasonable? I've just done 
> a couple of quick hacks to make this work (basically assume anyone who 
> sets atkbd_set= knows what they are doing, and don't special-case e0/e1 
> in set3) - but is that all there is to it? I've assumed that all other 
> codes are still valid in set3. I also haven't done it very prettily :)

I'm not very keen on going this way, see above.

> Even the above won't fix things for anyone who has a keyboard which a) 
> needs set3 handling b) generates codes above 0x7F c) has a broken i8042 
> translation implementation which mangles the codes above 0x7F and d) has 
> a problem using the i8042 in raw mode because of suspend/resume... in 
> which case, I think that will have to be fixed by getting the i8042 code 
> to reset raw mode on resume.. if thats even possible. Fortunately I 
> think this should be a very rare case :)

Yes, there are and will be unsupported configurations. d) will be fixed
by setting i8042 to bootup values when suspending and to kernel values
when resuming. a) b) and c) will be fixed by turning off translation in
those cases and relying on it working because of d).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
