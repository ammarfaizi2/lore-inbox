Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWGID3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWGID3H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbWGID3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:29:07 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:41231 "EHLO
	asav02.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1161075AbWGID3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:29:06 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HANYUsESBTA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC/PATCH] Introduce list_get() and list_get_tail()
Date: Sat, 8 Jul 2006 23:28:47 -0400
User-Agent: KMail/1.9.3
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <200607080124.21856.dtor@insightbb.com> <p73wtaonqow.fsf@verdi.suse.de> <1152368186.3120.50.camel@laptopd505.fenrus.org>
In-Reply-To: <1152368186.3120.50.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607082328.48575.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 10:16, Arjan van de Ven wrote:
> On Sat, 2006-07-08 at 15:58 +0200, Andi Kleen wrote:
> > Dmitry Torokhov <dtor@insightbb.com> writes:
> > 
> > > From: Dmitry Torokhov <dtor@mail.ru>
> > > 
> > > Add primitives to access first and last elements of a list instead
> > > of accessng pointers directly.
> > 
> > Wouldn't that be beter named list_first() and list_last() then?
> > _get is like _do and usually not very descriptive.
> 
> and _get tends to imply a reference count as well; I'm with Andi on
> this.. list_first() and list_last() 
> 

OK, so what about the following:

Subject: Introduce primitives to get first and last list elements

Introduce list_first() and list_last(); list_first_entry() and
list_last_entry().

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 include/linux/list.h |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+)

Index: work/include/linux/list.h
===================================================================
--- work.orig/include/linux/list.h
+++ work/include/linux/list.h
@@ -343,6 +343,26 @@ static inline void list_splice_init(stru
 	container_of(ptr, type, member)
 
 /**
+ * list_first_entry - get the struct for the first entry
+ * @head:	the &struct list_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_first_entry(head, type, member) \
+	list_entry((head)->next, type, member)
+#define list_next_entry list_first_entry
+
+/**
+ * list_last_entry - get the struct for the last entry
+ * @head:	the &struct list_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_last_entry(head, type, member) \
+	list_entry((head)->prev, type, member)
+#define list_prev_entry list_last_entry
+
+/**
  * list_for_each	-	iterate over a list
  * @pos:	the &struct list_head to use as a loop cursor.
  * @head:	the head for your list.
@@ -571,6 +591,26 @@ static inline void list_splice_init(stru
 		prefetch(rcu_dereference((pos))->next), (pos) != (head); \
         	(pos) = (pos)->next)
 
+/**
+ * list_first - get first element in a list
+ * @head: the head of your list
+ */
+#define list_next list_first
+static inline struct list_head *list_first(struct list_head *head)
+{
+	return head->next;
+}
+
+/**
+ * list_last - get last element in a list
+ * @head: the head of your list
+ */
+#define list_prev list_last
+static inline struct list_head *list_last(struct list_head *head)
+{
+	return head->prev;
+}
+
 /*
  * Double linked lists with a single pointer list head.
  * Mostly useful for hash tables where the two pointer list head is
