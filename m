Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVAQTQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVAQTQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVAQTQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:16:43 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:58639 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262836AbVAQTQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:16:29 -0500
Date: Mon, 17 Jan 2005 20:19:01 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Simone Piunno <pioppo@ferrara.linux.it>
Cc: djg@pdp8.net, LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050117201901.3e712cfa.khali@linux-fr.org>
In-Reply-To: <200501162332.14324.pioppo@ferrara.linux.it>
References: <g7Idbr9m.1105713630.9207120.khali@localhost>
	<200501151654.46412.pioppo@ferrara.linux.it>
	<20050115175545.743a39f9.khali@linux-fr.org>
	<200501162332.14324.pioppo@ferrara.linux.it>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simone,

> While we're at it, the fan speed sensor reports an absurd speed when
> the fan  is driven with very low but non-zero pwm values.  For
> example, driving it  with pwm=2 I get speeds over 50K rpms, while of
> course the fan is stopped  (almost?).  This could be just an hardware
> sensitivity problem in the sensor  chip, or a false measure triggered
> by fan vibration, but maybe you know  better.

This is a frequent problem with PWM. In order to estimate the fan
rotation speed, chips sample a signal that comes from the fan on its
third wire (typically two pulses per revolution). Since the fan is not a
power source by itself, the pulses are powered from the fan header's
+12V pin. When you start using PWM, you affect the +12V pin duty cycle,
and as a result you affect the speed signal duty cycle. The lower the
duty cycle, the harder for the chip to correctly determine the speed.

Newer chips have the capability to correct the effects of PWM at
reasonable duty cycles. It however supposes that it knows which fan
corresponds to which PWM output. Motherboard manufacturers will have to
take this information into account when designing their boards. And at
any rate, very low PWM duty cycles cannot possibly corrected.

It is possible to affect the fan speed vs. PWM curve by changing the
base frequency of the PWM signal. This can help achieve lower fan speeds
with higher PWM duty cycles (and thus better speed readings). Most chips
support frequency adjustment, but our drivers don't, because it wasn't
realized until very recently that this could be of any benefit to the
user.

-- 
Jean Delvare
http://khali.linux-fr.org/
