Return-Path: <linux-kernel-owner+w=401wt.eu-S965013AbWL1WXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWL1WXQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWL1WXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:23:16 -0500
Received: from pool-71-111-57-167.ptldor.dsl-w.verizon.net ([71.111.57.167]:6656
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965013AbWL1WXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:23:15 -0500
Date: Thu, 28 Dec 2006 14:23:14 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Corey Minyard <minyard@acm.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Carol Hebert <cah@us.ibm.com>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH] IPMI: fix some RCU problems
Message-ID: <20061228222314.GD4501@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061228182447.GA23730@localdomain> <20061228183101.GA2412@infradead.org> <20061228195504.GC4501@linux.vnet.ibm.com> <20061228122422.f052f6b5.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228122422.f052f6b5.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 12:24:22PM -0800, Randy Dunlap wrote:
> On Thu, 28 Dec 2006 11:55:04 -0800 Paul E. McKenney wrote:
> 
> >  list.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff -urpNa -X dontdiff linux-2.6.19/include/linux/list.h linux-2.6.19-lpr/include/linux/list.h
> > --- linux-2.6.19/include/linux/list.h	2006-11-29 13:57:37.000000000 -0800
> > +++ linux-2.6.19-lpr/include/linux/list.h	2006-12-28 11:48:31.000000000 -0800
> > @@ -360,6 +360,64 @@ static inline void list_splice_init(stru
> >  }
> >
> >  /**
> > + * list_splice_init_rcu - splice an RCU-protected list into an existing list.
> > + * @list	the RCU-protected list to splice
> > + * @head	the place in the list to splice the first list into
> > + * @sync	function to sync: synchronize_rcu(), synchronize_sched(), ...
> 
> @parameter: is kernel-doc syntax.
> I.e., please add a colon after each one of those.

Good point!  :-/

Fixed below.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 list.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff -urpNa -X dontdiff linux-2.6.19/include/linux/list.h linux-2.6.19-lpr/include/linux/list.h
--- linux-2.6.19/include/linux/list.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19-lpr/include/linux/list.h	2006-12-28 14:21:05.000000000 -0800
@@ -360,6 +360,64 @@ static inline void list_splice_init(stru
 }
 
 /**
+ * list_splice_init_rcu - splice an RCU-protected list into an existing list.
+ * @list:	the RCU-protected list to splice
+ * @head:	the place in the list to splice the first list into
+ * @sync:	function to sync: synchronize_rcu(), synchronize_sched(), ...
+ *
+ * @head can be RCU-read traversed concurrently with this function.
+ *
+ * Note that this function blocks.
+ *
+ * Important note: the caller must take whatever action is necessary to
+ *	prevent any other updates to @head.  In principle, it is possible
+ *	to modify the list as soon as sync() begins execution.
+ *	If this sort of thing becomes necessary, an alternative version
+ *	based on call_rcu() could be created.  But only if -really-
+ *	needed -- there is no shortage of RCU API members.
+ */
+static inline void list_splice_init_rcu(struct list_head *list,
+					struct list_head *head,
+					void (*sync)(void))
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+	struct list_head *at = head->next;
+
+	might_sleep();
+	if (list_empty(head)) {
+		return;
+	}
+
+	/* "first" and "last" tracking list, so initialize it. */
+
+	INIT_LIST_HEAD(list);
+
+	/*
+	 * At this point, the list body still points to the source list.
+	 * Wait for any readers to finish using the list before splicing
+	 * the list body into the new list.  Any new readers will see
+	 * an empty list.
+	 */
+
+	sync();
+
+	/*
+	 * Readers are finished with the source list, so perform splice.
+	 * The order is important if the new list is global and accessible
+	 * to concurrent RCU readers.  Note that RCU readers are not
+	 * permitted to traverse the prev pointers without excluding
+	 * this function.
+	 */
+
+	last->next = at;
+	smp_wmb();
+	head->next = first;
+	first->prev = head;
+	at->prev = last;
+}
+
+/**
  * list_entry - get the struct for this entry
  * @ptr:	the &struct list_head pointer.
  * @type:	the type of the struct this is embedded in.
