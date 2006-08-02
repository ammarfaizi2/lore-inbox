Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWHBURU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWHBURU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHBURU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:17:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:16550 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932154AbWHBURT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:17:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Subject: Re: Linux v2.6.18-rc3
Date: Wed, 2 Aug 2006 22:16:54 +0200
User-Agent: KMail/1.9.3
Cc: "Andrew Morton" <akpm@osdl.org>, stern@rowland.harvard.edu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       cpufreq@www.linux.org.uk
References: <20060731081112.05427677.akpm@osdl.org> <20060801215919.8596da9d.akpm@osdl.org> <4807377b0608021257p27882866i69a5a0a4a1f05dda@mail.gmail.com>
In-Reply-To: <4807377b0608021257p27882866i69a5a0a4a1f05dda@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608022216.54797.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 21:57, Jesse Brandeburg wrote:
> On 8/1/06, Andrew Morton <akpm@osdl.org> wrote:
> > On Tue, 1 Aug 2006 21:31:22 -0700
> > "Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:
> >
> > > On 7/31/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > On Mon, 31 Jul 2006, Andrew Morton wrote:
> > > >
> > > > > core_initcall() would suit.  That's actually a bit late for this sort of
> > > > > thing, but we can always add a new section later if it becomes a problem.
> > > > > I'd suggest that we ensure that srcu_notifier_chain_register() performs a
> > > > > reliable BUG() if it gets called too early.
> > > >
> > > > Here's a patch to test.  I can't try it out on my machine because
> > > > 2.6.18-rc2-mm1 (even without the patch) crashes partway through a
> > > > suspend-to-disk, in a way that's extremely hard to debug.  Some sort of
> > > > spinlock-related bug occurs within ioapic_write_entry.
> > >
> > > can't test because I also can't suspend or hibernate with rc2-mm1
> > > (resume causes hard hang with the backlight and screen off)  The issue
> > > i reported was against linus' 2.6.18-rc3 kernel.
> > >
> >
> > This might help?
> >
> >
> > author Jiri Slaby <ku@bellona.localdomain> Tue, 01 Aug 2006 01:16:13 +0159
> >
> > --- a/arch/i386/kernel/io_apic.c
> > +++ b/arch/i386/kernel/io_apic.c
> > @@ -2360,6 +2360,7 @@ static int ioapic_resume(struct sys_devi
> >                 reg_00.bits.ID = mp_ioapics[dev->id].mpc_apicid;
> >                 io_apic_write(dev->id, 0, reg_00.raw);
> >         }
> > +       spin_unlock_irqrestore(&ioapic_lock, flags);
> >         for (i = 0; i < nr_ioapic_registers[dev->id]; i ++)
> >                 ioapic_write_entry(dev->id, i, entry[i]);
> >
> > -
> >
> >
> 
> after applying this patch from jiri as well as the patch from alan, I
> can now suspend and resume, and the patch from alan seems to work too,
> but I have no idea if it executed.
> 
> BTW, I get junk out the serial port with the first bits of printk (and
> during resume from S3 too) but then something manages to init the
> serial port to the right speed and text starts coming out correctly.

Please try the following patch from Russell King and see if it helps.

 drivers/char/tty_io.c        |   13 +++++++++++++
 drivers/serial/serial_core.c |   12 ++++++------
 include/linux/tty.h          |    2 ++
 3 files changed, 21 insertions(+), 6 deletions(-)

Index: linux-2.6.18-rc1-mm2/drivers/char/tty_io.c
===================================================================
--- linux-2.6.18-rc1-mm2.orig/drivers/char/tty_io.c
+++ linux-2.6.18-rc1-mm2/drivers/char/tty_io.c
@@ -1663,6 +1663,19 @@ release_mem_out:
 }
 
 /*
+ * Get a copy of the termios structure for the driver/index
+ */
+void tty_get_termios(struct tty_driver *driver, int idx, struct termios *tio)
+{
+	lock_kernel();
+	if (driver->termios[idx])
+		*tio = *driver->termios[idx];
+	else
+		*tio = driver->init_termios;
+	unlock_kernel();
+}
+
+/*
  * Releases memory associated with a tty structure, and clears out the
  * driver table slots.
  */
Index: linux-2.6.18-rc1-mm2/drivers/serial/serial_core.c
===================================================================
--- linux-2.6.18-rc1-mm2.orig/drivers/serial/serial_core.c
+++ linux-2.6.18-rc1-mm2/drivers/serial/serial_core.c
@@ -1981,16 +1981,16 @@ int uart_resume_port(struct uart_driver 
 		struct termios termios;
 
 		/*
-		 * First try to use the console cflag setting.
+		 * Get the termios for this line
 		 */
-		memset(&termios, 0, sizeof(struct termios));
-		termios.c_cflag = port->cons->cflag;
+		tty_get_termios(drv->tty_driver, port->line, &termios);
 
 		/*
-		 * If that's unset, use the tty termios setting.
+		 * If the console cflag is still set, subsitute that
+		 * for the termios cflag.
 		 */
-		if (state->info && state->info->tty && termios.c_cflag == 0)
-			termios = *state->info->tty->termios;
+		if (port->cons->cflag)
+			termios.c_cflag = port->cons->cflag;
 
 		port->ops->set_termios(port, &termios, NULL);
 		console_start(port->cons);
Index: linux-2.6.18-rc1-mm2/include/linux/tty.h
===================================================================
--- linux-2.6.18-rc1-mm2.orig/include/linux/tty.h
+++ linux-2.6.18-rc1-mm2/include/linux/tty.h
@@ -284,6 +284,8 @@ extern int tty_read_raw_data(struct tty_
 			     int buflen);
 extern void tty_write_message(struct tty_struct *tty, char *msg);
 
+extern void tty_get_termios(struct tty_driver *drv, int idx, struct termios *tio);
+
 extern int is_orphaned_pgrp(int pgrp);
 extern int is_ignored(int sig);
 extern int tty_signal(int sig, struct tty_struct *tty);
