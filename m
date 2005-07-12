Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVGLS15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVGLS15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVGLS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:27:48 -0400
Received: from kirby.webscope.com ([204.141.84.57]:28033 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S262152AbVGLS0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:26:02 -0400
Message-ID: <42D40AF0.8060100@m1k.net>
Date: Tue, 12 Jul 2005 14:24:48 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [PATCH -rc2-mm2] BUG FIX - v4l broken hybrid dvb inclusion
References: <42D3DC5A.3010807@m1k.net> <200507122107.51907.adobriyan@gmail.com> <42D3FBA4.3050501@m1k.net> <200507122218.38508.adobriyan@gmail.com>
In-Reply-To: <200507122218.38508.adobriyan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

>On Tuesday 12 July 2005 21:19, Michael Krufky wrote:
>  
>
>>Alexey Dobriyan wrote:
>>    
>>
>>>On Tuesday 12 July 2005 19:06, Michael Krufky wrote:
>>>
>>>>I had tested this change against 2.6.13-rc2-mm1, and it worked perfectly as
>>>>expected, but it caused problems in today's 2.6.13-rc2-mm2 release.  For
>>>>some reason, the symbols don't get set properly.
>>>>
>>What I meant was the CONFIG_DVB_LGDT3302 , etc flags
>>
>>Previous patch removed the #define's that you see below... This should 
>>have worked, since these should be set instead from kconfig, but it 
>>didn't work as expected (even though the modules ARE selected by 
>>kconfig),
>>    
>>
>Strange... I did allyesconfig and preprocessed source shows lgdt3302.h,
>or51132.h et al. are included. What's your .config?
>
>>and the #ifdef's return false.... (I don't know why it worked  
>>in my test against 2.6.13-rc2-mm1, but it doesn't work in -mm2, and it 
>>must be fixed) Breaks all hybrid v4l/dvb boards.
>>    
>>
Everything does get built, just as you say... However, there is code 
inside cx88-dvb.c and saa7134-dvb.c that is enclosed within #ifdef's 
...  This code is NOT included during the compile.  For some reason the 
#ifdef's are turning up as false during compile time... In -mm1 this 
didn't happen.  For now, I am just setting these to true at the top of 
the *-dvb.c files... In the future, we (v4l) will either provide a 
better solution, or just remove the #define AND #ifdef's alltogether...  
I am including an excerp from cx88-dvb.c to illustrate what I am talking 
about:

#if CONFIG_DVB_MT352
# include "mt352.h"
# include "mt352_priv.h"
#endif
#if CONFIG_DVB_CX22702
# include "cx22702.h"
#endif
#if CONFIG_DVB_OR51132
# include "or51132.h"
#endif
#if CONFIG_DVB_LGDT3302
# include "lgdt3302.h"
#endif

<snip>

#if CONFIG_DVB_MT352
static int dvico_fusionhdtv_demod_init(struct dvb_frontend* fe)
{
	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x39 };
	static u8 reset []         = { RESET,      0x80 };
	static u8 adc_ctl_1_cfg [] = { ADC_CTL_1,  0x40 };
	static u8 agc_cfg []       = { AGC_TARGET, 0x24, 0x20 };

<snip>

static struct mt352_config dntv_live_dvbt_config = {
	.demod_address = 0x0f,
	.demod_init    = dntv_live_dvbt_demod_init,
	.pll_set       = mt352_pll_set,
};
#endif

<snip>

This should be enough to explain what I am talking about... Of course this is just a small snippet...
There is more in cx88-dvb.c that does this, as well as saa7134-dvb.c...

In -mm2, the code inside the #if is NOT compiled... This is a problem, and this is why I sumbitted the patch.

-- 
Michael Krufky


