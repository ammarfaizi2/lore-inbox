Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272797AbRIMXS1>; Thu, 13 Sep 2001 19:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272798AbRIMXSU>; Thu, 13 Sep 2001 19:18:20 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:3582 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272797AbRIMXSG>;
	Thu, 13 Sep 2001 19:18:06 -0400
Date: Thu, 13 Sep 2001 16:18:25 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [IrDA patch] ir247_ias_fix_max.diff
Message-ID: <20010913161825.C7470@bougret.hpl.hp.com>
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

ir247_ias_fix_max.diff :
----------------------
	o [CRITICA] Check overflow in string duplicate code in IAS/IAP
		- It was only done (more or less) if DEBUG was enabled
	o [CORRECT] Fix deadlock on legal large OCT_SEQ IAP replies
	o [CORRECT] Increase max IAS attribute size for IrDA compliance

diff -u -p linux/include/linux/irda.d8.h linux/include/linux/irda.h
--- linux/include/linux/irda.d8.h	Thu Sep 13 11:35:56 2001
+++ linux/include/linux/irda.h	Thu Sep 13 11:38:31 2001
@@ -92,10 +92,15 @@ enum {
 
 #define IRTTP_MAX_SDU_SIZE IRLMP_MAX_SDU_SIZE /* Compatibility */
 
-#define IAS_MAX_STRING         256
-#define IAS_MAX_OCTET_STRING  1024
-#define IAS_MAX_CLASSNAME       64
-#define IAS_MAX_ATTRIBNAME     256
+#define IAS_MAX_STRING         256	/* See IrLMP 1.1, 4.3.3.2 */
+#define IAS_MAX_OCTET_STRING  1024	/* See IrLMP 1.1, 4.3.3.2 */
+#define IAS_MAX_CLASSNAME       60	/* See IrLMP 1.1, 4.3.1 */
+#define IAS_MAX_ATTRIBNAME      60	/* See IrLMP 1.1, 4.3.3.1 */
+#define IAS_MAX_ATTRIBNUMBER   256	/* See IrLMP 1.1, 4.3.3.1 */
+/* For user space backward compatibility - may be fixed in kernel 2.5.X
+ * Note : need 60+1 ('\0'), make it 64 for alignement - Jean II */
+#define IAS_EXPORT_CLASSNAME       64
+#define IAS_EXPORT_ATTRIBNAME     256
 
 /* Attribute type needed for struct irda_ias_set */
 #define IAS_MISSING 0
@@ -126,8 +131,8 @@ struct irda_device_list {
 };
 
 struct irda_ias_set {
-	char irda_class_name[IAS_MAX_CLASSNAME];
-	char irda_attrib_name[IAS_MAX_ATTRIBNAME];
+	char irda_class_name[IAS_EXPORT_CLASSNAME];
+	char irda_attrib_name[IAS_EXPORT_ATTRIBNAME];
 	unsigned int irda_attrib_type;
 	union {
 		unsigned int irda_attrib_int;
diff -u -p linux/include/net/irda/irias_object.d8.h linux/include/net/irda/irias_object.h
--- linux/include/net/irda/irias_object.d8.h	Thu Sep 13 11:36:24 2001
+++ linux/include/net/irda/irias_object.h	Thu Sep 13 11:38:31 2001
@@ -78,7 +78,7 @@ struct ias_attrib {
 	struct ias_value *value; /* Attribute value */
 };
 
-char *strdup(char *str);
+char *strndup(char *str, int max);
 
 struct ias_object *irias_new_object(char *name, int id);
 void irias_insert_object(struct ias_object *obj);
diff -u -p linux/net/irda/irias_object.d8.c linux/net/irda/irias_object.c
--- linux/net/irda/irias_object.d8.c	Thu Sep 13 11:36:46 2001
+++ linux/net/irda/irias_object.c	Thu Sep 13 11:38:31 2001
@@ -37,25 +37,35 @@ hashbin_t *objects = NULL;
 struct ias_value missing = { IAS_MISSING, 0, 0, 0, {0}};
 
 /*
- * Function strdup (str)
+ * Function strndup (str, max)
  *
- *    My own kernel version of strdup!
+ *    My own kernel version of strndup!
  *
+ * Faster, check boundary... Jean II
  */
-char *strdup(char *str)
+char *strndup(char *str, int max)
 {
 	char *new_str;
+	int len;
 	
+	/* Check string */
 	if (str == NULL)
 		return NULL;
-
-	ASSERT(strlen( str) < 64, return NULL;);
-	
-        new_str = kmalloc(strlen(str)+1, GFP_ATOMIC);
-        if (new_str == NULL)
+	/* Check length, truncate */
+	len = strlen(str);
+	if(len > max)
+		len = max;
+
+	/* Allocate new string */
+        new_str = kmalloc(len + 1, GFP_ATOMIC);
+        if (new_str == NULL) {
+		WARNING(__FUNCTION__"(), Unable to kmalloc!\n");
 		return NULL;
-	
-	strcpy(new_str, str);
+	}
+
+	/* Copy and truncate */
+	memcpy(new_str, str, len);
+	new_str[len] = '\0';
 	
 	return new_str;
 }
@@ -81,7 +91,7 @@ struct ias_object *irias_new_object( cha
 	memset(obj, 0, sizeof( struct ias_object));
 
 	obj->magic = IAS_OBJECT_MAGIC;
-	obj->name = strdup( name);
+	obj->name = strndup(name, IAS_MAX_CLASSNAME);
 	obj->id = id;
 
 	obj->attribs = hashbin_new(HB_LOCAL);
@@ -315,7 +325,7 @@ void irias_add_integer_attrib(struct ias
 	memset(attrib, 0, sizeof( struct ias_attrib));
 
 	attrib->magic = IAS_ATTRIB_MAGIC;
-	attrib->name = strdup(name);
+	attrib->name = strndup(name, IAS_MAX_ATTRIBNAME);
 
 	/* Insert value */
 	attrib->value = irias_new_integer_value(value);
@@ -351,7 +361,7 @@ void irias_add_octseq_attrib(struct ias_
 	memset(attrib, 0, sizeof( struct ias_attrib));
 	
 	attrib->magic = IAS_ATTRIB_MAGIC;
-	attrib->name = strdup( name);
+	attrib->name = strndup(name, IAS_MAX_ATTRIBNAME);
 	
 	attrib->value = irias_new_octseq_value( octets, len);
 	
@@ -384,7 +394,7 @@ void irias_add_string_attrib(struct ias_
 	memset(attrib, 0, sizeof( struct ias_attrib));
 
 	attrib->magic = IAS_ATTRIB_MAGIC;
-	attrib->name = strdup(name);
+	attrib->name = strndup(name, IAS_MAX_ATTRIBNAME);
 
 	attrib->value = irias_new_string_value(value);
 
@@ -420,10 +430,13 @@ struct ias_value *irias_new_integer_valu
  *
  *    Create new IAS string value
  *
+ * Per IrLMP 1.1, 4.3.3.2, strings are up to 256 chars - Jean II
  */
 struct ias_value *irias_new_string_value(char *string)
 {
 	struct ias_value *value;
+	int len;
+	char *new_str;
 
 	value = kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value == NULL) {
@@ -434,8 +447,8 @@ struct ias_value *irias_new_string_value
 
 	value->type = IAS_STRING;
 	value->charset = CS_ASCII;
-	value->len = strlen(string);
-	value->t.string = strdup(string);
+	value->t.string = strndup(string, IAS_MAX_STRING);
+	value->len = strlen(value->t.string);
 
 	return value;
 }
@@ -446,6 +459,7 @@ struct ias_value *irias_new_string_value
  *
  *    Create new IAS octet-sequence value
  *
+ * Per IrLMP 1.1, 4.3.3.2, octet-sequence are up to 1024 bytes - Jean II
  */
 struct ias_value *irias_new_octseq_value(__u8 *octseq , int len)
 {
@@ -459,11 +473,15 @@ struct ias_value *irias_new_octseq_value
 	memset(value, 0, sizeof(struct ias_value));
 
 	value->type = IAS_OCT_SEQ;
+	/* Check length */
+	if(len > IAS_MAX_OCTET_STRING)
+		len = IAS_MAX_OCTET_STRING;
 	value->len = len;
 
 	value->t.oct_seq = kmalloc(len, GFP_ATOMIC);
 	if (value->t.oct_seq == NULL){
 		WARNING(__FUNCTION__"(), Unable to kmalloc!\n");
+		kfree(value);
 		return NULL;
 	}
 	memcpy(value->t.oct_seq, octseq , len);
diff -u -p linux/net/irda/iriap.d8.c linux/net/irda/iriap.c
--- linux/net/irda/iriap.d8.c	Thu Sep 13 11:37:13 2001
+++ linux/net/irda/iriap.c	Thu Sep 13 11:38:31 2001
@@ -379,7 +379,7 @@ int iriap_getvaluebyclass_request(struct
 				  char *name, char *attr)
 {
 	struct sk_buff *skb;
-	int name_len, attr_len;
+	int name_len, attr_len, skb_len;
 	__u8 *frame;
 
 	ASSERT(self != NULL, return -1;);
@@ -400,13 +400,14 @@ int iriap_getvaluebyclass_request(struct
 	/* Give ourselves 10 secs to finish this operation */
 	iriap_start_watchdog_timer(self, 10*HZ);
 	
-	skb = dev_alloc_skb(64);
+	name_len = strlen(name);	/* Up to IAS_MAX_CLASSNAME = 60 */
+	attr_len = strlen(attr);	/* Up to IAS_MAX_ATTRIBNAME = 60 */
+
+	skb_len = self->max_header_size+2+name_len+1+attr_len+4;
+	skb = dev_alloc_skb(skb_len);
 	if (!skb)
 		return -ENOMEM;
 
-	name_len = strlen(name);
-	attr_len = strlen(attr);
-
 	/* Reserve space for MUX and LAP header */
  	skb_reserve(skb, self->max_header_size);
 	skb_put(skb, 3+name_len+attr_len);
@@ -500,20 +501,19 @@ void iriap_getvaluebyclass_confirm(struc
 		}
 		value_len = fp[n++];
 		IRDA_DEBUG(4, __FUNCTION__ "(), strlen=%d\n", value_len);
-		ASSERT(value_len < 64, return;);
 		
 		/* Make sure the string is null-terminated */
 		fp[n+value_len] = 0x00;
-		
 		IRDA_DEBUG(4, "Got string %s\n", fp+n);
+
+		/* Will truncate to IAS_MAX_STRING bytes */
 		value = irias_new_string_value(fp+n);
 		break;
 	case IAS_OCT_SEQ:
 		value_len = be16_to_cpu(get_unaligned((__u16 *)(fp+n)));
 		n += 2;
 		
-		ASSERT(value_len <= 55, return;);      
-		
+		/* Will truncate to IAS_MAX_OCTET_STRING bytes */
 		value = irias_new_octseq_value(fp+n, value_len);
 		break;
 	default:
@@ -635,8 +635,8 @@ void iriap_getvaluebyclass_indication(st
 	struct ias_attrib *attrib;
 	int name_len;
 	int attr_len;
-	char name[64];
-	char attr[64];
+	char name[IAS_MAX_CLASSNAME + 1];	/* 60 bytes */
+	char attr[IAS_MAX_ATTRIBNAME + 1];	/* 60 bytes */
 	__u8 *fp;
 	int n;
 
@@ -1013,7 +1013,7 @@ int irias_proc_read(char *buf, char **st
 					       attrib->value->t.string);
 				break;
 			case IAS_OCT_SEQ:
-				len += sprintf(buf+len, "octet sequence\n");
+				len += sprintf(buf+len, "octet sequence (%d bytes)\n", attrib->value->len);
 				break;
 			case IAS_MISSING:
 				len += sprintf(buf+len, "missing\n");
