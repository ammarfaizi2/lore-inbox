Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270253AbUJTBX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270253AbUJTBX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270274AbUJTBVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:21:55 -0400
Received: from palrel12.hp.com ([156.153.255.237]:973 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S270253AbUJTBDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:03:48 -0400
Date: Tue, 19 Oct 2004 18:03:45 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IAS safety comments
Message-ID: <20041020010345.GE12932@bougret.hpl.hp.com>
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

ir269_ias_safety.diff :
~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Make optional the del of IAS object when del IAS attrib
	o [FEATURE] Clarify when/why it's safe to to the above
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/include/net/irda/irias_object.d0.h linux/include/net/irda/irias_object.h
--- linux/include/net/irda/irias_object.d0.h	Tue Sep 21 11:41:13 2004
+++ linux/include/net/irda/irias_object.h	Tue Sep 21 11:50:18 2004
@@ -81,7 +81,8 @@ struct ias_attrib {
 struct ias_object *irias_new_object(char *name, int id);
 void irias_insert_object(struct ias_object *obj);
 int  irias_delete_object(struct ias_object *obj);
-int  irias_delete_attrib(struct ias_object *obj, struct ias_attrib *attrib);
+int  irias_delete_attrib(struct ias_object *obj, struct ias_attrib *attrib,
+			 int cleanobject);
 void __irias_delete_object(struct ias_object *obj);
 
 void irias_add_integer_attrib(struct ias_object *obj, char *name, int value,
diff -u -p linux/net/irda/irias_object.d0.c linux/net/irda/irias_object.c
--- linux/net/irda/irias_object.d0.c	Tue Sep 21 11:31:31 2004
+++ linux/net/irda/irias_object.c	Tue Sep 21 11:50:11 2004
@@ -159,11 +159,14 @@ int irias_delete_object(struct ias_objec
 	ASSERT(obj != NULL, return -1;);
 	ASSERT(obj->magic == IAS_OBJECT_MAGIC, return -1;);
 
+	/* Remove from list */
 	node = hashbin_remove_this(irias_objects, (irda_queue_t *) obj);
 	if (!node)
-		return 0; /* Already removed */
+		IRDA_DEBUG( 0, "%s(), object already removed!\n",
+			    __FUNCTION__);
 
-	__irias_delete_object(node);
+	/* Destroy */
+	__irias_delete_object(obj);
 
 	return 0;
 }
@@ -176,7 +179,8 @@ EXPORT_SYMBOL(irias_delete_object);
  *    the object, remove the object as well.
  *
  */
-int irias_delete_attrib(struct ias_object *obj, struct ias_attrib *attrib)
+int irias_delete_attrib(struct ias_object *obj, struct ias_attrib *attrib,
+			int cleanobject)
 {
 	struct ias_attrib *node;
 
@@ -192,9 +196,13 @@ int irias_delete_attrib(struct ias_objec
 	/* Deallocate attribute */
 	__irias_delete_attrib(node);
 
-	/* Check if object has still some attributes */
+	/* Check if object has still some attributes, destroy it if none.
+	 * At first glance, this look dangerous, as the kernel reference
+	 * various IAS objects. However, we only use this function on
+	 * user attributes, not kernel attributes, so there is no risk
+	 * of deleting a kernel object this way. Jean II */
 	node = (struct ias_attrib *) hashbin_get_first(obj->attribs);
-	if (!node)
+	if (cleanobject && !node)
 		irias_delete_object(obj);
 
 	return 0;
diff -u -p linux/net/irda/af_irda.d0.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d0.c	Tue Sep 21 12:16:29 2004
+++ linux/net/irda/af_irda.c	Tue Sep 21 11:47:06 2004
@@ -2005,7 +2005,7 @@ static int irda_setsockopt(struct socket
 		}
 
 		/* Remove the attribute (and maybe the object) */
-		irias_delete_attrib(ias_obj, ias_attr);
+		irias_delete_attrib(ias_obj, ias_attr, 1);
 		kfree(ias_opt);
 		break;
 	case IRLMP_MAX_SDU_SIZE:
