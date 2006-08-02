Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWHBT5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWHBT5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWHBT5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:57:08 -0400
Received: from wx-out-0102.google.com ([66.249.82.204]:44303 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932196AbWHBT5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:57:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WPBp1SVH5yDGegWXLZWAZ+35OCGWeyZYFc8VjnPmBARbXbtPnKi9+6tTb6eghRBdpYh6q6SuT8O1eG4ycC8Fn4zCZrBEIpp2s809szpRjBA1uVaO1UyMTanlFYT7Lp0yMBeBDEJGOLBZslXeVBgIqGx0716F9HdCMWmHoGm5z8g=
Message-ID: <4807377b0608021257p27882866i69a5a0a4a1f05dda@mail.gmail.com>
Date: Wed, 2 Aug 2006 12:57:06 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Linux v2.6.18-rc3
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       cpufreq@www.linux.org.uk
In-Reply-To: <20060801215919.8596da9d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060731081112.05427677.akpm@osdl.org>
	 <Pine.LNX.4.44L0.0607311627240.5805-100000@iolanthe.rowland.org>
	 <4807377b0608012131mf160bc3iff724910191b521@mail.gmail.com>
	 <20060801215919.8596da9d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/06, Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 1 Aug 2006 21:31:22 -0700
> "Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:
>
> > On 7/31/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Mon, 31 Jul 2006, Andrew Morton wrote:
> > >
> > > > core_initcall() would suit.  That's actually a bit late for this sort of
> > > > thing, but we can always add a new section later if it becomes a problem.
> > > > I'd suggest that we ensure that srcu_notifier_chain_register() performs a
> > > > reliable BUG() if it gets called too early.
> > >
> > > Here's a patch to test.  I can't try it out on my machine because
> > > 2.6.18-rc2-mm1 (even without the patch) crashes partway through a
> > > suspend-to-disk, in a way that's extremely hard to debug.  Some sort of
> > > spinlock-related bug occurs within ioapic_write_entry.
> >
> > can't test because I also can't suspend or hibernate with rc2-mm1
> > (resume causes hard hang with the backlight and screen off)  The issue
> > i reported was against linus' 2.6.18-rc3 kernel.
> >
>
> This might help?
>
>
> author Jiri Slaby <ku@bellona.localdomain> Tue, 01 Aug 2006 01:16:13 +0159
>
> --- a/arch/i386/kernel/io_apic.c
> +++ b/arch/i386/kernel/io_apic.c
> @@ -2360,6 +2360,7 @@ static int ioapic_resume(struct sys_devi
>                 reg_00.bits.ID = mp_ioapics[dev->id].mpc_apicid;
>                 io_apic_write(dev->id, 0, reg_00.raw);
>         }
> +       spin_unlock_irqrestore(&ioapic_lock, flags);
>         for (i = 0; i < nr_ioapic_registers[dev->id]; i ++)
>                 ioapic_write_entry(dev->id, i, entry[i]);
>
> -
>
>

after applying this patch from jiri as well as the patch from alan, I
can now suspend and resume, and the patch from alan seems to work too,
but I have no idea if it executed.

BTW, I get junk out the serial port with the first bits of printk (and
during resume from S3 too) but then something manages to init the
serial port to the right speed and text starts coming out correctly.
