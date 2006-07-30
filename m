Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWG3IIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWG3IIO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 04:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWG3IIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 04:08:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:51549 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751360AbWG3IIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 04:08:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=YM6KtJHCkAInF6QKKcW+2rrLIKREYsnn3CASpMlND5Xn5YoOACKdLZGnLQdgiSFJNrsuLoog2EXaXQ6jvc6F8vpGXMVZz7pKIXls/VDrszTd0e66j4wnqP2Ama0GzdvjIaBUoz4poS04foy0i4PFVcP8FwzFbmILjvsGHmjR2g0=
Message-ID: <44CC68EE.1080208@gmail.com>
Date: Sun, 30 Jul 2006 10:07:51 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org, linux-mm@kvack.org
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
References: <20060727015639.9c89db57.akpm@osdl.org> <44CBF60C.3090508@gmail.com> <20060730000652.GA2057@elf.ucw.cz> <200607300931.07679.rjw@sisk.pl>
In-Reply-To: <200607300931.07679.rjw@sisk.pl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki napsal(a):
> On Sunday 30 July 2006 02:06, Pavel Machek wrote:
>> Hi!
>>
>>>>>>> I have problems with swsusp again. While suspending, the very last thing kernel
>>>>>>> writes is 'restoring higmem' and then hangs, hardly. No sysrq response at all.
>>>>>>> Here is a snapshot of the screen:
>>>>>>> http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif
>>>>>>>
>>>>>>> It's SMP system (HT), higmem enabled (1 gig of ram).
>>>>>> Most probably it hangs in device_power_up(), so the problem seems to be
>>>>>> with one of the devices that are resumed with IRQs off.
>>>>>>
>>>>>> Does vanila .18-rc2 work?
>>>>> Yup, it does.
>>>> Can you try up kernel, no highmem? (mem=512M)?
>>> It writes then:
>>> p16v: status 0xffffffff, mask 0x00001000, pvoice f7c04a20, use 0
>>> in endless loop when resuming -- after reading from swap.
>> Okay, so we have two different problems here.
>>
>> One is "hang during suspend" with smp/highmem mode,
> 
> That one is "interesting".  I've no idea why the restoration of highmem would
> have caused the box to hang like that.  Jiri, could you please post the output
> of dmesg after a fresh boot?

higmem is ok. ioapic0 is the culprit -- its class resume dies:
        if (cls->resume)
                cls->resume(dev); <----
in __sysdev_resume

>> and one is probably driver problem with p16v (whatever it is).
>>
>> /data/l/linux/sound/pci/emu10k1/irq.c:
>> snd_printk(KERN_ERR "p16v: status: 0x%08x, mask=0x%08x, pvoice=%p,
>> use=%d\n", status2, mask, pvoice, pvoice->use);
>>
>> ...aha, so you may want to unload emu10k1 for testing.

Sure, this helped.

>> Since you mention radeon in one of your other mails, just try it in
>> vesafb mode...
> 
> Yes.  Or just don't compile the radeon driver and see what happens.

Doesn't matter. I do not use graphics (fb) in console -- radeon was not inited
at all, it was bad tip.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
