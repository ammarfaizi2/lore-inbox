Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbULHFRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbULHFRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 00:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbULHFRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 00:17:35 -0500
Received: from [62.206.217.67] ([62.206.217.67]:9864 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262024AbULHFR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 00:17:29 -0500
Message-ID: <41B68E5D.2080009@trash.net>
Date: Wed, 08 Dec 2004 06:17:17 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: hadi@znyx.com
CC: Thomas Graf <tgraf@suug.ch>, Andrew Morton <akpm@osdl.org>,
       Thomas Cataldo <tomc@compaqnet.fr>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
References: <1102380430.6103.6.camel@buffy>	 <20041206224441.628e7885.akpm@osdl.org>	 <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net>	 <20041207170748.GF1371@postel.suug.ch>  <41B5E722.2080600@trash.net>	 <1102480044.1050.9.camel@jzny.localdomain> <1102480913.1049.24.camel@jzny.localdomain>
In-Reply-To: <1102480913.1049.24.camel@jzny.localdomain>
Content-Type: multipart/mixed;
 boundary="------------040309070208000504050501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040309070208000504050501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jamal Hadi Salim wrote:

>BTW, old kernel in this case implies one that does not support tc
>actions at all. So pick something like 2.4.28.
>New is whatever 2.6.x with patch.
>Old tc is something that for example ships with redhat
>new tc is whatever one is patched.
>
>Supplementary tests are: in 2.6.x to compile the policer
>in two different ways a) via tc actions and b) using the old scheme
>which is understood by "old" tc. Repeat the tests i described earlier
>with b) pretending to be "old" kernel.
>
>Infact come to think of it i would also prefer to have the suplementary
>tests run as well.
>If you guys have no cycles, please pass the patch to me and i will test
>on the weekend.
>  
>

I think these tests are a waste of time. struct tcf_police is not
userspace-visible, so it's highly unlikely that the tc version matters.
Why an old kernel needs to be tested is beyond me. For possible in-kernel
breakage caused by the restructuring, without CONFIG_NET_CLS_ACT,
struct tcf_police is only used in police.c, without any casts or
assumptions about layout, so I can't see what could break. With
CONFIG_NET_CLS_ACT, the only place where it is used outside of
police.c is tcf_action_copy_stats, and this is exactly what this patch
(tested) fixes.

If you still want to do these test, please use the attached patch.

Regards
Patrick



--------------040309070208000504050501
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

===== include/net/act_api.h 1.4 vs edited =====
--- 1.4/include/net/act_api.h	2004-11-06 01:33:12 +01:00
+++ edited/include/net/act_api.h	2004-12-07 17:53:37 +01:00
@@ -8,15 +8,23 @@
 #include <net/sch_generic.h>
 #include <net/pkt_sched.h>
 
+#define tca_gen(name) \
+struct tcf_##name *next; \
+	u32 index; \
+	int refcnt; \
+	int bindcnt; \
+	u32 capab; \
+	int action; \
+	struct tcf_t tm; \
+	struct gnet_stats_basic bstats; \
+	struct gnet_stats_queue qstats; \
+	struct gnet_stats_rate_est rate_est; \
+	spinlock_t *stats_lock; \
+	spinlock_t lock
+
 struct tcf_police
 {
-	struct tcf_police *next;
-	int		refcnt;
-#ifdef CONFIG_NET_CLS_ACT
-	int		bindcnt;
-#endif
-	u32		index;
-	int		action;
+	tca_gen(police);
 	int		result;
 	u32		ewma_rate;
 	u32		burst;
@@ -24,33 +32,14 @@
 	u32		toks;
 	u32		ptoks;
 	psched_time_t	t_c;
-	spinlock_t	lock;
 	struct qdisc_rate_table *R_tab;
 	struct qdisc_rate_table *P_tab;
-
-	struct gnet_stats_basic bstats;
-	struct gnet_stats_queue qstats;
-	struct gnet_stats_rate_est rate_est;
-	spinlock_t	*stats_lock;
 };
 
 #ifdef CONFIG_NET_CLS_ACT
 
 #define ACT_P_CREATED 1
 #define ACT_P_DELETED 1
-#define tca_gen(name) \
-struct tcf_##name *next; \
-	u32 index; \
-	int refcnt; \
-	int bindcnt; \
-	u32 capab; \
-	int action; \
-	struct tcf_t tm; \
-	struct gnet_stats_basic bstats; \
-	struct gnet_stats_queue qstats; \
-	struct gnet_stats_rate_est rate_est; \
-	spinlock_t *stats_lock; \
-	spinlock_t lock
 
 struct tcf_act_hdr
 {

--------------040309070208000504050501--
