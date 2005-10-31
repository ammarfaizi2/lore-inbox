Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVJaFqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVJaFqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVJaFqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:46:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27411 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932297AbVJaFqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:46:45 -0500
Date: Mon, 31 Oct 2005 06:46:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James Morris <jmorris@redhat.com>
Cc: Kausty <kkumbhalkar@gmail.com>, linux-kernel@vger.kernel.org,
       herbert@gondor.apana.org.au, davem@davemloft.net,
       linux-crypto@vger.kernel.org
Subject: [2.6 patch] crypto/api.c: remove the second argument of crypto_alg_available()
Message-ID: <20051031054642.GD8009@stusta.de>
References: <41ae44840501200448197d18c0@mail.gmail.com> <Xine.LNX.4.44.0501200952440.952-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0501200952440.952-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 09:54:28AM -0500, James Morris wrote:
> On Thu, 20 Jan 2005, Kausty wrote:
> 
> > hi
> > A small observation. In crypto/api.c in linux-2.6.8.1
> > 
> > The function:
> > int crypto_alg_available(const char *name, u32 flags)
> > 
> > has a flags param which does not seem to be used.
> > 
> > though it does not matter much but has this been fixed in later releases?
> > xfrm functions in ipsec do call this function but always with flags as 0.
> > 
> > Thanks and regards
> > kausty
> 
> IIRC, this was to allow future code to specify preferences for the type of
> algorithm driver (e.g. hardware), but has not been used.  This is an
> example of why it's a bad idea to add infrastructure which isn't being
> used at the time.

Since it's still unused, a patch to remove this second argument is 
below.

> - James

cu
Adrian


<--  snip  -->


The second argument of crypto_alg_available() was not used and is 
therefore removed in this patch.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 crypto/api.c           |    2 +-
 crypto/tcrypt.c        |    2 +-
 drivers/net/ppp_mppe.c |    4 ++--
 include/linux/crypto.h |    4 ++--
 net/xfrm/xfrm_algo.c   |    8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.14-rc5-mm1-full/include/linux/crypto.h.old	2005-10-31 06:23:42.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/include/linux/crypto.h	2005-10-31 06:23:56.000000000 +0100
@@ -152,9 +152,9 @@
  * Algorithm query interface.
  */
 #ifdef CONFIG_CRYPTO
-int crypto_alg_available(const char *name, u32 flags);
+int crypto_alg_available(const char *name);
 #else
-static inline int crypto_alg_available(const char *name, u32 flags)
+static inline int crypto_alg_available(const char *name)
 {
 	return 0;
 }
--- linux-2.6.14-rc5-mm1-full/crypto/api.c.old	2005-10-31 06:24:05.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/crypto/api.c	2005-10-31 06:24:12.000000000 +0100
@@ -300,7 +300,7 @@
 	return ret;
 }
 
-int crypto_alg_available(const char *name, u32 flags)
+int crypto_alg_available(const char *name)
 {
 	int ret = 0;
 	struct crypto_alg *alg = crypto_alg_mod_lookup(name);
--- linux-2.6.14-rc5-mm1-full/crypto/tcrypt.c.old	2005-10-31 06:24:20.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/crypto/tcrypt.c	2005-10-31 06:24:26.000000000 +0100
@@ -753,7 +753,7 @@
 
 	while (*name) {
 		printk("alg %s ", *name);
-		printk((crypto_alg_available(*name, 0)) ?
+		printk((crypto_alg_available(*name)) ?
 			"found\n" : "not found\n");
 		name++;
 	}
--- linux-2.6.14-rc5-mm1-full/drivers/net/ppp_mppe.c.old	2005-10-31 06:24:35.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/net/ppp_mppe.c	2005-10-31 06:24:41.000000000 +0100
@@ -695,8 +695,8 @@
 static int __init ppp_mppe_init(void)
 {
 	int answer;
-	if (!(crypto_alg_available("arc4", 0) &&
-	      crypto_alg_available("sha1", 0)))
+	if (!(crypto_alg_available("arc4") &&
+	      crypto_alg_available("sha1")))
 		return -ENODEV;
 
 	sha_pad = kmalloc(sizeof(struct sha_pad), GFP_KERNEL);
--- linux-2.6.14-rc5-mm1-full/net/xfrm/xfrm_algo.c.old	2005-10-31 06:24:51.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/net/xfrm/xfrm_algo.c	2005-10-31 06:25:06.000000000 +0100
@@ -369,7 +369,7 @@
 		if (!probe)
 			break;
 
-		status = crypto_alg_available(name, 0);
+		status = crypto_alg_available(name);
 		if (!status)
 			break;
 
@@ -428,19 +428,19 @@
 	BUG_ON(in_softirq());
 
 	for (i = 0; i < aalg_entries(); i++) {
-		status = crypto_alg_available(aalg_list[i].name, 0);
+		status = crypto_alg_available(aalg_list[i].name);
 		if (aalg_list[i].available != status)
 			aalg_list[i].available = status;
 	}
 	
 	for (i = 0; i < ealg_entries(); i++) {
-		status = crypto_alg_available(ealg_list[i].name, 0);
+		status = crypto_alg_available(ealg_list[i].name);
 		if (ealg_list[i].available != status)
 			ealg_list[i].available = status;
 	}
 	
 	for (i = 0; i < calg_entries(); i++) {
-		status = crypto_alg_available(calg_list[i].name, 0);
+		status = crypto_alg_available(calg_list[i].name);
 		if (calg_list[i].available != status)
 			calg_list[i].available = status;
 	}

