Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVC3T2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVC3T2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVC3T0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:26:41 -0500
Received: from bartol.udel.edu ([128.175.14.150]:59878 "EHLO bartol.udel.edu")
	by vger.kernel.org with ESMTP id S262383AbVC3TU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:20:58 -0500
Message-ID: <424AFC3B.7090007@bartol.udel.edu>
Date: Wed, 30 Mar 2005 14:21:31 -0500
From: Rich Townsend <rhdt@bartol.udel.edu>
Organization: Bartol Research Institute
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       dtor_core@ameritech.net, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] 2.6.11 acpi battery state readout as source of keyboard/touchpad
 troubles
References: <424AF9C3.4000905@domdv.de>
In-Reply-To: <424AF9C3.4000905@domdv.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> In traceing the source of my sporadic synaptics touchpad troubles
> 
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
> 
> and keyboard troubles (sporadically lost key up/down events) on an Acer
> Aspire 1520 (x86_64, latest bios v1.09) I did enable the
> report_lost_ticks option which did spit out stuff like the following at
> regular intervals:
> 
> time.c: Lost 17 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 19 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 18 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> 
> This looked suspiciously like it happended when the the kde laptop
> applet polled the battery status. So I did terminate the applet.
> 
> The result was no more lost ticks, no lost keyboard events and no more
> lost touchpad sync.
> 
> To verify ACPI battery data as the source of trouble i did a simple
> 
> cat /proc/acpi/battery/BAT0/state
> 
> which instantly resulted in:
> 
> time.c: Lost 19 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> 
> So it seems ACPI battery readout does cause some long running interrupt
> disable and that it causes nasty side effects for the 8042 input.
> 
> Note that doing
> 
> cat /proc/acpi/battery/BAT0/info
> 
> doesn't cause any trouble (battery alarm is unsupported).
> 
> I can ignore the lost ticks but the keyboard/touchpad problems caused by
> the state readout are definitely nasty.
> 
> Any ideas?

Yes. I strongly suspect that your problems are caused by the embedded
controller driver. On many laptop systems, the embedded controller is
used to access and query the batter subsystem. Unfortunately, the driver
code that performs embedded controller reads and writes currently uses a
spinlock to prevent multiple accesses. A typical read/write operation
can take around 2.5 ms, during which no interrupts can be serviced.

I've been trying to make noise about this problem on the ACPI mailing
list, but progress on this issue is still glacial. Luming Yu has posted
a patch to 2.6.11 that appears to resolve the interrupt blocking, but it
has the side effect that embedded controller access becomes unacceptably
slow.

cheers,

Rich

