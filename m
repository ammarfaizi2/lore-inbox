Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263386AbRFEWEm>; Tue, 5 Jun 2001 18:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263390AbRFEWEe>; Tue, 5 Jun 2001 18:04:34 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:34504 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263386AbRFEWER>;
	Tue, 5 Jun 2001 18:04:17 -0400
Date: Tue, 5 Jun 2001 15:04:13 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Patch : IrNET v6
Message-ID: <20010605150413.A30309@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hi,

	This is the next revision of IrNET.
	The main big difference compared to the previous version is
"connection retries". Basically, instead of trying the IrDA connection
only once, we retry the full IrDA connection for as long as PPP is
trying to set up LCP. The IrDA connection may fail for various reasons
(device not aligned, packet loss, IrLAP not yet disconnected...). This
way, the user doesn't have to kill and restart the PPP instance by
himself.
	There are other minor fixes to support multiple IrDA dongle
properly from the IrNET control channel, plus a few cleanups.

	I did some heavy testing of the new code, and it basically
works and do what it's supposed to do. I've reported the few IrDA
pecularities to Dag, as usual...

	Alan : would you mind adding that to your tree ?

	Linus : maybe you want to wait until the result of testing in
Alan's tree.

	Have fun...

	Jean

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ir245_irnet_v6.diff"

diff -u -p -r linux/net/irda/irnet-v5/irnet.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet-v5/irnet.h	Thu May 31 10:21:50 2001
+++ linux/net/irda/irnet/irnet.h	Fri Jun  1 18:25:23 2001
@@ -168,6 +168,23 @@
  *		(but PPP doesn't read the MTU value :-()
  *	o Declare hashbin HB_NOLOCK instead of HB_LOCAL to avoid
  *		disabling and enabling irq twice
+ *
+ * v6 - 31/05/01 - Jean II
+ *	o Print source address in Found, Discovery, Expiry & Request events
+ *	o Print requested source address in /proc/net/irnet
+ *	o Change control channel input. Allow multiple commands in one line.
+ *	o Add saddr command to change ap->rsaddr (and use that in IrDA)
+ *	---
+ *	o Make the IrDA connection procedure totally asynchronous.
+ *	  Heavy rewrite of the IAS query code and the whole connection
+ *	  procedure. Now, irnet_connect() no longer need to be called from
+ *	  a process context...
+ *	o Enable IrDA connect retries in ppp_irnet_send(). The good thing
+ *	  is that IrDA connect retries are directly driven by PPP LCP
+ *	  retries (we retry for each LCP packet), so that everything
+ *	  is transparently controlled from pppd lcp-max-configure.
+ *	o Add ttp_connect flag to prevent rentry on the connect procedure
+ *	o Test and fixups to eliminate side effects of retries
  */
 
 /***************************** INCLUDES *****************************/
@@ -181,6 +198,8 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/netdevice.h>
 #include <linux/poll.h>
+#include <linux/config.h>
+#include <linux/ctype.h>	/* isspace() */
 #include <asm/uaccess.h>
 
 #include <linux/ppp_defs.h>
@@ -214,7 +233,7 @@
 
 /* PPP side of the business */
 #define BLOCK_WHEN_CONNECT	/* Block packets when connecting */
-#undef CONNECT_IN_SEND		/* Will crash hard your box... */
+#define CONNECT_IN_SEND		/* Retry IrDA connection procedure */
 #undef FLUSH_TO_PPP		/* Not sure about this one, let's play safe */
 #undef SECURE_DEVIRNET		/* Bah... */
 
@@ -249,9 +268,11 @@
 #define DEBUG_IRDA_SERV_INFO	0	/* various info */
 #define DEBUG_IRDA_SERV_ERROR	1	/* problems */
 #define DEBUG_IRDA_TCB_TRACE	0	/* IRDA IrTTP callbacks */
-#define DEBUG_IRDA_OCB_TRACE	0	/* IRDA other callbacks */
 #define DEBUG_IRDA_CB_INFO	0	/* various info */
 #define DEBUG_IRDA_CB_ERROR	1	/* problems */
+#define DEBUG_IRDA_OCB_TRACE	0	/* IRDA other callbacks */
+#define DEBUG_IRDA_OCB_INFO	0	/* various info */
+#define DEBUG_IRDA_OCB_ERROR	1	/* problems */
 
 #define DEBUG_ASSERT		0	/* Verify all assertions */
 
@@ -351,13 +372,15 @@ typedef struct irnet_socket
   /* ------------------------ IrTTP part ------------------------ */
   /* We create a pseudo "socket" over the IrDA tranport */
   int			ttp_open;	/* Set when IrTTP is ready */
+  int			ttp_connect;	/* Set when IrTTP is connecting */
   struct tsap_cb *	tsap;		/* IrTTP instance (the connection) */
 
   char			rname[NICKNAME_MAX_LEN + 1];
 					/* IrDA nickname of destination */
-  __u32			raddr;		/* Requested peer IrDA address */
-  __u32			saddr;		/* my local IrDA address */
+  __u32			rdaddr;		/* Requested peer IrDA address */
+  __u32			rsaddr;		/* Requested local IrDA address */
   __u32			daddr;		/* actual peer IrDA address */
+  __u32			saddr;		/* my local IrDA address */
   __u8			dtsap_sel;	/* Remote TSAP selector */
   __u8			stsap_sel;	/* Local TSAP selector */
 
@@ -374,17 +397,14 @@ typedef struct irnet_socket
   int			nslots;		/* Number of slots for discovery */
 
   struct iriap_cb *	iriap;		/* Used to query remote IAS */
-  wait_queue_head_t	query_wait;	/* Wait for the answer to a query */
-  struct ias_value *	ias_result;	/* Result of remote IAS query */
   int			errno;		/* status of the IAS query */
 
-  /* ---------------------- Optional parts ---------------------- */
-#ifdef INITIAL_DISCOVERY
-  /* Stuff used to dump discovery log */
+  /* -------------------- Discovery log part -------------------- */
+  /* Used by initial discovery on the control channel
+   * and by irnet_discover_daddr_and_lsap_sel() */
   struct irda_device_info *discoveries;	/* Copy of the discovery log */
   int			disco_index;	/* Last read in the discovery log */
   int			disco_number;	/* Size of the discovery log */
-#endif /* INITIAL_DISCOVERY */
 
 } irnet_socket;
 
@@ -411,8 +431,9 @@ typedef struct irnet_log
 {
   irnet_event	event;
   int		unit;
-  __u32		addr;
-  char		name[NICKNAME_MAX_LEN + 1];
+  __u32		saddr;
+  __u32		daddr;
+  char		name[NICKNAME_MAX_LEN + 1];	/* 21 + 1 */
 } irnet_log;
 
 /*
diff -u -p -r linux/net/irda/irnet-v5/irnet_irda.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet-v5/irnet_irda.c	Thu May 31 10:21:49 2001
+++ linux/net/irda/irnet/irnet_irda.c	Fri Jun  1 17:58:16 2001
@@ -8,7 +8,6 @@
  * and exchange frames with IrTTP.
  */
 
-#include <linux/config.h>
 #include "irnet_irda.h"		/* Private header */
 
 /************************* CONTROL CHANNEL *************************/
@@ -27,14 +26,15 @@
 static void
 irnet_post_event(irnet_socket *	ap,
 		 irnet_event	event,
-		 __u32		addr,
+		 __u32		saddr,
+		 __u32		daddr,
 		 char *		name)
 {
   unsigned long		flags;		/* For spinlock */
   int			index;		/* In the log */
 
-  DENTER(CTRL_TRACE, "(ap=0x%X, event=%d, addr=%08x, name=``%s'')\n",
-	 (unsigned int) ap, event, addr, name);
+  DENTER(CTRL_TRACE, "(ap=0x%X, event=%d, daddr=%08x, name=``%s'')\n",
+	 (unsigned int) ap, event, daddr, name);
 
   /* Protect this section via spinlock.
    * Note : as we are the only event producer, we only need to exclude
@@ -45,7 +45,8 @@ irnet_post_event(irnet_socket *	ap,
   /* Copy the event in the log */
   index = irnet_events.index;
   irnet_events.log[index].event = event;
-  irnet_events.log[index].addr = addr;
+  irnet_events.log[index].daddr = daddr;
+  irnet_events.log[index].saddr = saddr;
   /* Try to copy IrDA nickname */
   if(name)
     strcpy(irnet_events.log[index].name, name);
@@ -129,6 +130,92 @@ irnet_open_tsap(irnet_socket *	self)
 
 /*------------------------------------------------------------------*/
 /*
+ * Function irnet_ias_to_tsap (self, result, value)
+ *
+ *    Examine an IAS object and extract TSAP
+ *
+ * We do an IAP query to find the TSAP associated with the IrNET service.
+ * When IrIAP pass us the result of the query, this function look at
+ * the return values to check for failures and extract the TSAP if
+ * possible.
+ * Also deallocate value
+ * The failure is in self->errno
+ * Return TSAP or -1
+ */
+static inline __u8
+irnet_ias_to_tsap(irnet_socket *	self,
+		  int			result,
+		  struct ias_value *	value)
+{
+  __u8	dtsap_sel = 0;		/* TSAP we are looking for */
+
+  DENTER(IRDA_SR_TRACE, "(self=0x%X)\n", (unsigned int) self);
+
+  /* By default, no error */
+  self->errno = 0;
+
+  /* Check if request succeeded */
+  switch(result)
+    {
+      /* Standard errors : service not available */
+    case IAS_CLASS_UNKNOWN:
+    case IAS_ATTRIB_UNKNOWN:
+      DEBUG(IRDA_SR_INFO, "IAS object doesn't exist ! (%d)\n", result);
+      self->errno = -EADDRNOTAVAIL;
+      break;
+
+      /* Other errors, most likely IrDA stack failure */
+    default :
+      DEBUG(IRDA_SR_INFO, "IAS query failed ! (%d)\n", result);
+      self->errno = -EHOSTUNREACH;
+      break;
+
+      /* Success : we got what we wanted */
+    case IAS_SUCCESS:
+      break;
+    }
+
+  /* Check what was returned to us */
+  if(value != NULL)
+    {
+      /* What type of argument have we got ? */
+      switch(value->type)
+	{
+	case IAS_INTEGER:
+	  DEBUG(IRDA_SR_INFO, "result=%d\n", value->t.integer);
+	  if(value->t.integer != -1)
+	    /* Get the remote TSAP selector */
+	    dtsap_sel = value->t.integer;
+	  else 
+	    self->errno = -EADDRNOTAVAIL;
+	  break;
+	default:
+	  self->errno = -EADDRNOTAVAIL;
+	  DERROR(IRDA_SR_ERROR, "bad type ! (0x%X)\n", value->type);
+	  break;
+	}
+
+      /* Cleanup */
+      irias_delete_value(value);
+    }
+  else	/* value == NULL */
+    {
+      /* Nothing returned to us - usually result != SUCCESS */
+      if(!(self->errno))
+	{
+	  DERROR(IRDA_SR_ERROR,
+		 "IrDA bug : result == SUCCESS && value == NULL\n");
+	  self->errno = -EHOSTUNREACH;
+	}
+    }
+  DEXIT(IRDA_SR_TRACE, "\n");
+
+  /* Return the TSAP */
+  return(dtsap_sel);
+}
+
+/*------------------------------------------------------------------*/
+/*
  * Function irnet_find_lsap_sel (self)
  *
  *    Try to lookup LSAP selector in remote LM-IAS
@@ -139,7 +226,7 @@ irnet_open_tsap(irnet_socket *	self)
  * Note that in some case, the query fail even before we go to sleep,
  * creating some races...
  */
-static int
+static inline int
 irnet_find_lsap_sel(irnet_socket *	self)
 {
   DENTER(IRDA_SR_TRACE, "(self=0x%X)\n", (unsigned int) self);
@@ -155,48 +242,101 @@ irnet_find_lsap_sel(irnet_socket *	self)
   self->errno = -EHOSTUNREACH;
 
   /* Query remote LM-IAS */
-  iriap_getvaluebyclass_request(self->iriap, self->saddr, self->daddr,
+  iriap_getvaluebyclass_request(self->iriap, self->rsaddr, self->daddr,
 				IRNET_SERVICE_NAME, IRNET_IAS_VALUE);
-  /* Wait for answer (if not already failed) */
-  if(self->iriap != NULL)
-    interruptible_sleep_on(&self->query_wait);
 
-  /* Check what happened */
-  if(self->errno)
+  /* The above request is non-blocking.
+   * After a while, IrDA will call us back in irnet_getvalue_confirm()
+   * We will then call irnet_ias_to_tsap() and finish the
+   * connection procedure */
+
+  DEXIT(IRDA_SR_TRACE, "\n");
+  return 0;
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Function irnet_connect_tsap (self)
+ *
+ *    Initialise the TTP socket and initiate TTP connection
+ *
+ */
+static inline int
+irnet_connect_tsap(irnet_socket *	self)
+{
+  int		err;
+
+  DENTER(IRDA_SR_TRACE, "(self=0x%X)\n", (unsigned int) self);
+
+  /* Open a local TSAP (an IrTTP instance) */
+  err = irnet_open_tsap(self);
+  if(err != 0)
     {
-      DEBUG(IRDA_SR_INFO, "IAS query failed! (%d)\n", self->errno);
-      /* Requested object/attribute doesn't exist */
-      if((self->errno == IAS_CLASS_UNKNOWN) ||
-	 (self->errno == IAS_ATTRIB_UNKNOWN))
-	return (-EADDRNOTAVAIL);
-      else
-	return (-EHOSTUNREACH);
+      self->ttp_connect = 0;
+      DERROR(IRDA_SR_ERROR, "connect aborted!\n");
+      return(err);
     }
 
-  /* Get the remote TSAP selector */
-  switch(self->ias_result->type)
+  /* Connect to remote device */
+  err = irttp_connect_request(self->tsap, self->dtsap_sel, 
+			      self->rsaddr, self->daddr, NULL, 
+			      self->max_sdu_size_rx, NULL);
+  if(err != 0)
     {
-    case IAS_INTEGER:
-      DEBUG(IRDA_SR_INFO, "result=%d\n", self->ias_result->t.integer);
-      if(self->ias_result->t.integer != -1)
-	self->dtsap_sel = self->ias_result->t.integer;
-      else 
-	self->dtsap_sel = 0;
-      break;
-    default:
-      self->dtsap_sel = 0;
-      DERROR(IRDA_SR_ERROR, "bad type ! (0x%X)\n", self->ias_result->type);
-      break;
+      self->ttp_connect = 0;
+      DERROR(IRDA_SR_ERROR, "connect aborted!\n");
+      return(err);
     }
-  /* Cleanup */
-  if(self->ias_result)
-    irias_delete_value(self->ias_result);
+
+  /* The above call is non-blocking.
+   * After a while, the IrDA stack will either call us back in
+   * irnet_connect_confirm() or irnet_disconnect_indication()
+   * See you there ;-) */
 
   DEXIT(IRDA_SR_TRACE, "\n");
-  if(self->dtsap_sel)
-    return 0;
+  return(err);
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Function irnet_discover_next_daddr (self)
+ *
+ *    Query the IrNET TSAP of the next device in the log.
+ *
+ * Used in the TSAP discovery procedure.
+ */
+static inline int
+irnet_discover_next_daddr(irnet_socket *	self)
+{
+  /* Close the last instance of IrIAP, and open a new one.
+   * We can't reuse the IrIAP instance in the IrIAP callback */
+  if(self->iriap)
+    {
+      iriap_close(self->iriap);
+      self->iriap = NULL;
+    }
+  /* Create a new IAP instance */
+  self->iriap = iriap_open(LSAP_ANY, IAS_CLIENT, self,
+			   irnet_discovervalue_confirm);
 
-  return -EADDRNOTAVAIL;
+  /* Next discovery - before the call to avoid races */
+  self->disco_index++;
+
+  /* Check if we have one more address to try */
+  if(self->disco_index < self->disco_number)
+    {
+      /* Query remote LM-IAS */
+      iriap_getvaluebyclass_request(self->iriap,
+				    self->discoveries[self->disco_index].saddr,
+				    self->discoveries[self->disco_index].daddr,
+				    IRNET_SERVICE_NAME, IRNET_IAS_VALUE);
+      /* The above request is non-blocking.
+       * After a while, IrDA will call us back in irnet_discovervalue_confirm()
+       * We will then call irnet_ias_to_tsap() and come back here again... */
+      return(0);
+    }
+  else
+    return(1);
 }
 
 /*------------------------------------------------------------------*/
@@ -205,100 +345,67 @@ irnet_find_lsap_sel(irnet_socket *	self)
  *
  *    This try to find a device with the requested service.
  *
+ * Initiate a TSAP discovery procedure.
  * It basically look into the discovery log. For each address in the list,
  * it queries the LM-IAS of the device to find if this device offer
  * the requested service.
  * If there is more than one node supporting the service, we complain
  * to the user (it should move devices around).
- * The, we set both the destination address and the lsap selector to point
- * on the service on the unique device we have found.
+ * If we find one node which have the requested TSAP, we connect to it.
  *
- * Note : this function fails if there is more than one device in range,
- * because IrLMP doesn't disconnect the LAP when the last LSAP is closed.
- * Moreover, we would need to wait the LAP disconnection...
+ * This function just start the whole procedure. It request the discovery
+ * log and submit the first IAS query.
+ * The bulk of the job is handled in irnet_discovervalue_confirm()
+ *
+ * Note : this procedure fails if there is more than one device in range
+ * on the same dongle, because IrLMP doesn't disconnect the LAP when the
+ * last LSAP is closed. Moreover, we would need to wait the LAP
+ * disconnection...
  */
 static inline int
 irnet_discover_daddr_and_lsap_sel(irnet_socket *	self)
 {
-  struct irda_device_info *discoveries;	/* Copy of the discovery log */
-  int	number;			/* Number of nodes in the log */
-  int	i;
-  int	err = -ENETUNREACH;
-  __u32	daddr = DEV_ADDR_ANY;	/* Address we found the service on */
-  __u8	dtsap_sel = 0x0;	/* TSAP associated with it */
+  int	ret;
 
   DENTER(IRDA_SR_TRACE, "(self=0x%X)\n", (unsigned int) self);
 
-  /* Ask lmp for the current discovery log
-   * Note : we have to use irlmp_get_discoveries(), as opposed
-   * to play with the cachelog directly, because while we are
-   * making our ias query, le log might change... */
-  discoveries = irlmp_get_discoveries(&number, self->mask);
-  /* Check if the we got some results */
-  if (discoveries == NULL)
-    DRETURN(-ENETUNREACH, IRDA_SR_INFO, "Cachelog empty...\n");
+  /* Ask lmp for the current discovery log */
+  self->discoveries = irlmp_get_discoveries(&self->disco_number, self->mask);
 
-  /* 
-   * Now, check all discovered devices (if any), and connect
-   * client only about the services that the client is
-   * interested in...
-   */
-  for(i = 0; i < number; i++)
+  /* Check if the we got some results */
+  if(self->discoveries == NULL)
     {
-      /* Try the address in the log */
-      self->daddr = discoveries[i].daddr;
-      self->saddr = 0x0;
-      DEBUG(IRDA_SR_INFO, "trying daddr = %08x\n", self->daddr);
-
-      /* Query remote LM-IAS for this service */
-      err = irnet_find_lsap_sel(self);
-      switch(err)
-	{
-	case 0:
-	  /* We found the requested service */
-	  if(daddr != DEV_ADDR_ANY)
-	    {
-	      DEBUG(IRDA_SR_INFO, "More than one device in range supports IrNET...\n");
-	    }
-	  else
-	    {
-	      /* First time we found that one, save it ! */
-	      daddr = self->daddr;
-	      dtsap_sel = self->dtsap_sel;
-	    }
-	  break;
-	case -EADDRNOTAVAIL:
-	  /* Requested service simply doesn't exist on this node */
-	  break;
-	default:
-	  /* Something bad did happen :-( */
-	  DERROR(IRDA_SR_ERROR, "unexpected IAS query failure\n");
-	  self->daddr = DEV_ADDR_ANY;
-	  kfree(discoveries);
-	  return(-EHOSTUNREACH);
-	  break;
-	}
+      self->disco_number = -1;
+      self->ttp_connect = 0;
+      DRETURN(-ENETUNREACH, IRDA_SR_INFO, "No Cachelog...\n");
     }
-  /* Cleanup our copy of the discovery log */
-  kfree(discoveries);
+  DEBUG(IRDA_SR_INFO, "Got the log (0x%X), size is %d\n",
+	(unsigned int) self->discoveries, self->disco_number);
 
-  /* Check out what we found */
-  if(daddr == DEV_ADDR_ANY)
+  /* Start with the first discovery */
+  self->disco_index = -1;
+  self->daddr = DEV_ADDR_ANY;
+
+  /* This will fail if the log is empty - this is non-blocking */
+  ret = irnet_discover_next_daddr(self);
+  if(ret)
     {
-      self->daddr = DEV_ADDR_ANY;
-      DEXIT(IRDA_SR_INFO, "cannot discover IrNET in any device !!!\n");
-      return(-EADDRNOTAVAIL);
+      /* Close IAP */
+      iriap_close(self->iriap);
+      self->iriap = NULL;
+
+      /* Cleanup our copy of the discovery log */
+      kfree(self->discoveries);
+      self->discoveries = NULL;
+
+      self->ttp_connect = 0;
+      DRETURN(-ENETUNREACH, IRDA_SR_INFO, "Cachelog empty...\n");
     }
 
-  /* Revert back to discovered device & service */
-  self->daddr = daddr;
-  self->saddr = 0x0;
-  self->dtsap_sel = dtsap_sel;
+  /* Follow me in irnet_discovervalue_confirm() */
 
-  DEBUG(IRDA_SR_INFO, "discovered IrNET at address %08x\n", self->daddr);
   DEXIT(IRDA_SR_TRACE, "\n");
-
-  return 0;
+  return(0);
 }
 
 /*------------------------------------------------------------------*/
@@ -367,13 +474,13 @@ irda_irnet_create(irnet_socket *	self)
 
   self->magic = IRNET_MAGIC;	/* Paranoia */
 
-  init_waitqueue_head(&self->query_wait);
-
   self->ttp_open = 0;		/* Prevent higher layer from accessing IrTTP */
+  self->ttp_connect = 0;	/* Not connecting yet */
   self->rname[0] = '\0';	/* May be set via control channel */
-  self->raddr = DEV_ADDR_ANY;	/* May be set via control channel */
+  self->rdaddr = DEV_ADDR_ANY;	/* May be set via control channel */
+  self->rsaddr = 0x0;		/* May be set via control channel */
   self->daddr = DEV_ADDR_ANY;	/* Until we get connected */
-  self->saddr = 0x0;		/* so IrLMP assign us any link */
+  self->saddr = 0x0;		/* Until we get connected */
   self->max_sdu_size_rx = TTP_SAR_UNBOUND;
 
   /* Register as a client with IrLMP */
@@ -395,6 +502,12 @@ irda_irnet_create(irnet_socket *	self)
  *	o convert device name to an address
  *	o find the socket number (dlsap)
  *	o Establish the connection
+ *
+ * Note : We no longer mimic af_irda. The IAS query for finding the TSAP
+ * is done asynchronously, like the TTP connection. This allow us to
+ * call this function from any context (not only process).
+ * The downside is that following what's happening in there is tricky
+ * because it involve various functions all over the place...
  */
 int
 irda_irnet_connect(irnet_socket *	self)
@@ -406,8 +519,11 @@ irda_irnet_connect(irnet_socket *	self)
   /* Check if we have opened a local TSAP :
    * If we have already opened a TSAP, it means that either we are already
    * connected or in the process of doing so... */
-  if(self->tsap != NULL)
+  if(self->ttp_connect)
     DRETURN(-EBUSY, IRDA_SOCK_INFO, "Already connecting...\n");
+  self->ttp_connect = 1;
+  if((self->iriap != NULL) || (self->tsap != NULL))
+    DERROR(IRDA_SOCK_ERROR, "Socket not cleaned up...\n");
 
   /* Insert ourselves in the hashbin so that the IrNET server can find us.
    * Notes : 4th arg is string of 32 char max and must be null terminated
@@ -423,41 +539,34 @@ irda_irnet_connect(irnet_socket *	self)
     }
 
   /* If we don't have anything (no address, no name) */
-  if((self->raddr == DEV_ADDR_ANY) && (self->rname[0] == '\0'))
+  if((self->rdaddr == DEV_ADDR_ANY) && (self->rname[0] == '\0'))
     {
       /* Try to find a suitable address */
-      if((err = irnet_discover_daddr_and_lsap_sel(self)) != 0) 
+      if((err = irnet_discover_daddr_and_lsap_sel(self)) != 0)
 	DRETURN(err, IRDA_SOCK_INFO, "auto-connect failed!\n");
+      /* In most cases, the call above is non-blocking */
     }
   else
     {
       /* If we have only the name (no address), try to get an address */
-      if(self->raddr == DEV_ADDR_ANY)
+      if(self->rdaddr == DEV_ADDR_ANY)
 	{
 	  if((err = irnet_dname_to_daddr(self)) != 0)
-	    DRETURN(err, IRDA_SOCK_INFO, "name-connect failed!\n");
+	    DRETURN(err, IRDA_SOCK_INFO, "name connect failed!\n");
 	}
       else
 	/* Use the requested destination address */
-	self->daddr = self->raddr;
+	self->daddr = self->rdaddr;
 
       /* Query remote LM-IAS to find LSAP selector */
-      if((err = irnet_find_lsap_sel(self)) != 0)
-	DRETURN(err, IRDA_SOCK_INFO, "connect failed!\n");
+      irnet_find_lsap_sel(self);
+      /* The above call is non blocking */
     }
-  DEBUG(IRDA_SOCK_INFO, "daddr = %08x, lsap = %d, starting IrTTP connection\n",
-	self->daddr, self->dtsap_sel);
-
-  /* Open a local TSAP (an IrTTP instance) */
-  err = irnet_open_tsap(self);
-  DABORT(err != 0, err, IRDA_SOCK_ERROR, "connect aborted!\n");
-
-  /* Connect to remote device */
-  err = irttp_connect_request(self->tsap, self->dtsap_sel, 
-			      self->saddr, self->daddr, NULL, 
-			      self->max_sdu_size_rx, NULL);
-  DABORT(err != 0, err, IRDA_SOCK_ERROR, "connect aborted!\n");
 
+  /* At this point, we are waiting for the IrDA stack to call us back,
+   * or we have already failed.
+   * We will finish the connection procedure in irnet_connect_tsap().
+   */
   DEXIT(IRDA_SOCK_TRACE, "\n");
   return(0);
 }
@@ -494,8 +603,21 @@ irda_irnet_destroy(irnet_socket *	self)
   irlmp_unregister_client(self->ckey);
 
   /* Unregister with LM-IAS */
-  if(self->iriap) 
-    iriap_close(self->iriap);
+  if(self->iriap)
+    { 
+      iriap_close(self->iriap);
+      self->iriap = NULL;
+    }
+
+  /* If we were connected, post a message */
+  if(self->ttp_open)
+    {
+      /* Note : as the disconnect comes from ppp_generic, the unit number
+       * doesn't exist anymore when we post the event, so we need to pass
+       * NULL as the first arg... */
+      irnet_post_event(NULL, IRNET_DISCONNECT_TO,
+		       self->saddr, self->daddr, self->rname);
+    }
 
   /* Prevent higher layer from accessing IrTTP */
   self->ttp_open = 0;
@@ -507,10 +629,6 @@ irda_irnet_destroy(irnet_socket *	self)
       irttp_disconnect_request(self->tsap, NULL, P_NORMAL);
       irttp_close_tsap(self->tsap);
       self->tsap = NULL;
-      /* Note : as the disconnect comes from ppp_generic, the unit number
-       * doesn't exist anymore when we post the event, so we need to pass
-       * NULL as the first arg... */
-      irnet_post_event(NULL, IRNET_DISCONNECT_TO, self->daddr, self->rname);
     }
   self->stsap_sel = 0;
 
@@ -591,8 +709,9 @@ irnet_find_socket(irnet_socket *	self)
 
   DENTER(IRDA_SERV_TRACE, "(self=0x%X)\n", (unsigned int) self);
 
-  /* Get the address of the requester */
+  /* Get the addresses of the requester */
   self->daddr = irttp_get_daddr(self->tsap);
+  self->saddr = irttp_get_saddr(self->tsap);
 
   /* Try to get the IrDA nickname of the requester */
   err = irnet_daddr_to_dname(self);
@@ -621,7 +740,7 @@ irnet_find_socket(irnet_socket *	self)
       while(new !=(irnet_socket *) NULL)
 	{
 	  /* Does it have the same address ? */
-	  if((new->raddr == self->daddr) || (new->daddr == self->daddr))
+	  if((new->rdaddr == self->daddr) || (new->daddr == self->daddr))
 	    {
 	      /* Yes !!! Get it.. */
 	      DEBUG(IRDA_SERV_INFO, "Socket 0x%X matches daddr %#08x.\n",
@@ -639,7 +758,7 @@ irnet_find_socket(irnet_socket *	self)
       while(new !=(irnet_socket *) NULL)
 	{
 	  /* Is it available ? */
-	  if(!(new->ttp_open) && (new->raddr == DEV_ADDR_ANY) &&
+	  if(!(new->ttp_open) && (new->rdaddr == DEV_ADDR_ANY) &&
 	     (new->rname[0] == '\0') && (new->ppp_open))
 	    {
 	      /* Yes !!! Get it.. */
@@ -703,6 +822,7 @@ irnet_connect_socket(irnet_socket *	self
 
   /* Allow PPP to send its junk over the new socket... */
   new->ttp_open = 1;
+  new->ttp_connect = 0;
 #ifdef CONNECT_INDIC_KICK
   /* As currently we don't packets in ppp_irnet_send(), this is not needed...
    * Also, not doing it give IrDA a chance to finish the setup properly
@@ -711,7 +831,8 @@ irnet_connect_socket(irnet_socket *	self
 #endif /* CONNECT_INDIC_KICK */
 
   /* Notify the control channel */
-  irnet_post_event(new, IRNET_CONNECT_FROM, new->daddr, self->rname);
+  irnet_post_event(new, IRNET_CONNECT_FROM,
+		   new->saddr, new->daddr, self->rname);
 
   DEXIT(IRDA_SERV_TRACE, "\n");
   return 0;
@@ -740,13 +861,14 @@ irnet_disconnect_server(irnet_socket *	s
   irttp_disconnect_request(self->tsap, NULL, P_NORMAL);
 #endif /* FAIL_SEND_DISCONNECT */
 
+  /* Notify the control channel (see irnet_find_socket()) */
+  irnet_post_event(NULL, IRNET_REQUEST_FROM,
+		   self->saddr, self->daddr, self->rname);
+
   /* Clean up the server to keep it in listen state */
   self->tsap->dtsap_sel = self->tsap->lsap->dlsap_sel = LSAP_ANY;
   self->tsap->lsap->lsap_state = LSAP_DISCONNECTED;
 
-  /* Notify the control channel */
-  irnet_post_event(NULL, IRNET_REQUEST_FROM, self->daddr, self->rname);
-
   DEXIT(IRDA_SERV_TRACE, "\n");
   return;
 }
@@ -934,14 +1056,17 @@ irnet_disconnect_indication(void *	insta
 
   /* If we were active, notify the control channel */
   if(self->ttp_open)
-    irnet_post_event(self, IRNET_DISCONNECT_FROM, self->daddr, self->rname);
+    irnet_post_event(self, IRNET_DISCONNECT_FROM,
+		     self->saddr, self->daddr, self->rname);
   else
     /* If we were trying to connect, notify the control channel */
     if((self->tsap) && (self != &irnet_server.s))
-      irnet_post_event(self, IRNET_NOANSWER_FROM, self->daddr, self->rname);
+      irnet_post_event(self, IRNET_NOANSWER_FROM,
+		       self->saddr, self->daddr, self->rname);
 
   /* Prevent higher layer from accessing IrTTP */
   self->ttp_open = 0;
+  self->ttp_connect = 0;
 
   /* Close our IrTTP connection */
   if((self->tsap) && (self != &irnet_server.s))
@@ -1001,6 +1126,7 @@ irnet_connect_confirm(void *	instance,
   self->saddr = irttp_get_saddr(self->tsap);
 
   /* Allow higher layer to access IrTTP */
+  self->ttp_connect = 0;
   self->ttp_open = 1;
   /* Give a kick in the ass of ppp_generic so that he sends us some data */
   ppp_output_wakeup(&self->chan);
@@ -1021,7 +1147,8 @@ irnet_connect_confirm(void *	instance,
     kfree_skb(skb);
 
   /* Notify the control channel */
-  irnet_post_event(self, IRNET_CONNECT_TO, self->daddr, self->rname);
+  irnet_post_event(self, IRNET_CONNECT_TO,
+		   self->saddr, self->daddr, self->rname);
 
   DEXIT(IRDA_TCB_TRACE, "\n");
 }
@@ -1081,7 +1208,6 @@ irnet_status_indication(void *	instance,
 			LOCK_STATUS lock)
 {
   irnet_socket *	self = (irnet_socket *) instance;
-  LOCAL_FLOW		oldflow = self->tx_flow;
 
   DENTER(IRDA_TCB_TRACE, "(self=0x%X)\n", (unsigned int) self);
   DASSERT(self != NULL, , IRDA_CB_ERROR, "Self is NULL !!!\n");
@@ -1090,7 +1216,8 @@ irnet_status_indication(void *	instance,
   switch(link)
     {
     case STATUS_NO_ACTIVITY:
-      irnet_post_event(self, IRNET_BLOCKED_LINK, self->daddr, self->rname);
+      irnet_post_event(self, IRNET_BLOCKED_LINK,
+		       self->saddr, self->daddr, self->rname);
       break;
     default:
       DEBUG(IRDA_CB_INFO, "Unknown status...\n");
@@ -1199,10 +1326,14 @@ irnet_connect_indication(void *		instanc
 
 /*------------------------------------------------------------------*/
 /*
- * Function irnet_getvalue_confirm (obj_id, value, priv)
+ * Function irnet_getvalue_confirm (result, obj_id, value, priv)
  *
- *    Got answer from remote LM-IAS, just pass object to requester...
+ *    Got answer from remote LM-IAS, just connect
  *
+ * This is the reply to a IAS query we were doing to find the TSAP of
+ * the device we want to connect to.
+ * If we have found a valid TSAP, just initiate the TTP connection
+ * on this TSAP.
  */
 static void
 irnet_getvalue_confirm(int	result,
@@ -1213,27 +1344,146 @@ irnet_getvalue_confirm(int	result,
   irnet_socket *	self = (irnet_socket *) priv;
 
   DENTER(IRDA_OCB_TRACE, "(self=0x%X)\n", (unsigned int) self);
-  DASSERT(self != NULL, , IRDA_CB_ERROR, "Self is NULL !!!\n");
+  DASSERT(self != NULL, , IRDA_OCB_ERROR, "Self is NULL !!!\n");
 
   /* We probably don't need to make any more queries */
   iriap_close(self->iriap);
   self->iriap = NULL;
 
-  /* Check if request succeeded */
-  if(result != IAS_SUCCESS)
+  /* Check if already connected (via irnet_connect_socket()) */
+  if(self->ttp_open)
     {
-      DEBUG(IRDA_CB_INFO, "IAS query failed! (%d)\n", result);
-      self->errno = result;	/* We really need it later */
+      DERROR(IRDA_OCB_ERROR, "Socket already connected. Ouch !\n");
+      return;
     }
-  else
+
+  /* Post process the IAS reply */
+  self->dtsap_sel = irnet_ias_to_tsap(self, result, value);
+
+  /* If error, just go out */
+  if(self->errno)
+    {
+      self->ttp_connect = 0;
+      DERROR(IRDA_OCB_ERROR, "IAS connect failed ! (0x%X)\n", self->errno);
+      return;
+    }
+
+  DEBUG(IRDA_OCB_INFO, "daddr = %08x, lsap = %d, starting IrTTP connection\n",
+	self->daddr, self->dtsap_sel);
+
+  /* Start up TTP - non blocking */
+  irnet_connect_tsap(self);
+
+  DEXIT(IRDA_OCB_TRACE, "\n");
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Function irnet_discovervalue_confirm (result, obj_id, value, priv)
+ *
+ *    Handle the TSAP discovery procedure state machine.
+ *    Got answer from remote LM-IAS, try next device
+ *
+ * We are doing a  TSAP discovery procedure, and we got an answer to
+ * a IAS query we were doing to find the TSAP on one of the address
+ * in the discovery log.
+ *
+ * If we have found a valid TSAP for the first time, save it. If it's
+ * not the first time we found one, complain.
+ *
+ * If we have more addresses in the log, just initiate a new query.
+ * Note that those query may fail (see irnet_discover_daddr_and_lsap_sel())
+ *
+ * Otherwise, wrap up the procedure (cleanup), check if we have found
+ * any device and connect to it.
+ */
+static void
+irnet_discovervalue_confirm(int		result,
+			    __u16	obj_id, 
+			    struct ias_value *value,
+			    void *	priv)
+{
+  irnet_socket *	self = (irnet_socket *) priv;
+  __u8			dtsap_sel;		/* TSAP we are looking for */
+
+  DENTER(IRDA_OCB_TRACE, "(self=0x%X)\n", (unsigned int) self);
+  DASSERT(self != NULL, , IRDA_OCB_ERROR, "Self is NULL !!!\n");
+
+  /* Post process the IAS reply */
+  dtsap_sel = irnet_ias_to_tsap(self, result, value);
+
+  /* Have we got something ? */
+  if(self->errno == 0)
+    {
+      /* We found the requested service */
+      if(self->daddr != DEV_ADDR_ANY)
+	{
+	  DERROR(IRDA_OCB_ERROR, "More than one device in range supports IrNET...\n");
+	}
+      else
+	{
+	  /* First time we found that one, save it ! */
+	  self->daddr = self->discoveries[self->disco_index].daddr;
+	  self->dtsap_sel = dtsap_sel;
+	}
+    }
+
+  /* If no failure */
+  if((self->errno == -EADDRNOTAVAIL) || (self->errno == 0))
+    {
+      int	ret;
+
+      /* Search the next node */
+      ret = irnet_discover_next_daddr(self);
+      if(!ret)
+	{
+	  /* In this case, the above request was non-blocking.
+	   * We will return here after a while... */
+	  return;
+	}
+      /* In this case, we have processed the last discovery item */
+    }
+
+  /* No more queries to be done (failure or last one) */
+
+  /* We probably don't need to make any more queries */
+  iriap_close(self->iriap);
+  self->iriap = NULL;
+
+  /* No more items : remove the log and signal termination */
+  DEBUG(IRDA_OCB_INFO, "Cleaning up log (0x%X)\n",
+	(unsigned int) self->discoveries);
+  if(self->discoveries != NULL)
+    {
+      /* Cleanup our copy of the discovery log */
+      kfree(self->discoveries);
+      self->discoveries = NULL;
+    }
+  self->disco_number = -1;
+
+  /* Check out what we found */
+  if(self->daddr == DEV_ADDR_ANY)
     {
-      /* Pass the object to the caller (so the caller must delete it) */
-      self->ias_result = value;
-      self->errno = 0;
+      self->daddr = DEV_ADDR_ANY;
+      self->ttp_connect = 0;
+      DEXIT(IRDA_OCB_TRACE, ": cannot discover IrNET in any device !!!\n");
+      return;
     }
 
-  /* Wake up any processes waiting for result */
-  wake_up_interruptible(&self->query_wait);
+  /* Check if already connected (via irnet_connect_socket()) */
+  if(self->ttp_open)
+    {
+      DERROR(IRDA_OCB_ERROR, "Socket already connected. Ouch !\n");
+      return;
+    }
+
+  /* We have a valid address - just connect */
+
+  DEBUG(IRDA_OCB_INFO, "daddr = %08x, lsap = %d, starting IrTTP connection\n",
+	self->daddr, self->dtsap_sel);
+
+  /* Start up TTP - non blocking */
+  irnet_connect_tsap(self);
 
   DEXIT(IRDA_OCB_TRACE, "\n");
 }
@@ -1268,7 +1518,7 @@ irnet_discovery_indication(discovery_t *
   irnet_socket *	self = &irnet_server.s;
 	
   DENTER(IRDA_OCB_TRACE, "(self=0x%X)\n", (unsigned int) self);
-  DASSERT(priv == &irnet_server, , IRDA_CB_ERROR,
+  DASSERT(priv == &irnet_server, , IRDA_OCB_ERROR,
 	  "Invalid instance (0x%X) !!!\n", (unsigned int) priv);
 
   /* Check if node is discovered is a new one or an old one.
@@ -1280,12 +1530,12 @@ irnet_discovery_indication(discovery_t *
       return;		/* Too old, not interesting -> goodbye */
     }
 
-  DEBUG(IRDA_CB_INFO, "Discovered new IrNET/IrLAN node %s...\n",
+  DEBUG(IRDA_OCB_INFO, "Discovered new IrNET/IrLAN node %s...\n",
 	discovery->nickname);
 
   /* Notify the control channel */
-  irnet_post_event(NULL, IRNET_DISCOVER, discovery->daddr,
-		   discovery->nickname);
+  irnet_post_event(NULL, IRNET_DISCOVER,
+		   discovery->saddr, discovery->daddr, discovery->nickname);
 
   DEXIT(IRDA_OCB_TRACE, "\n");
 }
@@ -1306,15 +1556,15 @@ irnet_expiry_indication(discovery_t *	ex
   irnet_socket *	self = &irnet_server.s;
 	
   DENTER(IRDA_OCB_TRACE, "(self=0x%X)\n", (unsigned int) self);
-  DASSERT(priv == &irnet_server, , IRDA_CB_ERROR,
+  DASSERT(priv == &irnet_server, , IRDA_OCB_ERROR,
 	  "Invalid instance (0x%X) !!!\n", (unsigned int) priv);
 
-  DEBUG(IRDA_CB_INFO, "IrNET/IrLAN node %s expired...\n",
+  DEBUG(IRDA_OCB_INFO, "IrNET/IrLAN node %s expired...\n",
 	expiry->nickname);
 
   /* Notify the control channel */
-  irnet_post_event(NULL, IRNET_EXPIRE, expiry->daddr,
-		   expiry->nickname);
+  irnet_post_event(NULL, IRNET_EXPIRE,
+		   expiry->saddr, expiry->daddr, expiry->nickname);
 
   DEXIT(IRDA_OCB_TRACE, "\n");
 }
@@ -1370,7 +1620,8 @@ irnet_proc_read(char *	buf,
 
       /* First, get the requested configuration */
       len += sprintf(buf+len, "Requested IrDA name: \"%s\", ", self->rname);
-      len += sprintf(buf+len, "addr: %08x\n", self->raddr);
+      len += sprintf(buf+len, "daddr: %08x, ", self->rdaddr);
+      len += sprintf(buf+len, "saddr: %08x\n", self->rsaddr);
 
       /* Second, get all the PPP info */
       len += sprintf(buf+len, "	PPP state: %s",
@@ -1393,7 +1644,13 @@ irnet_proc_read(char *	buf,
 	if(self->tsap != NULL)
 	  state = "connecting";
 	else
-	  state = "idle";
+	  if(self->iriap != NULL)
+	    state = "searching";
+	  else
+	    if(self->ttp_connect)
+	      state = "weird";
+	    else
+	      state = "idle";
       len += sprintf(buf+len, "\n	IrDA state: %s, ", state);
       len += sprintf(buf+len, "daddr: %08x, ", self->daddr);
       len += sprintf(buf+len, "stsap_sel: %02x, ", self->stsap_sel);
diff -u -p -r linux/net/irda/irnet-v5/irnet_irda.h linux/net/irda/irnet/irnet_irda.h
--- linux/net/irda/irnet-v5/irnet_irda.h	Thu May 31 10:21:50 2001
+++ linux/net/irda/irnet/irnet_irda.h	Thu May 31 18:13:22 2001
@@ -13,7 +13,6 @@
 #define IRNET_IRDA_H
 
 /***************************** INCLUDES *****************************/
-#include <linux/config.h>
 /* Please add other headers in irnet.h */
 
 #include "irnet.h"		/* Module global include */
@@ -69,13 +68,22 @@ static void
 	irnet_post_event(irnet_socket *,
 			 irnet_event,
 			 __u32,
+			 __u32,
 			 char *);
 /* ----------------------- IRDA SUBROUTINES ----------------------- */
 static inline int
 	irnet_open_tsap(irnet_socket *);
-static int
+static inline __u8
+	irnet_ias_to_tsap(irnet_socket *,
+			  int,
+			  struct ias_value *);
+static inline int
 	irnet_find_lsap_sel(irnet_socket *);
 static inline int
+	irnet_connect_tsap(irnet_socket *);
+static inline int
+	irnet_discover_next_daddr(irnet_socket *);
+static inline int
 	irnet_discover_daddr_and_lsap_sel(irnet_socket *);
 static inline int
 	irnet_dname_to_daddr(irnet_socket *);
@@ -135,6 +143,11 @@ static void
 			       __u16,
 			       struct ias_value *,
 			       void *);
+static void
+	irnet_discovervalue_confirm(int,
+				    __u16, 
+				    struct ias_value *,
+				    void *);
 #ifdef DISCOVERY_EVENTS
 static void
 	irnet_discovery_indication(discovery_t *,
diff -u -p -r linux/net/irda/irnet-v5/irnet_ppp.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet-v5/irnet_ppp.c	Thu May 31 10:21:50 2001
+++ linux/net/irda/irnet/irnet_ppp.c	Thu May 31 14:58:14 2001
@@ -37,13 +37,15 @@ irnet_ctrl_write(irnet_socket *	ap,
 		 const char *	buf,
 		 size_t		count)
 {
-  char		command[5 + NICKNAME_MAX_LEN + 2];
-  int		length = count;
+  char		command[IRNET_MAX_COMMAND];
+  char *	start;		/* Current command beeing processed */
+  char *	next;		/* Next command to process */
+  int		length;		/* Length of current command */
 
   DENTER(CTRL_TRACE, "(ap=0x%X, count=%d)\n", (unsigned int) ap, count);
 
   /* Check for overflow... */
-  DABORT(count > (5 + NICKNAME_MAX_LEN + 1), -ENOMEM,
+  DABORT(count >= IRNET_MAX_COMMAND, -ENOMEM,
 	 CTRL_ERROR, "Too much data !!!\n");
 
   /* Get the data in the driver */
@@ -53,58 +55,110 @@ irnet_ctrl_write(irnet_socket *	ap,
       return -EFAULT;
     }
 
-  /* Strip out '\n' if needed, and safe terminate the string */
-  if(command[length - 1] == '\0')
-    length--;
-  if(command[length - 1] == '\n')
-    length--;
-  command[length] = '\0';
-  DEBUG(CTRL_INFO, "Command received is ``%s'' (%d-%d).\n",
-	command, length, count);
-
-  /* Check if we recognised the command */
-  /* First command : name */
-  if(!strncmp(command, "name", 4))
-    {
-      /* Copy the name only if is included and not "any" */
-      if((length > 5) && (strcmp(command + 5, "any")))
+  /* Safe terminate the string */
+  command[count] = '\0';
+  DEBUG(CTRL_INFO, "Command line received is ``%s'' (%d).\n",
+	command, count);
+
+  /* Check every commands in the command line */
+  next = command;
+  while(next != NULL)
+    {
+      /* Look at the next command */
+      start = next;
+
+      /* Scrap whitespaces before the command */
+      while(isspace(*start))
+	start++;
+
+      /* ',' is our command separator */
+      next = strchr(start, ',');
+      if(next)
 	{
-	  /* Copy the name for later reuse (including the '/0') */
-	  memcpy(ap->rname, command + 5, length - 5 + 1);
+	  *next = '\0';			/* Terminate command */
+	  length = next - start;	/* Length */
+	  next++;			/* Skip the '\0' */
 	}
       else
-	ap->rname[0] = '\0';
-      DEXIT(CTRL_TRACE, " - rname = ``%s''\n", ap->rname);
-      return(count);
-    }
+	length = strlen(start);
 
-  /* Second command : addr */
-  if(!strncmp(command, "addr", 4))
-    {
-      /* Copy the address only if is included and not "any" */
-      if((length > 5) && (strcmp(command + 5, "any")))
+      DEBUG(CTRL_INFO, "Found command ``%s'' (%d).\n", start, length);
+
+      /* Check if we recognised one of the known command
+       * We can't use "switch" with strings, so hack with "continue" */
+      
+      /* First command : name -> Requested IrDA nickname */
+      if(!strncmp(start, "name", 4))
 	{
-	  char *	endp;
-	  __u32		daddr;
+	  /* Copy the name only if is included and not "any" */
+	  if((length > 5) && (strcmp(start + 5, "any")))
+	    {
+	      /* Strip out trailing whitespaces */
+	      while(isspace(start[length - 1]))
+		length--;
+
+	      /* Copy the name for later reuse */
+	      memcpy(ap->rname, start + 5, length - 5);
+	      ap->rname[length - 5] = '\0';
+	    }
+	  else
+	    ap->rname[0] = '\0';
+	  DEBUG(CTRL_INFO, "Got rname = ``%s''\n", ap->rname);
 
-	  /* Convert argument to a number (last arg is the base) */
-	  daddr = simple_strtoul(command + 5, &endp, 16);
-	  /* Has it worked  ? (endp should be command + count) */
-	  DABORT(endp <= (command + 5), -EINVAL,
-		 CTRL_ERROR, "Invalid address.\n");
-	  /* Save it */
-	  ap->raddr = daddr;
+	  /* Restart the loop */
+	  continue;
+	}
+
+      /* Second command : addr, daddr -> Requested IrDA destination address
+       * Also process : saddr -> Requested IrDA source address */
+      if((!strncmp(start, "addr", 4)) ||
+	 (!strncmp(start, "daddr", 5)) ||
+	 (!strncmp(start, "saddr", 5)))
+	{
+	  __u32		addr = DEV_ADDR_ANY;
+
+	  /* Copy the address only if is included and not "any" */
+	  if((length > 5) && (strcmp(start + 5, "any")))
+	    {
+	      char *	begp = start + 5;
+	      char *	endp;
+
+	      /* Scrap whitespaces before the command */
+	      while(isspace(*begp))
+		begp++;
+
+	      /* Convert argument to a number (last arg is the base) */
+	      addr = simple_strtoul(begp, &endp, 16);
+	      /* Has it worked  ? (endp should be start + length) */
+	      DABORT(endp <= (start + 5), -EINVAL,
+		     CTRL_ERROR, "Invalid address.\n");
+	    }
+	  /* Which type of address ? */
+	  if(start[0] == 's')
+	    {
+	      /* Save it */
+	      ap->rsaddr = addr;
+	      DEBUG(CTRL_INFO, "Got rsaddr = %08x\n", ap->rsaddr);
+	    }
+	  else
+	    {
+	      /* Save it */
+	      ap->rdaddr = addr;
+	      DEBUG(CTRL_INFO, "Got rdaddr = %08x\n", ap->rdaddr);
+	    }
+
+	  /* Restart the loop */
+	  continue;
 	}
-      else
-	ap->raddr = DEV_ADDR_ANY;
-      DEXIT(CTRL_TRACE, " - raddr = %08x\n", ap->raddr);
-      return(count);
-    }
 
-  /* Other possible command : connect N (number of retries) */
+      /* Other possible command : connect N (number of retries) */
 
-  /* Failed... */
-  DABORT(1, -EINVAL, CTRL_ERROR, "Not a recognised IrNET command.\n");
+      /* No command matched -> Failed... */
+      DABORT(1, -EINVAL, CTRL_ERROR, "Not a recognised IrNET command.\n");
+    }
+
+  /* Success : we have parsed all commands successfully */
+  return(count);
 }
 
 #ifdef INITIAL_DISCOVERY
@@ -157,9 +211,10 @@ irnet_read_discovery_log(irnet_socket *	
   if(ap->disco_index < ap->disco_number)
     {
       /* Write an event */
-      sprintf(event, "Found %08x (%s)\n",
+      sprintf(event, "Found %08x (%s) behind %08x\n",
 	      ap->discoveries[ap->disco_index].daddr,
-	      ap->discoveries[ap->disco_index].info);
+	      ap->discoveries[ap->disco_index].info,
+	      ap->discoveries[ap->disco_index].saddr);
       DEBUG(CTRL_INFO, "Writing discovery %d : %s\n",
 	    ap->disco_index, ap->discoveries[ap->disco_index].info);
 
@@ -256,53 +311,56 @@ irnet_ctrl_read(irnet_socket *	ap,
   switch(irnet_events.log[ap->event_index].event)
     {
     case IRNET_DISCOVER:
-      sprintf(event, "Discovered %08x (%s)\n",
-	      irnet_events.log[ap->event_index].addr,
-	      irnet_events.log[ap->event_index].name);
+      sprintf(event, "Discovered %08x (%s) behind %08x\n",
+	      irnet_events.log[ap->event_index].daddr,
+	      irnet_events.log[ap->event_index].name,
+	      irnet_events.log[ap->event_index].saddr);
       break;
     case IRNET_EXPIRE:
-      sprintf(event, "Expired %08x (%s)\n",
-	      irnet_events.log[ap->event_index].addr,
-	      irnet_events.log[ap->event_index].name);
+      sprintf(event, "Expired %08x (%s) behind %08x\n",
+	      irnet_events.log[ap->event_index].daddr,
+	      irnet_events.log[ap->event_index].name,
+	      irnet_events.log[ap->event_index].saddr);
       break;
     case IRNET_CONNECT_TO:
       sprintf(event, "Connected to %08x (%s) on ppp%d\n",
-	      irnet_events.log[ap->event_index].addr,
+	      irnet_events.log[ap->event_index].daddr,
 	      irnet_events.log[ap->event_index].name,
 	      irnet_events.log[ap->event_index].unit);
       break;
     case IRNET_CONNECT_FROM:
       sprintf(event, "Connection from %08x (%s) on ppp%d\n",
-	      irnet_events.log[ap->event_index].addr,
+	      irnet_events.log[ap->event_index].daddr,
 	      irnet_events.log[ap->event_index].name,
 	      irnet_events.log[ap->event_index].unit);
       break;
     case IRNET_REQUEST_FROM:
-      sprintf(event, "Request from %08x (%s)\n",
-	      irnet_events.log[ap->event_index].addr,
-	      irnet_events.log[ap->event_index].name);
+      sprintf(event, "Request from %08x (%s) behind %08x\n",
+	      irnet_events.log[ap->event_index].daddr,
+	      irnet_events.log[ap->event_index].name,
+	      irnet_events.log[ap->event_index].saddr);
       break;
     case IRNET_NOANSWER_FROM:
       sprintf(event, "No-answer from %08x (%s) on ppp%d\n",
-	      irnet_events.log[ap->event_index].addr,
+	      irnet_events.log[ap->event_index].daddr,
 	      irnet_events.log[ap->event_index].name,
 	      irnet_events.log[ap->event_index].unit);
       break;
     case IRNET_BLOCKED_LINK:
       sprintf(event, "Blocked link with %08x (%s) on ppp%d\n",
-	      irnet_events.log[ap->event_index].addr,
+	      irnet_events.log[ap->event_index].daddr,
 	      irnet_events.log[ap->event_index].name,
 	      irnet_events.log[ap->event_index].unit);
       break;
     case IRNET_DISCONNECT_FROM:
       sprintf(event, "Disconnection from %08x (%s) on ppp%d\n",
-	      irnet_events.log[ap->event_index].addr,
+	      irnet_events.log[ap->event_index].daddr,
 	      irnet_events.log[ap->event_index].name,
 	      irnet_events.log[ap->event_index].unit);
       break;
     case IRNET_DISCONNECT_TO:
       sprintf(event, "Disconnected to %08x (%s)\n",
-	      irnet_events.log[ap->event_index].addr,
+	      irnet_events.log[ap->event_index].daddr,
 	      irnet_events.log[ap->event_index].name);
       break;
     default:
@@ -794,11 +852,9 @@ ppp_irnet_send(struct ppp_channel *	chan
     {
 #ifdef CONNECT_IN_SEND
       /* Let's try to connect one more time... */
-      /* Note : we won't connect fully yet, but we should be ready for
-       * next packet... */
-      /* Note : we can't do that, we need to have a process context to
-       * go through interruptible_sleep_on() in irnet_find_lsap_sel()
-       * We need to find another way... */
+      /* Note : we won't be connected after this call, but we should be
+       * ready for next packet... */
+      /* If we are already connecting, this will fail */
       irda_irnet_connect(self);
 #endif /* CONNECT_IN_SEND */
 
diff -u -p -r linux/net/irda/irnet-v5/irnet_ppp.h linux/net/irda/irnet/irnet_ppp.h
--- linux/net/irda/irnet-v5/irnet_ppp.h	Thu May 31 10:21:50 2001
+++ linux/net/irda/irnet/irnet_ppp.h	Thu May 31 18:13:18 2001
@@ -22,13 +22,8 @@
 #define IRNET_MAJOR	10	/* Misc range */
 #define IRNET_MINOR	187	/* Official allocation */
 
-#ifdef LINKNAME_IOCTL
-/* Compatibility with old ppp drivers
- * Should be defined in <linux/if_ppp.h> */
-#ifndef PPPIOCSLINKNAME
-#define PPPIOCSLINKNAME	_IOW('t', 74, struct ppp_option_data)
-#endif /* PPPIOCSLINKNAME */
-#endif /* LINKNAME_IOCTL */
+/* IrNET control channel stuff */
+#define IRNET_MAX_COMMAND	256	/* Max length of a command line */
 
 /* PPP hardcore stuff */
 

--GvXjxJ+pjyke8COw--
