Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTBGU0k>; Fri, 7 Feb 2003 15:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTBGU0j>; Fri, 7 Feb 2003 15:26:39 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54664 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266435AbTBGU0h>;
	Fri, 7 Feb 2003 15:26:37 -0500
Message-ID: <3E441910.2000003@us.ibm.com>
Date: Fri, 07 Feb 2003 14:37:36 -0600
From: Tom Lendacky <toml@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IPSec: PFKey patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In doing some preliminary testing of the IPSec code, I found a problem
related to pfkey and racoon.  Racoon listens to the PFKey interface
for messages related to changes in policy.  If a policy is added after
racoon has been started, an SADB_X_SPDADD message is received by
racoon and processed.  However, the spid within the message has not
been set prior to the message being formatted for broadcast.  When an
SADB_ACQUIRE message is broadcast related to this policy, with the
proper spid, racoon tries to match it with it's internal
representation from the SPDADD message and does not find a match.
This results in an SA not being established.

The following patch fixes that situation.  This patch can be made much
smaller if it is decided to not worry about inserting or modifying
the policy (by calling xfrm_policy_insert from within the pfkey_spdadd
routine of af_key.c) before calling pfkey_xfrm_policy2msg which could
possibly return an error and result in the policy changing without
the message being broadcast.  If that is the case, then you only
need move the call to pfkey_xfrm_policy2msg after the call to
xfrm_policy_insert.  But assuming that condition should be avoided
resulted in splitting the pfkey_xfrm_policy2msg routine and this
patch:

diff -urb linux-2.5.59-orig/net/key/af_key.c linux-2.5.59/net/key/af_key.c
--- linux-2.5.59-orig/net/key/af_key.c	2003-02-06 15:40:32.000000000 -0600
+++ linux-2.5.59/net/key/af_key.c	2003-02-07 11:03:27.000000000 -0600
@@ -1388,29 +1388,43 @@
  	return 0;
  }

-static struct sk_buff * pfkey_xfrm_policy2msg(struct xfrm_policy *xp, int dir)
+static int pfkey_xfrm_policy2msg_size(struct xfrm_policy *xp)
  {
-	struct sk_buff *skb;
-	struct sadb_msg *hdr;
-	struct sadb_address *addr;
-	struct sadb_lifetime *lifetime;
-	struct sadb_x_policy *pol;
-	struct sockaddr_in   *sin;
-	int i;
-	int size;
-
-	size = sizeof(struct sadb_msg) +
+	return sizeof(struct sadb_msg) +
  		sizeof(struct sadb_lifetime) * 3 +
  			sizeof(struct sadb_address)*2 +
  				sizeof(struct sockaddr_in)*2 + /* XXX */
  					sizeof(struct sadb_x_policy) +
  						xp->xfrm_nr*(sizeof(struct sadb_x_ipsecrequest) +
  							     sizeof(struct sockaddr_in)*2);
+}
+
+static struct sk_buff * pfkey_xfrm_policy2msg_prep(struct xfrm_policy *xp)
+{
+	struct sk_buff *skb;
+	int size;
+
+	size = pfkey_xfrm_policy2msg_size(xp);

  	skb =  alloc_skb(size + 16, GFP_ATOMIC);
  	if (skb == NULL)
  		return ERR_PTR(-ENOBUFS);

+	return skb;
+}
+
+static void pfkey_xfrm_policy2msg(struct sk_buff *skb, struct xfrm_policy *xp, int dir)
+{
+	struct sadb_msg *hdr;
+	struct sadb_address *addr;
+	struct sadb_lifetime *lifetime;
+	struct sadb_x_policy *pol;
+	struct sockaddr_in   *sin;
+	int i;
+	int size;
+
+	size = pfkey_xfrm_policy2msg_size(xp);
+
  	/* call should fill header later */
  	hdr = (struct sadb_msg *) skb_put(skb, sizeof(struct sadb_msg));
  	memset(hdr, 0, size);	/* XXX do we need this ? */
@@ -1527,7 +1541,6 @@
  	}
  	hdr->sadb_msg_len = size / sizeof(uint64_t);
  	hdr->sadb_msg_reserved = atomic_read(&xp->refcnt);
-	return skb;
  }

  static int pfkey_spdadd(struct sock *sk, struct sk_buff *skb, struct sadb_msg *hdr, void **ext_hdrs)
@@ -1600,7 +1613,7 @@
  	    (err = parse_ipsecrequests(xp, pol)) < 0)
  		goto out;

-	out_skb = pfkey_xfrm_policy2msg(xp, pol->sadb_x_policy_dir-1);
+	out_skb = pfkey_xfrm_policy2msg_prep(xp);
  	if (IS_ERR(out_skb)) {
  		err =  PTR_ERR(out_skb);
  		goto out;
@@ -1613,6 +1626,8 @@
  		goto out;
  	}

+	pfkey_xfrm_policy2msg(out_skb, xp, pol->sadb_x_policy_dir-1);
+
  	xfrm_pol_put(xp);

  	out_hdr = (struct sadb_msg *) out_skb->data;
@@ -1673,11 +1688,12 @@

  	err = 0;

-	out_skb = pfkey_xfrm_policy2msg(xp, pol->sadb_x_policy_dir-1);
+	out_skb = pfkey_xfrm_policy2msg_prep(xp);
  	if (IS_ERR(out_skb)) {
  		err =  PTR_ERR(out_skb);
  		goto out;
  	}
+	pfkey_xfrm_policy2msg(out_skb, xp, pol->sadb_x_policy_dir-1);

  	out_hdr = (struct sadb_msg *) out_skb->data;
  	out_hdr->sadb_msg_version = hdr->sadb_msg_version;
@@ -1715,11 +1731,12 @@

  	err = 0;

-	out_skb = pfkey_xfrm_policy2msg(xp, pol->sadb_x_policy_dir-1);
+	out_skb = pfkey_xfrm_policy2msg_prep(xp);
  	if (IS_ERR(out_skb)) {
  		err =  PTR_ERR(out_skb);
  		goto out;
  	}
+	pfkey_xfrm_policy2msg(out_skb, xp, pol->sadb_x_policy_dir-1);

  	out_hdr = (struct sadb_msg *) out_skb->data;
  	out_hdr->sadb_msg_version = hdr->sadb_msg_version;
@@ -1746,9 +1763,10 @@
  	struct sk_buff *out_skb;
  	struct sadb_msg *out_hdr;

-	out_skb = pfkey_xfrm_policy2msg(xp, dir);
+	out_skb = pfkey_xfrm_policy2msg_prep(xp);
  	if (IS_ERR(out_skb))
  		return PTR_ERR(out_skb);
+	pfkey_xfrm_policy2msg(out_skb, xp, dir);

  	out_hdr = (struct sadb_msg *) out_skb->data;
  	out_hdr->sadb_msg_version = data->hdr->sadb_msg_version;

Tom

