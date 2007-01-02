Return-Path: <linux-kernel-owner+w=401wt.eu-S1754964AbXABVLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbXABVLv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbXABVLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:11:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:54223 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964AbXABVLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:11:50 -0500
Date: Tue, 2 Jan 2007 14:57:25 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200701022057.l02KvP9s028947@faith.austin.ibm.com>
To: hadi@cyberus.ca
Subject: Re: [patch] net/xfrm: fix crash in ipsec audit logging
Cc: akpm@osdl.org, davem@davemloft.net, dmw2@infradead.org,
       linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2006-12-26 at 13:37 -0500, jamal wrote:
>On Tue, 2006-26-12 at 18:56 +0100, Ingo Molnar wrote:
> 
> 
> > +	xfrm_audit_log(NETLINK_CB(skb).loginuid, NETLINK_CB(skb).sid,
> > +		       AUDIT_MAC_IPSEC_DELSPD, delete, xp, NULL);
> > +
> >  	if (!delete) {
> >  		struct sk_buff *resp_skb;
> 
> 
> You could move the call into the else from above if (!delete) maybe?
> Otherwise you have to add back the "if (delete)" check since that
> function could be used to either retrieve (which is not subject to an
> audit) or delete an xp.
> 
> cheers,
> jamal
>  

My apologies as I am just reading my email.

Yes, I think in the else part of the "if (!delete)".

I also added a check to xfrm_audit_log() such that if both xfrm
and policy are NULL, we return. There isn't anything to audit
since we are only auditing creation and deletion of xfrm and 
policy.

Ingo, could you try this patch and let me know if everything works ok
for you. I have built and test in my environment, but not tested as
you are using it.  

Regards,
Joy

Signed-off-by: Joy Latten <latten@austin.ibm.com>

--------------------------------------------------------------------------

diff -urpN linux-2.6.19.orig/net/xfrm/xfrm_policy.c linux-2.6.19/net/xfrm/xfrm_policy.c
--- linux-2.6.19.orig/net/xfrm/xfrm_policy.c	2007-01-02 14:24:14.000000000 -0600
+++ linux-2.6.19/net/xfrm/xfrm_policy.c	2007-01-02 14:28:24.000000000 -0600
@@ -2003,6 +2003,9 @@ void xfrm_audit_log(uid_t auid, u32 sid,
 	if (audit_enabled == 0)
 		return;
 
+	if ((x == NULL) && (xp == NULL))
+		return;
+
 	audit_buf = audit_log_start(current->audit_context, GFP_ATOMIC, type);
 	if (audit_buf == NULL)
 	return;
diff -urpN linux-2.6.19.orig/net/xfrm/xfrm_user.c linux-2.6.19/net/xfrm/xfrm_user.c
--- linux-2.6.19.orig/net/xfrm/xfrm_user.c	2007-01-02 14:24:14.000000000 -0600
+++ linux-2.6.19/net/xfrm/xfrm_user.c	2007-01-02 14:28:14.000000000 -0600
@@ -1268,10 +1268,6 @@ static int xfrm_get_policy(struct sk_buf
 		xp = xfrm_policy_bysel_ctx(type, p->dir, &p->sel, tmp.security, delete);
 		security_xfrm_policy_free(&tmp);
 	}
-	if (delete)
-		xfrm_audit_log(NETLINK_CB(skb).loginuid, NETLINK_CB(skb).sid,
-			       AUDIT_MAC_IPSEC_DELSPD, (xp) ? 1 : 0, xp, NULL);
-
 	if (xp == NULL)
 		return -ENOENT;
 
@@ -1289,6 +1285,10 @@ static int xfrm_get_policy(struct sk_buf
 	} else {
 		if ((err = security_xfrm_policy_delete(xp)) != 0)
 			goto out;
+
+		xfrm_audit_log(NETLINK_CB(skb).loginuid, NETLINK_CB(skb).sid,
+			       AUDIT_MAC_IPSEC_DELSPD, (xp) ? 1 : 0, xp, NULL);
+
 		c.data.byid = p->index;
 		c.event = nlh->nlmsg_type;
 		c.seq = nlh->nlmsg_seq;

