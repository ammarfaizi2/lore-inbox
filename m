Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132986AbRADNFK>; Thu, 4 Jan 2001 08:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbRADNFA>; Thu, 4 Jan 2001 08:05:00 -0500
Received: from du-225-88.nat.dialup.freesurf.fr ([212.43.225.88]:10760 "EHLO
	wild-wind.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S132912AbRADNEs>; Thu, 4 Jan 2001 08:04:48 -0500
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.UiT.No
Subject: Re: [IrDA+SMP] Lockup in handle_IRQ_event
In-Reply-To: <wrpzoh89t1c.fsf@hina.wild-wind.fr.eu.org> <3A53B356.32353C01@uow.edu.au>
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: Loën 12 juin 1996 13:10
X-Baby-2: None
Reply-to: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 04 Jan 2001 10:58:56 +0100
Message-ID: <wrpsnmz63kv.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: Andrew Morton's message of "Thu, 04 Jan 2001 10:18:46 +1100"
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Capitol Reef"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AM" == Andrew Morton <andrewm@uow.edu.au> writes:

Hi Andrew,

AM> Try this:

AM> --- linux-2.4.0-prerelease/net/irda/irqueue.c	Tue Nov 21 20:11:22 2000
AM> +++ linux-akpm/net/irda/irqueue.c	Thu Jan  4 10:14:10 2001
AM> @@ -436,7 +436,7 @@
 
AM>  	/* Release lock */
AM>  	if ( hashbin->hb_type & HB_GLOBAL) {
AM> -		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
AM> +		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
AM>  	} else if ( hashbin->hb_type & HB_LOCAL) {
AM>  		restore_flags( flags);


Ok, that wasn't enough, but you pointed me to the right
direction. With your patch, the machine survived a few more seconds,
that crashed with a slightly different path :

>>EIP; c010a5e5 <handle_IRQ_event+21/78>   <=====
Trace; c010a7f6 <do_IRQ+a6/f4>
Trace; c0108fbc <ret_from_intr+0/20>
Trace; d0830018 <[irda]irlmp_unregister_client+20/54>
Trace; d0835f01 <[irda]hashbin_insert+bd/c4>
Trace; d082f863 <[irda]irlmp_disconnect_request+7b/98>
Trace; d0837299 <[irda]irttp_disconnect_request+f1/f8>
Trace; d0878d58 <[ircomm]ircomm_ttp_disconnect_request+14/18>
Trace; d0878767 <[ircomm]ircomm_state_conn+83/b8>
Trace; d08787c0 <[ircomm]ircomm_do_event+24/2c>
Trace; d0878467 <[ircomm]ircomm_disconnect_request+17/20>
Trace; d0838438 <[irda]__irias_delete_attrib+0/30>
Trace; d087d2eb <[ircomm-tty]ircomm_tty_state_ready+47/a4>
Trace; d087d36c <[ircomm-tty]ircomm_tty_do_event+24/2c>
Trace; d087c92a <[ircomm-tty]ircomm_tty_detach_cable+72/a8>
Trace; d087bfac <[ircomm-tty]ircomm_tty_shutdown+88/b8>
Trace; d087b8fa <[ircomm-tty]ircomm_tty_close+c2/16c>
Trace; c017e960 <release_dev+244/514>
Trace; c017efc9 <tty_release+2d/68>
Trace; c0132af1 <fput+39/e8>
Trace; c0131aa2 <filp_close+b2/bc>
Trace; c01184fb <put_files_struct+4f/b8>
Trace; c0118cd3 <do_exit+127/274>
Trace; c0118e4a <sys_exit+e/10>
Trace; c0108efb <system_call+33/38>
Code;  c010a5e5 <handle_IRQ_event+21/78>

hashbin_insert was guilty this time. So, using your patch as a
guideline, I changed all spin_lock_irqsave/spin_unlock_irq pairs to
spin_lock_irqsave/spin_unlock_irqrestore. Which seems to make sense
anyway !

Using this patch, the machine is solid, and I've been able to play
with my phone as much as I wanted to (well... while the battery
lasted, anyway... ;-).

Here's the patch (which of course includes yours). If it's proved to
be correct, it would be a good idea to summit it to Linus while
prerelease is still open to fixes.

Thanks a lot for your help.

	M.

--- linux/net/irda/irqueue.c.prerelease	Thu Jan  4 10:21:13 2001
+++ linux/net/irda/irqueue.c	Thu Jan  4 10:24:39 2001
@@ -198,7 +198,7 @@
 	
 	/* Release lock */
 	if ( hashbin->hb_type & HB_GLOBAL)
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 	else if (hashbin->hb_type & HB_LOCAL) {
 		restore_flags( flags);
 	}
@@ -258,7 +258,7 @@
 	/* Release lock */
 	if ( hashbin->hb_type & HB_GLOBAL) {
 
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
 	} else if ( hashbin->hb_type & HB_LOCAL) {
 		restore_flags( flags);
@@ -327,7 +327,7 @@
 	
 	/* Release lock */
 	if ( hashbin->hb_type & HB_GLOBAL) {
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
 	} else if ( hashbin->hb_type & HB_LOCAL) {
 		restore_flags( flags);
@@ -436,7 +436,7 @@
 
 	/* Release lock */
 	if ( hashbin->hb_type & HB_GLOBAL) {
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
 	} else if ( hashbin->hb_type & HB_LOCAL) {
 		restore_flags( flags);
@@ -511,7 +511,7 @@
 
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
