Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUASVB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUASVBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:01:55 -0500
Received: from mail.convergence.de ([212.84.236.4]:50620 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263185AbUASVBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:01:53 -0500
Message-ID: <400C45BB.3010407@convergence.de>
Date: Mon, 19 Jan 2004 22:01:47 +0100
From: Holger Waechtler <holger@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-dvb@linuxtv.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb] Re: Kernel oops with ttusb_dec
References: <ecartis-01182004203937.22827.1@mail.convergence2.de> <200401182002.18784.linux-dvb@giblets.org> <200401182134.12598.rafael@mondoria.de> <200401182213.37387.linux-dvb@giblets.org> <E1Aig6W-0006m8-00@bigred.inka.de>
In-Reply-To: <E1Aig6W-0006m8-00@bigred.inka.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Titz wrote:
> [CCd to linux-kernel and dvb lists. Context: SuSE 9.0, kernel 2.4.21,
> ttusb_dec module fails]
> 
> 
>>>Is cipcb really needed in Release 1.36? It is the only modules which gives
>>>crc32 as a symbol.
> 
> 
>>>>>EIP; dde5ba82 <[cipcb]crc32+12/30>   <=====
>>>>>
>>>>>eax; dea04560 <[ttusb_dec]dsp_dec2000t+0/69100>
>>>>>edx; dea0455f <[ttusb_dec]dec3000s_frontend_info+bf/c0>
>>>>>esi; ddcfde18 <[snd-mixer-oss].data.end+eaf2141/ec4c389>
>>>>>edi; ddcfde20 <[snd-mixer-oss].data.end+eaf2149/ec4c389>
>>>>>esp; ddcfcdb4 <[snd-mixer-oss].data.end+eaf10dd/ec4c389>
> 
> 
>>No, cipcb isn't needed.  It should be using the crc32 function from the main
>>kernel.  If it's trying to use the one in cipcb, which takes very different
>>arguments, it's no wonder there is a problem.
>>
>>I'm unsure of the right way to fix this.  Suggestions anyone?

it's probably safer to use crc32_le() or crc32_be(), depends on which 
one exactly you need.

> Eeek. If the OP didn't even know if he needed the cipcb module, this
> should mean he didn't knowingly start the CIPE driver, and[*] thus the
> cipcb module was loaded by the modprobe dependency mechanism by virtue
> of it defining a symbol called "crc32".
> 
> modprobe shouldn't know of that symbol in the CIPE module at all,
> because it's not meant to be exported. There are some definitions in
> the module subsystem which deal with the exporting of symbols. I
> suspect either CIPE or DVB (or both of them) needs a fix in this area.
> Anyone here knows more?

Use a recent kernel, there crc32(), crc32_le() and crc32_be() are 
implemented as library functions.

> Another data point: crc32 isn't available in 2.4.21 at all, so it's
> apparently(?) not a kernel configuration problem. But shouldn't that
> mean that the ttusb_dec driver wouldn't run at all under that kernel?
> 
> Ah, by the way, this could perhaps have been avoided completely if the
> kernel was compiled with CONFIG_MODVERSIONS enabled (because then the
> crc32 function, if properly exported, would have gotten a name which
> depends on its arguments). This not being on unconditionally is one of
> my pet peeves with Linux and distros, because of the many CIPE
> bugreports I get which are due to just version incompatibilities.

Enabling CONFIG_MODVERSIONS causes even more troubles, just browse the 
LinuxDVB mailing list archives, you'll find hundrets of mails where 
people failed to install standalone drivers just because they/their 
friends/their distributor didn't managed it to install matching kernel 
source, kernel config and kernel image.

Holger

