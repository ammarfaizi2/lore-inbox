Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317386AbSGYGQc>; Thu, 25 Jul 2002 02:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318348AbSGYGQc>; Thu, 25 Jul 2002 02:16:32 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:43784 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317386AbSGYGQb>;
	Thu, 25 Jul 2002 02:16:31 -0400
Date: Wed, 24 Jul 2002 23:19:26 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: cli-sti-removal.txt fixup
Message-ID: <20020725061926.GC13691@kroah.com>
References: <20020725003735.GA12682@kroah.com> <Pine.LNX.4.44.0207241815120.4293-100000@home.transmeta.com> <20020725060106.GA13691@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725060106.GA13691@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 27 Jun 2002 04:48:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 11:01:06PM -0700, Greg KH wrote:
> On Wed, Jul 24, 2002 at 06:17:17PM -0700, Linus Torvalds wrote:
> > > @@ -2814,15 +2814,15 @@
> > >  		}
> > >  		dmabuf->count = dmabuf->dmasize;
> > >  		outb(31,card->iobase+dmabuf->write_channel->port+OFF_LVI);
> > > -		save_flags(flags);
> > > -		cli();
> > > +		local_irq_save(flags);
> > > +		local_irq_disable();
> > 
> > First off, "local_irq_save()" does both the save and the disable (the same
> > way "spin_lock_irqsave()" does), it's the "local_save_flags(") that is
> > equivalent to the old plain save_flags. So this should just be
> > 
> > 	local_irq_save(flags);
> 
> Ah, sorry, I didn't get that from cli-sti-removal.txt.  Actually it
> looks like cli-sti-removal.txt is a bit wrong, as there is no
> local_irq_save_off() function.  I'll send a patch for that next.

Here's that patch.

thanks,

greg k-h


diff -Nru a/Documentation/cli-sti-removal.txt b/Documentation/cli-sti-removal.txt
--- a/Documentation/cli-sti-removal.txt	Wed Jul 24 23:25:38 2002
+++ b/Documentation/cli-sti-removal.txt	Wed Jul 24 23:25:38 2002
@@ -94,10 +94,10 @@
 released.
 
 drivers that want to disable local interrupts (interrupts on the
-current CPU), can use the following five macros:
+current CPU), can use the following four macros:
 
   local_irq_disable(), local_irq_enable(), local_irq_save(flags),
-  local_irq_save_off(flags), local_irq_restore(flags)
+  local_irq_restore(flags)
 
 but beware, their meaning and semantics are much simpler, far from
 that of the old cli(), sti(), save_flags(flags) and restore_flags(flags)
@@ -107,11 +107,7 @@
 
     local_irq_enable()        => turn local IRQs on
 
-    local_irq_save(flags)     => save the current IRQ state into flags. The
-                                 state can be on or off. (on some
-                                 architectures there's even more bits in it.)
-
-    local_irq_save_off(flags) => save the current IRQ state into flags and
+    local_irq_save(flags)     => save the current IRQ state into flags and
                                  disable interrupts.
 
     local_irq_restore(flags)  => restore the IRQ state from flags.
