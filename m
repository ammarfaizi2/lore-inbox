Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUGNH7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUGNH7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 03:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267316AbUGNH7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 03:59:41 -0400
Received: from tristate.vision.ee ([194.204.30.144]:40654 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S267314AbUGNH7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 03:59:35 -0400
Message-ID: <40F4E7F9.3020603@vision.ee>
Date: Wed, 14 Jul 2004 10:59:53 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
Organization: Vision
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040705)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <40F40080.8010801@vision.ee> <20040713221654.GJ21066@holomorphy.com>
In-Reply-To: <20040713221654.GJ21066@holomorphy.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Tue, Jul 13, 2004 at 06:32:16PM +0300, Lenar L?hmus wrote:
>  
>
>>Machine in question is XP2500+@1.84GHz (it was overlocked@2.25GHz during 
>>last test, now running at
>>official speed). Is this really slow for 1ms?
>>    
>>
>
>It should actually be fast enough. I suspect something else, maybe some
>slow devices. What's /proc/interrupts look like?
>  
>
           CPU0
  0:   60521505    IO-APIC-edge  timer
  1:      11445    IO-APIC-edge  i8042
  8:      33269    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:     523202    IO-APIC-edge  ide0
 15:      61761    IO-APIC-edge  ide1
 16:   10376547   IO-APIC-level  eth0
 19:     522859   IO-APIC-level  ide2
 20:     131904   IO-APIC-level  NVidia nForce2, ehci_hcd
 21:      66209   IO-APIC-level  ohci_hcd
 22:    9165291   IO-APIC-level  ohci_hcd, eth1
NMI:          0
LOC:   60351703
ERR:          0
MIS:          2

> <>exit_notify() isn't a huge surprise unless you're not doing things with
> lots of processes. Actually, it probably is a surprise, since it should
> only hurt when you're doing forkbombs and/or threadbombs.

It probably happened when users where simultaneously logging in (many 
kdeinit processes created at that time).

>Not surprised either. There's probably enough time spent with interrupts
>off the local_irq_save() hurt, and it didn't make your schedule() things
>go away, so my wild guesswork thus far is it made things worse with no
>tangible benefit, so best to drop that local_irq_save() change.
>  
>
Yeah, ok.

In the meantime couple of these found their way to logs during the night:
3ms non-preemptible critical section violated 2 ms preempt threshold 
starting at search_by_key+0xe3/0xf70 and ending at do_IRQ+0xec/0x130

And this still seems to be very long and real:
50ms non-preemptible critical section violated 2 ms preempt threshold 
starting at snd_pcm_action_lock_irq+0x1b/0x1d0 [snd_pcm] and ending at 
snd_pcm_action_lock_irq+0x65/0x1d0 [snd_pcm]
Trace has this:
[<f9239b09>] snd_pcm_playback_ioctl1+0x49/0x2f0 [snd_pcm]
So maybe this too is ioctl related (non-educated guess)?

Lenar
