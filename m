Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWIBK3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWIBK3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 06:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWIBK3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 06:29:24 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:59919 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751006AbWIBK3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 06:29:23 -0400
Date: Sat, 2 Sep 2006 20:29:19 +1000
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc5-mm1 -- possible circular locking dependency detected
Message-ID: <20060902102919.GA4279@gondor.apana.org.au>
References: <a44ae5cd0609020111l33a560cpea3d450d4be556aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0609020111l33a560cpea3d450d4be556aa@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2006 at 01:11:30AM -0700, Miles Lane wrote:
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.18-rc5-mm1 #6
> -------------------------------------------------------
> wpa_supplicant/4658 is trying to acquire lock:
> (crypto_alg_sem){----}, at: [__crypto_lookup_template+20/168]
> __crypto_lookup_template+0x14/0xa8
> 
> but task is already holding lock:
> ((crypto_chain).rwsem){----}, at:
> [blocking_notifier_call_chain+14/45]
> blocking_notifier_call_chain+0xe/0x2d

Thanks for the report.  I started with the right code but then optimised
it away :) I've checked in this changeset.

[CRYPTO] cryptomgr: Defer probing into a work queue

We cannot perform the probing directly as we're holding at least one
lock that may be retaken during probing.  So this patch be defers it
to a work queue.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/crypto/cryptomgr.c b/crypto/cryptomgr.c
index ebe637c..9b5b156 100644
--- a/crypto/cryptomgr.c
+++ b/crypto/cryptomgr.c
@@ -19,35 +19,81 @@ #include <linux/notifier.h>
 #include <linux/rtnetlink.h>
 #include <linux/sched.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include "internal.h"
 
 struct cryptomgr_param {
+	struct work_struct work;
+
 	struct {
 		struct rtattr attr;
 		struct crypto_attr_alg data;
 	} alg;
+
+	struct {
+		u32 type;
+		u32 mask;
+		char name[CRYPTO_MAX_ALG_NAME];
+	} larval;
+
+	char template[CRYPTO_MAX_ALG_NAME];
 };
 
-static int cryptomgr_probe(struct crypto_larval *larval)
+static void cryptomgr_probe(void *data)
 {
-	struct cryptomgr_param param;
+	struct cryptomgr_param *param = data;
 	struct crypto_template *tmpl;
 	struct crypto_instance *inst;
+	int err;
+
+	tmpl = crypto_lookup_template(param->template);
+	if (!tmpl)
+		goto err;
+
+	do {
+		inst = tmpl->alloc(&param->alg, sizeof(param->alg));
+		if (IS_ERR(inst))
+			err = PTR_ERR(inst);
+		else if ((err = crypto_register_instance(tmpl, inst)))
+			tmpl->free(inst);
+	} while (err == -EAGAIN && !signal_pending(current));
+
+	crypto_tmpl_put(tmpl);
+
+	if (err)
+		goto err;
+
+out:
+	kfree(param);
+	return;
+
+err:
+	crypto_larval_error(param->larval.name, param->larval.type,
+			    param->larval.mask);
+	goto out;
+}
+
+static int cryptomgr_schedule_probe(struct crypto_larval *larval)
+{
+	struct cryptomgr_param *param;
 	const char *name = larval->alg.cra_name;
 	const char *p;
 	unsigned int len;
-	int err;
+
+	param = kmalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		goto err;
 
 	for (p = name; isalnum(*p) || *p == '-' || *p == '_'; p++)
 		;
 
 	len = p - name;
 	if (!len || *p != '(')
-		return NOTIFY_OK;
+		goto err_free_param;
 
-	memcpy(param.alg.data.name, name, len);
-	param.alg.data.name[len] = 0;
+	memcpy(param->template, name, len);
+	param->template[len] = 0;
 
 	name = p + 1;
 	for (p = name; isalnum(*p) || *p == '-' || *p == '_'; p++)
@@ -55,36 +101,26 @@ static int cryptomgr_probe(struct crypto
 
 	len = p - name;
 	if (!len || *p != ')' || p[1])
-		return NOTIFY_OK;
+		goto err_free_param;
 
-	tmpl = crypto_lookup_template(param.alg.data.name);
-	if (!tmpl)
-		goto err;
+	param->alg.attr.rta_len = sizeof(param->alg);
+	param->alg.attr.rta_type = CRYPTOA_ALG;
+	memcpy(param->alg.data.name, name, len);
+	param->alg.data.name[len] = 0;
 
-	param.alg.attr.rta_len = sizeof(param.alg);
-	param.alg.attr.rta_type = CRYPTOA_ALG;
-	memcpy(param.alg.data.name, name, len);
-	param.alg.data.name[len] = 0;
+	memcpy(param->larval.name, larval->alg.cra_name, CRYPTO_MAX_ALG_NAME);
+	param->larval.type = larval->alg.cra_flags;
+	param->larval.mask = larval->mask;
 
-	do {
-		inst = tmpl->alloc(&param, sizeof(param));
-		if (IS_ERR(inst))
-			err = PTR_ERR(inst);
-		else if ((err = crypto_register_instance(tmpl, inst)))
-			tmpl->free(inst);
-	} while (err == -EAGAIN && !signal_pending(current));
-
-	crypto_tmpl_put(tmpl);
-
-	if (err)
-		goto err;
+	INIT_WORK(&param->work, cryptomgr_probe, param);
+	schedule_work(&param->work);
 
 	return NOTIFY_STOP;
 
+err_free_param:
+	kfree(param);
 err:
-	crypto_larval_error(larval->alg.cra_name, larval->alg.cra_flags,
-			    larval->mask);
-	return NOTIFY_STOP;
+	return NOTIFY_OK;
 }
 
 static int cryptomgr_notify(struct notifier_block *this, unsigned long msg,
@@ -92,7 +128,7 @@ static int cryptomgr_notify(struct notif
 {
 	switch (msg) {
 	case CRYPTO_MSG_ALG_REQUEST:
-		return cryptomgr_probe(data);
+		return cryptomgr_schedule_probe(data);
 	}
 
 	return NOTIFY_DONE;
