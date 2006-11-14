Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965468AbWKNMbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965468AbWKNMbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965472AbWKNMbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:31:41 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:15844 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965468AbWKNMbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:31:40 -0500
Date: Tue, 14 Nov 2006 17:50:51 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       vatsa@in.ibm.com, dipankar@in.ibm.com, davej@redhat.com, mingo@elte.hu,
       kiran@scalex86.org
Subject: [PATCH 1/4] Extend notifier_call_chain to count nr_calls made.
Message-ID: <20061114122050.GB31787@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061114121832.GA31787@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114121832.GA31787@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide notifier_call_chain with an option to call only a specified number of 
notifiers and also record the number of call to notifiers made.

The need for this enhancement was identified in the post entitled 
"Slab - Eliminate lock_cpu_hotplug from slab" 
(http://lkml.org/lkml/2006/10/28/92) by Ravikiran G Thirumalai and 
Andrew Morton.

This patch adds two additional parameters to notifier_call_chain API namely 
 - int nr_to_calls : Number of notifier_functions to be called. 
 		     The don't care value is -1.

 - unsigned int *nr_calls : Records the total number of notifier_funtions 
			    called by notifier_call_chain. The don't care
			    value is NULL.

Credit : Andrew Morton <akpm@osdl.org> 
Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>

--
 include/linux/notifier.h |    8 +++
 kernel/sys.c             |   97 +++++++++++++++++++++++++++++++++++++++-------- 2 files changed, 89 insertions(+), 16 deletions(-)

Index: hotplug/kernel/sys.c
===================================================================
--- hotplug.orig/kernel/sys.c
+++ hotplug/kernel/sys.c
@@ -134,19 +134,41 @@ static int notifier_chain_unregister(str
 	return -ENOENT;
 }
 
+/*
+ * notifier_call_chain - Informs the registered notifiers about an event.
+ *
+ *	@nl:		Pointer to head of the blocking notifier chain
+ *	@val:		Value passed unmodified to notifier function
+ *	@v:		Pointer passed unmodified to notifier function
+ *	@nr_to_call:	Number of notifier functions to be called. Don't care
+ *		     	value of this parameter is -1.
+ *	@nr_calls:	Records the number of notifications sent. Don't care
+ *		   	value of this field is NULL.
+ *
+ * 	RETURN VALUE:	notifier_call_chain returns the value returned by the
+ *			last notifier function called.
+ */
+
 static int __kprobes notifier_call_chain(struct notifier_block **nl,
-		unsigned long val, void *v)
+					unsigned long val, void *v,
+					int nr_to_call,	unsigned int *nr_calls)
 {
 	int ret = NOTIFY_DONE;
 	struct notifier_block *nb, *next_nb;
 
 	nb = rcu_dereference(*nl);
-	while (nb) {
+
+	while (nb && nr_to_call) {
 		next_nb = rcu_dereference(nb->next);
 		ret = nb->notifier_call(nb, val, v);
+
+		if (nr_calls)
+			*nr_calls ++;
+
 		if ((ret & NOTIFY_STOP_MASK) == NOTIFY_STOP_MASK)
 			break;
 		nb = next_nb;
+		nr_to_call--;
 	}
 	return ret;
 }
@@ -205,10 +227,13 @@ int atomic_notifier_chain_unregister(str
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
 
 /**
- *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
+ *	__atomic_notifier_call_chain - Call functions in an atomic notifier
+ *				       chain
  *	@nh: Pointer to head of the atomic notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
+ *	@nr_to_call: See the comment for notifier_call_chain.
+ *	@nr_calls: See the comment for notifier_call_chain.
  *
  *	Calls each function in a notifier chain in turn.  The functions
  *	run in an atomic context, so they must not block.
@@ -222,19 +247,27 @@ EXPORT_SYMBOL_GPL(atomic_notifier_chain_
  *	of the last notifier function called.
  */
  
-int __kprobes atomic_notifier_call_chain(struct atomic_notifier_head *nh,
-		unsigned long val, void *v)
+int __kprobes __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
+					unsigned long val, void *v,
+					int nr_to_call, unsigned int *nr_calls)
 {
 	int ret;
 
 	rcu_read_lock();
-	ret = notifier_call_chain(&nh->head, val, v);
+	ret = notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
 	rcu_read_unlock();
 	return ret;
 }
 
-EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
+EXPORT_SYMBOL_GPL(__atomic_notifier_call_chain);
 
+int __kprobes atomic_notifier_call_chain(struct atomic_notifier_head *nh,
+		unsigned long val, void *v)
+{
+	return __atomic_notifier_call_chain(nh, val, v, -1, NULL);
+}
+
+EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
 /*
  *	Blocking notifier chain routines.  All access to the chain is
  *	synchronized by an rwsem.
@@ -304,10 +337,13 @@ int blocking_notifier_chain_unregister(s
 EXPORT_SYMBOL_GPL(blocking_notifier_chain_unregister);
 
 /**
- *	blocking_notifier_call_chain - Call functions in a blocking notifier chain
+ *	__blocking_notifier_call_chain - Call functions in a blocking notifier
+ *					 chain
  *	@nh: Pointer to head of the blocking notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
+ *	@nr_to_call: See comment for notifier_call_chain.
+ *	@nr_calls: See comment for notifier_call_chain.
  *
  *	Calls each function in a notifier chain in turn.  The functions
  *	run in a process context, so they are allowed to block.
@@ -320,17 +356,26 @@ EXPORT_SYMBOL_GPL(blocking_notifier_chai
  *	of the last notifier function called.
  */
  
-int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
-		unsigned long val, void *v)
+int __blocking_notifier_call_chain(struct blocking_notifier_head *nh,
+				   unsigned long val, void *v,
+				   int nr_to_call, unsigned int * nr_calls)
 {
 	int ret;
 
 	down_read(&nh->rwsem);
-	ret = notifier_call_chain(&nh->head, val, v);
+	ret = notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
 	up_read(&nh->rwsem);
 	return ret;
 }
 
+EXPORT_SYMBOL_GPL(__blocking_notifier_call_chain);
+
+int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
+		unsigned long val, void *v)
+{
+	return __blocking_notifier_call_chain(nh, val, v, -1, NULL);
+}
+
 EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
 
 /*
@@ -376,10 +421,12 @@ int raw_notifier_chain_unregister(struct
 EXPORT_SYMBOL_GPL(raw_notifier_chain_unregister);
 
 /**
- *	raw_notifier_call_chain - Call functions in a raw notifier chain
+ *	__raw_notifier_call_chain - Call functions in a raw notifier chain
  *	@nh: Pointer to head of the raw notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
+ *	@nr_to_call: See comment for notifier_call_chain.
+ *	@nr_calls: See comment for notifier_call_chain
  *
  *	Calls each function in a notifier chain in turn.  The functions
  *	run in an undefined context.
@@ -393,10 +440,19 @@ EXPORT_SYMBOL_GPL(raw_notifier_chain_unr
  *	of the last notifier function called.
  */
 
+int __raw_notifier_call_chain(struct raw_notifier_head *nh,
+			      unsigned long val, void *v,
+			      int nr_to_call, unsigned int *nr_calls)
+{
+	return notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
+}
+
+EXPORT_SYMBOL_GPL(__raw_notifier_call_chain);
+
 int raw_notifier_call_chain(struct raw_notifier_head *nh,
 		unsigned long val, void *v)
 {
-	return notifier_call_chain(&nh->head, val, v);
+	return __raw_notifier_call_chain(nh, val, v, -1, NULL);
 }
 
 EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
@@ -475,6 +531,8 @@ EXPORT_SYMBOL_GPL(srcu_notifier_chain_un
  *	@nh: Pointer to head of the SRCU notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
+ *	@nr_to_call: See comment for notifier_call_chain.
+ *	@nr_calls: See comment for notifier_call_chain
  *
  *	Calls each function in a notifier chain in turn.  The functions
  *	run in a process context, so they are allowed to block.
@@ -487,18 +545,25 @@ EXPORT_SYMBOL_GPL(srcu_notifier_chain_un
  *	of the last notifier function called.
  */
 
-int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
-		unsigned long val, void *v)
+int __srcu_notifier_call_chain(struct srcu_notifier_head *nh,
+			       unsigned long val, void *v,
+			       int nr_to_call, unsigned int *nr_calls)
 {
 	int ret;
 	int idx;
 
 	idx = srcu_read_lock(&nh->srcu);
-	ret = notifier_call_chain(&nh->head, val, v);
+	ret = notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
 	srcu_read_unlock(&nh->srcu, idx);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__srcu_notifier_call_chain);
 
+int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
+		unsigned long val, void *v)
+{
+	return __srcu_notifier_call_chain(nh, val, v, -1, NULL);
+}
 EXPORT_SYMBOL_GPL(srcu_notifier_call_chain);
 
 /**
Index: hotplug/include/linux/notifier.h
===================================================================
--- hotplug.orig/include/linux/notifier.h
+++ hotplug/include/linux/notifier.h
@@ -132,12 +132,20 @@ extern int srcu_notifier_chain_unregiste
 
 extern int atomic_notifier_call_chain(struct atomic_notifier_head *,
 		unsigned long val, void *v);
+extern int __atomic_notifier_call_chain(struct atomic_notifier_head *,
+	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
 extern int blocking_notifier_call_chain(struct blocking_notifier_head *,
 		unsigned long val, void *v);
+extern int __blocking_notifier_call_chain(struct blocking_notifier_head *,
+	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
 extern int raw_notifier_call_chain(struct raw_notifier_head *,
 		unsigned long val, void *v);
+extern int __raw_notifier_call_chain(struct raw_notifier_head *,
+	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
 extern int srcu_notifier_call_chain(struct srcu_notifier_head *,
 		unsigned long val, void *v);
+extern int __srcu_notifier_call_chain(struct srcu_notifier_head *,
+	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
