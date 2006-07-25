Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWGYRJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWGYRJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 13:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWGYRJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 13:09:09 -0400
Received: from kurby.webscope.com ([204.141.84.54]:51134 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932470AbWGYRJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 13:09:08 -0400
Message-ID: <44C64FC1.4060501@linuxtv.org>
Date: Tue, 25 Jul 2006 13:07:13 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: David Lang <dlang@digitalinsight.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
References: <20060725034247.GA5837@kroah.com>	 <m33bcqdn5y.fsf@anduin.mandriva.com>	 <200607251123.40549.adq_dvb@lidskialf.net>	 <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz> <1153846619.8932.36.camel@laptopd505.fenrus.org>
In-Reply-To: <1153846619.8932.36.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-07-25 at 09:47 -0700, David Lang wrote:
>> On Tue, 25 Jul 2006, Andrew de Quincey wrote:
>>
>>> On Tuesday 25 July 2006 10:55, Arnaud Patard wrote:
>>>> Greg KH <gregkh@suse.de> writes:
>>>>
>>>> Hi,
>>>>
>>>>> We (the -stable team) are announcing the release of the 2.6.17.7 kernel.
>>>> Sorry, but doesn't compile if DVB_BUDGET_AV is set :(
>>>>
>>>>> Andrew de Quincey:
>>>>>       v4l/dvb: Fix budget-av frontend detection
>>>
>>> In fact it is just this patch causing the problem:
>> <SNIP>
>>> Sorry, I had so much work going on in that area I must have diffed the wrong
>>> kernel when I created this patch. :(
>> is it reasonable to have an aotomated test figure out what config options are 
>> relavent to a patch (or patchset) and test compile all the combinations to catch 
>> this sort of mistake?
> 
> well you can do such a thing withing statistical bounds; however... if
> the patch already is in -git (as is -stable policy normally).. it should
> have been found there already...
> 
> 
In this case it isn't quite that simple...

The DVB tree is in the midst of tuner refactoring, and somehow the diff
was generated against the wrong tree.

The fix can be found here... We'll need this queued up for 2.6.17.8 ...
 I have already attached this inline in a prior email, not sure how many
people have seen that yet...

You can also get it from here:

http://linuxtv.org/~mkrufky/stable/2.6.17.y/budget-av-compile-fix.patch

---

[PATCH 2.6.17.7] Fix budget-av compile failure

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Currently I am doing lots of refactoring work in the dvb tree. This
bugfix became necessary to fix 2.6.17 whilst I was in the middle of this
work. Unfortunately after I tested the original code for the patch, I
generated the diff against the wrong tree (I accidentally used a tree
with part of the refactoring code in it). This resulted in the reported
compile errors because that tree (a) was incomplete, and (b) used
features which are simply not in the mainline kernel yet.

Many apologies for the error and problems this has caused. :(

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

diff -Naur linux-2.6.17.7.orig/drivers/media/dvb/ttpci/budget-av.c
linux-2.6.17.7/drivers/media/dvb/ttpci/budget-av.c
--- linux-2.6.17.7.orig/drivers/media/dvb/ttpci/budget-av.c 2006-07-25
14:53:19.000000000 +0100
+++ linux-2.6.17.7/drivers/media/dvb/ttpci/budget-av.c 2006-07-25
15:25:32.000000000 +0100
@@ -58,6 +58,7 @@
 	struct tasklet_struct ciintf_irq_tasklet;
 	int slot_status;
 	struct dvb_ca_en50221 ca;
+	u8 reinitialise_demod:1;
 };

 /* GPIO Connections:
@@ -214,8 +215,9 @@
 	while (--timeout > 0 && ciintf_read_attribute_mem(ca, slot, 0) != 0x1d)
 		msleep(100);

-	/* reinitialise the frontend */
-	dvb_frontend_reinitialise(budget_av->budget.dvb_frontend);
+	/* reinitialise the frontend if necessary */
+	if (budget_av->reinitialise_demod)
+		dvb_frontend_reinitialise(budget_av->budget.dvb_frontend);

 	if (timeout <= 0)
 	{
@@ -1064,12 +1066,10 @@
 		fe = tda10021_attach(&philips_cu1216_config,
 				     &budget_av->budget.i2c_adap,
 				     read_pwm(budget_av));
-		if (fe) {
-			fe->ops.tuner_ops.set_params = philips_cu1216_tuner_set_params;
-		}
 		break;

 	case SUBID_DVBC_KNC1_PLUS:
+		budget_av->reinitialise_demod = 1;
 		fe = tda10021_attach(&philips_cu1216_config,
 				     &budget_av->budget.i2c_adap,
 				     read_pwm(budget_av));



-- 
Michael Krufky

