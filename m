Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSLBXfX>; Mon, 2 Dec 2002 18:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265228AbSLBXfA>; Mon, 2 Dec 2002 18:35:00 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:22015 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265201AbSLBXdG>;
	Mon, 2 Dec 2002 18:33:06 -0500
Date: Mon, 2 Dec 2002 15:39:03 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.4] : ir241_lsap_lap_close-2.diff
Message-ID: <20021202233903.GE16284@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir241_lsap_lap_close-2.diff :
---------------------------
		<apply after ir241_flow_sched_lap_lmp-6.diff to avoid fuzz>
	o [CORRECT] Cancel LSAP watchdog when putting socket back to listen
	o [CORRECT] Try to close LAP when closing LSAP still active
	        <Following patch from Felix Tang>
	o [CORRECT] Header fix for compile on Alpha architecture



diff -u -p linux/include/net/irda/irlmp.d7.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d7.h	Wed Apr 10 18:32:46 2002
+++ linux/include/net/irda/irlmp.h	Fri Apr 12 09:54:54 2002
@@ -278,6 +278,8 @@ static inline void irlmp_listen(struct l
 	self->dlsap_sel = LSAP_ANY;
 	self->lap = NULL;
 	self->lsap_state = LSAP_DISCONNECTED;
+	/* Started when we received the LM_CONNECT_INDICATION */
+	del_timer(&self->watchdog_timer);
 }
 
 #endif
diff -u -p linux/net/irda/irlmp.d7.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d7.c	Wed Apr 10 18:20:24 2002
+++ linux/net/irda/irlmp.c	Wed Apr 10 18:27:26 2002
@@ -236,6 +236,16 @@ void irlmp_close_lsap(struct lsap_cb *se
 	lap = self->lap;
 	if (lap) {
 		ASSERT(lap->magic == LMP_LAP_MAGIC, return;);
+		/* We might close a LSAP before it has completed the
+		 * connection setup. In those case, higher layers won't
+		 * send a proper disconnect request. Harmless, except
+		 * that we will forget to close LAP... - Jean II */
+		if(self->lsap_state != LSAP_DISCONNECTED) {
+			self->lsap_state = LSAP_DISCONNECTED;
+			irlmp_do_lap_event(self->lap,
+					   LM_LAP_DISCONNECT_REQUEST, NULL);
+		}
+		/* Now, remove from the link */
 		lsap = hashbin_remove(lap->lsaps, (int) self, NULL);
 	}
 	self->lap = NULL;
diff -u -p linux/net/irda/parameters.d7.c linux/net/irda/parameters.c
--- linux/net/irda/parameters.d7.c	Fri Apr 12 14:45:08 2002
+++ linux/net/irda/parameters.c	Fri Apr 12 14:45:29 2002
@@ -28,6 +28,7 @@
  *     
  ********************************************************************/
 
+#include <linux/types.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
 
