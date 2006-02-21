Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161292AbWBUDKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161292AbWBUDKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWBUDKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:10:18 -0500
Received: from stinky.trash.net ([213.144.137.162]:59275 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1161292AbWBUDKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:10:17 -0500
Message-ID: <43FA8439.6080009@trash.net>
Date: Tue, 21 Feb 2006 04:08:41 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ernst Herzberg <earny@net4u.de>
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.6.16-rc4 bridge/iptables Oops
References: <200602201651.50217.list-lkml@net4u.de> <43FA0C02.8000909@trash.net> <200602210211.22364.earny@net4u.de>
In-Reply-To: <200602210211.22364.earny@net4u.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------000803000504050308040807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000803000504050308040807
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Ernst Herzberg wrote:
>>This patch should fix it. Please test it and report if it helps.
> 
> 
> oernie:~ # uname -a ; uptime
> Linux oernie 2.6.16-rc4 #1 PREEMPT Mon Feb 20 22:07:34 CET 2006 i686 Intel(R) 
> Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
>  02:06:00 up  3:53,  4 users,  load average: 0.08, 0.15, 0.10
> 
> No oops so far. Serial console still connected, will report if this or a 
> similar problem occurs again.

Thanks for testing. Dave, please take this patch instead, it avoids
having to guess whether a packet originates from bridging in IP
netfilter by using DST_NOXFRM for bridge-netfilter's fake dst_entry.

--------------000803000504050308040807
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: Fix bridge netfilter related in xfrm_lookup

The bridge-netfilter code attaches a fake dst_entry with dst->ops == NULL
to purely bridged packets. When these packets are SNATed and a policy
lookup is done, xfrm_lookup crashes because it tries to dereference
dst->ops.

Change xfrm_lookup not to dereference dst->ops before checking for the
DST_NOXFRM flag and set this flag in the fake dst_entry.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 6f149cebfdad51205b405058496a501a550dfdb4
tree f87624178d8e9e8b255080f20a5b91a5c25d45e9
parent a8372f035aa2f6717123eb30679a08b619321dd4
author Patrick McHardy <kaber@trash.net> Tue, 21 Feb 2006 04:03:16 +0100
committer Patrick McHardy <kaber@trash.net> Tue, 21 Feb 2006 04:03:16 +0100

 net/bridge/br_netfilter.c |    1 +
 net/xfrm/xfrm_policy.c    |    7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 6bb0c7e..e060aad 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -90,6 +90,7 @@ static struct rtable __fake_rtable = {
 			.dev			= &__fake_net_device,
 			.path			= &__fake_rtable.u.dst,
 			.metrics		= {[RTAX_MTU - 1] = 1500},
+			.flags			= DST_NOXFRM,
 		}
 	},
 	.rt_flags	= 0,
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 5e6b05a..8206025 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -782,7 +782,7 @@ int xfrm_lookup(struct dst_entry **dst_p
 	int nx = 0;
 	int err;
 	u32 genid;
-	u16 family = dst_orig->ops->family;
+	u16 family;
 	u8 dir = policy_to_flow_dir(XFRM_POLICY_OUT);
 	u32 sk_sid = security_sk_sid(sk, fl, dir);
 restart:
@@ -796,13 +796,14 @@ restart:
 		if ((dst_orig->flags & DST_NOXFRM) || !xfrm_policy_list[XFRM_POLICY_OUT])
 			return 0;
 
-		policy = flow_cache_lookup(fl, sk_sid, family, dir,
-					   xfrm_policy_lookup);
+		policy = flow_cache_lookup(fl, sk_sid, dst_orig->ops->family,
+					   dir, xfrm_policy_lookup);
 	}
 
 	if (!policy)
 		return 0;
 
+	family = dst_orig->ops->family;
 	policy->curlft.use_time = (unsigned long)xtime.tv_sec;
 
 	switch (policy->action) {

--------------000803000504050308040807--
