Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUBVIsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 03:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUBVIsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 03:48:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2829 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261203AbUBVIsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 03:48:13 -0500
Date: Sun, 22 Feb 2004 09:41:53 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-rc4
Message-ID: <20040222084153.GA20189@alpha.home.local>
References: <Pine.LNX.4.58L.0402180207540.4852@logos.cnet> <20040218055744.GC15660@alpha.home.local> <Pine.LNX.4.58L.0402181132480.4852@logos.cnet> <20040220224836.GA32153@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220224836.GA32153@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Fri, Feb 20, 2004 at 11:48:36PM +0100, Pavel Machek wrote:
> > 
> > Your fix looks ok. I dont think calling acpi_system_save_state(S5) can
> > cause any breakage. Len?
> 
> I bet it will create "machine will reboot instead of poweroff" on some
> strange machine.... Perhaps it fixes more machines than it breaks, but
> it will probably break some.

This is interesting. Do you have an idea about what could break exactly ?
In my case, I have noticed two things :
  - if I disable local APIC, the standard code works
  - if I enable local APIC, I need the patch above.

So perhaps it would be enough to disable local APIC instead of calling this
function ?

BTW, I have retested on the Supermicro server which didn't want to stop
previously. It's a P4 HT. Interestingly, with the new code, it displays :
  Power Down
  Trying to free free IRQ 23

IRQ 23 is assigned to eth0 (e1000). If I rmmod e1000 before, then it stops
correctly. And if I boot it with 'nosmp', it stops correcly both with new
and older code.

So I suspect that sending PM events is not exactly SMP safe, and that this
system cannot power off in SMP for an unknown reason. Perhaps as with APM,
some parts of the code need to be executed by CPU0 only ? Or perhaps when
I booted with 'nosmp', APIC was disabled ? (I didn't notice particularly).

I can do tests on my notebook, but I'm mainly lacking ideas now. I will
try to disable APIC only, just in case. And if it doesn't work on the
P4 HT, I can try to stop every CPU>0. If we don't find an universal solution,
it might indicate that we need another boot option to adapt to different
hardware :-(

Regards,
Willy

