Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132351AbQKKUmy>; Sat, 11 Nov 2000 15:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbQKKUmp>; Sat, 11 Nov 2000 15:42:45 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:16393 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132351AbQKKUmh>; Sat, 11 Nov 2000 15:42:37 -0500
Date: Sat, 11 Nov 2000 20:43:32 GMT
Message-Id: <200011112043.UAA31275@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda1 (was: Re The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda1 (was: Re The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda1.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda1.diff :
----------------
	o [CORRECT] Proper return code in case of IAS lookup failure
	o [CORRECT] Fix getname() to return proper length & data
	o [FEATURE] Add Kernel/User space tag to IAS attributes
	o [FEATURE] Add the ability to delete user space IAS attributes
	o [FEATURE] Auto discover dest address base on service name
	o [FEATURE] Allow query IAS outside a connection

diff -urpN old-linux/include/linux/irda.h linux/include/linux/irda.h
--- old-linux/include/linux/irda.h	Thu Jan  6 14:46:18 2000
+++ linux/include/linux/irda.h	Thu Nov  9 11:17:07 2000
@@ -86,6 +86,7 @@ enum {
 #define IRLMP_QOS_GET            6
 #define IRLMP_MAX_SDU_SIZE       7
 #define IRLMP_IAS_GET            8
+#define IRLMP_IAS_DEL		 9
 
 #define IRTTP_MAX_SDU_SIZE IRLMP_MAX_SDU_SIZE /* Compatibility */
 
@@ -93,6 +94,11 @@ enum {
 #define IAS_MAX_OCTET_STRING  1024
 #define IAS_MAX_CLASSNAME       64
 #define IAS_MAX_ATTRIBNAME     256
+
+#define IAS_MISSING 0
+#define IAS_INTEGER 1
+#define IAS_OCT_SEQ 2
+#define IAS_STRING  3
 
 #define LSAP_ANY              0xff
 
diff -urpN old-linux/include/net/irda/irias_object.h linux/include/net/irda/irias_object.h
--- old-linux/include/net/irda/irias_object.h	Tue Dec 21 10:17:31 1999
+++ linux/include/net/irda/irias_object.h	Thu Nov  9 11:17:07 2000
@@ -34,6 +34,10 @@
 #define IAS_OCT_SEQ 2
 #define IAS_STRING  3
 
+/* Object ownership of attributes (user or kernel) */
+#define IAS_KERNEL_ATTR	0
+#define IAS_USER_ATTR	1
+
 /*
  *  LM-IAS Object
  */
@@ -51,6 +55,7 @@ struct ias_object {
  */
 struct ias_value {
         __u8    type;    /* Value description */
+	__u8	owner;	/* Managed from user/kernel space */
 	int     charset; /* Only used by string type */
         int     len;
 	
@@ -78,12 +83,15 @@ char *strdup(char *str);
 struct ias_object *irias_new_object(char *name, int id);
 void irias_insert_object(struct ias_object *obj);
 int  irias_delete_object(struct ias_object *obj);
+int  irias_delete_attrib(struct ias_object *obj, struct ias_attrib *attrib);
 void __irias_delete_object(struct ias_object *obj);
 
-void irias_add_integer_attrib(struct ias_object *obj, char *name, int value);
-void irias_add_string_attrib(struct ias_object *obj, char *name, char *value);
+void irias_add_integer_attrib(struct ias_object *obj, char *name, int value,
+			      int user);
+void irias_add_string_attrib(struct ias_object *obj, char *name, char *value,
+			     int user);
 void irias_add_octseq_attrib(struct ias_object *obj, char *name, __u8 *octets,
-			     int len);
+			     int len, int user);
 int irias_object_change_attribute(char *obj_name, char *attrib_name, 
 				  struct ias_value *new_value);
 struct ias_object *irias_find_object(char *name);
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Fri Oct 27 10:56:41 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 11:17:07 2000
@@ -323,6 +323,8 @@ static void irda_flow_indication(void *i
 	}
 }
 
+#if 0
+/* Now obsolete... */
 /*
  * Function irda_getvalue_confirm (obj_id, value, priv)
  *
@@ -378,6 +380,55 @@ static void irda_getvalue_confirm(int re
 	/* Wake up any processes waiting for result */
 	wake_up_interruptible(&self->ias_wait);
 }
+#endif
+
+/*
+ * Function irda_getvalue_confirm (obj_id, value, priv)
+ *
+ *    Got answer from remote LM-IAS, just pass object to requester...
+ *
+ * Note : duplicate from above, but we need our own version that
+ * doesn't touch the dtsap_sel and save the full value structure...
+ */
+static void irda_getvalue_confirm(int result, __u16 obj_id, 
+					  struct ias_value *value, void *priv)
+{
+	struct irda_sock *self;
+	
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	ASSERT(priv != NULL, return;);
+	self = (struct irda_sock *) priv;
+	
+	if (!self) {
+		WARNING(__FUNCTION__ "(), lost myself!\n");
+		return;
+	}
+
+	/* We probably don't need to make any more queries */
+	iriap_close(self->iriap);
+	self->iriap = NULL;
+
+	/* Check if request succeeded */
+	if (result != IAS_SUCCESS) {
+		IRDA_DEBUG(1, __FUNCTION__ "(), IAS query failed! (%d)\n",
+			   result);
+
+		self->errno = result;	/* We really need it later */
+
+		/* Wake up any processes waiting for result */
+		wake_up_interruptible(&self->ias_wait);
+
+		return;
+	}
+
+	/* Pass the object to the caller (so the caller must delete it) */
+	self->ias_result = value;
+	self->errno = 0;
+
+	/* Wake up any processes waiting for result */
+	wake_up_interruptible(&self->ias_wait);
+}
 
 /*
  * Function irda_discovery_indication (log)
@@ -470,6 +521,11 @@ static int irda_open_lsap(struct irda_so
  *
  *    Try to lookup LSAP selector in remote LM-IAS
  *
+ * Basically, we start a IAP query, and the go to sleep. When the query
+ * return, irda_getvalue_confirm will wake us up, and we can examine the
+ * result of the query...
+ * Note that in some case, the query fail even before we go to sleep,
+ * creating some races...
  */
 static int irda_find_lsap_sel(struct irda_sock *self, char *name)
 {
@@ -485,16 +541,50 @@ static int irda_find_lsap_sel(struct ird
 	self->iriap = iriap_open(LSAP_ANY, IAS_CLIENT, self,
 				 irda_getvalue_confirm);
 
+	/* Treat unexpected signals as disconnect */
+	self->errno = -EHOSTUNREACH;
+
 	/* Query remote LM-IAS */
 	iriap_getvaluebyclass_request(self->iriap, self->saddr, self->daddr,
 				      name, "IrDA:TinyTP:LsapSel");
-	/* Wait for answer */
-	interruptible_sleep_on(&self->ias_wait);
+	/* Wait for answer (if not already failed) */
+	if(self->iriap != NULL)
+		interruptible_sleep_on(&self->ias_wait);
+
+	/* Check what happened */
+	if (self->errno)
+	{
+		/* Requested object/attribute doesn't exist */
+		if((self->errno == IAS_CLASS_UNKNOWN) ||
+		   (self->errno == IAS_ATTRIB_UNKNOWN))
+			return (-EADDRNOTAVAIL);
+		else
+			return (-EHOSTUNREACH);
+	}
+
+	/* Get the remote TSAP selector */
+	switch (self->ias_result->type) {
+	case IAS_INTEGER:
+		IRDA_DEBUG(4, __FUNCTION__ "() int=%d\n",
+			   self->ias_result->t.integer);
+		
+		if (self->ias_result->t.integer != -1)
+			self->dtsap_sel = self->ias_result->t.integer;
+		else 
+			self->dtsap_sel = 0;
+		break;
+	default:
+		self->dtsap_sel = 0;
+		IRDA_DEBUG(0, __FUNCTION__ "(), bad type!\n");
+		break;
+	}
+	if (self->ias_result)
+		irias_delete_value(self->ias_result);
 
 	if (self->dtsap_sel)
 		return 0;
 
-	return -ENETUNREACH; /* May not be true */
+	return -EADDRNOTAVAIL;
 }
 
  /*
@@ -518,7 +608,7 @@ static int irda_discover_daddr_and_lsap_
 {
 	discovery_t *discovery;
 	int err = -ENETUNREACH;
-	__u32	daddr = 0x0;		/* Address we found the service on */
+	__u32	daddr = DEV_ADDR_ANY;	/* Address we found the service on */
 	__u8	dtsap_sel = 0x0;	/* TSAP associated with it */
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), name=%s\n", name);
@@ -536,7 +626,7 @@ static int irda_discover_daddr_and_lsap_
 	if (!cachelog)
 		/* Wait for answer */
 		/*interruptible_sleep_on(&self->discovery_wait);*/
-		return -EAGAIN;
+		return -ENETUNREACH;	/* No nodes discovered */
 
 	/* 
 	 * Now, check all discovered devices (if any), and connect
@@ -555,32 +645,44 @@ static int irda_discover_daddr_and_lsap_
 
 			/* Query remote LM-IAS for this service */
 			err = irda_find_lsap_sel(self, name);
-			if (err == 0) {
+			switch (err) {
+			case 0:
 				/* We found the requested service */
-				if(daddr != 0x0) {
-					IRDA_DEBUG(0, __FUNCTION__
+				if(daddr != DEV_ADDR_ANY) {
+					IRDA_DEBUG(1, __FUNCTION__
 						   "(), discovered service ''%s'' in two different devices !!!\n",
 						   name);
+					self->daddr = DEV_ADDR_ANY;
 					return(-ENOTUNIQ);
 				}
-				/* First time we foun that one, save it ! */
+				/* First time we found that one, save it ! */
 				daddr = self->daddr;
 				dtsap_sel = self->dtsap_sel;
+				break;
+			case -EADDRNOTAVAIL:
+				/* Requested service simply doesn't exist on this node */
+				break;
+			default:
+				/* Something bad did happen :-( */
+				IRDA_DEBUG(0, __FUNCTION__
+					   "(), unexpected IAS query failure\n");
+				self->daddr = DEV_ADDR_ANY;
+				return(-EHOSTUNREACH);
+				break;
 			}
 		}
 
 		/* Next node, maybe we will be more lucky...  */
 		discovery = (discovery_t *) hashbin_get_next(cachelog);
 	}
-	cachelog = NULL;
 
 	/* Check out what we found */
-	if(daddr == 0x0) {
-		IRDA_DEBUG(0, __FUNCTION__
+	if(daddr == DEV_ADDR_ANY) {
+		IRDA_DEBUG(1, __FUNCTION__
 			   "(), cannot discover service ''%s'' in any device !!!\n",
 			   name);
-		self->daddr = 0;	/* Guessing */
-		return(-ENETUNREACH);
+		self->daddr = DEV_ADDR_ANY;
+		return(-EADDRNOTAVAIL);
 	}
 
 	/* Revert back to discovered device & service */
@@ -588,7 +690,7 @@ static int irda_discover_daddr_and_lsap_
 	self->saddr = 0x0;
 	self->dtsap_sel = dtsap_sel;
 
-	IRDA_DEBUG(0, __FUNCTION__ 
+	IRDA_DEBUG(1, __FUNCTION__ 
 		   "(), discovered requested service ''%s'' at address %08x\n",
 		   name, self->daddr);
 
@@ -606,25 +708,26 @@ static int irda_getname(struct socket *s
 {
 	struct sockaddr_irda saddr;
 	struct sock *sk = sock->sk;
+	struct irda_sock *self = sk->protinfo.irda;
 
 	if (peer) {
 		if (sk->state != TCP_ESTABLISHED)
 			return -ENOTCONN;
 		
 		saddr.sir_family = AF_IRDA;
-		saddr.sir_lsap_sel = sk->protinfo.irda->dtsap_sel;
-		saddr.sir_addr = sk->protinfo.irda->daddr;
+		saddr.sir_lsap_sel = self->dtsap_sel;
+		saddr.sir_addr = self->daddr;
 	} else {
 		saddr.sir_family = AF_IRDA;
-		saddr.sir_lsap_sel = sk->protinfo.irda->stsap_sel;
-		saddr.sir_addr = sk->protinfo.irda->saddr;
+		saddr.sir_lsap_sel = self->stsap_sel;
+		saddr.sir_addr = self->saddr;
 	}
 	
 	IRDA_DEBUG(1, __FUNCTION__ "(), tsap_sel = %#x\n", saddr.sir_lsap_sel);
 	IRDA_DEBUG(1, __FUNCTION__ "(), addr = %08x\n", saddr.sir_addr);
 
-	if (*uaddr_len > sizeof (struct sockaddr_irda))
-		*uaddr_len = sizeof (struct sockaddr_irda);
+	/* uaddr_len come to us uninitialised */
+	*uaddr_len = sizeof (struct sockaddr_irda);
 	memcpy(uaddr, &saddr, *uaddr_len);
 
 	return 0;
@@ -709,7 +812,7 @@ static int irda_bind(struct socket *sock
 	/*  Register with LM-IAS */
 	self->ias_obj = irias_new_object(addr->sir_name, jiffies);
 	irias_add_integer_attrib(self->ias_obj, "IrDA:TinyTP:LsapSel", 
-				 self->stsap_sel);
+				 self->stsap_sel, IAS_KERNEL_ATTR);
 	irias_insert_object(self->ias_obj);
 	
 #if 1 /* Will be removed in near future */
@@ -821,6 +924,20 @@ static int irda_accept(struct socket *so
  *
  *    Connect to a IrDA device
  *
+ * The main difference with a "standard" connect is that with IrDA we need
+ * to resolve the service name into a TSAP selector (in TCP, port number
+ * doesn't have to be resolved).
+ * Because of this service name resoltion, we can offer "auto-connect",
+ * where we connect to a service without specifying a destination address.
+ *
+ * Note : by consulting "errno", the user space caller may learn the cause
+ * of the failure. Most of them are visible in the function, others may come
+ * from subroutines called and are listed here :
+ *	o EBUSY : already processing a connect
+ *	o EHOSTUNREACH : bad addr->sir_addr argument
+ *	o EADDRNOTAVAIL : bad addr->sir_name argument
+ *	o ENOTUNIQ : more than one node has addr->sir_name (auto-connect)
+ *	o ENETUNREACH : no node found on the network (auto-connect)
  */
 static int irda_connect(struct socket *sock, struct sockaddr *uaddr,
 			int addr_len, int flags)
@@ -858,13 +975,13 @@ static int irda_connect(struct socket *s
 		return -EINVAL;
 
 	/* Check if user supplied any destination device address */
-	if (!addr->sir_addr) {
+	if ((!addr->sir_addr) || (addr->sir_addr == DEV_ADDR_ANY)) {
 		/* Try to find one suitable */
 		err = irda_discover_daddr_and_lsap_sel(self, addr->sir_name);
 		if (err) {
 			IRDA_DEBUG(0, __FUNCTION__ 
 				   "(), auto-connect failed!\n");
-			return -EINVAL;
+			return err;
 		}
 	} else {
 		/* Use the one provided by the user */
@@ -1606,6 +1723,7 @@ static int irda_setsockopt(struct socket
 	struct irda_sock *self;
 	struct irda_ias_set	ias_opt;
 	struct ias_object      *ias_obj;
+	struct ias_attrib *	ias_attr;	/* Attribute in IAS object */
 	int opt;
 	
 	self = sk->protinfo.irda;
@@ -1616,6 +1734,13 @@ static int irda_setsockopt(struct socket
 		
 	switch (optname) {
 	case IRLMP_IAS_SET:
+		/* The user want to add an attribute to an existing IAS object
+		 * (in the IAS database) or to create a new object with this
+		 * attribute.
+		 * We first query IAS to know if the object exist, and then
+		 * create the right attribute...
+		 */
+
 		if (optlen != sizeof(struct irda_ias_set))
 			return -EINVAL;
 	
@@ -1639,9 +1764,11 @@ static int irda_setsockopt(struct socket
 		switch(ias_opt.irda_attrib_type) {
 		case IAS_INTEGER:
 			/* Add an integer attribute */
-			irias_add_integer_attrib(ias_obj,
-						 ias_opt.irda_attrib_name, 
-					 ias_opt.attribute.irda_attrib_int);
+			irias_add_integer_attrib(
+				ias_obj,
+				ias_opt.irda_attrib_name, 
+				ias_opt.attribute.irda_attrib_int,
+				IAS_USER_ATTR);
 			break;
 		case IAS_OCT_SEQ:
 			/* Check length */
@@ -1653,7 +1780,8 @@ static int irda_setsockopt(struct socket
 			      ias_obj,
 			      ias_opt.irda_attrib_name, 
 			      ias_opt.attribute.irda_attrib_octet_seq.octet_seq,
-			      ias_opt.attribute.irda_attrib_octet_seq.len);
+			      ias_opt.attribute.irda_attrib_octet_seq.len,
+			      IAS_USER_ATTR);
 			break;
 		case IAS_STRING:
 			/* Should check charset & co */
@@ -1667,16 +1795,49 @@ static int irda_setsockopt(struct socket
 			irias_add_string_attrib(
 				ias_obj,
 				ias_opt.irda_attrib_name, 
-				ias_opt.attribute.irda_attrib_string.string);
+				ias_opt.attribute.irda_attrib_string.string,
+				IAS_USER_ATTR);
 			break;
 		default :
 			return -EINVAL;
 		}
 		irias_insert_object(ias_obj);
 		break;
+	case IRLMP_IAS_DEL:
+		/* The user want to delete an object from our local IAS
+		 * database. We just need to query the IAS, check is the
+		 * object is not owned by the kernel and delete it.
+		 */
 
-		IRDA_DEBUG(0, __FUNCTION__ "(), sorry not impl. yet!\n");
-		return -ENOPROTOOPT;
+		if (optlen != sizeof(struct irda_ias_set))
+			return -EINVAL;
+	
+		/* Copy query to the driver. */
+		if (copy_from_user(&ias_opt, (char *)optval, optlen))
+		  	return -EFAULT;
+
+		/* Find the object we target */
+		ias_obj = irias_find_object(ias_opt.irda_class_name);
+		if(ias_obj == (struct ias_object *) NULL)
+			return -EINVAL;
+
+		/* Find the attribute (in the object) we target */
+		ias_attr = irias_find_attrib(ias_obj,
+					     ias_opt.irda_attrib_name); 
+		if(ias_attr == (struct ias_attrib *) NULL)
+			return -EINVAL;
+
+		/* Check is the user space own the object */
+		if(ias_attr->value->owner != IAS_USER_ATTR) {
+			IRDA_DEBUG(1, __FUNCTION__ 
+				   "(), attempting to delete a kernel attribute\n");
+			return -EPERM;
+		}
+
+		/* Remove the attribute (and maybe the object) */
+		irias_delete_attrib(ias_obj, ias_attr);
+
+		break;
 	case IRLMP_MAX_SDU_SIZE:
 		if (optlen < sizeof(int))
 			return -EINVAL;
@@ -1715,56 +1876,6 @@ static int irda_setsockopt(struct socket
 	return 0;
 }
 
- /*
- * Function irda_simple_getvalue_confirm (obj_id, value, priv)
- *
- *    Got answer from remote LM-IAS, just copy object to requester...
- *
- * Note : duplicate from above, but we need our own version that
- * doesn't touch the dtsap_sel and save the full value structure...
- */
-static void irda_simple_getvalue_confirm(int result, __u16 obj_id, 
-					  struct ias_value *value, void *priv)
-{
-	struct irda_sock *self;
-	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-
-	ASSERT(priv != NULL, return;);
-	self = (struct irda_sock *) priv;
-	
-	if (!self) {
-		WARNING(__FUNCTION__ "(), lost myself!\n");
-		return;
-	}
-
-	/* We probably don't need to make any more queries */
-	iriap_close(self->iriap);
-	self->iriap = NULL;
-
-	/* Check if request succeeded */
-	if (result != IAS_SUCCESS) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), IAS query failed!\n");
-
-		self->errno = -EHOSTUNREACH;
-
-		/* Wake up any processes waiting for result */
-		wake_up_interruptible(&self->ias_wait);
-
-		return;
-	}
-
-	/* Clone the object (so the requester can free it) */
-	self->ias_result = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
-	memcpy(self->ias_result, value, sizeof(struct ias_value));
-	irias_delete_value(value);
-
-	self->errno = 0;
-
-	/* Wake up any processes waiting for result */
-	wake_up_interruptible(&self->ias_wait);
-}
-
 /*
  * Function irda_extract_ias_value(ias_opt, ias_value)
  *
@@ -1803,6 +1914,7 @@ static int irda_extract_ias_value(struct
 		/* NULL terminate the string (avoid troubles) */
 		ias_opt->attribute.irda_attrib_string.string[ias_value->len] = '\0';
 		break;
+	case IAS_MISSING:
 	default :
 		return -EINVAL;
 	}
@@ -1830,6 +1942,7 @@ static int irda_getsockopt(struct socket
 	struct irda_ias_set	ias_opt;	/* IAS get/query params */
 	struct ias_object *	ias_obj;	/* Object in IAS */
 	struct ias_attrib *	ias_attr;	/* Attribute in IAS object */
+	int daddr = DEV_ADDR_ANY;	/* Dest address for IAS queries */
 	int val = 0;
 	int len = 0;
 	int err;
@@ -1854,7 +1967,7 @@ static int irda_getsockopt(struct socket
 		
 		/* Check if the we got some results */
 		if (!cachelog)
-			return -EAGAIN;
+			return -EAGAIN;		/* Didn't find any devices */
 
 		info = &list.dev[0];
 
@@ -1896,6 +2009,10 @@ static int irda_getsockopt(struct socket
 			discovery = (discovery_t *) hashbin_get_next(cachelog);
 		}
 		cachelog = NULL;
+		/* Problem : at this point, the discovery log got scrapped
+		 * and will be regenerated only later. If anybody (another
+		 * app) want to perform a discovery now, it will get screwed.
+		 */
 
 		/* Write total number of bytes used back to client */
 		if (put_user(total, optlen))
@@ -1964,6 +2081,26 @@ static int irda_getsockopt(struct socket
 		if (copy_from_user((char *) &ias_opt, (char *)optval, len))
 		  	return -EFAULT;
 
+		/* At this point, there are two cases...
+		 * 1) the socket is connected - that's the easy case, we
+		 *	just query the device we are connected to...
+		 * 2) the socket is not connected - the user doesn't want
+		 *	to connect and/or may not have a valid service name
+		 *	(so can't create a fake connection). In this case,
+		 *	we assume that the user pass us a valid destination
+		 *	address in the requesting structure...
+		 */
+		if(self->daddr != DEV_ADDR_ANY) {
+			/* We are connected - reuse known daddr */
+			daddr = self->daddr;
+		} else {
+			/* We are not connected, we must specify a valid
+			 * destination address */
+			daddr = ias_opt.attribute.irda_attrib_int;
+			if((!daddr) || (daddr == DEV_ADDR_ANY))
+				return -EINVAL;
+		}
+
 		/* Check that we can proceed with IAP */
 		if (self->iriap) {
 			WARNING(__FUNCTION__
@@ -1972,26 +2109,34 @@ static int irda_getsockopt(struct socket
 		}
 
 		self->iriap = iriap_open(LSAP_ANY, IAS_CLIENT, self,
-					 irda_simple_getvalue_confirm);
+					 irda_getvalue_confirm);
 
 		/* Treat unexpected signals as disconnect */
 		self->errno = -EHOSTUNREACH;
 
 		/* Query remote LM-IAS */
-		iriap_getvaluebyclass_request(self->iriap, 
-					      self->saddr, self->daddr,
+		iriap_getvaluebyclass_request(self->iriap,
+					      self->saddr, daddr,
 					      ias_opt.irda_class_name,
 					      ias_opt.irda_attrib_name);
-		/* Wait for answer */
-		interruptible_sleep_on(&self->ias_wait);
+		/* Wait for answer (if not already failed) */
+		if(self->iriap != NULL)
+			interruptible_sleep_on(&self->ias_wait);
 		/* Check what happened */
 		if (self->errno)
-			return (self->errno);
+		{
+			/* Requested object/attribute doesn't exist */
+			if((self->errno == IAS_CLASS_UNKNOWN) ||
+			   (self->errno == IAS_ATTRIB_UNKNOWN))
+				return (-EADDRNOTAVAIL);
+			else
+				return (-EHOSTUNREACH);
+		}
 
 		/* Translate from internal to user structure */
 		err = irda_extract_ias_value(&ias_opt, self->ias_result);
 		if (self->ias_result)
-			kfree(self->ias_result);
+			irias_delete_value(self->ias_result);
 		if (err)
 			return err;
 
diff -urpN old-linux/net/irda/ircomm/ircomm_tty_attach.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- old-linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Jan  6 14:46:18 2000
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Nov  9 11:17:07 2000
@@ -213,7 +213,7 @@ static void ircomm_tty_ias_register(stru
 		/* Register IrLPT with LM-IAS */
 		self->obj = irias_new_object("IrLPT", IAS_IRLPT_ID);
 		irias_add_integer_attrib(self->obj, "IrDA:IrLMP:LsapSel", 
-					 self->slsap_sel);
+					 self->slsap_sel, IAS_KERNEL_ATTR);
 		irias_insert_object(self->obj);
 	} else {
 		hints = irlmp_service_to_hint(S_COMM);
@@ -221,7 +221,7 @@ static void ircomm_tty_ias_register(stru
 		/* Register IrCOMM with LM-IAS */
 		self->obj = irias_new_object("IrDA:IrCOMM", IAS_IRCOMM_ID);
 		irias_add_integer_attrib(self->obj, "IrDA:TinyTP:LsapSel", 
-					 self->slsap_sel);
+					 self->slsap_sel, IAS_KERNEL_ATTR);
 		
 		/* Code the parameters into the buffer */
 		irda_param_pack(oct_seq, "bbbbbb", 
@@ -229,7 +229,8 @@ static void ircomm_tty_ias_register(stru
 				IRCOMM_PORT_TYPE,    1, IRCOMM_SERIAL);
 		
 		/* Register parameters with LM-IAS */
-		irias_add_octseq_attrib(self->obj, "Parameters", oct_seq, 6);
+		irias_add_octseq_attrib(self->obj, "Parameters", oct_seq, 6,
+					IAS_KERNEL_ATTR);
 		irias_insert_object(self->obj);
 	}
 	self->skey = irlmp_register_service(hints);
diff -urpN old-linux/net/irda/iriap.c linux/net/irda/iriap.c
--- old-linux/net/irda/iriap.c	Thu Jan  6 14:46:18 2000
+++ linux/net/irda/iriap.c	Thu Nov  9 11:17:07 2000
@@ -107,7 +107,7 @@ int __init iriap_init(void)
 
 	/* Register the Device object with LM-IAS */
 	obj = irias_new_object("Device", IAS_DEVICE_ID);
-	irias_add_string_attrib(obj, "DeviceName", "Linux");
+	irias_add_string_attrib(obj, "DeviceName", "Linux", IAS_KERNEL_ATTR);
 
 	oct_seq[0] = 0x01;  /* Version 1 */
 	oct_seq[1] = 0x00;  /* IAS support bits */
@@ -115,7 +115,8 @@ int __init iriap_init(void)
 #ifdef CONFIG_IRDA_ULTRA
 	oct_seq[2] |= 0x04; /* Connectionless Data support */
 #endif
-	irias_add_octseq_attrib(obj, "IrLMPSupport", oct_seq, 3);
+	irias_add_octseq_attrib(obj, "IrLMPSupport", oct_seq, 3,
+				IAS_KERNEL_ATTR);
 	irias_insert_object(obj);
 
 	/*  
@@ -866,7 +867,7 @@ static int iriap_data_indication(void *i
 			iriap_getvaluebyclass_confirm(self, skb);
 			break;
 		case IAS_CLASS_UNKNOWN:
-			WARNING(__FUNCTION__ "(), No such class!\n");
+			IRDA_DEBUG(1, __FUNCTION__ "(), No such class!\n");
 			/* Finished, close connection! */
 			iriap_disconnect_request(self);
 
@@ -880,7 +881,7 @@ static int iriap_data_indication(void *i
 			dev_kfree_skb(skb);
 			break;
 		case IAS_ATTRIB_UNKNOWN:
-			WARNING(__FUNCTION__ "(), No such attribute!\n");
+			IRDA_DEBUG(1, __FUNCTION__ "(), No such attribute!\n");
 		       	/* Finished, close connection! */
 			iriap_disconnect_request(self);
 
@@ -889,7 +890,7 @@ static int iriap_data_indication(void *i
 			 * no to use self anymore after calling confirm 
 			 */
 			if (self->confirm)
-				self->confirm(IAS_CLASS_UNKNOWN, 0, NULL, 
+				self->confirm(IAS_ATTRIB_UNKNOWN, 0, NULL, 
 					      self->priv);
 			dev_kfree_skb(skb);
 			break;
diff -urpN old-linux/net/irda/irias_object.c linux/net/irda/irias_object.c
--- old-linux/net/irda/irias_object.c	Tue Dec 21 10:17:58 1999
+++ linux/net/irda/irias_object.c	Thu Nov  9 11:17:07 2000
@@ -148,6 +148,37 @@ int irias_delete_object(struct ias_objec
 }
 
 /*
+ * Function irias_delete_attrib (obj)
+ *
+ *    Remove attribute from hashbin and, if it was the last attribute of
+ *    the object, remove the object as well.
+ *
+ */
+int irias_delete_attrib(struct ias_object *obj, struct ias_attrib *attrib) 
+{
+	struct ias_attrib *node;
+
+	ASSERT(obj != NULL, return -1;);
+	ASSERT(obj->magic == IAS_OBJECT_MAGIC, return -1;);
+	ASSERT(attrib != NULL, return -1;);
+
+	/* Remove atribute from object */
+	node = hashbin_remove(obj->attribs, 0, attrib->name);
+	if (!node)
+		return 0; /* Already removed or non-existent */
+
+	/* Deallocate attribute */
+	__irias_delete_attrib(node);
+
+	/* Check if object has still some attributes */
+	node = (struct ias_attrib *) hashbin_get_first(obj->attribs);
+	if (!node)
+		irias_delete_object(obj);
+
+	return 0;
+}
+
+/*
  * Function irias_insert_object (obj)
  *
  *    Insert an object into the LM-IAS database
@@ -201,7 +232,8 @@ struct ias_attrib *irias_find_attrib(str
  *    Add attribute to object
  *
  */
-void irias_add_attrib( struct ias_object *obj, struct ias_attrib *attrib)
+void irias_add_attrib( struct ias_object *obj, struct ias_attrib *attrib,
+		       int owner)
 {
 	ASSERT(obj != NULL, return;);
 	ASSERT(obj->magic == IAS_OBJECT_MAGIC, return;);
@@ -209,6 +241,9 @@ void irias_add_attrib( struct ias_object
 	ASSERT(attrib != NULL, return;);
 	ASSERT(attrib->magic == IAS_ATTRIB_MAGIC, return;);
 
+	/* Set if attrib is owned by kernel or user space */
+	attrib->value->owner = owner;
+
 	hashbin_insert(obj->attribs, (queue_t *) attrib, 0, attrib->name);
 }
 
@@ -262,7 +297,8 @@ int irias_object_change_attribute(char *
  *    Add an integer attribute to an LM-IAS object
  *
  */
-void irias_add_integer_attrib(struct ias_object *obj, char *name, int value)
+void irias_add_integer_attrib(struct ias_object *obj, char *name, int value,
+			      int owner)
 {
 	struct ias_attrib *attrib;
 
@@ -284,7 +320,7 @@ void irias_add_integer_attrib(struct ias
 	/* Insert value */
 	attrib->value = irias_new_integer_value(value);
 	
-	irias_add_attrib(obj, attrib);
+	irias_add_attrib(obj, attrib, owner);
 }
 
  /*
@@ -295,7 +331,7 @@ void irias_add_integer_attrib(struct ias
  */
 
 void irias_add_octseq_attrib(struct ias_object *obj, char *name, __u8 *octets,
-			     int len)
+			     int len, int owner)
 {
 	struct ias_attrib *attrib;
 	
@@ -319,7 +355,7 @@ void irias_add_octseq_attrib(struct ias_
 	
 	attrib->value = irias_new_octseq_value( octets, len);
 	
-	irias_add_attrib(obj, attrib);
+	irias_add_attrib(obj, attrib, owner);
 }
 
 /*
@@ -328,7 +364,8 @@ void irias_add_octseq_attrib(struct ias_
  *    Add a string attribute to an LM-IAS object
  *
  */
-void irias_add_string_attrib(struct ias_object *obj, char *name, char *value)
+void irias_add_string_attrib(struct ias_object *obj, char *name, char *value,
+			     int owner)
 {
 	struct ias_attrib *attrib;
 
@@ -351,7 +388,7 @@ void irias_add_string_attrib(struct ias_
 
 	attrib->value = irias_new_string_value(value);
 
-	irias_add_attrib(obj, attrib);
+	irias_add_attrib(obj, attrib, owner);
 }
 
 /*
diff -urpN old-linux/net/irda/irlan/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- old-linux/net/irda/irlan/irlan_common.c	Thu May  4 11:31:22 2000
+++ linux/net/irda/irlan/irlan_common.c	Thu Nov  9 11:17:07 2000
@@ -595,7 +595,8 @@ void irlan_ias_register(struct irlan_cb 
 	 */
 	if (!irias_find_object("IrLAN")) {
 		obj = irias_new_object("IrLAN", IAS_IRLAN_ID);
-		irias_add_integer_attrib(obj, "IrDA:TinyTP:LsapSel", tsap_sel);
+		irias_add_integer_attrib(obj, "IrDA:TinyTP:LsapSel", tsap_sel,
+					 IAS_KERNEL_ATTR);
 		irias_insert_object(obj);
 	} else {
 		new_value = irias_new_integer_value(tsap_sel);
@@ -607,18 +608,23 @@ void irlan_ias_register(struct irlan_cb 
         if (!irias_find_object("PnP")) {
 		obj = irias_new_object("PnP", IAS_PNP_ID);
 #if 0
-		irias_add_string_attrib(obj, "Name", sysctl_devname);
+		irias_add_string_attrib(obj, "Name", sysctl_devname,
+					IAS_KERNEL_ATTR);
 #else
-		irias_add_string_attrib(obj, "Name", "Linux");
+		irias_add_string_attrib(obj, "Name", "Linux", IAS_KERNEL_ATTR);
 #endif
-		irias_add_string_attrib(obj, "DeviceID", "HWP19F0");
-		irias_add_integer_attrib(obj, "CompCnt", 1);
+		irias_add_string_attrib(obj, "DeviceID", "HWP19F0",
+					IAS_KERNEL_ATTR);
+		irias_add_integer_attrib(obj, "CompCnt", 1, IAS_KERNEL_ATTR);
 		if (self->provider.access_type == ACCESS_PEER)
-			irias_add_string_attrib(obj, "Comp#01", "PNP8389");
+			irias_add_string_attrib(obj, "Comp#01", "PNP8389",
+						IAS_KERNEL_ATTR);
 		else
-			irias_add_string_attrib(obj, "Comp#01", "PNP8294");
+			irias_add_string_attrib(obj, "Comp#01", "PNP8294",
+						IAS_KERNEL_ATTR);
 
-		irias_add_string_attrib(obj, "Manufacturer", "Linux-IrDA Project");
+		irias_add_string_attrib(obj, "Manufacturer",
+					"Linux-IrDA Project", IAS_KERNEL_ATTR);
 		irias_insert_object(obj);
 	}
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
