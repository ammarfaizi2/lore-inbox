Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSJDBFo>; Thu, 3 Oct 2002 21:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSJDBFo>; Thu, 3 Oct 2002 21:05:44 -0400
Received: from smtp2.texas.rr.com ([24.93.36.230]:13983 "EHLO
	txsmtp02.texas.rr.com") by vger.kernel.org with ESMTP
	id <S261264AbSJDBFn>; Thu, 3 Oct 2002 21:05:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <kcorry@austin.rr.com>
Reply-To: kcorry@austin.rr.com
To: Greg KH <greg@kroah.com>, Mark Peloquin <peloquin@us.ibm.com>
Subject: Re: [PATCH] add safe version of list_for_each_entry() to list.h
Date: Thu, 3 Oct 2002 19:25:47 -0500
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <OF9EDF8472.CDE2D9D8-ON85256C47.0080772B@pok.ibm.com> <20021003234430.GG2289@kroah.com>
In-Reply-To: <20021003234430.GG2289@kroah.com>
MIME-Version: 1.0
Message-Id: <02100319254700.00236@cygnus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 18:44, Greg KH wrote:
> On Thu, Oct 03, 2002 at 06:42:09PM -0500, Mark Peloquin wrote:
> > Please consider adding the following patch to list.h.
>
> This patch had the tabs mangled and would not apply.
>
> Yeah, Notes sucks for sending patches...

It does indeed. Avoid Notes at all costs. :)

Here is the patch again. Should apply cleanly this time.

-Kevin

=========================================================
diff -Naur linux-2.5.40a/include/linux/list.h linux-2.5.40b/include/linux/list.h
--- linux-2.5.40a/include/linux/list.h	Tue Oct  1 02:05:48 2002
+++ linux-2.5.40b/include/linux/list.h	Thu Oct  3 19:17:27 2002
@@ -137,6 +137,15 @@
 	return head->next == head;
 }
 
+/**
+ * list_member - tests whether a list member is currently on a list
+ * @member:	member to evaulate
+ */
+static inline int list_member(struct list_head *member)
+{
+	return ((!member->next || !member->prev) ? 0 : 1);
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
 
