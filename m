Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966700AbWKOIqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966700AbWKOIqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 03:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966701AbWKOIqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 03:46:54 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:22988 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP id S966700AbWKOIqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 03:46:53 -0500
Date: Wed, 15 Nov 2006 13:59:57 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: akpm@osdl.org
Cc: ego@in.ibm.com, randy.dunlap@oracle.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, vatsa@in.ibm.com, dipankar@in.ibm.com,
       davej@redhat.com, mingo@elte.hu, kiran@scalex86.org
Subject: [PATCH 1-fix/4] Fix extend notifier_call_chain to count nr_calls made.
Message-ID: <20061115082957.GB7207@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061114121832.GA31787@in.ibm.com> <20061114122050.GB31787@in.ibm.com> <20061114101806.a14ef7b7.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114101806.a14ef7b7.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please apply the following patch on top of 
extend-notifier_call_chain-to-count-nr_calls-made.patch.
This patch incorporates the Randy's suggestions.

thanks,
gautham.


This patch

* Corrects the type of nr_calls to int * from unsigned int * in
notifier_call_chain and it's subsequent callers.

* Converts comments of notifier_call_chain to be compliant with kernel-docs
standards.

*Reverts the changes made to the comments of other *_notifier_call_chain.

*Adds parameter names to a few functions prototypes in
include/linux/notifier.h .

Depends on patch: extend-notifier_call_chain-to-count-nr_calls-made.patch


Cc: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>

--
 include/linux/notifier.h |   58 +++++++++++++++++++++++------------------------
 kernel/sys.c             |   24 ++++++++-----------
 2 files changed, 39 insertions(+), 43 deletions(-)

Index: hotplug/kernel/sys.c
===================================================================
--- hotplug.orig/kernel/sys.c
+++ hotplug/kernel/sys.c
@@ -134,9 +134,8 @@ static int notifier_chain_unregister(str
 	return -ENOENT;
 }
 
-/*
+/**
  * notifier_call_chain - Informs the registered notifiers about an event.
- *
  *	@nl:		Pointer to head of the blocking notifier chain
  *	@val:		Value passed unmodified to notifier function
  *	@v:		Pointer passed unmodified to notifier function
@@ -144,14 +143,13 @@ static int notifier_chain_unregister(str
  *		     	value of this parameter is -1.
  *	@nr_calls:	Records the number of notifications sent. Don't care
  *		   	value of this field is NULL.
- *
- * 	RETURN VALUE:	notifier_call_chain returns the value returned by the
+ * 	@returns:	notifier_call_chain returns the value returned by the
  *			last notifier function called.
  */
 
 static int __kprobes notifier_call_chain(struct notifier_block **nl,
 					unsigned long val, void *v,
-					int nr_to_call,	unsigned int *nr_calls)
+					int nr_to_call,	int *nr_calls)
 {
 	int ret = NOTIFY_DONE;
 	struct notifier_block *nb, *next_nb;
@@ -227,8 +225,7 @@ int atomic_notifier_chain_unregister(str
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
 
 /**
- *	__atomic_notifier_call_chain - Call functions in an atomic notifier
- *				       chain
+ *	__atomic_notifier_call_chain - Call functions in an atomic notifier chain
  *	@nh: Pointer to head of the atomic notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
@@ -249,7 +246,7 @@ EXPORT_SYMBOL_GPL(atomic_notifier_chain_
  
 int __kprobes __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 					unsigned long val, void *v,
-					int nr_to_call, unsigned int *nr_calls)
+					int nr_to_call, int *nr_calls)
 {
 	int ret;
 
@@ -337,8 +334,7 @@ int blocking_notifier_chain_unregister(s
 EXPORT_SYMBOL_GPL(blocking_notifier_chain_unregister);
 
 /**
- *	__blocking_notifier_call_chain - Call functions in a blocking notifier
- *					 chain
+ *	__blocking_notifier_call_chain - Call functions in a blocking notifier chain
  *	@nh: Pointer to head of the blocking notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
@@ -358,7 +354,7 @@ EXPORT_SYMBOL_GPL(blocking_notifier_chai
  
 int __blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 				   unsigned long val, void *v,
-				   int nr_to_call, unsigned int * nr_calls)
+				   int nr_to_call, int *nr_calls)
 {
 	int ret;
 
@@ -442,7 +438,7 @@ EXPORT_SYMBOL_GPL(raw_notifier_chain_unr
 
 int __raw_notifier_call_chain(struct raw_notifier_head *nh,
 			      unsigned long val, void *v,
-			      int nr_to_call, unsigned int *nr_calls)
+			      int nr_to_call, int *nr_calls)
 {
 	return notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
 }
@@ -527,7 +523,7 @@ int srcu_notifier_chain_unregister(struc
 EXPORT_SYMBOL_GPL(srcu_notifier_chain_unregister);
 
 /**
- *	srcu_notifier_call_chain - Call functions in an SRCU notifier chain
+ *	__srcu_notifier_call_chain - Call functions in an SRCU notifier chain
  *	@nh: Pointer to head of the SRCU notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
@@ -547,7 +543,7 @@ EXPORT_SYMBOL_GPL(srcu_notifier_chain_un
 
 int __srcu_notifier_call_chain(struct srcu_notifier_head *nh,
 			       unsigned long val, void *v,
-			       int nr_to_call, unsigned int *nr_calls)
+			       int nr_to_call, int *nr_calls)
 {
 	int ret;
 	int idx;
Index: hotplug/include/linux/notifier.h
===================================================================
--- hotplug.orig/include/linux/notifier.h
+++ hotplug/include/linux/notifier.h
@@ -112,40 +112,40 @@ extern void srcu_init_notifier_head(stru
 
 #ifdef __KERNEL__
 
-extern int atomic_notifier_chain_register(struct atomic_notifier_head *,
-		struct notifier_block *);
-extern int blocking_notifier_chain_register(struct blocking_notifier_head *,
-		struct notifier_block *);
-extern int raw_notifier_chain_register(struct raw_notifier_head *,
-		struct notifier_block *);
-extern int srcu_notifier_chain_register(struct srcu_notifier_head *,
-		struct notifier_block *);
-
-extern int atomic_notifier_chain_unregister(struct atomic_notifier_head *,
-		struct notifier_block *);
-extern int blocking_notifier_chain_unregister(struct blocking_notifier_head *,
-		struct notifier_block *);
-extern int raw_notifier_chain_unregister(struct raw_notifier_head *,
-		struct notifier_block *);
-extern int srcu_notifier_chain_unregister(struct srcu_notifier_head *,
-		struct notifier_block *);
+extern int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
+		struct notifier_block *nb);
+extern int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
+		struct notifier_block *nb);
+extern int raw_notifier_chain_register(struct raw_notifier_head *nh,
+		struct notifier_block *nb);
+extern int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
+		struct notifier_block *nb);
+
+extern int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
+		struct notifier_block *nb);
+extern int blocking_notifier_chain_unregister(struct blocking_notifier_head *nh,
+		struct notifier_block *nb);
+extern int raw_notifier_chain_unregister(struct raw_notifier_head *nh,
+		struct notifier_block *nb);
+extern int srcu_notifier_chain_unregister(struct srcu_notifier_head *nh,
+		struct notifier_block *nb);
 
-extern int atomic_notifier_call_chain(struct atomic_notifier_head *,
+extern int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __atomic_notifier_call_chain(struct atomic_notifier_head *,
-	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
-extern int blocking_notifier_call_chain(struct blocking_notifier_head *,
+extern int __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
+	unsigned long val, void *v, int nr_to_call, int *nr_calls);
+extern int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __blocking_notifier_call_chain(struct blocking_notifier_head *,
-	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
-extern int raw_notifier_call_chain(struct raw_notifier_head *,
+extern int __blocking_notifier_call_chain(struct blocking_notifier_head *nh,
+	unsigned long val, void *v, int nr_to_call, int *nr_calls);
+extern int raw_notifier_call_chain(struct raw_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __raw_notifier_call_chain(struct raw_notifier_head *,
-	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
-extern int srcu_notifier_call_chain(struct srcu_notifier_head *,
+extern int __raw_notifier_call_chain(struct raw_notifier_head *nh,
+	unsigned long val, void *v, int nr_to_call, int *nr_calls);
+extern int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __srcu_notifier_call_chain(struct srcu_notifier_head *,
-	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
+extern int __srcu_notifier_call_chain(struct srcu_notifier_head *nh,
+	unsigned long val, void *v, int nr_to_call, int *nr_calls);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
