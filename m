Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWEZVxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWEZVxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWEZVxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:53:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:63538 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750988AbWEZVxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:53:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DpV+rCoMK/eN8Tx0dO3PsSa1s0HCrnBnWhz1uVLpTOCyI0jgoN9JoGQWsd9FJuK/ycmmBTtGdYaBKXeRcUg893y+5xcsvsx03iIuzX9DnR9mtBAHKxFNKoDbrWO1UVKa7uKWSi2sQ4Iqu/MFEQIledcwpc8x0g0TIZC/FOjvXEA=
Message-ID: <447778DA.8080507@gmail.com>
Date: Sat, 27 May 2006 00:53:30 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/13] input: make input a multi-object module
References: <20060526161129.557416000@gmail.com>	<20060526162902.227348000@gmail.com>	<20060526141603.054f0459.akpm@osdl.org>	<44777340.7030905@gmail.com> <20060526144309.60469bcd.akpm@osdl.org>
In-Reply-To: <20060526144309.60469bcd.akpm@osdl.org>
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
>>>>Move the input.c to input-core.c and modify Makefile so that the input module
>>>>can be built from multiple source files. This is preparing for the input-ff.c.
>>>>
>>>>Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
>>>>
>>>>---
>>>>drivers/input/Makefile     |    2 
>>>>drivers/input/input-core.c | 1099 +++++++++++++++++++++++++++++++++++++++++++++
>>>>drivers/input/input.c      | 1099 ---------------------------------------------
>>>
>>>urgh.  There are other changes pending againt input.c and this renaming
>>>makes everything a huge pain.
>>>
>>>What does "can be built from multiple source files" mean?
>>
>>Well, I want to embed the input-ff.c into the input module too.
> 
> 
> What does "embed" mean?  #include a .c file, or what?  (If "yes" then "no",
> there's enough of that happening and it's an awful thing to do).
> 

No, but this (from Documentation/kbuild/makefiles.txt):
<clip>
	If a kernel module is built from several source files, you specify
	that you want to build a module in the same way as above.

	Kbuild needs to know which the parts that you want to build your
	module from, so you have to tell it by setting an
	$(<module_name>-objs) variable.

	Example:
		#drivers/isdn/i4l/Makefile
		obj-$(CONFIG_ISDN) += isdn.o
		isdn-objs := isdn_net_lib.o isdn_v110.o isdn_common.o

	In this example, the module name will be isdn.o. Kbuild will
	compile the objects listed in $(isdn-objs) and then run
	"$(LD) -r" on the list of these files to generate isdn.o.
</clip>

input.o would be the "module" name, and it would be by default build
from input-core.o, and if INPUT_FF_EFFECTS is enabled, then also input-ff.o.

Then any functions in input-ff.c that are called from input-core.c would
not need to be EXPORT_SYMBOLed to the rest of the kernel.

Note especially that the module name of such module can't be the same as
one of the source files that the module is built from (I tried). That's
the reason for the rename.

>>>It would be much nicer all round if we could avoid renaming this file.
>>
>>Indeed... There are these 4 options as far as I see:
>>
>>1. Do this rename
>>2. Put all the code in input-ff.c to input.c
>>3. Make the input-ff a separate bool "module" and add
>>EXPORT_SYMBOL_GPL() for input_ff_event() which is currently the only
>>function in input-ff.c that is called from input.c
>>4. Rename the input "module" to something else, it doesn't matter so
>>much as almost everybody builds it as built-in anyway.
>>
>>WDYT is the best one?
> 
> 
> I still don't know what problem you're trying to solve so I cannot say.

Maybe you know now.

-- 
Anssi Hannula

