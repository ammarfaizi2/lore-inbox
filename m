Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVCLQEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVCLQEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVCLQBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:01:39 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:18124 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261942AbVCLPzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:55:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IciESIizYkHRM2ENTX1XrlTkF0S5I5Ds5g2qXtCqvJ36ObvAzmcF8gUQxMRQzYa97NJue/yv1x7kYrIaOuTw7D85ntj2DpE6TfH+BuArIS1u/zeCdi6XLZvLreEGoVRdmN9BSp5I4tjVSzd5+sPMAXGv8ox6Ram23NJ5XvRuyl0=
Message-ID: <9e473391050312075548fb0f29@mail.gmail.com>
Date: Sat, 12 Mar 2005 10:55:21 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005 14:36:10 +1100, Peter Chubb
<peterc@gelato.unsw.edu.au> wrote:
> 
> As many of you will be aware, we've been working on infrastructure for
> user-mode PCI and other drivers.  The first step is to be able to
> handle interrupts from user space. Subsequent patches add
> infrastructure for setting up DMA for PCI devices.

I've tried implementing this before and could not get around the
interrupt problem. Most interrupts on the x86 architecture are shared.
Disabling the IRQ at the PIC blocks all of the shared IRQs. This works
(hope your userspace handler is last on the shared handler list) until
you have a problem in userspace.

Once you have a problem in userspace there is no way to acknowledge
the interrupt anymore. I tried to address that by maintaining a timer
and suspending the hardware through the D0 state to reset it. That had
some success. Not acknowledging the interrupt results in an interrupt
loop and reboot.

The problem can be mitigated by choosing what slot your hardware to
put your hardware in. This can reduce the number of shared interrupts.
If you can get exclusive use of the interrupt this method will work.

If I were designing a new bus I would make interrupt acknowledge part
of PCI config space in order to allow a single piece of code to
acknowledge them. Since we can't change the bus the only safe way to
do this is to build a hardware specific driver for each device to
acknowledge the interrupt.

Bottom line is that I could find no reliable solution for handing interrupts.

-- 
Jon Smirl
jonsmirl@gmail.com
