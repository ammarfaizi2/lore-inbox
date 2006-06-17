Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWFQSjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWFQSjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWFQSjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:39:10 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:30839 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWFQSjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:39:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Q8Fp0xl7gJ1S/XsAy/V+re6ZVtMfLuFUd53JiJVxb0MQjZ1bkIcXJ3eLpYH3Ec6hI3jC+AkuKJ6qhnJcibTFMYWjFFJCqq5C9otzJ8uhlT6dbaEavON8/XmUGKwHamj/0kzYRo3hnzroNaPzbhM3UWSLyguBVYH27zwmlmd94Gw=
Message-ID: <44944C49.3080503@gmail.com>
Date: Sat, 17 Jun 2006 12:39:05 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 18/20] chardev: GPIO for SCx200 & PC-8736x: display pin
 values in/out in gpio_dump
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

18/20. patch.viewpins-values

Add current pin settings to gpio_dump() output. This adds the last
'word' to the syslog lines, which displays the input and output values
that the pin is set to.

  pc8736x_gpio.0: io00: 0x0044 TS OD PUE  EDGE LO DEBOUNCE        io:1/1

The 2 values may differ for a number of reasons:
1- the pin output circuitry is diaabled, (as the above 'TS' indicates)
2- it needs a pullup resistor to drive the attached circuit,
3- the external circuit needs a pullup so the open-drain has something
   to pull-down
4- the pin is wired to Vcc or Ground

It might be appropriate to add a WARN for 2,3,4, since they could
damage the chip and/or circuit, esp if misconfig goes unnoticed.


Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.viewpins-values
 nsc_gpio.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-17/drivers/char/nsc_gpio.c ax-18/drivers/char/nsc_gpio.c
--- ax-17/drivers/char/nsc_gpio.c	2006-06-17 01:45:49.000000000 -0600
+++ ax-18/drivers/char/nsc_gpio.c	2006-06-17 01:54:42.000000000 -0600
@@ -26,7 +26,7 @@ void nsc_gpio_dump(struct nsc_gpio_ops *
 	u32 config = amp->gpio_config(index, ~0, 0);
 
 	/* user requested via 'v' command, so its INFO */
-	dev_info(amp->dev, "io%02u: 0x%04x %s %s %s %s %s %s %s\n",
+	dev_info(amp->dev, "io%02u: 0x%04x %s %s %s %s %s %s %s\tio:%d/%d\n",
 		 index, config,
 		 (config & 1) ? "OE" : "TS",      /* output-enabled/tristate */
 		 (config & 2) ? "PP" : "OD",      /* push pull / open drain */
@@ -34,7 +34,9 @@ void nsc_gpio_dump(struct nsc_gpio_ops *
 		 (config & 8) ? "LOCKED" : "",    /* locked / unlocked */
 		 (config & 16) ? "LEVEL" : "EDGE",/* level/edge input */
 		 (config & 32) ? "HI" : "LO",     /* trigger on rise/fall edge */
-		 (config & 64) ? "DEBOUNCE" : "");        /* debounce */
+		 (config & 64) ? "DEBOUNCE" : "", /* debounce */
+
+		 amp->gpio_get(index), amp->gpio_current(index));
 }
 
 ssize_t nsc_gpio_write(struct file *file, const char __user *data,


