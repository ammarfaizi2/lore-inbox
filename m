Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVKWTS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVKWTS4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVKWTS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:18:56 -0500
Received: from kirby.webscope.com ([204.141.84.57]:24802 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932207AbVKWTSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:18:55 -0500
Message-ID: <4384C059.3070003@m1k.net>
Date: Wed, 23 Nov 2005 14:17:45 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Johannes Stezenbach <js@linuxtv.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux 2.6.15-rc2
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511202049.30952.gene.heskett@verizon.net> <4383CC4E.40206@m1k.net> <200511222336.48506.gene.heskett@verizon.net> <20051123174237.GO3963@stusta.de>
In-Reply-To: <20051123174237.GO3963@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Tue, Nov 22, 2005 at 11:36:48PM -0500, Gene Heskett wrote:
>  
>
>>...
>>Well, I just went thru it again, and turned off everything but the
>>cx8800 and ORv51132 stuffs, and now I get this at the and of the
>>'makeit' script I use here:
>>
>>WARNING:
>>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>>needs unknown symbol mt352_attach
>>WARNING:
>>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>>needs unknown symbol nxt200x_attach
>>WARNING:
>>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>>needs unknown symbol mt352_write
>>WARNING:
>>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>>needs unknown symbol lgdt330x_attach
>>WARNING:
>>/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
>>needs unknown symbol cx22702_attach
>>...
>>    
>>
>Nice catch and thanks for your report.
>
>The bug is obvious. A possible patch is below (and at least 
>drivers/media/video/saa7134/Makefile contains the same bug),
>but I'd really prfer getting rid of the -DHAVE_* stuff in the
>Makefiles and using Kconfig variables instead.
>  
>
We need to keep the -DHAVE_FOO stuff there, in order to satisfy the 
following requirements:

1) To allow the option of only selecting those frontends required by 
specific dvb hardware, without forcing all modules to be loaded... This 
feature is optional, and I implemented it in response to the demand from 
some hybrid v4l/dvb device users, (and myself)  Why force a driver to 
load every frontend module if it isnt required by the hardware? -- 
apparantly the implementation was less than perfect.  I had originally 
intended for this to live in -mm for a bit, but when the merge window 
came around, Mauro had sent it upstream before I had the chance to 
create alternate patches for linus' tree.

2) (more importantly) To allow v4l-kernel cvs to retain backwards 
compatability with older kernels..

I had originally tried to rename these to use the Kconfig variables, but 
LKML people asked for it to be changed back.

Please do not remove this feature -- if it is broken, then we should try 
to fix it, rather than remove it.  If the specific frontend selection 
isn't working, then I guess we can revert back to the old behavior where 
every frontend is forced, but I would rather not.

>Would such a patch be accepted?
>
>>Cheers, Gene
>>    
>>
>cu
>Adrian
>  
>
If it fixes Gene's problem (a quick glance at his emails suggests that 
it does) then:

Acked-by: Michael Krufky <mkrufky@linuxtv.org>

although Sam Ravnborg's suggestion looks better to me.  Unfortunately, I 
will be unable to test this out on my system until After Thanksgiving 
(on Friday) ...

>BTW: Please don't strip the Cc whenreplying to linux-kernel.
>
>
>--- linux-2.6.15-rc2/drivers/media/video/cx88/Makefile.old	2005-11-23 18:34:07.000000000 +0100
>+++ linux-2.6.15-rc2/drivers/media/video/cx88/Makefile	2005-11-23 18:34:18.000000000 +0100
>@@ -9,21 +9,21 @@
> EXTRA_CFLAGS += -I$(src)/..
> EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
> EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends
>-ifneq ($(CONFIG_VIDEO_BUF_DVB),n)
>+ifneq ($(CONFIG_VIDEO_BUF_DVB),)
>  EXTRA_CFLAGS += -DHAVE_VIDEO_BUF_DVB=1
> endif
>-ifneq ($(CONFIG_DVB_CX22702),n)
>+ifneq ($(CONFIG_DVB_CX22702),)
>  EXTRA_CFLAGS += -DHAVE_CX22702=1
> endif
>-ifneq ($(CONFIG_DVB_OR51132),n)
>+ifneq ($(CONFIG_DVB_OR51132),)
>  EXTRA_CFLAGS += -DHAVE_OR51132=1
> endif
>-ifneq ($(CONFIG_DVB_LGDT330X),n)
>+ifneq ($(CONFIG_DVB_LGDT330X),)
>  EXTRA_CFLAGS += -DHAVE_LGDT330X=1
> endif
>-ifneq ($(CONFIG_DVB_MT352),n)
>+ifneq ($(CONFIG_DVB_MT352),)
>  EXTRA_CFLAGS += -DHAVE_MT352=1
> endif
>-ifneq ($(CONFIG_DVB_NXT200X),n)
>+ifneq ($(CONFIG_DVB_NXT200X),)
>  EXTRA_CFLAGS += -DHAVE_NXT200X=1
> endif
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
-- 
Michael Krufky


