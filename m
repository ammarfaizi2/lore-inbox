Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWC1OIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWC1OIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWC1OIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:08:15 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41121 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932261AbWC1OIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:08:14 -0500
Date: Tue, 28 Mar 2006 08:07:49 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: sds@sergelap.austin.ibm.com, James Morris <jmorris@namei.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org
Subject: Re: [PATCH] split security_key_alloc into two functions
Message-ID: <20060328140749.GF19243@sergelap.austin.ibm.com>
References: <20060328130533.GB19243@sergelap.austin.ibm.com> <4452.1143553806@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4452.1143553806@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The security_key_alloc() function acted as both an authorizer and
security structure allocation function.  These roles should be
separated.  There are two reasons for this.

First, if two modules are stacked, the first module might grant
permission and allocate security data, after which the second
module refuses permission.

Second, by adding a security_post_alloc() function after the
serial number has been assigned, security modules can append
useful info.

Note that currently there is no LSM using these hooks, so the
question of whether an LSM needs to recored the serial number
can't really be answered.

An alternative to this patch, supported by the historical approach
to LSM hooks, would be to remove all these hooks.  However as
the keystore starts being used - in particular by, eg, ecryptfs -
one might expect LSMs to be more interested in key activity.

Changelog:
Moved the security_key_post_alloc() hook under the
key_serial_lock to ensure that is not accessed before
an LSM has a chance to tag it.

:100644 100644 aaa0a5c... 569e874... M	include/linux/security.h
:100644 100644 fd99429... 1eff777... M	security/dummy.c
:100644 100644 a057e33... b72ffe2... M	security/keys/key.c

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -844,10 +844,15 @@ struct swap_info_struct;
  * Security hooks affecting all Key Management operations
  *
  * @key_alloc:
- *	Permit allocation of a key and assign security data. Note that key does
- *	not have a serial number assigned at this point.
+ *	Check permission to allocate a key and assign security data. Note
+ *	that key does not have a serial number assigned at this point.
  *	@key points to the key.
  *	Return 0 if permission is granted, -ve error otherwise.
+ * @key_post_alloc:
+ * 	Allocate and attach a security structure to a key structure.
+ * 	This is called under the key_serial_lock spinlock, after a
+ * 	serial number is assigned and the key is inserted into a keyring.
+ *	@key points to the key.
  * @key_free:
  *	Notification of destruction; free security data.
  *	@key points to the key.
@@ -1312,6 +1317,7 @@ struct security_operations {
 	/* key management security hooks */
 #ifdef CONFIG_KEYS
 	int (*key_alloc)(struct key *key);
+	void (*key_post_alloc)(struct key *key);
 	void (*key_free)(struct key *key);
 	int (*key_permission)(key_ref_t key_ref,
 			      struct task_struct *context,
@@ -3001,6 +3007,11 @@ static inline int security_key_alloc(str
 	return security_ops->key_alloc(key);
 }
 
+static inline void security_key_post_alloc(struct key *key)
+{
+	security_ops->key_post_alloc(key);
+}
+
 static inline void security_key_free(struct key *key)
 {
 	security_ops->key_free(key);
@@ -3020,6 +3031,10 @@ static inline int security_key_alloc(str
 	return 0;
 }
 
+static inline void security_key_post_alloc(struct key *key)
+{
+}
+
 static inline void security_key_free(struct key *key)
 {
 }
diff --git a/security/dummy.c b/security/dummy.c
index fd99429..1eff777 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -860,6 +860,10 @@ static inline int dummy_key_alloc(struct
 	return 0;
 }
 
+static inline void dummy_key_post_alloc(struct key *key)
+{
+}
+
 static inline void dummy_key_free(struct key *key)
 {
 }
@@ -1036,6 +1040,7 @@ void security_fixup_ops (struct security
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 #ifdef CONFIG_KEYS
 	set_to_dummy_if_null(ops, key_alloc);
+	set_to_dummy_if_null(ops, key_post_alloc);
 	set_to_dummy_if_null(ops, key_free);
 	set_to_dummy_if_null(ops, key_permission);
 #endif	/* CONFIG_KEYS */
diff --git a/security/keys/key.c b/security/keys/key.c
index a057e33..b72ffe2 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -231,6 +231,8 @@ static inline void key_alloc_serial(stru
  insert_here:
 	rb_link_node(&key->serial_node, parent, p);
 	rb_insert_color(&key->serial_node, &key_serial_tree);
+	/* let the security module know the key has been published */
+	security_key_post_alloc(key);
 
 	spin_unlock(&key_serial_lock);
 
