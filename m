Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271737AbTGXVJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 17:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271738AbTGXVJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 17:09:12 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:20358 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S271737AbTGXVJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 17:09:09 -0400
Date: Thu, 24 Jul 2003 23:24:16 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: schierlm@gmx.de
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: touchpad doesn't work under 2.6.0-test1-ac2
Message-ID: <20030724212416.GA18141@vana.vc.cvut.cz>
References: <bXg8.4Wg.1@gated-at.bofh.it> <S270097AbTGXUNM/20030724201313Z+7864@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S270097AbTGXUNM/20030724201313Z+7864@vger.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 10:27:51PM +0200, Michael Schierl wrote:
> David Benfell <benfell@greybeard95a.com> wrote:
> 
> However, giving 'psmouse_noext' as kernel param helped for me to make
> the touchpad work (using /dev/input/mice (protocol autops2) as source
> for gpm and gpm repeater as source for x, as I did in 2.4.x kernels).
> 
> Setting "#define DEBUG" in drivers/input/serio/i8042.c caused lots of
> lines of text on my console whenever i touched either the touchpad or
> one of the (four) buttons.

In the drivers/input/mousedev.c there is (beside other entries) only
one entry for absolute devices:

{
        .flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
        .evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
        .keybit = { [LONG(BTN_TOUCH)] = BIT(BTN_TOUCH) },
        .absbit = { BIT(ABS_X) | BIT(ABS_Y) },
},      /* A tablet like device, at least touch detection, two absolute axes */

This entry requires that device reports BTN_TOUCH - but Synaptics tablet
does not have any BTN_TOUCH, it has only "normal" LEFT, RIGHT buttons.
So I created additional entry, which listed "[LONG(BTN_LEFT)] = BIT(BTN_LEFT)"
for .keybit instead.

After this change gpm sees some events, but vertical movement is reversed
(although synaptics does not report that...) and whenever I take finger
up from touchpad mouse randomly jumps over screen.

And worse - after booting with Synaptics protocol enabled touching flatpannel
with finger stops working as left button until machine is powered off.

This all happens on Compaq EVO N800C. I strongly believe that we need a
build time option for disabling Synaptics detection, or at least input_synaptics=0
runtime option, until it can work at least as well as it works like ps/2
device.

Needless to say that small joystick on the keyboard does not work in synaptics
mode, and it does not create separate input device.

					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz
						

