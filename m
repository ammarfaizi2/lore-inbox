Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbTL3QwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbTL3QwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:52:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5902 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265851AbTL3Qur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:50:47 -0500
Date: Tue, 30 Dec 2003 16:50:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Message-ID: <20031230165042.B13556@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
References: <20031005171055.A21478@flint.arm.linux.org.uk> <20031228174622.A20278@flint.arm.linux.org.uk> <20031228182545.B20278@flint.arm.linux.org.uk> <Pine.LNX.4.58.0312281248190.11299@home.osdl.org> <20031230114324.A1632@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031230114324.A1632@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Dec 30, 2003 at 11:43:24AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 11:43:24AM +0000, Russell King wrote:
> On Sun, Dec 28, 2003 at 12:49:21PM -0800, Linus Torvalds wrote:
> > On Sun, 28 Dec 2003, Russell King wrote:
> > > 
> > > Would it be possible to switch LDT/GDT to whatever the APM BIOS expects
> > > just before calling the APM BIOS to suspend/hibernate, and restore them
> > > to whatever Linux requires after the APM BIOS returns from resume?
> > 
> > Possible, yes. But it would help a lot to know what's wrong with the 
> > current segments - we did leave most of them with exactly the same layout 
> > as before, and I thought we explicitly left the ones that APM cares about 
> > that way..
> 
> With thanks to Arjan, I think we've proven that this is not the change
> which is causing the problem by testing various Red Hat and Fedora 2.4
> kernels on the machine (which have various 2.6 NPTL backports.)
> 
> I'm now back to being completely out of my depth on this issue; a 2.4
> kernel booted through to init=/bin/bash suspends, but a 2.6 kernel
> with the same hardware support booted to the same point refuses to
> suspend via APM.
> 
> I think I'm going to have to resort to a binary search of the 2.5
> kernel series to find out exactly what broke and when.

Ok, the binary search led me to a changeset between 2.5.25 and 2.5.26
kernels.  Further investigation led me to i8042.c, specifically this:

static void __init i8042_start_polling(void)
{
        i8042_ctr &= ~I8042_CTR_KBDDIS;
        if (i8042_aux_values.exists)
                i8042_ctr &= ~I8042_CTR_AUXDIS;

        if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
                printk(KERN_WARNING "i8042.c: Can't write CTR while starting polling.\n");
                return;
        }

//      i8042_timer.function = i8042_timer_func;
//      mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
}

With the function as above, the observed behaviour is as follows:

- don't call i8042_start_polling at all - suspend works
- call i8042_start_polling - suspend fails

It seems that my BIOS is taking exception to CTR value we're writing.

My next step will be to try this with 2.6.0 and see whether this is the
only issue affecting APM suspend.  In the mean time, does Vojtech have
any hints?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
