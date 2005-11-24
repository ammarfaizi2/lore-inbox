Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVKXTHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVKXTHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVKXTHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:07:55 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:30059 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750761AbVKXTHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:07:54 -0500
Message-ID: <43860F7D.2090307@m1k.net>
Date: Thu, 24 Nov 2005 14:07:41 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Krufky <mkrufky@m1k.net>
CC: Gene Heskett <gene.heskett@verizon.net>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Johannes Stezenbach <js@linuxtv.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] hybrid v4l/dvb advanced frontend selection fix
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511231736.58204.gene.heskett@verizon.net> <Pine.LNX.4.61.0511232338100.4550@goblin.wat.veritas.com> <200511231937.34206.gene.heskett@verizon.net> <Pine.LNX.4.61.0511240741020.5619@goblin.wat.veritas.com> <4385F22E.4020509@m1k.net>
In-Reply-To: <4385F22E.4020509@m1k.net>
Content-Type: multipart/mixed;
 boundary="------------030409070502020907010507"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030409070502020907010507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Krufky wrote:

> Gene Heskett wrote:
>
>> Got it, building src tree now, config'd & building.
>>
>> And, I unchecked everything but what I need to run this card (I think,
>> whatdoIknow) and got this at depmod time:
>> WARNING:
>> /lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol mt352_attach
>> WARNING:
>> /lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol nxt200x_attach
>> WARNING:
>> /lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol mt352_write
>> WARNING:
>> /lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol lgdt330x_attach
>> WARNING:
>> /lib/modules/2.6.15-rc2-git4/kernel/drivers/media/video/cx88/cx88-dvb.ko
>> needs unknown symbol cx22702_attach
>>
>> Maybe somebody can take the time to tell me what I do need to run a
>> pcHDTV-3000 in both ntsc and atsc modes using this newer code?
>> I was under the impression I needed the cx88 stuffs, ORV51132 (for
>> atsc) and nxt2002(for ntsc), but now we have lots of other dependencies
>> out the wazoo.  Please clarify.
>
> These other dependencies have always been there, except that nxt200x 
> and lgdt330x are relatively new frontends.
>
> The difference is that a new Kconfig / Makefile feature is allowing us 
> to only select the specific frontend needed by your hardware... 
> Previously, all frontend support was forced to be built-in.
>
> You and Adrian have clearly demonstrated that this frontend selection 
> capability isn't working properly.  I think I will send Linus a patch 
> to restore previous functionality, forcing all frontends to be 
> built... Then I will resubmit a patch to Andrew that will re-enable 
> this frontend selection support, and I'll ask him to hold it in -mm 
> until we can work out the bugs.

Actually, I think that I might have fixed it... Please test the attached 
patch.

> The problem is that you are selecting cx88-dvb to be built-in to the 
> kernel (not as a module) , but the frontends are being built as 
> modules only. 

[PATCH] hybrid v4l/dvb advanced frontend selection fix

Signed-off-by: Michael Krufky <mkrufky@m1k.net>


--------------030409070502020907010507
Content-Type: text/plain;
 name="advanced-frontend-selection-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="advanced-frontend-selection-fix.patch"

diff -upr linux-2.6.15-rc2-git4/drivers/media/video/cx88/Kconfig linux/drivers/media/video/cx88/Kconfig
--- linux-2.6.15-rc2-git4/drivers/media/video/cx88/Kconfig	2005-11-24 13:47:02.148734660 -0500
+++ linux/drivers/media/video/cx88/Kconfig	2005-11-24 13:50:29.849190791 -0500
@@ -46,8 +46,8 @@ config VIDEO_CX88_DVB_ALL_FRONTENDS
 	  If you are unsure, choose Y.
 
 config VIDEO_CX88_DVB_MT352
-	tristate "Zarlink MT352 DVB-T Support"
-	default m
+	bool "Zarlink MT352 DVB-T Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_MT352
 	---help---
@@ -55,8 +55,8 @@ config VIDEO_CX88_DVB_MT352
 	  Connexant 2388x chip and the MT352 demodulator.
 
 config VIDEO_CX88_DVB_OR51132
-	tristate "OR51132 ATSC Support"
-	default m
+	bool "OR51132 ATSC Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_OR51132
 	---help---
@@ -64,8 +64,8 @@ config VIDEO_CX88_DVB_OR51132
 	  Connexant 2388x chip and the OR51132 demodulator.
 
 config VIDEO_CX88_DVB_CX22702
-	tristate "Conexant CX22702 DVB-T Support"
-	default m
+	bool "Conexant CX22702 DVB-T Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_CX22702
 	---help---
@@ -73,8 +73,8 @@ config VIDEO_CX88_DVB_CX22702
 	  Connexant 2388x chip and the CX22702 demodulator.
 
 config VIDEO_CX88_DVB_LGDT330X
-	tristate "LG Electronics DT3302/DT3303 ATSC Support"
-	default m
+	bool "LG Electronics DT3302/DT3303 ATSC Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_LGDT330X
 	---help---
@@ -82,8 +82,8 @@ config VIDEO_CX88_DVB_LGDT330X
 	  Connexant 2388x chip and the LGDT3302/LGDT3303 demodulator.
 
 config VIDEO_CX88_DVB_NXT200X
-	tristate "NXT2002/NXT2004 ATSC Support"
-	default m
+	bool "NXT2002/NXT2004 ATSC Support"
+	default y
 	depends on VIDEO_CX88_DVB && !VIDEO_CX88_DVB_ALL_FRONTENDS
 	select DVB_NXT200X
 	---help---
diff -upr linux-2.6.15-rc2-git4/drivers/media/video/Kconfig linux/drivers/media/video/Kconfig
--- linux-2.6.15-rc2-git4/drivers/media/video/Kconfig	2005-11-24 13:47:02.123743990 -0500
+++ linux/drivers/media/video/Kconfig	2005-11-24 13:52:00.525339321 -0500
@@ -26,7 +26,7 @@ config VIDEO_BT848
 	  module will be called bttv.
 
 config VIDEO_BT848_DVB
-	tristate "DVB/ATSC Support for bt878 based TV cards"
+	bool "DVB/ATSC Support for bt878 based TV cards"
 	depends on VIDEO_BT848 && DVB_CORE
 	select DVB_BT8XX
 	---help---
diff -upr linux-2.6.15-rc2-git4/drivers/media/video/saa7134/Kconfig linux/drivers/media/video/saa7134/Kconfig
--- linux-2.6.15-rc2-git4/drivers/media/video/saa7134/Kconfig	2005-11-24 13:47:02.185720851 -0500
+++ linux/drivers/media/video/saa7134/Kconfig	2005-11-24 13:51:24.175908125 -0500
@@ -42,8 +42,8 @@ config VIDEO_SAA7134_DVB_ALL_FRONTENDS
 	  If you are unsure, choose Y.
 
 config VIDEO_SAA7134_DVB_MT352
-	tristate "Zarlink MT352 DVB-T Support"
-	default m
+	bool "Zarlink MT352 DVB-T Support"
+	default y
 	depends on VIDEO_SAA7134_DVB && !VIDEO_SAA7134_DVB_ALL_FRONTENDS
 	select DVB_MT352
 	---help---
@@ -51,8 +51,8 @@ config VIDEO_SAA7134_DVB_MT352
 	  Philips saa7134 chip and the MT352 demodulator.
 
 config VIDEO_SAA7134_DVB_TDA1004X
-	tristate "Phillips TDA10045H/TDA10046H DVB-T Support"
-	default m
+	bool "Phillips TDA10045H/TDA10046H DVB-T Support"
+	default y
 	depends on VIDEO_SAA7134_DVB && !VIDEO_SAA7134_DVB_ALL_FRONTENDS
 	select DVB_TDA1004X
 	---help---
@@ -60,8 +60,8 @@ config VIDEO_SAA7134_DVB_TDA1004X
 	  Philips saa7134 chip and the TDA10045H/TDA10046H demodulator.
 
 config VIDEO_SAA7134_DVB_NXT200X
-	tristate "NXT2002/NXT2004 ATSC Support"
-	default m
+	bool "NXT2002/NXT2004 ATSC Support"
+	default y
 	depends on VIDEO_SAA7134_DVB && !VIDEO_SAA7134_DVB_ALL_FRONTENDS
 	select DVB_NXT200X
 	---help---

--------------030409070502020907010507--

