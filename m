Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbSJDOSg>; Fri, 4 Oct 2002 10:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261813AbSJDOSg>; Fri, 4 Oct 2002 10:18:36 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:1712 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261812AbSJDOSf>; Fri, 4 Oct 2002 10:18:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] add safe version of list_for_each_entry() to list.h
Date: Fri, 4 Oct 2002 08:51:12 -0500
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <OF9EDF8472.CDE2D9D8-ON85256C47.0080772B@pok.ibm.com> <02100319254700.00236@cygnus> <20021004145850.B30064@infradead.org>
In-Reply-To: <20021004145850.B30064@infradead.org>
MIME-Version: 1.0
Message-Id: <02100408511202.02266@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 08:58, Christoph Hellwig wrote:
> > + */
> > +#define list_for_each_entry_safe(pos, n, head, member)			\
> > +	for (pos = list_entry((head)->next, typeof(*pos), member),	\
> > +		n = list_entry(pos->member.next, typeof(*pos), member);	\
> > +	     &pos->member != (head);					\
> > +	     pos = n,							\
> > +		n = list_entry(pos->member.next, typeof(*pos), member))
>
> Identation looks a little strange..

Dammit. Forgot to insert the patch. Here goes again.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/

======================================================
diff -Naur linux-2.5.40a/include/linux/list.h linux-2.5.40b/include/linux/list.h
--- linux-2.5.40a/include/linux/list.h	Fri Oct  4 08:45:54 2002
+++ linux-2.5.40b/include/linux/list.h	Fri Oct  4 08:45:31 2002
@@ -137,6 +137,15 @@
 	return head->next == head;
 }
 
+/**
+ * list_member - tests whether a list member is currently on a list
+ * @member:	member to evaulate
+ */
+static inline int list_member(struct list_head *member)
+{
+	return member->next && member->prev;
+}
+
 static inline void __list_splice(struct list_head *list,
 				 struct list_head *head)
 {
@@ -240,6 +249,20 @@
 	     &pos->member != (head); 					\
 	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
 		     prefetch(pos->member.next))
+
+/**
+ * list_for_each_entry_safe - iterate over list safe against removal of list entry
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_entry((head)->next, typeof(*pos), member),	\
+		n = list_entry(pos->member.next, typeof(*pos), member);	\
+	     &pos->member != (head);					\
+	     pos = n,							\
+		n = list_entry(pos->member.next, typeof(*pos), member))
 
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
