Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTE0Of4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbTE0Of4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:35:56 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:31376 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S263654AbTE0Ofl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:35:41 -0400
Message-ID: <3ED37AD5.7020607@acm.org>
Date: Tue, 27 May 2003 09:48:53 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Registering for notifier chains in modules (was Linux 2.4.21-rc3
 - ipmi unresolved)
References: <20707.1054013443@kao2.melbourne.sgi.com>
In-Reply-To: <20707.1054013443@kao2.melbourne.sgi.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010904080200040004060407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010904080200040004060407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Keith Owens wrote:

>On Mon, 26 May 2003 23:45:39 -0500, 
>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>Keith Owens wrote:
>>    
>>
>>>>Why can't you have a module id in the notifier chain, and use a boolean
>>>>to tell if it is set, or something similar to that?  That way you could
>>>>mix them, if the bool is set then do the try_in_module_count thing, if
>>>>not then just call the function.  It does add some components to the
>>>>register structure, but that shouldn't hurt anything besides taking a
>>>>little more memory.
>>>>        
>>>>
>>>It is a change of API in a 2.4 kernel.  Not a good idea.
>>>
>>>      
>>>
>>Does adding a field to a structure (where the user does not have to do
>>anything with the
>>field) change the API?  That would be the only API change here.
>>    
>>
>
>The user does have to do something.  Every piece of code that calls
>notify_register has to set the new field to __THIS_MODULE.  WIthout
>that field being set, you are no better off, the race still exists.
>
Why?  The user doesn't have to set the field, you can let the
registration code do that.  I have attached a patch as an example.
(It also seems safer to get the next field from the notifier before
calling it, in case the called code removes itself and puts itself
on another list, or something like that, so I made that change).

-Corey

--------------010904080200040004060407
Content-Type: text/plain;
 name="module-notifier.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module-notifier.diff"

Index: include/linux/notifier.h
===================================================================
RCS file: /home/cvs/linux-2.4/include/linux/notifier.h,v
retrieving revision 1.3
diff -u -r1.3 notifier.h
--- include/linux/notifier.h	4 Aug 2002 00:02:49 -0000	1.3
+++ include/linux/notifier.h	27 May 2003 13:39:02 -0000
@@ -10,18 +10,22 @@
 #ifndef _LINUX_NOTIFIER_H
 #define _LINUX_NOTIFIER_H
 #include <linux/errno.h>
+#include <linux/module.h>
 
 struct notifier_block
 {
 	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
 	struct notifier_block *next;
 	int priority;
+
+	struct module *owner; /* NULL if not from a module */
 };
 
 
 #ifdef __KERNEL__
 
 extern int notifier_chain_register(struct notifier_block **list, struct notifier_block *n);
+extern int notifier_chain_register_module(struct notifier_block **list, struct notifier_block *n, struct module *owner);
 extern int notifier_chain_unregister(struct notifier_block **nl, struct notifier_block *n);
 extern int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v);
 
Index: kernel/sys.c
===================================================================
RCS file: /home/cvs/linux-2.4/kernel/sys.c,v
retrieving revision 1.14
diff -u -r1.14 sys.c
--- kernel/sys.c	9 May 2003 00:35:17 -0000	1.14
+++ kernel/sys.c	27 May 2003 13:39:03 -0000
@@ -71,16 +71,19 @@
 rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
 
 /**
- *	notifier_chain_register	- Add notifier to a notifier chain
+ *	notifier_chain_register_module - Add notifier to a notifier chain
+ *      for a module.
+ *
  *	@list: Pointer to root list pointer
  *	@n: New entry in notifier chain
+ *      @owner: The module that owns this notifier block
  *
  *	Adds a notifier to a notifier chain.
  *
  *	Currently always returns zero.
  */
  
-int notifier_chain_register(struct notifier_block **list, struct notifier_block *n)
+int notifier_chain_register_module(struct notifier_block **list, struct notifier_block *n, struct module *owner)
 {
 	write_lock(&notifier_lock);
 	while(*list)
@@ -90,12 +93,28 @@
 		list= &((*list)->next);
 	}
 	n->next = *list;
+	n->owner = owner;
 	*list=n;
 	write_unlock(&notifier_lock);
 	return 0;
 }
 
 /**
+ *	notifier_chain_register	- Add notifier to a notifier chain
+ *	@list: Pointer to root list pointer
+ *	@n: New entry in notifier chain
+ *
+ *	Adds a notifier to a notifier chain.
+ *
+ *	Currently always returns zero.
+ */
+ 
+int notifier_chain_register(struct notifier_block **list, struct notifier_block *n)
+{
+	return notifier_chain_register_module(list, n, NULL);
+}
+
+/**
  *	notifier_chain_unregister - Remove notifier from a notifier chain
  *	@nl: Pointer to root list pointer
  *	@n: New entry in notifier chain
@@ -128,7 +147,8 @@
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
  *
- *	Calls each function in a notifier chain in turn.
+ *	Calls each function in a notifier chain in turn.  If it is owned
+ *      by a module, increment that module's use count while in the call.
  *
  *	If the return value of the notifier can be and'd
  *	with %NOTIFY_STOP_MASK, then notifier_call_chain
@@ -142,15 +162,24 @@
 {
 	int ret=NOTIFY_DONE;
 	struct notifier_block *nb = *n;
+	struct notifier_block *next;
+	struct module *owner;
 
-	while(nb)
+	for (; nb; nb=next)
 	{
+		owner = nb->owner;
+		next = nb->next;
+		if ((owner) && (!try_inc_mod_count(owner)))
+			/* The module that owns us has ceased to
+                           exist, just go on. */
+			continue;
 		ret=nb->notifier_call(nb,val,v);
+		if (owner)
+			__MOD_DEC_USE_COUNT(owner);
 		if(ret&NOTIFY_STOP_MASK)
 		{
 			return ret;
 		}
-		nb=nb->next;
 	}
 	return ret;
 }

--------------010904080200040004060407--

