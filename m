Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUCITOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUCITJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:09:11 -0500
Received: from palrel11.hp.com ([156.153.255.246]:28313 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262117AbUCITGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:06:33 -0500
Date: Tue, 9 Mar 2004 11:06:30 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (5/14) irias exports
Message-ID: <20040309190630.GF14543@bougret.hpl.hp.com>
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

ir264_irsyms_05_irias.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(5/14) irias exports

Move iriap_reoutines out of irsyms
Rename variable "missing" to irias_missing


diff -u -p -r linux/include/net/irda.s4/irias_object.h linux/include/net/irda/irias_object.h
--- linux/include/net/irda.s4/irias_object.h	Mon Mar  8 19:03:15 2004
+++ linux/include/net/irda/irias_object.h	Mon Mar  8 19:03:37 2004
@@ -101,7 +101,7 @@ struct ias_value *irias_new_octseq_value
 struct ias_value *irias_new_missing_value(void);
 void irias_delete_value(struct ias_value *value);
 
-extern struct ias_value missing;
+extern struct ias_value irias_missing;
 extern hashbin_t *irias_objects;
 
 #endif
diff -u -p -r linux/net/irda.s4/iriap.c linux/net/irda/iriap.c
--- linux/net/irda.s4/iriap.c	Wed Dec 17 18:58:38 2003
+++ linux/net/irda/iriap.c	Mon Mar  8 19:03:37 2004
@@ -25,6 +25,7 @@
  ********************************************************************/
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/skbuff.h>
 #include <linux/string.h>
@@ -200,6 +201,7 @@ struct iriap_cb *iriap_open(__u8 slsap_s
 
 	return self;
 }
+EXPORT_SYMBOL(iriap_open);
 
 /*
  * Function __iriap_close (self)
@@ -248,6 +250,7 @@ void iriap_close(struct iriap_cb *self)
 
 	__iriap_close(self);
 }
+EXPORT_SYMBOL(iriap_close);
 
 static int iriap_register_lsap(struct iriap_cb *self, __u8 slsap_sel, int mode)
 {
@@ -435,6 +438,7 @@ int iriap_getvaluebyclass_request(struct
 
 	return 0;
 }
+EXPORT_SYMBOL(iriap_getvaluebyclass_request);
 
 /*
  * Function iriap_getvaluebyclass_confirm (self, skb)
@@ -674,7 +678,7 @@ void iriap_getvaluebyclass_indication(st
 	if (obj == NULL) {
 		IRDA_DEBUG(2, "LM-IAS: Object %s not found\n", name);
 		iriap_getvaluebyclass_response(self, 0x1235, IAS_CLASS_UNKNOWN,
-					       &missing);
+					       &irias_missing);
 		return;
 	}
 	IRDA_DEBUG(4, "LM-IAS: found %s, id=%d\n", obj->name, obj->id);
@@ -683,7 +687,8 @@ void iriap_getvaluebyclass_indication(st
 	if (attrib == NULL) {
 		IRDA_DEBUG(2, "LM-IAS: Attribute %s not found\n", attr);
 		iriap_getvaluebyclass_response(self, obj->id,
-					       IAS_ATTRIB_UNKNOWN, &missing);
+					       IAS_ATTRIB_UNKNOWN, 
+					       &irias_missing);
 		return;
 	}
 
diff -u -p -r linux/net/irda.s4/irias_object.c linux/net/irda/irias_object.c
--- linux/net/irda.s4/irias_object.c	Wed Dec 17 18:59:05 2003
+++ linux/net/irda/irias_object.c	Mon Mar  8 19:03:37 2004
@@ -24,6 +24,7 @@
 
 #include <linux/string.h>
 #include <linux/socket.h>
+#include <linux/module.h>
 
 #include <net/irda/irda.h>
 #include <net/irda/irias_object.h>
@@ -33,7 +34,7 @@ hashbin_t *irias_objects;
 /*
  *  Used when a missing value needs to be returned
  */
-struct ias_value missing = { IAS_MISSING, 0, 0, 0, {0}};
+struct ias_value irias_missing = { IAS_MISSING, 0, 0, 0, {0}};
 
 /*
  * Function strndup (str, max)
@@ -107,6 +108,7 @@ struct ias_object *irias_new_object( cha
 
 	return obj;
 }
+EXPORT_SYMBOL(irias_new_object);
 
 /*
  * Function irias_delete_attrib (attrib)
@@ -165,6 +167,7 @@ int irias_delete_object(struct ias_objec
 
 	return 0;
 }
+EXPORT_SYMBOL(irias_delete_object);
 
 /*
  * Function irias_delete_attrib (obj)
@@ -210,6 +213,7 @@ void irias_insert_object(struct ias_obje
 
 	hashbin_insert(irias_objects, (irda_queue_t *) obj, 0, obj->name);
 }
+EXPORT_SYMBOL(irias_insert_object);
 
 /*
  * Function irias_find_object (name)
@@ -224,6 +228,7 @@ struct ias_object *irias_find_object(cha
 	/* Unsafe (locking), object might change */
 	return hashbin_lock_find(irias_objects, 0, name);
 }
+EXPORT_SYMBOL(irias_find_object);
 
 /*
  * Function irias_find_attrib (obj, name)
@@ -246,6 +251,7 @@ struct ias_attrib *irias_find_attrib(str
 	/* Unsafe (locking), attrib might change */
 	return attrib;
 }
+EXPORT_SYMBOL(irias_find_attrib);
 
 /*
  * Function irias_add_attribute (obj, attrib)
@@ -318,6 +324,7 @@ int irias_object_change_attribute(char *
 	spin_unlock_irqrestore(&obj->attribs->hb_spinlock, flags);
 	return 0;
 }
+EXPORT_SYMBOL(irias_object_change_attribute);
 
 /*
  * Function irias_object_add_integer_attrib (obj, name, value)
@@ -350,6 +357,7 @@ void irias_add_integer_attrib(struct ias
 
 	irias_add_attrib(obj, attrib, owner);
 }
+EXPORT_SYMBOL(irias_add_integer_attrib);
 
  /*
  * Function irias_add_octseq_attrib (obj, name, octet_seq, len)
@@ -384,6 +392,7 @@ void irias_add_octseq_attrib(struct ias_
 
 	irias_add_attrib(obj, attrib, owner);
 }
+EXPORT_SYMBOL(irias_add_octseq_attrib);
 
 /*
  * Function irias_object_add_string_attrib (obj, string)
@@ -417,6 +426,7 @@ void irias_add_string_attrib(struct ias_
 
 	irias_add_attrib(obj, attrib, owner);
 }
+EXPORT_SYMBOL(irias_add_string_attrib);
 
 /*
  * Function irias_new_integer_value (integer)
@@ -441,6 +451,7 @@ struct ias_value *irias_new_integer_valu
 
 	return value;
 }
+EXPORT_SYMBOL(irias_new_integer_value);
 
 /*
  * Function irias_new_string_value (string)
@@ -467,7 +478,7 @@ struct ias_value *irias_new_string_value
 
 	return value;
 }
-
+EXPORT_SYMBOL(irias_new_string_value);
 
 /*
  * Function irias_new_octseq_value (octets, len)
@@ -502,6 +513,7 @@ struct ias_value *irias_new_octseq_value
 	memcpy(value->t.oct_seq, octseq , len);
 	return value;
 }
+EXPORT_SYMBOL(irias_new_octseq_value);
 
 struct ias_value *irias_new_missing_value(void)
 {
@@ -553,3 +565,4 @@ void irias_delete_value(struct ias_value
 	}
 	kfree(value);
 }
+EXPORT_SYMBOL(irias_delete_value);
diff -u -p -r linux/net/irda.s4/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.s4/irsyms.c	Mon Mar  8 18:57:25 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 19:03:37 2004
@@ -79,24 +79,6 @@ EXPORT_SYMBOL(irda_param_extract_all);
 EXPORT_SYMBOL(irda_param_pack);
 EXPORT_SYMBOL(irda_param_unpack);
 
-/* IrIAP/IrIAS */
-EXPORT_SYMBOL(iriap_open);
-EXPORT_SYMBOL(iriap_close);
-EXPORT_SYMBOL(iriap_getvaluebyclass_request);
-EXPORT_SYMBOL(irias_object_change_attribute);
-EXPORT_SYMBOL(irias_add_integer_attrib);
-EXPORT_SYMBOL(irias_add_octseq_attrib);
-EXPORT_SYMBOL(irias_add_string_attrib);
-EXPORT_SYMBOL(irias_insert_object);
-EXPORT_SYMBOL(irias_new_object);
-EXPORT_SYMBOL(irias_delete_object);
-EXPORT_SYMBOL(irias_delete_value);
-EXPORT_SYMBOL(irias_find_object);
-EXPORT_SYMBOL(irias_find_attrib);
-EXPORT_SYMBOL(irias_new_integer_value);
-EXPORT_SYMBOL(irias_new_string_value);
-EXPORT_SYMBOL(irias_new_octseq_value);
-
 /* IrLMP */
 EXPORT_SYMBOL(irlmp_discovery_request);
 EXPORT_SYMBOL(irlmp_get_discoveries);
