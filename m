Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTBUACO>; Thu, 20 Feb 2003 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTBUABo>; Thu, 20 Feb 2003 19:01:44 -0500
Received: from palrel11.hp.com ([156.153.255.246]:33511 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S267323AbTBUABM>;
	Thu, 20 Feb 2003 19:01:12 -0500
Date: Thu, 20 Feb 2003 16:11:17 -0800
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : IrNET module fix
Message-ID: <20030221001116.GG26770@bougret.hpl.hp.com>
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

ir253_irnet_mod_hints-2.diff :
----------------------------
	o [CORRECT] Fix module refcounting (MOD_INC/DEC => .owner)
	o [FEATURE] Add hints to discovery (control channel)


diff -u -p linux/net/irda/irnet/irnet.j3.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.j3.h	Thu Feb 20 12:07:32 2003
+++ linux/net/irda/irnet/irnet.h	Thu Feb 20 13:41:10 2003
@@ -225,6 +225,10 @@
  *
  * v13 - 30.5.02 - Jean II
  *	o Update module init code
+ *
+ * v14 - 20.2.03 - Jean II
+ *	o Add discovery hint bits in the control channel.
+ *	o Remove obsolete MOD_INC/DEC_USE_COUNT in favor of .owner
  */
 
 /***************************** INCLUDES *****************************/
@@ -476,6 +480,7 @@ typedef struct irnet_log
   __u32		saddr;
   __u32		daddr;
   char		name[NICKNAME_MAX_LEN + 1];	/* 21 + 1 */
+  __u16_host_order hints;			/* Discovery hint bits */
 } irnet_log;
 
 /*
diff -u -p linux/net/irda/irnet/irnet_irda.j3.h linux/net/irda/irnet/irnet_irda.h
--- linux/net/irda/irnet/irnet_irda.j3.h	Thu Feb 20 12:07:43 2003
+++ linux/net/irda/irnet/irnet_irda.h	Thu Feb 20 13:39:28 2003
@@ -69,7 +69,8 @@ static void
 			 irnet_event,
 			 __u32,
 			 __u32,
-			 char *);
+			 char *,
+			 __u16);
 /* ----------------------- IRDA SUBROUTINES ----------------------- */
 static inline int
 	irnet_open_tsap(irnet_socket *);
diff -u -p linux/net/irda/irnet/irnet_irda.j3.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.j3.c	Thu Feb 20 12:07:51 2003
+++ linux/net/irda/irnet/irnet_irda.c	Thu Feb 20 13:39:28 2003
@@ -28,7 +28,8 @@ irnet_post_event(irnet_socket *	ap,
 		 irnet_event	event,
 		 __u32		saddr,
 		 __u32		daddr,
-		 char *		name)
+		 char *		name,
+		 __u16		hints)
 {
   unsigned long		flags;		/* For spinlock */
   int			index;		/* In the log */
@@ -52,6 +53,8 @@ irnet_post_event(irnet_socket *	ap,
     strcpy(irnet_events.log[index].name, name);
   else
     irnet_events.log[index].name[0] = '\0';
+  /* Copy hints */
+  irnet_events.log[index].hints.word = hints;
   /* Try to get ppp unit number */
   if((ap != (irnet_socket *) NULL) && (ap->ppp_open))
     irnet_events.log[index].unit = ppp_unit_number(&ap->chan);
@@ -609,7 +612,7 @@ irda_irnet_destroy(irnet_socket *	self)
        * doesn't exist anymore when we post the event, so we need to pass
        * NULL as the first arg... */
       irnet_post_event(NULL, IRNET_DISCONNECT_TO,
-		       self->saddr, self->daddr, self->rname);
+		       self->saddr, self->daddr, self->rname, 0);
     }
 
   /* Prevent various IrDA callbacks from messing up things
@@ -862,7 +865,7 @@ irnet_connect_socket(irnet_socket *	serv
 
   /* Notify the control channel */
   irnet_post_event(new, IRNET_CONNECT_FROM,
-		   new->saddr, new->daddr, server->rname);
+		   new->saddr, new->daddr, server->rname, 0);
 
   DEXIT(IRDA_SERV_TRACE, "\n");
   return 0;
@@ -893,7 +896,7 @@ irnet_disconnect_server(irnet_socket *	s
 
   /* Notify the control channel (see irnet_find_socket()) */
   irnet_post_event(NULL, IRNET_REQUEST_FROM,
-		   self->saddr, self->daddr, self->rname);
+		   self->saddr, self->daddr, self->rname, 0);
 
   /* Clean up the server to keep it in listen state */
   irttp_listen(self->tsap);
@@ -1108,12 +1111,12 @@ irnet_disconnect_indication(void *	insta
   /* If we were active, notify the control channel */
   if(test_open)
     irnet_post_event(self, IRNET_DISCONNECT_FROM,
-		     self->saddr, self->daddr, self->rname);
+		     self->saddr, self->daddr, self->rname, 0);
   else
     /* If we were trying to connect, notify the control channel */
     if((self->tsap) && (self != &irnet_server.s))
       irnet_post_event(self, IRNET_NOANSWER_FROM,
-		       self->saddr, self->daddr, self->rname);
+		       self->saddr, self->daddr, self->rname, 0);
 
   /* Close our IrTTP connection, cleanup tsap */
   if((self->tsap) && (self != &irnet_server.s))
@@ -1213,7 +1216,7 @@ irnet_connect_confirm(void *	instance,
 
   /* Notify the control channel */
   irnet_post_event(self, IRNET_CONNECT_TO,
-		   self->saddr, self->daddr, self->rname);
+		   self->saddr, self->daddr, self->rname, 0);
 
   DEXIT(IRDA_TCB_TRACE, "\n");
 }
@@ -1282,7 +1285,7 @@ irnet_status_indication(void *	instance,
     {
     case STATUS_NO_ACTIVITY:
       irnet_post_event(self, IRNET_BLOCKED_LINK,
-		       self->saddr, self->daddr, self->rname);
+		       self->saddr, self->daddr, self->rname, 0);
       break;
     default:
       DEBUG(IRDA_CB_INFO, "Unknown status...\n");
@@ -1648,7 +1651,8 @@ irnet_discovery_indication(discinfo_t *	
 
   /* Notify the control channel */
   irnet_post_event(NULL, IRNET_DISCOVER,
-		   discovery->saddr, discovery->daddr, discovery->info);
+		   discovery->saddr, discovery->daddr, discovery->info,
+		   u16ho(discovery->hints));
 
   DEXIT(IRDA_OCB_TRACE, "\n");
 }
@@ -1678,7 +1682,8 @@ irnet_expiry_indication(discinfo_t *	exp
 
   /* Notify the control channel */
   irnet_post_event(NULL, IRNET_EXPIRE,
-		   expiry->saddr, expiry->daddr, expiry->info);
+		   expiry->saddr, expiry->daddr, expiry->info,
+		   u16ho(expiry->hints));
 
   DEXIT(IRDA_OCB_TRACE, "\n");
 }
diff -u -p linux/net/irda/irnet/irnet_ppp.j3.h linux/net/irda/irnet/irnet_ppp.h
--- linux/net/irda/irnet/irnet_ppp.j3.h	Thu Feb 20 12:08:09 2003
+++ linux/net/irda/irnet/irnet_ppp.h	Thu Feb 20 12:08:26 2003
@@ -98,6 +98,7 @@ static int
 /* Filesystem callbacks (to call us) */
 static struct file_operations irnet_device_fops =
 {
+	.owner		= THIS_MODULE,
 	.read		= dev_irnet_read,
 	.write		= dev_irnet_write,
 	.poll		= dev_irnet_poll,
diff -u -p linux/net/irda/irnet/irnet_ppp.j3.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet/irnet_ppp.j3.c	Thu Feb 20 12:07:59 2003
+++ linux/net/irda/irnet/irnet_ppp.c	Thu Feb 20 13:39:28 2003
@@ -213,10 +213,12 @@ irnet_read_discovery_log(irnet_socket *	
   if(ap->disco_index < ap->disco_number)
     {
       /* Write an event */
-      sprintf(event, "Found %08x (%s) behind %08x\n",
+      sprintf(event, "Found %08x (%s) behind %08x {hints %02X-%02X}\n",
 	      ap->discoveries[ap->disco_index].daddr,
 	      ap->discoveries[ap->disco_index].info,
-	      ap->discoveries[ap->disco_index].saddr);
+	      ap->discoveries[ap->disco_index].saddr,
+	      ap->discoveries[ap->disco_index].hints[0],
+	      ap->discoveries[ap->disco_index].hints[1]);
       DEBUG(CTRL_INFO, "Writing discovery %d : %s\n",
 	    ap->disco_index, ap->discoveries[ap->disco_index].info);
 
@@ -313,16 +315,20 @@ irnet_ctrl_read(irnet_socket *	ap,
   switch(irnet_events.log[ap->event_index].event)
     {
     case IRNET_DISCOVER:
-      sprintf(event, "Discovered %08x (%s) behind %08x\n",
+      sprintf(event, "Discovered %08x (%s) behind %08x {hints %02X-%02X}\n",
 	      irnet_events.log[ap->event_index].daddr,
 	      irnet_events.log[ap->event_index].name,
-	      irnet_events.log[ap->event_index].saddr);
+	      irnet_events.log[ap->event_index].saddr,
+	      irnet_events.log[ap->event_index].hints.byte[0],
+	      irnet_events.log[ap->event_index].hints.byte[1]);
       break;
     case IRNET_EXPIRE:
-      sprintf(event, "Expired %08x (%s) behind %08x\n",
+      sprintf(event, "Expired %08x (%s) behind %08x {hints %02X-%02X}\n",
 	      irnet_events.log[ap->event_index].daddr,
 	      irnet_events.log[ap->event_index].name,
-	      irnet_events.log[ap->event_index].saddr);
+	      irnet_events.log[ap->event_index].saddr,
+	      irnet_events.log[ap->event_index].hints.byte[0],
+	      irnet_events.log[ap->event_index].hints.byte[1]);
       break;
     case IRNET_CONNECT_TO:
       sprintf(event, "Connected to %08x (%s) on ppp%d\n",
@@ -445,8 +451,6 @@ dev_irnet_open(struct inode *	inode,
   ap = kmalloc(sizeof(*ap), GFP_KERNEL);
   DABORT(ap == NULL, -ENOMEM, FS_ERROR, "Can't allocate struct irnet...\n");
 
-  MOD_INC_USE_COUNT;
-
   /* initialize the irnet structure */
   memset(ap, 0, sizeof(*ap));
   ap->file = file;
@@ -469,7 +473,6 @@ dev_irnet_open(struct inode *	inode,
     {
       DERROR(FS_ERROR, "Can't setup IrDA link...\n");
       kfree(ap);
-      MOD_DEC_USE_COUNT;
       return err;
     }
 
@@ -514,7 +517,6 @@ dev_irnet_close(struct inode *	inode,
     }
 
   kfree(ap);
-  MOD_DEC_USE_COUNT;
 
   DEXIT(FS_TRACE, "\n");
   return 0;
