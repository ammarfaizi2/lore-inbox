Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272871AbRIMXU1>; Thu, 13 Sep 2001 19:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272847AbRIMXUT>; Thu, 13 Sep 2001 19:20:19 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:11201 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272871AbRIMXUC>;
	Thu, 13 Sep 2001 19:20:02 -0400
Date: Thu, 13 Sep 2001 16:20:20 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [IrDA patch] ir247_lap_keepalive.diff
Message-ID: <20010913162020.F7470@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir247_lap_keepalive.diff :
------------------------
	<Apply after ir248_disco_fixes_4.diff to avoid "offset X lines">
	o [FEATURE] Add "lap_keepalive_time" sysctl
		- Control how long LAP stay alive after last socket closed
		- Allow to test the secondary disconnect path
		- Allow to trigger LMP deadlocks fixed one month ago

diff -u -p linux/include/net/irda/irlmp.j1.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.j1.h	Thu Sep 13 12:07:12 2001
+++ linux/include/net/irda/irlmp.h	Thu Sep 13 12:08:30 2001
@@ -247,6 +247,7 @@ extern char *lmp_reasons[];
 extern int sysctl_discovery_timeout;
 extern int sysctl_discovery_slots;
 extern int sysctl_discovery;
+extern int sysctl_lap_keepalive_time;	/* in ms, default is LM_IDLE_TIMEOUT */
 extern struct irlmp_cb *irlmp;
 
 static inline hashbin_t *irlmp_get_cachelog(void) { return irlmp->cachelog; }
diff -u -p linux/net/irda/irlmp.j1.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.j1.c	Thu Sep 13 12:07:27 2001
+++ linux/net/irda/irlmp.c	Thu Sep 13 12:08:30 2001
@@ -49,6 +49,7 @@ struct irlmp_cb *irlmp = NULL;
 int  sysctl_discovery         = 0;
 int  sysctl_discovery_timeout = 3; /* 3 seconds by default */
 int  sysctl_discovery_slots   = 6; /* 6 slots by default */
+int  sysctl_lap_keepalive_time = LM_IDLE_TIMEOUT * 1000 / HZ;
 char sysctl_devname[65];
 
 char *lmp_reasons[] = {
diff -u -p linux/net/irda/irsysctl.j1.c linux/net/irda/irsysctl.c
--- linux/net/irda/irsysctl.j1.c	Thu Sep 13 12:07:39 2001
+++ linux/net/irda/irsysctl.c	Thu Sep 13 12:08:30 2001
@@ -33,7 +33,7 @@
 
 #define NET_IRDA 412 /* Random number */
 enum { DISCOVERY=1, DEVNAME, DEBUG, SLOTS, DISCOVERY_TIMEOUT, 
-       SLOT_TIMEOUT, MAX_BAUD_RATE, MAX_INACTIVE_TIME };
+       SLOT_TIMEOUT, MAX_BAUD_RATE, MAX_INACTIVE_TIME, LAP_KEEPALIVE_TIME, };
 
 extern int  sysctl_discovery;
 extern int  sysctl_discovery_slots;
@@ -44,6 +44,7 @@ int         sysctl_compression = 0;
 extern char sysctl_devname[];
 extern int  sysctl_max_baud_rate;
 extern int  sysctl_max_inactive_time;
+extern int  sysctl_lap_keepalive_time;
 
 #ifdef CONFIG_IRDA_DEBUG
 extern unsigned int irda_debug;
@@ -88,6 +89,8 @@ static ctl_table irda_table[] = {
 	{ MAX_BAUD_RATE, "max_baud_rate", &sysctl_max_baud_rate,
 	  sizeof(int), 0644, NULL, &proc_dointvec },
 	{ MAX_INACTIVE_TIME, "max_inactive_time", &sysctl_max_inactive_time,
+	  sizeof(int), 0644, NULL, &proc_dointvec },
+	{ LAP_KEEPALIVE_TIME, "lap_keepalive_time", &sysctl_lap_keepalive_time,
 	  sizeof(int), 0644, NULL, &proc_dointvec },
 	{ 0 }
 };
diff -u -p linux/net/irda/irlmp_event.j1.c linux/net/irda/irlmp_event.c
--- linux/net/irda/irlmp_event.j1.c	Thu Sep 13 12:07:50 2001
+++ linux/net/irda/irlmp_event.c	Thu Sep 13 12:08:30 2001
@@ -387,9 +387,15 @@ static void irlmp_state_active(struct la
 		 *  must be the one that tries to close IrLAP. It will be 
 		 *  removed later and moved to the list of unconnected LSAPs
 		 */
-		if (HASHBIN_GET_SIZE(self->lsaps) > 0)
-			irlmp_start_idle_timer(self, LM_IDLE_TIMEOUT);
-		else {
+		if (HASHBIN_GET_SIZE(self->lsaps) > 0) {
+			/* Make sure the timer has sensible value (the user
+			 * may have set it) - Jean II */
+			if(sysctl_lap_keepalive_time < 100)	/* 100ms */
+				sysctl_lap_keepalive_time = 100;
+			if(sysctl_lap_keepalive_time > 10000)	/* 10s */
+				sysctl_lap_keepalive_time = 10000;
+			irlmp_start_idle_timer(self, sysctl_lap_keepalive_time * HZ / 1000);
+		} else {
 			/* No more connections, so close IrLAP */
 
 			/* We don't want to change state just yet, because
