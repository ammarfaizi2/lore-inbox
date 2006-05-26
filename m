Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWEZXHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWEZXHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWEZXHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:07:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:40377 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751679AbWEZXHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:07:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JeuATfJgkVd4xdA1effnReSJSsk2fe5NGdsoGcR69azHJxuOWdcDfWJ0IyCu7DMtSa9XBRcDH1sEyNufbPGJbsDwUimC1VmHqb17EHV3dTr4j4vWbFpWohRplrbcmf6X9YTigufsFhciyI/DUk2HOVtohIfpBptYV4aBMWlU/1Y=
Message-ID: <44778A14.4060500@gmail.com>
Date: Sat, 27 May 2006 02:07:00 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/13] input: make input a multi-object module
References: <20060526161129.557416000@gmail.com>	<20060526162902.227348000@gmail.com>	<20060526141603.054f0459.akpm@osdl.org>	<44777340.7030905@gmail.com>	<20060526144309.60469bcd.akpm@osdl.org>	<447778DA.8080507@gmail.com>	<20060526150804.0ae11b1f.akpm@osdl.org>	<44777F98.4080004@gmail.com> <20060526153246.267991ed.akpm@osdl.org>
In-Reply-To: <20060526153246.267991ed.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Anssi Hannula <anssi.hannula@gmail.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Anssi Hannula <anssi.hannula@gmail.com> wrote:
>>>
>>>
>>>>>>>It would be much nicer all round if we could avoid renaming this file.
>>>>>>
>>>>>>Indeed... There are these 4 options as far as I see:
>>>>>>
>>>>>>1. Do this rename
>>>>>>2. Put all the code in input-ff.c to input.c
>>>>>>3. Make the input-ff a separate bool "module" and add
>>>>>>EXPORT_SYMBOL_GPL() for input_ff_event() which is currently the only
>>>>>>function in input-ff.c that is called from input.c
>>>>>>4. Rename the input "module" to something else, it doesn't matter so
>>>>>>much as almost everybody builds it as built-in anyway.
>>>>>>
>>>>>>WDYT is the best one?
>>>>>
>>>>>
>>>>>I still don't know what problem you're trying to solve so I cannot say.
>>>>
>>>>Maybe you know now.
>>>
>>>
>>>yup, thanks.
>>>
>>>I'd have thought that 3) is the path of least resistance.
>>>
>>>But it does require that input.c "knows" that input-ff.c was included in
>>>the build, which is not a thing we like to do.
>>
>>Well, it's going to be included as built-in and can't be built as a
>>module at all, so I think it's okay for us to do so?
> 
> 
> If that's the case then no EXPORT_SYMBOL_GPL() is needed - we just link the
> the two .o files together, link the result into vmlinux?
> 

Probably so, I was under the false assumption that even built-in modules
should use EXPORT_SYMBOL.

>>>Why should things in input.c call into input-ff.c, btw?  The way we
>>>normally would handle that is to add a register_something() API to input.c
>>>and input-ff.c would insert its callback via that interface.
>>
>>Yes, we could easily add a callback to e.g. struct input_dev, but is
>>that really preferred if the input-ff.c is built-in?
> 
> 
> Nope, not if they're as tightly-coupled as that.

Actually, they don't call each others functions at all (except for the
one we discuss below)... But if input-ff.o would be allowed as a module,
device drivers would either need to know at the build time if input-ff.o
is enabled (not an option, as it could be built as a module afterwards),
_or_ query input.o if the input-ff.o is registered in. However the
latter causes again the situation that nothing depends on input-ff.o and
it is never loaded...

> However it still might not be _appropriate_ for the input core code to call
> into the force-feedback code in this manner.  It certainly sounds unusual.
> 

I guess I could just use the normal event() handler in input_dev:
FF-capable input-drivers should assign input_ff_event() as the event()
or call input_ff_event() in their own event() handler.

Hmm, just came to me mind that input.o can be built as module if
EMBEDDED is set. But input-ff.o doesn't actually require input.o (it's
just not useful without it), so input-ff.o as a built-in wouldn't be a
problem. That's why I wanted them to be in a single module (so that if
input.o is a module, input-ff.o would also be part of that module
instead of being built-in). But I don't think there is someone who runs
with EMBEDDED enabled, INPUT as a module, INPUT_FF_EFFECTS enabled, and
doesn't like that input-ff.o cannot be built as a module.

So, I guess we go for a separate input-ff.o as a bool.

Unless you have any more thoughts, I'll make patches for (1) separate
input-ff.o from input.o so that input.c renaming is not required, and to
(2) use the input_dev->event() handler instead of input.o calling
input-ff.o.

-- 
Anssi Hannula

