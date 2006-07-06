Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWGFMIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWGFMIS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 08:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWGFMIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 08:08:17 -0400
Received: from postel.suug.ch ([194.88.212.233]:49286 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S1030217AbWGFMIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 08:08:16 -0400
Date: Thu, 6 Jul 2006 14:08:36 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@sgi.com>, pj@sgi.com,
       Valdis.Kletnieks@vt.edu, Balbir Singh <balbir@in.ibm.com>,
       csturtiv@sgi.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Jamal <hadi@cyberus.ca>, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] per-task delay accounting taskstats interface: control exit data through cpumasks]
Message-ID: <20060706120835.GY14627@postel.suug.ch>
References: <44ACD7C3.5040008@watson.ibm.com> <20060706025633.cd4b1c1d.akpm@osdl.org> <1152185865.5986.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152185865.5986.15.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Shailabh Nagar <nagar@watson.ibm.com> 2006-07-06 07:37
> @@ -37,9 +45,26 @@ static struct nla_policy taskstats_cmd_g
>  __read_mostly = {
>  	[TASKSTATS_CMD_ATTR_PID]  = { .type = NLA_U32 },
>  	[TASKSTATS_CMD_ATTR_TGID] = { .type = NLA_U32 },
> +	[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK] = { .type = NLA_STRING },
> +	[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK] = { .type = NLA_STRING },};

> +		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
> +		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
> +			return -E2BIG;
> +		rc = cpulist_parse((char *)nla_data(na), mask);

This isn't safe, the data in the attribute is not guaranteed to be
NUL terminated. Still it's probably me to blame for not making
this more obvious in the API.

I've attached a patch below extending the API to make it easier
for interfaces using NUL termianted strings, so you'd do:

[TASKSTATS_CMS_ATTR_REGISTER_CPUMASK] = { .type = NLA_NUL_STRING,
                                          .len = TASKSTATS_CPUMASK_MAXLEN }

... and then use (char *) nla_data(str_attr) without any further
sanity checks.

[NETLINK]: Improve string attribute validation

Introduces a new attribute type NLA_NUL_STRING to support NUL
terminated strings. Attributes of this kind require to carry
a terminating NUL within the maximum specified in the policy.

The `old' NLA_STRING which is not required to be NUL terminated
is extended to provide means to specify a maximum length of the
string.

Aims at easing the pain with using nla_strlcpy() on temporary
buffers.

The old `minlen' field is renamed to `len' for cosmetic purposes
which is ok since nobody was using it at this point.

Signed-off-by: Thomas Graf <tgraf@suug.ch>

Index: net-2.6.git/include/net/netlink.h
===================================================================
--- net-2.6.git.orig/include/net/netlink.h
+++ net-2.6.git/include/net/netlink.h
@@ -158,6 +158,7 @@ enum {
 	NLA_FLAG,
 	NLA_MSECS,
 	NLA_NESTED,
+	NLA_NUL_STRING,
 	__NLA_TYPE_MAX,
 };
 
@@ -166,21 +167,27 @@ enum {
 /**
  * struct nla_policy - attribute validation policy
  * @type: Type of attribute or NLA_UNSPEC
- * @minlen: Minimal length of payload required to be available
+ * @len: Type specific length of payload
  *
  * Policies are defined as arrays of this struct, the array must be
  * accessible by attribute type up to the highest identifier to be expected.
  *
+ * Meaning of `len' field:
+ *    NLA_STRING           Maximum length of string
+ *    NLA_NUL_STRING       Maximum length of string including NUL
+ *    NLA_FLAG             Unused
+ *    All other            Exact length of attribute payload
+ *
  * Example:
  * static struct nla_policy my_policy[ATTR_MAX+1] __read_mostly = {
  * 	[ATTR_FOO] = { .type = NLA_U16 },
- *	[ATTR_BAR] = { .type = NLA_STRING },
- *	[ATTR_BAZ] = { .minlen = sizeof(struct mystruct) },
+ *	[ATTR_BAR] = { .type = NLA_STRING, len = BARSIZ },
+ *	[ATTR_BAZ] = { .len = sizeof(struct mystruct) },
  * };
  */
 struct nla_policy {
 	u16		type;
-	u16		minlen;
+	u16		len;
 };
 
 extern void		netlink_run_queue(struct sock *sk, unsigned int *qlen,
Index: net-2.6.git/net/netlink/attr.c
===================================================================
--- net-2.6.git.orig/net/netlink/attr.c
+++ net-2.6.git/net/netlink/attr.c
@@ -20,7 +20,6 @@ static u16 nla_attr_minlen[NLA_TYPE_MAX+
 	[NLA_U16]	= sizeof(u16),
 	[NLA_U32]	= sizeof(u32),
 	[NLA_U64]	= sizeof(u64),
-	[NLA_STRING]	= 1,
 	[NLA_NESTED]	= NLA_HDRLEN,
 };
 
@@ -28,7 +27,7 @@ static int validate_nla(struct nlattr *n
 			struct nla_policy *policy)
 {
 	struct nla_policy *pt;
-	int minlen = 0;
+	int minlen = 0, attrlen = nla_len(nla);
 
 	if (nla->nla_type <= 0 || nla->nla_type > maxtype)
 		return 0;
@@ -37,16 +36,33 @@ static int validate_nla(struct nlattr *n
 
 	BUG_ON(pt->type > NLA_TYPE_MAX);
 
-	if (pt->minlen)
-		minlen = pt->minlen;
-	else if (pt->type != NLA_UNSPEC)
-		minlen = nla_attr_minlen[pt->type];
+	switch (pt->type) {
+	case NLA_FLAG:
+		if (attrlen > 0)
+			return -ERANGE;
+		break;
+
+	case NLA_NUL_STRING:
+		minlen = min_t(int, attrlen, pt->len);
+
+		if (!minlen || strnchr(nla_data(nla), minlen, '\0') == NULL)
+			return -EINVAL;
+		/* fall through */
+
+	case NLA_STRING:
+		if (attrlen < 1 || attrlen > pt->len)
+			return -ERANGE;
+		break;
+
+	default:
+		if (pt->len)
+			minlen = pt->len;
+		else if (pt->type != NLA_UNSPEC)
+			minlen = nla_attr_minlen[pt->type];
 
-	if (pt->type == NLA_FLAG && nla_len(nla) > 0)
-		return -ERANGE;
-
-	if (nla_len(nla) < minlen)
-		return -ERANGE;
+		if (attrlen < minlen)
+			return -ERANGE;
+	}
 
 	return 0;
 }
