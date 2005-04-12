Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVDLUc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVDLUc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVDLUbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:31:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:35752 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262305AbVDLShQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:37:16 -0400
Date: Tue, 12 Apr 2005 11:37:28 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, mingo@mvista.com, sdietrich@mvista.com,
       inaky.perez-gonzalez@intel.com
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050412183728.GA1369@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1112896344.16901.26.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112896344.16901.26.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 10:52:25AM -0700, Daniel Walker wrote:
> 
> Source: Daniel Walker <dwalker@mvista.com> MontaVista Software, Inc
> Description:
> 	This patch adds the priority list data structure from Inaky Perez-Gonzalez 
> to the Preempt Real-Time mutex.
> 
> the patch order is (starting with a 2.6.11 kernel tree),
> 
> patch-2.6.12-rc2
> realtime-preempt-2.6.12-rc2-V0.7.44-01
> 	
> Signed-off-by: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.11/include/linux/plist.h
> ===================================================================
> --- linux-2.6.11.orig/include/linux/plist.h	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.11/include/linux/plist.h	2005-04-07 17:47:42.000000000 +0000
> @@ -0,0 +1,310 @@

[ . . . ]

> +/* Grunt to do the real removal work of @pl from the plist. */
> +static inline
> +void __plist_del (struct plist *pl)
> +{
> +	struct list_head *victim;
> +	if (list_empty (&pl->dp_node))  	/* SP-node, not head */
> +		victim = &pl->sp_node;
> +	else if (list_empty (&pl->sp_node)) 	/* DP-node, empty SP list */
> +		victim = &pl->dp_node;
> +	else {					/* SP list head, not empty */
> +		struct plist *pl_new = container_of (pl->sp_node.next,
> +						     struct plist, sp_node);
> +		victim = &pl->sp_node;
> +		list_replace_rcu (&pl->dp_node, &pl_new->dp_node);

If you are protecting this list with RCU...

> +	}
> +	list_del_init (victim);

... you need to wait for a grace period before deleting the element
removed from the list.

Or are you just using list_replace_rcu() for its replacement capability?
If so, seems like it might be worthwhile to make a list_replace().
This would get rid of the memory barrier, and also keep from confusing
people like myself.  ;-)

							Thanx, Paul
