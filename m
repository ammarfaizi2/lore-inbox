Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVBDNb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVBDNb1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264525AbVBDNb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:31:27 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:7945 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262528AbVBDN1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:27:38 -0500
Date: Fri, 4 Feb 2005 14:27:32 +0100
From: Fruhwirth Clemens <clemens@endorphin.org>
To: dm-crypt@saout.de
Cc: Christophe Saout <christophe@saout.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, dm-crypt@saout.de,
       Alasdair G Kergon <agk@redhat.com>, Matt Mackall <mpm@selenic.com>
Subject: Re: [dm-crypt] Re: dm-crypt crypt_status reports key?
Message-ID: <20050204132732.GA29129@ghanima.endorphin.org>
References: <20050202211916.GJ2493@waste.org> <1107394381.10497.16.camel@server.cs.pocnet.net> <20050203015236.GO2493@waste.org> <1107398069.11826.16.camel@server.cs.pocnet.net> <20050203040542.GQ2493@waste.org> <1107440300.15236.58.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107440300.15236.58.camel@ghanima>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 03:18:20PM +0100, Fruhwirth Clemens wrote:

> Way too complicated. This is a crypto project, why does nobody think of
> crypto to solve the problem :). Here's the idea:

> [see original post, http://lkml.org/lkml/2005/2/3/109 , for idea]

Very simple patch. With that, it's really hard for root to reveal his real
keys accidentally.

Of course the intended 

dmsetup table foo > foo-table
dmsetup remove foo
dmsetup create foo foo-table 

works. If anyone is interested in that feature, this fellow has to clean the
patch and push it.

--- linux-2.6.11-rc1-mm1-therp/drivers/md/dm-crypt.c.orig	2005-02-04 12:53:57.000000000 +0100
+++ linux-2.6.11-rc1-mm1-therp/drivers/md/dm-crypt.c	2005-02-04 14:14:34.927560784 +0100
@@ -18,6 +18,7 @@
 #include <asm/scatterlist.h>
 #include <asm/page.h>
 
+#include <linux/random.h>
 #include "dm.h"
 
 #define PFX	"crypt: "
@@ -488,6 +489,33 @@
 	queue_work(_kcryptd_workqueue, &io->work);
 }
 
+/* Trigger safety */
+
+static char *asure_dc_secret(int want_size) {
+	static char *secret = NULL;
+	static int secret_size = 0;
+
+	// FIXME: obtain some lock
+	if(secret_size < want_size) {
+		char *new_secret = kmalloc(want_size,GFP_KERNEL);
+		// FIXME malloc fail check
+		if(secret) {
+			memcpy(new_secret, secret, secret_size);
+			kfree(secret);
+		}
+
+		get_random_bytes(new_secret+secret_size, want_size - secret_size);
+		secret = new_secret; secret_size = want_size;
+	}
+	return secret;
+}
+
+static void xor_with_secret(char *p, int size) {
+	char *secret = asure_dc_secret(size);
+	while(size--)
+		*p++ ^= *secret++;
+}
+
 /*
  * Decode key from its hex representation
  */
@@ -496,9 +524,14 @@
 	char buffer[3];
 	char *endp;
 	unsigned int i;
+	int post_process = 0;
 
 	buffer[2] = '\0';
 
+	if(*hex == '!') {
+		post_process = 1;
+		hex++;
+	}
 	for(i = 0; i < size; i++) {
 		buffer[0] = *hex++;
 		buffer[1] = *hex++;
@@ -512,6 +545,9 @@
 	if (*hex != '\0')
 		return -EINVAL;
 
+	if (post_process)
+		xor_with_secret(key,size);
+
 	return 0;
 }
 
@@ -522,6 +558,7 @@
 {
 	unsigned int i;
 
+	*hex++ = '!';
 	for(i = 0; i < size; i++) {
 		sprintf(hex, "%02x", *key);
 		hex += 2;
@@ -689,6 +726,8 @@
 	} else
 		cc->iv_mode = NULL;
 
+	xor_with_secret(cc->key, cc->key_size);
+
 	ti->private = cc;
 	return 0;
 
@@ -899,11 +938,11 @@
 			DMEMIT("%s-%s ", cipher, chainmode);
 
 		if (cc->key_size > 0) {
-			if ((maxlen - sz) < ((cc->key_size << 1) + 1))
+			if ((maxlen - sz) < ((cc->key_size << 1) + 2))
 				return -ENOMEM;
 
 			crypt_encode_key(result + sz, cc->key, cc->key_size);
-			sz += cc->key_size << 1;
+			sz += (cc->key_size << 1) + 1;
 		} else {
 			if (sz >= maxlen)
 				return -ENOMEM;
