Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRADOMC>; Thu, 4 Jan 2001 09:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130163AbRADOLw>; Thu, 4 Jan 2001 09:11:52 -0500
Received: from [213.36.168.173] ([213.36.168.173]:21000 "EHLO
	wild-wind.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S129962AbRADOLf>; Thu, 4 Jan 2001 09:11:35 -0500
To: torvalds@transmeta.com
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        linux-irda@pasta.cs.UiT.No
Subject: [PATCH] [IrDA+SMP] Lockup in handle_IRQ_event
In-Reply-To: <wrpzoh89t1c.fsf@hina.wild-wind.fr.eu.org> <3A53B356.32353C01@uow.edu.au> <wrpsnmz63kv.fsf@hina.wild-wind.fr.eu.org> <3A547911.C5320C69@uow.edu.au>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: Loën 12 juin 1996 13:10
X-Baby-2: None
Reply-to: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 04 Jan 2001 15:13:08 +0100
Message-ID: <wrpvgrviex7.fsf_-_@hina.wild-wind.fr.eu.org>
In-Reply-To: Andrew Morton's message of "Fri, 05 Jan 2001 00:22:25 +1100"
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please find enclosed a patch against 2.4.0-prerelease that :

- Fixes a lockup in handle_IRQ_event when using IrDA on an SMP
machine. It changes spin_lock_irqsave/spin_unlock_irq pairs to
spin_lock_irqsave/spin_unlock_irqrestore, which seems to be the
logical thing to do.

- Removes 2 unused functions that are broken on SPARC (hashbin_unlock
does a restore_flags when save_flags is done in hashbin_lock, which
messes register windows).

With this patch, IrDA is rock solid on my x86 SMP box (at least with
my usage patern...). It was crashing immediatly before (NMI watchdog).

A previous version of this patch has been reviewed by Andrew Morton,
who said it looked ok.

Thanks for applying it to your tree.

	M.

--- linux/net/irda/irqueue.c.prerelease	Thu Jan  4 10:21:13 2001
+++ linux/net/irda/irqueue.c	Thu Jan  4 14:30:35 2001
@@ -8,6 +8,8 @@
  * Created at:    Tue Jun  9 13:29:31 1998
  * Modified at:   Sun Dec 12 13:48:22 1999
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified at:   Thu Jan  4 14:29:10 CET 2001
+ * Modified by:   Marc Zyngier <mzyngier@freesurf.fr>
  * 
  *     Copyright (C) 1998-1999, Aage Kvalnes <aage@cs.uit.no>
  *     Copyright (C) 1998, Dag Brattli, 
@@ -142,69 +144,6 @@
 }
 
 /*
- * Function hashbin_lock (hashbin, hashv, name)
- *
- *    Lock the hashbin
- *
- */
-void hashbin_lock(hashbin_t* hashbin, __u32 hashv, char* name, 
-		  unsigned long flags)
-{
-	int bin;
-	
-	IRDA_DEBUG(0, "hashbin_lock\n");
-
-	ASSERT(hashbin != NULL, return;);
-	ASSERT(hashbin->magic == HB_MAGIC, return;);
-
-	/*
-	 * Locate hashbin
-	 */
-	if (name)
-		hashv = hash(name);
-	bin = GET_HASHBIN(hashv);
-	
-	/* Synchronize */
-	if ( hashbin->hb_type & HB_GLOBAL )
-		spin_lock_irqsave(&hashbin->hb_mutex[ bin], flags);
-	else {
-		save_flags(flags);
-		cli();
-	}
-}
-
-/*
- * Function hashbin_unlock (hashbin, hashv, name)
- *
- *    Unlock the hashbin
- *
- */
-void hashbin_unlock(hashbin_t* hashbin, __u32 hashv, char* name, 
-		    unsigned long flags)
-{
-	int bin;
-
-	IRDA_DEBUG(0, "hashbin_unlock()\n");
-
-	ASSERT(hashbin != NULL, return;);
-	ASSERT(hashbin->magic == HB_MAGIC, return;);
-	
-	/*
-	 * Locate hashbin
-	 */
-	if (name )
-		hashv = hash(name);
-	bin = GET_HASHBIN(hashv);
-	
-	/* Release lock */
-	if ( hashbin->hb_type & HB_GLOBAL)
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
-	else if (hashbin->hb_type & HB_LOCAL) {
-		restore_flags( flags);
-	}
-}
-
-/*
  * Function hashbin_insert (hashbin, entry, name)
  *
  *    Insert an entry into the hashbin
@@ -258,7 +197,7 @@
 	/* Release lock */
 	if ( hashbin->hb_type & HB_GLOBAL) {
 
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
 	} else if ( hashbin->hb_type & HB_LOCAL) {
 		restore_flags( flags);
@@ -327,7 +266,7 @@
 	
 	/* Release lock */
 	if ( hashbin->hb_type & HB_GLOBAL) {
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
 	} else if ( hashbin->hb_type & HB_LOCAL) {
 		restore_flags( flags);
@@ -436,7 +375,7 @@
 
 	/* Release lock */
 	if ( hashbin->hb_type & HB_GLOBAL) {
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
 	} else if ( hashbin->hb_type & HB_LOCAL) {
 		restore_flags( flags);
@@ -511,7 +450,7 @@
 
 	/* Release lock */
 	if ( hashbin->hb_type & HB_GLOBAL) {
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
 	} else if ( hashbin->hb_type & HB_LOCAL) {
 		restore_flags( flags);

-- 
Places change, faces change. Life is so very strange.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
