Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSGUVPO>; Sun, 21 Jul 2002 17:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSGUVPN>; Sun, 21 Jul 2002 17:15:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22206 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313743AbSGUVPM>;
	Sun, 21 Jul 2002 17:15:12 -0400
Date: Sun, 21 Jul 2002 23:17:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: martin@dalecki.de
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
In-Reply-To: <3D3972C3.2010307@evision.ag>
Message-ID: <Pine.LNX.4.44.0207212312010.28392-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin,

On Sat, 20 Jul 2002, Marcin Dalecki wrote:

> Well I would like to allow myself to allow a tad bit of advocacy for
> this step.

the attached patch was a quick hack to get rid of the global cli() from
drivers/ide/main.c - but it's obviously broken and i'd like to fix it.

how can this be done cleanly - should we do a:

	synchronize_irq(drive->channel->irq);

before unregistering the driver?

this might not even be necessery i believe, since the implicit (?)  
free_irq() synchronizes with all pending instances of that interrupt
source.

is there something else i'm missing, something else we need to synchronize
with - perhaps the timers?

	Ingo

--- linux/drivers/ide/main.c.orig	Sun Jul 21 20:37:12 2002
+++ linux/drivers/ide/main.c	Sun Jul 21 21:06:28 2002
@@ -1091,18 +1091,18 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);		/* all CPUs */
-	cli();				/* all CPUs */
+	__save_flags(flags); // FIXME: is this safe?
+	__cli();
 
 #if 0
 	if (__MOD_IN_USE(ata_ops(drive)->owner)) {
-		restore_flags(flags);
+		__restore_flags(flags); // FIXME: is this safe?
 		return 1;
 	}
 #endif
 
 	if (drive->usage || drive->busy || !ata_ops(drive)) {
-		restore_flags(flags);	/* all CPUs */
+		__restore_flags(flags);	// FIXME: is this safe?
 		return 1;
 	}
 
@@ -1111,7 +1111,7 @@
 #endif
 	drive->driver = NULL;
 
-	restore_flags(flags);		/* all CPUs */
+	__restore_flags(flags); // FIXME: is this safe?
 
 	return 0;
 }


