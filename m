Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbUL3JTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbUL3JTg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUL3JHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:07:04 -0500
Received: from smtp.knology.net ([24.214.63.101]:36829 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261594AbUL3Isi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:38 -0500
Date: Thu, 30 Dec 2004 03:48:37 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 18/22] typhoon: add validation of offloaded xfrm_states
Message-Id: <20041230035000.27@ori.thedillows.org>
References: <20041230035000.26@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 01:00:43-05:00 dave@thedillows.org 
#   Add routines to validate that the xfrm_state passed to them is
#   one that we can offload to the 3XP.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# drivers/net/typhoon.c
#   2004/12/30 01:00:25-05:00 dave@thedillows.org +90 -0
#   Add routines to validate that the xfrm_state passed to them is
#   one that we can offload to the 3XP.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2004-12-30 01:08:32 -05:00
+++ b/drivers/net/typhoon.c	2004-12-30 01:08:32 -05:00
@@ -2330,6 +2330,96 @@
 	return 0;
 }
 
+#define UNSUPPORTED	goto unsupported
+#define REQUIRED(x)	if(!(x)) goto unsupported
+
+static inline int
+typhoon_validate_ealgo(struct typhoon *tp, struct xfrm_state *x)
+{
+	switch(x->props.ealgo) {
+	case SADB_EALG_NULL:
+		break;
+	case SADB_EALG_DESCBC:
+		REQUIRED(x->ealg);
+		REQUIRED(tp->capabilities & TYPHOON_CRYPTO_DES);
+		REQUIRED(x->ealg->alg_key_len == 64);
+		break;
+	case SADB_EALG_3DESCBC:
+		REQUIRED(x->ealg);
+		REQUIRED(tp->capabilities & TYPHOON_CRYPTO_3DES);
+		REQUIRED(x->ealg->alg_key_len == 128 ||
+					x->ealg->alg_key_len == 192);
+		break;
+	default:
+		UNSUPPORTED;
+	}
+
+	return 1;
+
+unsupported:
+	return 0;
+}
+
+static inline int
+typhoon_validate_aalgo(struct typhoon *tp, struct xfrm_state *x)
+{
+	switch(x->props.aalgo) {
+	case SADB_X_AALG_NULL:
+		break;
+	case SADB_AALG_MD5HMAC:
+		REQUIRED(x->aalg);
+		REQUIRED(x->aalg->alg_key_len == 128);
+		break;
+	case SADB_AALG_SHA1HMAC:
+		REQUIRED(x->aalg);
+		REQUIRED(x->aalg->alg_key_len == 160);
+		break;
+	default:
+		UNSUPPORTED;
+	}
+
+	return 1;
+
+unsupported:
+	return 0;
+}
+
+static inline int
+typhoon_validate_xfrm(struct typhoon *tp, struct xfrm_state *x)
+{
+	u8 ealgo, aalgo, need_auth = 1;
+
+	REQUIRED(x->props.family == AF_INET);
+	REQUIRED(x->dir == XFRM_STATE_DIR_OUT || x->dir == XFRM_STATE_DIR_IN);
+	REQUIRED(!x->encap);
+
+	aalgo = x->props.aalgo;
+	ealgo = x->props.ealgo;
+
+	switch(x->type->proto) {
+	case IPPROTO_ESP:
+		need_auth = 0;
+		REQUIRED(aalgo != SADB_X_AALG_NULL || ealgo != SADB_EALG_NULL);
+		REQUIRED(typhoon_validate_ealgo(tp, x));
+		/* fall through to validate auth algorithm */
+	case IPPROTO_AH:
+		REQUIRED(typhoon_validate_aalgo(tp, x));
+		if(need_auth)
+			REQUIRED(aalgo != SADB_X_AALG_NULL);
+		break;
+	default:
+		UNSUPPORTED;
+	}
+
+	return 1;
+
+unsupported:
+	return 0;
+}
+
+#undef REQUIRED
+#undef UNSUPPORTED
+
 static void
 typhoon_tx_timeout(struct net_device *dev)
 {
