Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWAaAES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWAaAES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWAaAES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:04:18 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:41653 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965046AbWAaAER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:04:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JIHsEtjrua71ZCqgtZ/nj/m5yQcTCGMcbabcKEhHkEuYKmqBK1aunRwYojOF8FUlBtMa/RClFHI+kzY50BRuNEP6m5PibgTYPd0ggNc3ws4+zlf7lxuTAZYeBkR6GDCg+itBvJVfSHteTbiGkkNv+zB2hti+1S2PUgidXgpP1Jw=
Message-ID: <43DEA978.8000706@gmail.com>
Date: Tue, 31 Jan 2006 09:04:08 +0900
From: Tejun <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata queue updated
References: <20060128182522.GA31458@havoc.gtf.org> <200601300936.43977.ioe-lkml@rameria.de> <43DDD206.6000502@gmail.com> <200601302002.18962.ioe-lkml@rameria.de>
In-Reply-To: <200601302002.18962.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi,
> 
> On Monday 30 January 2006 09:44, Tejun Heo wrote:
> 
>>So, are you saying....
>>
>>struct ata_classes {
>>	unsigned int classes[2];
>>|;
>>
>>is safer than
>>
>>unsigned int *class;
>>
>>?
> 
>  
> No, but with a little bit of additional code it CAN be safer.
> 
> Or maybe, we can store the classification in a different way.
> 
> What about putting the information directly into "ap->device[INDEX].class" 
> in the sole caller (ata_drive_probe_reset) so far?
> 

Not altering ->class directly in lldd driver is one major point of this 
whole patchset such that higher level driving logic has a say on whether 
a device is online or not, not the low level driver.  Primarily this is 
useful for sharing low-level codes with hot plugging / EH but it's also 
possible to retry some of the operations during probing in limited cases.

> 
>>>So please let the core layer pass a bounded array here or provide
>>>a function from core layer to set that and check the index.
>>>
>>
>>Can you show me what you have in mind as code?
> 
>  
> /* Define this to 15, if you need to */
> #define ATA_MAX_CLASSES 2
> struct ata_set {
>         unsigned int class[ATA_MAX_CLASSES];
> };
> 
> void set_ata_class(struct ata_set *cls, unsigned int idx, unsigned int what)
> {
>         BUG_ON(idx >= ARRAY_SIZE(cls->class);
>         cls->class[idx] = what;
> }
> 
> set_ata_class(&myclass, 0, what);
> 
> You can enforce that even better by making "what" 
> a typedef like we do it with pte/pmd/pud/pgd in the VM.

First of all, I'm not a big fan of safety through typedef/structure kind 
of stuff.  For VM, I think it's justifiable, but this class thing 
doesn't involve any complex operation around it.  Drivers just do what 
they do and record the result into the @classes array.  I mean, how/why 
a driver would touch classes[1] when it can recognize only one device. 
It's dictated by the hardware spec and reflected in the driver code.  If 
a driver doesn't get this right, things wouldn't work at all.  @classes 
safety is a minor issue at that point.

> But I prefer not passing this class stuff around, which would even safe
> arguments and thus reduce code size.

No boudnary check is done for accessing ap->device[i] and this is really 
not a place to worry about code size, IMHO.

> Maybe we should even have a classify ata port operation instead?

In ATA, probe and reset are closely related.  There's only one way to 
get class code without resetting - EDD, and it doesn't always work well. 
  That's why the callback is named ->probe_reset.  ATA devices are 
designed to be classfied by resetting them.

-- 
tejun
