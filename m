Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVKEEBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVKEEBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 23:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVKEEBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 23:01:21 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:7142 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751194AbVKEEBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 23:01:21 -0500
Message-ID: <436C2E8E.9040909@acm.org>
Date: Fri, 04 Nov 2005 22:01:18 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-6mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix remaining list_for_each_safe_rcu in -mm
References: <20051101152933.GA6210@us.ibm.com>
In-Reply-To: <20051101152933.GA6210@us.ibm.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the long delay, I've been travelling and giving presentations :(.

IIRC, the RCU operations are "safe" by nature, so this is fine.

-Corey

Paul E. McKenney wrote:

>Hello!
>
>I missed a use of list_for_each_rcu_safe() in -mm tree.  Here is a patch
>to fix it.
>
>Signed-off-by: <paulmck@us.ibm.com>
>
>---
>
> ipmi_msghandler.c |    5 ++---
> 1 files changed, 2 insertions(+), 3 deletions(-)
>
>diff -urpNa -X dontdiff linux-2.6.14-rc5-mm1/drivers/char/ipmi/ipmi_msghandler.c linux-2.6.14-rc5-mm1-safe_rcu/drivers/char/ipmi/ipmi_msghandler.c
>--- linux-2.6.14-rc5-mm1/drivers/char/ipmi/ipmi_msghandler.c	2005-11-01 06:44:09.000000000 -0800
>+++ linux-2.6.14-rc5-mm1-safe_rcu/drivers/char/ipmi/ipmi_msghandler.c	2005-11-01 07:00:50.000000000 -0800
>@@ -788,7 +788,7 @@ int ipmi_destroy_user(ipmi_user_t user)
> 	int              i;
> 	unsigned long    flags;
> 	struct cmd_rcvr  *rcvr;
>-	struct list_head *entry1, *entry2;
>+	struct list_head *entry1;
> 	struct cmd_rcvr  *rcvrs = NULL;
> 
> 	user->valid = 1;
>@@ -813,8 +813,7 @@ int ipmi_destroy_user(ipmi_user_t user)
> 	 * synchronize_rcu()) then free everything in that list.
> 	 */
> 	spin_lock_irqsave(&intf->cmd_rcvrs_lock, flags);
>-	list_for_each_safe_rcu(entry1, entry2, &intf->cmd_rcvrs) {
>-		rcvr = list_entry(entry1, struct cmd_rcvr, link);
>+	list_for_each_entry_rcu(entry1, &intf->cmd_rcvrs, link) {
> 		if (rcvr->user == user) {
> 			list_del_rcu(&rcvr->link);
> 			rcvr->next = rcvrs;
>  
>

