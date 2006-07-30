Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWG3KyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWG3KyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWG3KyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:54:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:34526 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751387AbWG3KyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:54:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=o+0hIM4KkKd4YMKHi8FZ1i4WqelM9iHvU7u4GktFM79ADeOHzc65WF6Ub+RcDg2j4nKdTKEPAdM0bNmsBFDZcLj/+UfjF5ejE1Zv/+MJflHwiWxB3iNyQnnuYmLOeVPK7u6LKyk5YpD3J7igg1VeNGu5iVMEIgn8Kq/4WmMnCrY=
Message-ID: <44CC8FD3.5030403@gmail.com>
Date: Sun, 30 Jul 2006 12:53:48 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       alsa-devel@alsa-project.org, mingo@elte.hu
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
References: <20060727015639.9c89db57.akpm@osdl.org> <200607300931.07679.rjw@sisk.pl> <44CC68EE.1080208@gmail.com> <200607301128.04395.rjw@sisk.pl>
In-Reply-To: <200607301128.04395.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uncc: linux-mm
Cc: alsa-devel
Cc: mingo

Rafael J. Wysocki wrote:
> On Sunday 30 July 2006 10:08, Jiri Slaby wrote:
>> Rafael J. Wysocki napsal(a):
>>> On Sunday 30 July 2006 02:06, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>>>>> I have problems with swsusp again. While suspending, the very last thing kernel
>>>>>>>>> writes is 'restoring higmem' and then hangs, hardly. No sysrq response at all.
>>>>>>>>> Here is a snapshot of the screen:
>>>>>>>>> http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif
>>>>>>>>>
>>>>>>>>> It's SMP system (HT), higmem enabled (1 gig of ram).
>>>>>>>> Most probably it hangs in device_power_up(), so the problem seems to be
>>>>>>>> with one of the devices that are resumed with IRQs off.
>>>>>>>>
>>>>>>>> Does vanila .18-rc2 work?
>>>>>>> Yup, it does.
>>>>>> Can you try up kernel, no highmem? (mem=512M)?
>>>>> It writes then:
>>>>> p16v: status 0xffffffff, mask 0x00001000, pvoice f7c04a20, use 0
>>>>> in endless loop when resuming -- after reading from swap.
>>>> Okay, so we have two different problems here.

[snip]

>>>> and one is probably driver problem with p16v (whatever it is).
>>>>
>>>> /data/l/linux/sound/pci/emu10k1/irq.c:
>>>> snd_printk(KERN_ERR "p16v: status: 0x%08x, mask=0x%08x, pvoice=%p,
>>>> use=%d\n", status2, mask, pvoice, pvoice->use);
>>>>
>>>> ...aha, so you may want to unload emu10k1 for testing.
>> Sure, this helped.
> 
> So, we have two different regressions here.
> 
> Please try to revert git-alsa.patch and see if the emu10k1-related problem
> goes away.

Wow, it didn't helped, I find out there is a difference between in-kernel and 
modules version of the driver. When compiled as modules (loaded/unloaded) 
suspending (and resuming) is working ok (enabled higmem and preempt back -- 
still no smp), when compiled in-kernel (see the config diff below), it doesn't 
resume.
@@ -1263,8 +1263,8 @@
  CONFIG_SND=y
  CONFIG_SND_TIMER=y
  CONFIG_SND_PCM=y
-CONFIG_SND_HWDEP=m
-CONFIG_SND_RAWMIDI=m
+CONFIG_SND_HWDEP=y
+CONFIG_SND_RAWMIDI=y
  CONFIG_SND_SEQUENCER=y
  # CONFIG_SND_SEQ_DUMMY is not set
  CONFIG_SND_OSSEMUL=y
@@ -1282,8 +1282,8 @@
  #
  # Generic devices
  #
-CONFIG_SND_AC97_CODEC=m
-CONFIG_SND_AC97_BUS=m
+CONFIG_SND_AC97_CODEC=y
+CONFIG_SND_AC97_BUS=y
  # CONFIG_SND_DUMMY is not set
  # CONFIG_SND_VIRMIDI is not set
  # CONFIG_SND_MTPAV is not set
@@ -1347,7 +1347,7 @@
  # CONFIG_SND_INDIGO is not set
  # CONFIG_SND_INDIGOIO is not set
  # CONFIG_SND_INDIGODJ is not set
-CONFIG_SND_EMU10K1=m
+CONFIG_SND_EMU10K1=y
  # CONFIG_SND_EMU10K1X is not set
  # CONFIG_SND_ENS1370 is not set
  # CONFIG_SND_ENS1371 is not set


> As far as the first one is concerned, the genirq-* patches look suspicious.

Hmm, what to do?

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
