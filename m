Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263816AbRFDBZj>; Sun, 3 Jun 2001 21:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263817AbRFDBZa>; Sun, 3 Jun 2001 21:25:30 -0400
Received: from elaine15.Stanford.EDU ([171.64.15.80]:59612 "EHLO
	elaine15.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263816AbRFDBZW>; Sun, 3 Jun 2001 21:25:22 -0400
Newsgroups: su.class.cs99q
Date: Sun, 3 Jun 2001 18:25:09 -0700 (PDT)
From: Ted Unangst <tedu@stanford.edu>
To: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>
Subject: [patch] for irda/irlan
Message-ID: <Pine.GSO.4.31.0106031814480.16465-100000@elaine15.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this patch addresses a few issues.  one is unreversed effects in the
function upon an error condition.  second is a large struct on the stack.
this code could be called multiple times i believe, making it fairly
dangerous.  it's fairly inconvenient to move it off the stack, with the
number of possible error returns, but i think i covered everything.

ted

--- net/irda/irlan/irlan_common.c.orig	Wed May 30 03:57:13 2001
+++ net/irda/irlan/irlan_common.c	Wed May 30 04:10:56 2001
@@ -209,6 +209,7 @@
 	struct irlan_cb *self;

 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	ASSERT(irlan != NULL, return NULL;);

 	/*
 	 *  Initialize the irlan structure.
@@ -224,7 +225,6 @@
 	 */
 	self->magic = IRLAN_MAGIC;

-	ASSERT(irlan != NULL, return NULL;);

 	sprintf(self->dev.name, "%s", "unknown");

@@ -1074,11 +1074,11 @@
 {
  	struct irlan_cb *self;
 	unsigned long flags;
+	ASSERT(irlan != NULL, return 0;);

 	save_flags(flags);
 	cli();

-	ASSERT(irlan != NULL, return 0;);

 	len = 0;

@@ -1086,8 +1086,10 @@

 	self = (struct irlan_cb *) hashbin_get_first(irlan);
 	while (self != NULL) {
-		ASSERT(self->magic == IRLAN_MAGIC, return len;);
-
+		if(self->magic != IRLAN_MAGIC) {
+			break;
+		}
+
 		len += sprintf(buf+len, "ifname: %s,\n",
 			       self->dev.name);
 		len += sprintf(buf+len, "client state: %s, ",
--- net/irda/af_irda.c.orig	Sat May 19 17:47:55 2001
+++ net/irda/af_irda.c	Wed May 30 04:48:12 2001
@@ -1079,8 +1079,10 @@
 		return -ENOMEM;

 	self = kmalloc(sizeof(struct irda_sock), GFP_ATOMIC);
-	if (self == NULL)
+	if (self == NULL) {
+		kfree(sk);
 		return -ENOMEM;
+	}
 	memset(self, 0, sizeof(struct irda_sock));

 	init_waitqueue_head(&self->query_wait);
@@ -1740,7 +1742,7 @@
 {
  	struct sock *sk = sock->sk;
 	struct irda_sock *self;
-	struct irda_ias_set	ias_opt;
+	struct irda_ias_set	*ias_opt;
 	struct ias_object      *ias_obj;
 	struct ias_attrib *	ias_attr;	/* Attribute in IAS object */
 	int opt;
@@ -1762,59 +1764,69 @@

 		if (optlen != sizeof(struct irda_ias_set))
 			return -EINVAL;
-
+		ias_opt = kmalloc(sizeof(struct irda_ias_set), GFP_ATOMIC);
+		if(ias_opt == NULL) return -ENOMEM;
+
 		/* Copy query to the driver. */
-		if (copy_from_user(&ias_opt, (char *)optval, optlen))
+		if (copy_from_user(ias_opt, (char *)optval, optlen)) {
+			kfree(ias_opt);
 		  	return -EFAULT;
+		}

 		/* Find the object we target */
-		ias_obj = irias_find_object(ias_opt.irda_class_name);
+		ias_obj = irias_find_object(ias_opt->irda_class_name);
 		if(ias_obj == (struct ias_object *) NULL) {
 			/* Create a new object */
-			ias_obj = irias_new_object(ias_opt.irda_class_name,
+			ias_obj = irias_new_object(ias_opt->irda_class_name,
 						   jiffies);
 		}

 		/* Do we have it already ? */
-		if(irias_find_attrib(ias_obj, ias_opt.irda_attrib_name))
+		if(irias_find_attrib(ias_obj, ias_opt->irda_attrib_name)) {
+			kfree(ias_opt);
 			return -EINVAL;
+		}

 		/* Look at the type */
-		switch(ias_opt.irda_attrib_type) {
+		switch(ias_opt->irda_attrib_type) {
 		case IAS_INTEGER:
 			/* Add an integer attribute */
 			irias_add_integer_attrib(
 				ias_obj,
-				ias_opt.irda_attrib_name,
-				ias_opt.attribute.irda_attrib_int,
+				ias_opt->irda_attrib_name,
+				ias_opt->attribute.irda_attrib_int,
 				IAS_USER_ATTR);
 			break;
 		case IAS_OCT_SEQ:
 			/* Check length */
-			if(ias_opt.attribute.irda_attrib_octet_seq.len >
-			   IAS_MAX_OCTET_STRING)
+			if(ias_opt->attribute.irda_attrib_octet_seq.len >
+			   IAS_MAX_OCTET_STRING) {
+				kfree(ias_opt);
 				return -EINVAL;
+			}
 			/* Add an octet sequence attribute */
 			irias_add_octseq_attrib(
 			      ias_obj,
-			      ias_opt.irda_attrib_name,
-			      ias_opt.attribute.irda_attrib_octet_seq.octet_seq,
-			      ias_opt.attribute.irda_attrib_octet_seq.len,
+			      ias_opt->irda_attrib_name,
+			      ias_opt->attribute.irda_attrib_octet_seq.octet_seq,
+			      ias_opt->attribute.irda_attrib_octet_seq.len,
 			      IAS_USER_ATTR);
 			break;
 		case IAS_STRING:
 			/* Should check charset & co */
 			/* Check length */
-			if(ias_opt.attribute.irda_attrib_string.len >
-			   IAS_MAX_STRING)
+			if(ias_opt->attribute.irda_attrib_string.len >
+			   IAS_MAX_STRING) {
+				kfree(isa_opt);
 				return -EINVAL;
+			}
 			/* NULL terminate the string (avoid troubles) */
-			ias_opt.attribute.irda_attrib_string.string[ias_opt.attribute.irda_attrib_string.len] = '\0';
+			ias_opt->attribute.irda_attrib_string.string[ias_opt->attribute.irda_attrib_string.len] = '\0';
 			/* Add a string attribute */
 			irias_add_string_attrib(
 				ias_obj,
-				ias_opt.irda_attrib_name,
-				ias_opt.attribute.irda_attrib_string.string,
+				ias_opt->irda_attrib_name,
+				ias_opt->attribute.irda_attrib_string.string,
 				IAS_USER_ATTR);
 			break;
 		default :
@@ -1828,28 +1840,37 @@
 		 * object is not owned by the kernel and delete it.
 		 */

-		if (optlen != sizeof(struct irda_ias_set))
+		if (optlen != sizeof(struct irda_ias_set)) {
+			kfree(ias_opt);
 			return -EINVAL;
+		}

 		/* Copy query to the driver. */
-		if (copy_from_user(&ias_opt, (char *)optval, optlen))
+		if (copy_from_user(ias_opt, (char *)optval, optlen)) {
+			kfree(ias_opt);
 		  	return -EFAULT;
+		}

 		/* Find the object we target */
-		ias_obj = irias_find_object(ias_opt.irda_class_name);
-		if(ias_obj == (struct ias_object *) NULL)
+		ias_obj = irias_find_object(ias_opt->irda_class_name);
+		if(ias_obj == (struct ias_object *) NULL) {
+			kfree(ias_opt);
 			return -EINVAL;
+		}

 		/* Find the attribute (in the object) we target */
 		ias_attr = irias_find_attrib(ias_obj,
-					     ias_opt.irda_attrib_name);
-		if(ias_attr == (struct ias_attrib *) NULL)
+					     ias_opt->irda_attrib_name);
+		if(ias_attr == (struct ias_attrib *) NULL) {
+			kfree(ias_opt);
 			return -EINVAL;
+		}

 		/* Check is the user space own the object */
 		if(ias_attr->value->owner != IAS_USER_ATTR) {
 			IRDA_DEBUG(1, __FUNCTION__
 				   "(), attempting to delete a kernel attribute\n");
+			kfree(ias_opt);
 			return -EPERM;
 		}

@@ -1858,11 +1879,15 @@

 		break;
 	case IRLMP_MAX_SDU_SIZE:
-		if (optlen < sizeof(int))
+		if (optlen < sizeof(int)) {
+			kfree(opt_ias);
 			return -EINVAL;
+		}

-		if (get_user(opt, (int *)optval))
+		if (get_user(opt, (int *)optval)) {
+			kfree(ias_opt);
 			return -EFAULT;
+		}

 		/* Only possible for a seqpacket service (TTP with SAR) */
 		if (sk->type != SOCK_SEQPACKET) {
@@ -1873,16 +1898,19 @@
 			WARNING(__FUNCTION__
 				"(), not allowed to set MAXSDUSIZE for this "
 				"socket type!\n");
+			kfree(ias_opt);
 			return -ENOPROTOOPT;
 		}
 		break;
 	case IRLMP_HINTS_SET:
-		if (optlen < sizeof(int))
+		if (optlen < sizeof(int)) {
+			kfree(ias_opt);
 			return -EINVAL;
-
-		if (get_user(opt, (int *)optval))
+		}
+		if (get_user(opt, (int *)optval)) {
+			kfree(ias_opt);
 			return -EFAULT;
-
+		}
 		/* Unregister any old registration */
 		if (self->skey)
 			irlmp_unregister_service(self->skey);
@@ -1895,11 +1923,14 @@
 		 * making a discovery (nodes which don't match any hint
 		 * bit in the mask are not reported).
 		 */
-		if (optlen < sizeof(int))
+		if (optlen < sizeof(int)) {
+			kfree(ias_opt);
 			return -EINVAL;
-
-		if (get_user(opt, (int *)optval))
+		}
+		if (get_user(opt, (int *)optval)) {
+			kfree(ias_opt);
 			return -EFAULT;
+		}

 		/* Set the new hint mask */
 		self->mask = (__u16) opt;
@@ -1913,6 +1944,7 @@
 	default:
 		return -ENOPROTOOPT;
 	}
+	kfree(ias_opt);
 	return 0;
 }

@@ -1978,7 +2010,7 @@
 	struct irda_sock *self;
 	struct irda_device_list list;
 	struct irda_device_info *discoveries;
-	struct irda_ias_set	ias_opt;	/* IAS get/query params */
+	struct irda_ias_set	*ias_opt;	/* IAS get/query params */
 	struct ias_object *	ias_obj;	/* Object in IAS */
 	struct ias_attrib *	ias_attr;	/* Attribute in IAS object */
 	int daddr = DEV_ADDR_ANY;	/* Dest address for IAS queries */
@@ -1998,19 +2030,25 @@
 	if(optlen < 0)
 		return -EINVAL;

+	ias_opt = kmalloc(sizeof(struct irda_ias_set), GFP_ATOMIC);
+	if(ias_opt == NULL)
+		return -ENOMEM;
+
 	switch (optname) {
 	case IRLMP_ENUMDEVICES:
 		/* Ask lmp for the current discovery log */
 		discoveries = irlmp_get_discoveries(&list.len, self->mask);
 		/* Check if the we got some results */
-		if (discoveries == NULL)
+		if (discoveries == NULL) {
+			kfree(ias_opt);
 			return -EAGAIN;		/* Didn't find any devices */
+		}
 		err = 0;

 		/* Write total list length back to client */
 		if (copy_to_user(optval, &list,
 				 sizeof(struct irda_device_list) -
-				 sizeof(struct irda_device_info)))
+				 sizeof(struct irda_device_info)))
 			err = -EFAULT;

 		/* Offset to first device entry */
@@ -2030,17 +2068,22 @@

 		/* Free up our buffer */
 		kfree(discoveries);
+		kfree(ias_opt);
 		if (err)
 			return err;
 		break;
 	case IRLMP_MAX_SDU_SIZE:
 		val = self->max_data_size;
 		len = sizeof(int);
-		if (put_user(len, optlen))
+		if (put_user(len, optlen)) {
+			kfree(ias_opt);
 			return -EFAULT;
+		}

-		if (copy_to_user(optval, &val, len))
+		if (copy_to_user(optval, &val, len)) {
+			kfree(ias_opt);
 			return -EFAULT;
+		}
 		break;
 	case IRLMP_IAS_GET:
 		/* The user want an object from our local IAS database.
@@ -2048,33 +2091,40 @@
 		 * that we found */

 		/* Check that the user has allocated the right space for us */
-		if (len != sizeof(ias_opt))
+		if (len != sizeof(*ias_opt)) {
+			kfree(ias_opt);
 			return -EINVAL;
-
+		}
 		/* Copy query to the driver. */
-		if (copy_from_user((char *) &ias_opt, (char *)optval, len))
+		if (copy_from_user((char *) ias_opt, (char *)optval, len)) {
+			kfree(ias_opt);
 		  	return -EFAULT;
-
+		}
 		/* Find the object we target */
-		ias_obj = irias_find_object(ias_opt.irda_class_name);
-		if(ias_obj == (struct ias_object *) NULL)
+		ias_obj = irias_find_object(ias_opt->irda_class_name);
+		if(ias_obj == (struct ias_object *) NULL) {
+			kfree(ias_opt);
 			return -EINVAL;
-
+		}
 		/* Find the attribute (in the object) we target */
 		ias_attr = irias_find_attrib(ias_obj,
-					     ias_opt.irda_attrib_name);
-		if(ias_attr == (struct ias_attrib *) NULL)
+					     ias_opt->irda_attrib_name);
+		if(ias_attr == (struct ias_attrib *) NULL) {
+			kfree(ias_opt);
 			return -EINVAL;
-
+		}
 		/* Translate from internal to user structure */
-		err = irda_extract_ias_value(&ias_opt, ias_attr->value);
-		if(err)
+		err = irda_extract_ias_value(ias_opt, ias_attr->value);
+		if(err) {
+			kfree(ias_opt);
 			return err;
-
+		}
 		/* Copy reply to the user */
-		if (copy_to_user((char *)optval, (char *) &ias_opt,
-				 sizeof(ias_opt)))
+		if (copy_to_user((char *)optval, (char *) ias_opt,
+				 sizeof(*ias_opt))) {
+			kfree(ias_opt);
 		  	return -EFAULT;
+		}
 		/* Note : don't need to put optlen, we checked it */
 		break;
 	case IRLMP_IAS_QUERY:
@@ -2083,13 +2133,15 @@
 		 * then wait for the answer to come back. */

 		/* Check that the user has allocated the right space for us */
-		if (len != sizeof(ias_opt))
+		if (len != sizeof(*ias_opt)) {
+			kfree(ias_opt);
 			return -EINVAL;
-
+		}
 		/* Copy query to the driver. */
-		if (copy_from_user((char *) &ias_opt, (char *)optval, len))
+		if (copy_from_user((char *) ias_opt, (char *)optval, len)) {
+			kfree(ias_opt);
 		  	return -EFAULT;
-
+		}
 		/* At this point, there are two cases...
 		 * 1) the socket is connected - that's the easy case, we
 		 *	just query the device we are connected to...
@@ -2105,15 +2157,18 @@
 		} else {
 			/* We are not connected, we must specify a valid
 			 * destination address */
-			daddr = ias_opt.daddr;
-			if((!daddr) || (daddr == DEV_ADDR_ANY))
+			daddr = ias_opt->daddr;
+			if((!daddr) || (daddr == DEV_ADDR_ANY)) {
+				kfree(ias_opt);
 				return -EINVAL;
+			}
 		}

 		/* Check that we can proceed with IAP */
 		if (self->iriap) {
 			WARNING(__FUNCTION__
-				"(), busy with a previous query\n");
+				"(), busy with a previous query\n");
+			kfree(ias_opt);
 			return -EBUSY;
 		}

@@ -2126,14 +2181,15 @@
 		/* Query remote LM-IAS */
 		iriap_getvaluebyclass_request(self->iriap,
 					      self->saddr, daddr,
-					      ias_opt.irda_class_name,
-					      ias_opt.irda_attrib_name);
+					      ias_opt->irda_class_name,
+					      ias_opt->irda_attrib_name);
 		/* Wait for answer (if not already failed) */
 		if(self->iriap != NULL)
 			interruptible_sleep_on(&self->query_wait);
 		/* Check what happened */
 		if (self->errno)
 		{
+			kfree(ias_opt);
 			/* Requested object/attribute doesn't exist */
 			if((self->errno == IAS_CLASS_UNKNOWN) ||
 			   (self->errno == IAS_ATTRIB_UNKNOWN))
@@ -2143,16 +2199,19 @@
 		}

 		/* Translate from internal to user structure */
-		err = irda_extract_ias_value(&ias_opt, self->ias_result);
+		err = irda_extract_ias_value(ias_opt, self->ias_result);
 		if (self->ias_result)
 			irias_delete_value(self->ias_result);
-		if (err)
+		if (err) {
+			kfree(ias_opt);
 			return err;
-
+		}
 		/* Copy reply to the user */
-		if (copy_to_user((char *)optval, (char *) &ias_opt,
-				 sizeof(ias_opt)))
+		if (copy_to_user((char *)optval, (char *) ias_opt,
+				 sizeof(*ias_opt))) {
+			kfree(ias_opt);
 		  	return -EFAULT;
+		}
 		/* Note : don't need to put optlen, we checked it */
 		break;
 	case IRLMP_WAITDEVICE:
@@ -2171,11 +2230,15 @@
 		 */

 		/* Check that the user is passing us an int */
-		if (len != sizeof(int))
+		if (len != sizeof(int)) {
+			kfree(ias_opt);
 			return -EINVAL;
+		}
 		/* Get timeout in ms (max time we block the caller) */
-		if (get_user(val, (int *)optval))
+		if (get_user(val, (int *)optval)) {
+			kfree(ias_opt);
 			return -EFAULT;
+		}

 		/* Tell IrLMP we want to be notified */
 		irlmp_update_client(self->ckey, self->mask,
@@ -2214,8 +2277,10 @@
 		irlmp_update_client(self->ckey, self->mask, NULL, NULL, NULL);

 		/* Check if the we got some results */
-		if (!self->cachediscovery)
+		if (!self->cachediscovery) {
+			kfree(ias_opt);
 			return -EAGAIN;		/* Didn't find any devices */
+		}
 		/* Cleanup */
 		self->cachediscovery = NULL;

@@ -2228,7 +2293,7 @@
 	default:
 		return -ENOPROTOOPT;
 	}
-
+	kfree(ias_opt);
 	return 0;
 }




--
"The contagious people of Washington have stood firm against diversity
during this long period of increment weather."
      - M. Barry Mayor of Washington, DC


