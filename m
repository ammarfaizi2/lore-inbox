Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVJKDDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVJKDDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVJKDDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:03:48 -0400
Received: from tus-gate1.raytheon.com ([199.46.245.230]:52816 "EHLO
	tus-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S1751364AbVJKDDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:03:47 -0400
Message-ID: <434B2B7B.9040509@raytheon.com>
Date: Mon, 10 Oct 2005 20:03:23 -0700
From: Robert Crocombe <rwcrocombe@raytheon.com>
Organization: Raytheon Missile Systems -- Tucson, AZ, U.S.
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PS/2 Keyboard under 2.6.x
References: <434B121A.3000705@raytheon.com> <5bdc1c8b0510101832v5f0c80d0ldec1ade4d4530292@mail.gmail.com>
In-Reply-To: <5bdc1c8b0510101832v5f0c80d0ldec1ade4d4530292@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Knecht wrote:
> I just reported this problem on the Gentoo bugzilla a couple of days
> ago. Here I have a P4HT machine. I had never turned on SMP to use the
> hyperthreading feature. When I turned it on I got exactly the problem
> you talk about. When I went back to UMP it worked fine.

Such was not the case for me.  It still didn't work:
            CPU0
   0:      71543    IO-APIC-edge  timer
   7:          0    IO-APIC-edge  parport0
   8:          0    IO-APIC-edge  rtc
   9:          0   IO-APIC-level  acpi
  14:         13    IO-APIC-edge  ide0
169:       2104   IO-APIC-level  megaraid
177:        249   IO-APIC-level  eth0
193:          0   IO-APIC-level  ohci_hcd:usb1, ohci_hcd:usb2
201:        539   IO-APIC-level  uhci_hcd:usb3
209:     181556   IO-APIC-level  uhci_hcd:usb4
217:       2664   IO-APIC-level  ehci_hcd:usb5
225:          2   IO-APIC-level  ohci1394
NMI:         81
LOC:      71028
ERR:          0
MIS:          0

and I also got:

Oct 10 18:50:36 hydra kernel: irq 209: nobody cared (try booting with 
the "irqpoll" option)
Oct 10 18:50:36 hydra kernel:
Oct 10 18:50:36 hydra kernel: Call 
Trace:<ffffffff8015b335>{__report_bad_irq+53} 
<ffffffff8015b5cb>{note_interrupt+571}
Oct 10 18:50:36 hydra kernel:        <ffffffff8015b0b0>{do_irqd+0} 
<ffffffff80149270>{keventd_create_kthread+0}
Oct 10 18:50:36 hydra kernel:        <ffffffff8015b23e>{do_irqd+398} 
<ffffffff801494ad>{kthread+205}
Oct 10 18:50:36 hydra kernel:        <ffffffff8010f6b2>{child_rip+8} 
<ffffffff80149270>{keventd_create_kthread+0}
Oct 10 18:50:36 hydra kernel:        <ffffffff801493e0>{kthread+0} 
<ffffffff8010f6aa>{child_rip+0}
Oct 10 18:50:36 hydra kernel:
Oct 10 18:50:36 hydra kernel: handlers:
Oct 10 18:50:36 hydra kernel: [usb_hcd_irq+0/80] (usb_hcd_irq+0x0/0x50)

so I tried booting with the noted flag, which got me:

BUG: scheduling while atomic: kjournald/0x00010001/792
caller is schedule+0xf8/0x130

Call Trace: <IRQ> <ffffffff803716eb>{__schedule+155} 
<ffffffff803723b8>{schedule+248}
        <ffffffff8037321d>{___down_mutex+589} 
<ffffffff802e5eae>{megaraid_isr+62}
        <ffffffff8015b497>{note_interrupt+263} 
<ffffffff8015a4b7>{__do_IRQ+279}
        <ffffffff8011120f>{do_IRQ+47} <ffffffff8010f1a8>{ret_from_intr+0}
         <EOI> <ffffffff8026b688>{__delay+8} 
<ffffffff802e4d81>{megaraid_mbox_runpendq+209}
        <ffffffff802d6370>{scsi_done+0} 
<ffffffff802e60e2>{megaraid_queue_command+114}
        <ffffffff802d6874>{scsi_dispatch_cmd+548} 
<ffffffff802dd216>{scsi_request_fn+806}
        <ffffffff8017f320>{sync_buffer+0} 
<ffffffff802c9af8>{generic_unplug_device+24}
        <ffffffff8017f356>{sync_buffer+54} 
<ffffffff80372940>{__wait_on_bit+64}
        <ffffffff8017f320>{sync_buffer+0} 
<ffffffff803729fa>{out_of_line_wait_on_bit+122}
        <ffffffff80149840>{wake_bit_function+0} 
<ffffffff801d6c3b>{journal_commit_transaction+2235}
        <ffffffff8013cc19>{lock_timer_base+41} 
<ffffffff801d9ac9>{kjournald+233}
        <ffffffff801d9440>{commit_timeout+0} 
<ffffffff801496e0>{autoremove_wake_function+0}
        <ffffffff80136ccb>{do_exit+1051} <ffffffff8010f6b2>{child_rip+8}
        <ffffffff802cf1a0>{as_queue_empty+0} <ffffffff801d99e0>{kjournald+0}
        <ffffffff8010f6aa>{child_rip+0}

I went back to the SMP kernel, but also appended "irqpoll", and got 
another BUG.  Somehow the Windows machine I'm using to capture the 
serial console output didn't get the entirety of the appropriate line, 
but it was similar to:

"BUG: scheduling with interrupts disabled: swapper 0x00010001"

or similar.

I should note that the other machines with the problem are also SMP: my 
home machine is a dual 1GHz Pentium III, and the Redhat machine is a 
hyper-threaded 3.4GHz Xeon.

While I'm at it, I am getting insane clock corrections:

Oct 10 19:10:40 hydra ntpd[4128]: adjusting local clock by -0.711763s
Oct 10 19:13:18 hydra ntpd[4128]: adjusting local clock by -0.579583s
Oct 10 19:16:30 hydra ntpd[4128]: adjusting local clock by -0.460506s

Anyone know what that might be about?

-- 
Robert Crocombe
rwcrocombe@raytheon.com

