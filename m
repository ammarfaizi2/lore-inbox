Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWBQMwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWBQMwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 07:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWBQMwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 07:52:42 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:36316 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S932282AbWBQMwm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 07:52:42 -0500
Date: Fri, 17 Feb 2006 13:48:56 +0100 (CET)
To: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [HWMON] Add LM82 support
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <XIPwj8XM.1140180536.0732280.khali@localhost>
In-Reply-To: <20060216175930.GE20157@cosmic.amd.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Jordan Crouse" <jordan.crouse@amd.com>, info-linux@ldcmail.amd.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Fri, 17 Feb 2006 13:48:58 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jordan,

It's nice to see someone from AMD working with us :)

On 2006-02-16, Jordan Crouse wrote:
> This patch adds support for the LM82 temperature sensor from National
> Semiconductor.  The chip is very much like the LM83 with less temperature
> sensors.  The really only goofy thing here, is that the registers for the
> 2nd temperature sensor on the LM82 are marked as the *3rd* sensor on the
> LM83, so I play a little magic to keep things all nice and linear.

It is really common for hardware monitoring drivers to just skip some
inputs when one driver handles several chips with minor differences. For
example, the w83627hf driver skips in5 and in6 for the W83627THF chip.
So I'd prefer that you don't attempt to renumber the inputs for the
LM82, but simply create temp1* and temp3* and omit temp2* and temp4*.

One reason why this is important is that there seem to be two variants of
the LM82. First is the one you have with a chip ID of 0x01. Second is a
stripped down version of the LM83, with chip ID of 0x03, which is
totally unrecognizable from the LM83. It will make things much easier if
the two variants can be handled the same way from user-space, which
implies that we don't renumber the inputs.

My comments on your code now:

> --- a/drivers/hwmon/lm83.c
> +++ b/drivers/hwmon/lm83.c
> @@ -12,6 +12,11 @@
>   * Since the datasheet omits to give the chip stepping code, I give it
>   * here: 0x03 (at register 0xff).
>   *
> + * <jordan.crouse@amd.com>: Added LM82 support
> + * http://www.national.com/pf/LM/LM82.html - basically a stripped down
> + * model of the LM83, with only two temperatures reported.  The stepping
> + * is 0x01 (at least according to the datasheet).
> + *

History doesn't belong to the source code, as we have GIT for this. So
this paragraph should be written just as if the driver had always
supported the LM82 device. See lm90.c for an example.

You should also include changes to Documentation/hwmon/lm83 in your
patch. Again you may use lm90 as an example. And an update to
drivers/hwmon/Kconfig would be welcome as well, to mention the LM82 in
the lm83 driver help text if no even label.

> @@ -142,6 +147,7 @@ struct lm83_data {
>  	struct semaphore update_lock;
>  	char valid; /* zero until following fields are valid */
>  	unsigned long last_updated; /* in jiffies */
> +	int type;  /* Remember the type of chip */

You should no more need this if you don't renumber the inputs, right?

All the rest is just fine with me. Great work!

Would you be kind enough to also provide a patch against lm_sensors
2.10.0 or CVS for user-space support? It should be quite simple.

Thanks,
--
Jean Delvare
