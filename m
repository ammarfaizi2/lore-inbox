Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWHMRTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWHMRTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWHMRTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 13:19:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:41295 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751336AbWHMRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 13:19:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Qk2PXCH6Gy9f1TXw5zoVldo7qOpyz0FzUhgsCJpvyzvYMCcbhYH8aEAl2QCUkxRv8/aEd7yAZXzt9lEkmV7lfllnK3Tkhd/MZichKOa7fWfH/R/pve1pnQH+AJ+LaXXTDtOiEOyH9FEo7psYhz3doaUzfvpP5VfZkP+1RG/Mo0M=
Message-ID: <44DF5F59.4000100@gmail.com>
Date: Sun, 13 Aug 2006 19:20:25 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: 2.6.18-rc4-mm1: drivers/video/sis/ compile error
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813153034.GD3543@stusta.de> <6bffcb0e0608130929k28ea4974sbced3374067d6794@mail.gmail.com> <20060813164056.GF3543@stusta.de>
In-Reply-To: <20060813164056.GF3543@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Aug 13, 2006 at 06:29:46PM +0200, Michal Piotrowski wrote:
>> On 13/08/06, Adrian Bunk <bunk@stusta.de> wrote:
>>> On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>>>> ...
>>>> Changes since 2.6.18-rc3-mm2:
>>>> ...
>>>> +drivers-video-sis-sis_mainh-removal-of-old.patch
>>>> ...
>>>>  fbdev updates
>>>> ...
>>> This patch removes too much:
>>> ...
>> I'll take a closer look at this. I have tested this with allyesconfig
>> on 2006-08-08-00-59 mm snapshot,

Not as well as I should.

>> but now it doesn't build when
>> CONFIG_FB_SIS=y (CONFIG_FB_SIS=m builds fine for me).
>>
>> Thanks for pointing that out.
> 
> The problem is here:
> 
> <--  snip  -->
> 
> ...
>  #ifdef MODULE
> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
> -static int sisfb_mode_idx = -1;
> -#else
> -static int sisfb_mode_idx = MODE_INDEX_NONE;  /* Don't use a mode by default if we are a module */
> -#endif
> -#else
>  static int sisfb_mode_idx = -1;               /* Use a default mode if we are inside the kernel */
>  #endif
> ...
> 
> <--  snip  -->
> 
> It's easy to see that you removed too much (or too few, since the
> #ifdef MODULE can be removed - there's also a similar no longer 
> required #ifdef MODULE in sis_main.c).

Thanks for your help.

This patch should fix this problem. Tested with CONFIG_FB_SIS=y and CONFIG_FB_SIS=m.

> 
> cu
> Adrian
> 

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/drivers/video/sis/sis_main.c linux-mm/drivers/video/sis/sis_main.c
--- linux-mm-clean/drivers/video/sis/sis_main.c	2006-08-13 19:12:46.000000000 +0200
+++ linux-mm/drivers/video/sis/sis_main.c	2006-08-13 18:58:49.000000000 +0200
@@ -83,13 +83,7 @@ sisfb_setdefaultparms(void)
 	sisfb_max		= -1;
 	sisfb_userom		= -1;
 	sisfb_useoem		= -1;
-#ifdef MODULE
-	/* Module: "None" for 2.4, default mode for 2.5+ */
-	sisfb_mode_idx		= -1;
-#else
-	/* Static: Default mode */
 	sisfb_mode_idx		= -1;
-#endif
 	sisfb_parm_rate		= -1;
 	sisfb_crt1off		= 0;
 	sisfb_forcecrt1		= -1;
diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/drivers/video/sis/sis_main.h linux-mm/drivers/video/sis/sis_main.h
--- linux-mm-clean/drivers/video/sis/sis_main.h	2006-08-13 19:12:46.000000000 +0200
+++ linux-mm/drivers/video/sis/sis_main.h	2006-08-13 19:06:43.000000000 +0200
@@ -67,9 +67,7 @@ static int sisfb_ypan = -1;
 static int sisfb_max = -1;
 static int sisfb_userom = 1;
 static int sisfb_useoem = -1;
-#ifdef MODULE
 static int sisfb_mode_idx = -1;               /* Use a default mode if we are inside the kernel */
-#endif
 static int sisfb_parm_rate = -1;
 static int sisfb_crt1off = 0;
 static int sisfb_forcecrt1 = -1;

