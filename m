Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSJCTaL>; Thu, 3 Oct 2002 15:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbSJCTaL>; Thu, 3 Oct 2002 15:30:11 -0400
Received: from gate.perex.cz ([194.212.165.105]:62223 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261299AbSJCTaH>;
	Thu, 3 Oct 2002 15:30:07 -0400
Date: Thu, 3 Oct 2002 21:31:18 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA fixes #1
In-Reply-To: <Pine.LNX.4.44.0210030828050.2066-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0210032104500.521-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Linus Torvalds wrote:

> 
> On Thu, 3 Oct 2002, Jaroslav Kysela wrote:
> > 
> > You can import this changeset into BK by piping this whole message to:
> > '| bk receive [path to repository]' or apply the patch as usual.
> 
> Don't even bother with the BK patches, I've never had them apply
> successfulyl for me, because your BK tree contains ChangeSets that simply
> do not exist in mine. As a result, your BK patches refuse to apply. Please 
> read the BK usage documentation.
> 
> Note that BK really only helps if you are careful, and I can synchronize 
> with your BK tree. The fact that your BK tree contains non-alsa stuff 

Please, remove the bksend script from Documentation/BK-usage/bksend . 
You don't like it and it's completely crappy. BK does renumbering of 
ChangeSets itselves. So everybody has different numbers for changesets.

The fix changeset was made using clean clone of BK repository of linux 2.5 
kernel tree and one "temporary" clone of first BK repository.

> already means that I cannot sync with it, which makes it pretty much 
> unusable.

Are you willing to do 'bk pull' from my BK tree to avoid such problems?
I have already a repository on bkbits.net.

> But even if that was fixed, what is all the OLD_USB crap, and 

Well, 2.5 is not only kernel version we are supporting. Yes, I know it's
bad to show "old compatibility" code with the actual one. The readability
is a bit worse, but USB was changed alot in 2.5 and it's not quite easy to
separate all things. If you have a better idea to hide compatibility code
for 2.4 kernels, I'm ready to repair all things.

> stuff like this:
> 
> > ChangeSet@1.676, 2002-10-03 12:03:21+02:00, perex@suse.cz
> >   ALSA compilation update
> >     - save_flags/cli/restore_flags removal
> 
> Don't even bother fixing compilation, if the end result is patches like
> 
> > @@ -140,20 +139,18 @@
> >  	snd_printdd("sgalaxy - setting up IRQ/DMA for WSS\n");
> >  #endif
> >  
> > -	save_flags(flags);
> > -	cli();
> > +	/* FIXME: this is really bogus --jk */
> > +	/* the irq line is not allocated (thus locked) for this device at the moment */
> > +	disable_irq(irq);
> >  
> >          /* initialize IRQ for WSS codec */
> >          tmp = interrupt_bits[irq % 16];
> > -        if (tmp < 0) {
> > -		restore_flags(flags);
> > +        if (tmp < 0)
> >                  return -EINVAL;
> > -	}
> >          outb(tmp | 0x40, port);
> >          tmp1 = dma_bits[dma % 4];
> >          outb(tmp | tmp1, port);
> >  
> > -	restore_flags(flags);
> >  	return 0;
> >  }
> >  
> 
> It's BETTER to not compile, than have obviously totally bogus code that 
> will break _other_ devices in the tree. 
> 
> You're disabling (and never re-enabling) an interrupt that isn't even 
> YOURS, for chrissake! Which just means that if that irq happens to be 
> shared with the harddisk, for example, you just killed the whole machine!
>
> Please, don't do crap like this. Sure, it may be an ISA driver, and if it
> has the right irq you may hope that it isn't shared (technically illegal
> in ISA, but certainly done nonetheless), but the old code didn't do 
> anything even _nearly_ that broken, and the trival spinlock replacement 
> should have worked quite as well as the old code ever did.

What block do you want to spinlock? It's an initialization phase - other
driver parts are not active, so spinlock is a dead code. I think that
original author wanted to prevent generating of interrupts for given line
at all. Anyway, you're right (I also stated it in my comment) that the
interrupt line should be free. I was working on all changes in hurry.
Hopefully, here is the correct patch:

===== sgalaxy.c 1.5 vs edited =====
--- 1.5/sound/isa/sgalaxy.c	Thu May 23 18:11:04 2002
+++ edited/sgalaxy.c	Thu Oct  3 21:00:10 2002
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/time.h>
+#include <linux/irq.h>
 #include <sound/core.h>
 #include <sound/sb.h>
 #include <sound/ad1848.h>
@@ -110,6 +111,10 @@
 	return 0;
 }
 
+static void snd_sgalaxy_dummy_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+}
+
 static int __init snd_sgalaxy_setup_wss(unsigned long port, int irq, int dma)
 {
 	static int interrupt_bits[] = {-1, -1, -1, -1, -1, -1, -1, 0x08, -1, 
@@ -117,8 +122,6 @@
 	static int dma_bits[] = {1, 2, 0, 3};
 	int tmp, tmp1;
 
-	unsigned long flags;
-
 	if ((tmp = inb(port + 3)) == 0xff)
 	{
 		snd_printdd("I/O address dead (0x%lx)\n", port);
@@ -140,20 +143,20 @@
 	snd_printdd("sgalaxy - setting up IRQ/DMA for WSS\n");
 #endif
 
-	save_flags(flags);
-	cli();
-
         /* initialize IRQ for WSS codec */
         tmp = interrupt_bits[irq % 16];
-        if (tmp < 0) {
-		restore_flags(flags);
+        if (tmp < 0)
                 return -EINVAL;
-	}
+
+	if (request_irq(irq, snd_sgalaxy_dummy_interrupt, SA_INTERRUPT, "sgalaxy", NULL))
+		return -EIO;
+
         outb(tmp | 0x40, port);
         tmp1 = dma_bits[dma % 4];
         outb(tmp | tmp1, port);
 
-	restore_flags(flags);
+	free_irq(irq, NULL);
+
 	return 0;
 }
 
> This, btw, is one reason why I don't like hidden CVS trees that are worked 
> on by people that don't know or care about the rest of the kernel - 
> because the end result ends up often being total crap, that is hidden by 
> large merges. I noticed this one only because the patch was of a 
> reasonable size, and I _shudder_ to think of what horrible things the big 
> broken merges have caused.

I hope that situation is not as bad as it seems in your eyes. Sure, we
have minor problems, because tracking of all kernel changes is very time
consuming (and we definitely want a time for our development), but I hope 
that we'll solve all troubles quickly.

> Yes, I'm frustrated. What can we do about things like this? I'll apply the 
> patch without the obviously horribly broken part, please don't 
> re-introduce it later.

I'll do my best.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

