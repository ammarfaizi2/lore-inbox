Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVA3LKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVA3LKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 06:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVA3LKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 06:10:47 -0500
Received: from av7-2-sn4.m-sp.skanova.net ([81.228.10.109]:15023 "EHLO
	av7-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261676AbVA3LKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 06:10:36 -0500
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with 2.6.11-rc2
References: <20050123190109.3d082021@localhost.localdomain>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Jan 2005 12:10:34 +0100
In-Reply-To: <20050123190109.3d082021@localhost.localdomain>
Message-ID: <m3acqr895h.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> Since the 2.6.11-rc2, I encounter problems with touchpad and keyboard 
> on my laptop, Dell Lattitude D600. The following patch appears to be
> the culprit:

[alps touchpad detection fix patch]

> Without the patch, touchpad is not detected as such. Instead, dmesg shows:
> 
> input: PS/2 Generic Mouse on isa0060/serio1
> 
> With this patch, I see this:
> 
> ALPS Touchpad (Dualpoint) detected
>   Disabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> 
> Looks like detection is correct, however either ALPS specific code doesn't work
> right, or it sets wrong parameters, I cannot tell. Here's the list of problems,
> from worst to least annoying:

I have posted 4 patches to LKML earlier today. Some of them might fix
some of your problems.

> - Very often, keyboard stops working after a click. Typing anything has no effect.
>   However, any smallest pointer movement will restore keyboard, and then an
>   application receives all buffered characters. This is very bad.

It would be interesting to know at which level the problem appears.
Can you reproduce the problem using "xev"? If xev works as expected,
the problem is possibly that the left mouse button gets stuck and
stops your application from accepting keyboard input. This patch fixes
the button stuck problem:

        [PATCH 1/4] Make mousedev.c report all events to user space immediately

If the keyboard gets stuck also using "xev", the problem is at a lower
level. Enable i8042_debug in drivers/input/serio/i8042.c to see if the
keyboards produces any data in the stuck state.

> - Double-click sometimes fails to work. I have to wait a second and retry it.
>   Retrying right away is likely not to work again.

Probably fixed by this patch:

        [PATCH 2/4] Enable hardware tapping for ALPS touchpads

> - Slow motion of finger produces no motion, then a jump. So, it's very hard to
>   target smaller UI elements and some web links.

I see this too when I don't use the X touchpad driver. With the X
driver there is no problem. I think the problem is that mousedev.c in
the kernel has to use integer arithmetic, so probably small movements
are rounded off to 0. I'll try to come up with a fix for this.

> P.S. I hate the tap, so keep it disabled by default, please :-)

You can disable tapping by setting the tap_time parameter for
mousedev.c to 0. The default value is 200ms.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
