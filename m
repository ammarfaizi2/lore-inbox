Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWALHn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWALHn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 02:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWALHn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 02:43:58 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:30776 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750927AbWALHn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 02:43:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Ngpkyhf18rPxoBJSZ8883tT8pIz5H1/m928+nP4z8XoMs7Sja+5AxGPgdkgvRHeqUw2UldH3gFoNtXNF3yStkIx+zk6EvqvL99VY9gkjSXHvF/ITXp9g5QgYFORSx4te1HNwW4xflnMqUhMCnMjR0UvugqVm1AXKVgsonAlkWU0=
Message-ID: <43C608B7.4040304@gmail.com>
Date: Thu, 12 Jan 2006 08:43:51 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051210)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>, akpm@osdl.org,
       "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.15-git5] new alsa power management completly broken
References: <43C36B0D.3030808@gmail.com>	<s5hr77gfg0l.wl%tiwai@suse.de>	<43C3A24C.3010207@gmail.com> <s5hoe2kf2vu.wl%tiwai@suse.de>
In-Reply-To: <s5hoe2kf2vu.wl%tiwai@suse.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai ha scritto:

>At Tue, 10 Jan 2006 13:02:20 +0100,
>Patrizio Bassi wrote:
>  
>
>>ok i'll test asap. (i think tomorrow).
>>
>>i'll do:
>>1) start pc
>>2) load module and play a wav
>>3) suspend without unloading
>>4) resume (and it shouldn't work)
>>5) unload
>>6) reload and try if that works again (should)
>>
>><joke> blame you, after a report of course. :PPP </joke>
>>    
>>
>
>Any news about blaming or blessing? :)
>
>  
>
>>do you want me to add any debug printk? if so, where? (or post me a patch)
>>    
>>
>
>The patch below might help.  Give it a shot.
>
>
>Takashi
>
>--- a/sound/pci/ens1370.c	7 Dec 2005 11:13:55 -0000	1.91
>+++ b/sound/pci/ens1370.c	10 Jan 2006 16:41:08 -0000
>@@ -2061,6 +2061,13 @@
> #ifdef CHIP1371	
> 	snd_ac97_suspend(ensoniq->u.es1371.ac97);
> #else
>+	/* try to reset AK4531 */
>+	outw(ES_1370_CODEC_WRITE(AK4531_RESET, 0x02), ES_REG(ensoniq, 1370_CODEC));
>+	inw(ES_REG(ensoniq, 1370_CODEC));
>+	udelay(100);
>+	outw(ES_1370_CODEC_WRITE(AK4531_RESET, 0x03), ES_REG(ensoniq, 1370_CODEC));
>+	inw(ES_REG(ensoniq, 1370_CODEC));
>+	udelay(100);
> 	snd_ak4531_suspend(ensoniq->u.es1370.ak4531);
> #endif	
> 	pci_set_power_state(pci, PCI_D3hot);
>
>  
>

sorry for delay, however i tested it and works perfectly.

just 2 things to notice:
1) [unrelated to this bug] swsusp ram pages write and read is really
slower than 2.6.14 one. i didn't follow changes, so don't know what happened

2) when i suspend i continue to see errors 0x660 in my tty. The strange
thing is that after resume they are no more in dmesg!
strange. however, as i wrote before, it works.

ps. i tested with module only, i'll switch back to built-in solution but
i think there won't be any problems.

big thanks to takashi for patch, please apply.

--
Patrizio Bassi
www.patriziobassi.it
