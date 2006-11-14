Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966253AbWKNSSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966253AbWKNSSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966256AbWKNSSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:18:51 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:41633 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966253AbWKNSSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:18:50 -0500
Date: Tue, 14 Nov 2006 10:18:06 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: ego@in.ibm.com
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       vatsa@in.ibm.com, dipankar@in.ibm.com, davej@redhat.com, mingo@elte.hu,
       kiran@scalex86.org
Subject: Re: [PATCH 1/4] Extend notifier_call_chain to count nr_calls made.
Message-Id: <20061114101806.a14ef7b7.randy.dunlap@oracle.com>
In-Reply-To: <20061114122050.GB31787@in.ibm.com>
References: <20061114121832.GA31787@in.ibm.com>
	<20061114122050.GB31787@in.ibm.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 17:50:51 +0530 Gautham R Shenoy wrote:

> Provide notifier_call_chain with an option to call only a specified number of 
> notifiers and also record the number of call to notifiers made.
> 
> The need for this enhancement was identified in the post entitled 
> "Slab - Eliminate lock_cpu_hotplug from slab" 
> (http://lkml.org/lkml/2006/10/28/92) by Ravikiran G Thirumalai and 
> Andrew Morton.
> 
> This patch adds two additional parameters to notifier_call_chain API namely 
>  - int nr_to_calls : Number of notifier_functions to be called. 
>  		     The don't care value is -1.
> 
>  - unsigned int *nr_calls : Records the total number of notifier_funtions 
> 			    called by notifier_call_chain. The don't care
> 			    value is NULL.

Those could (should?) be the same data type.

> Credit : Andrew Morton <akpm@osdl.org> 
> Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
> 
> --
>  include/linux/notifier.h |    8 +++
>  kernel/sys.c             |   97 +++++++++++++++++++++++++++++++++++++++-------- 2 files changed, 89 insertions(+), 16 deletions(-)
> 
> Index: hotplug/kernel/sys.c
> ===================================================================
> --- hotplug.orig/kernel/sys.c
> +++ hotplug/kernel/sys.c
> @@ -134,19 +134,41 @@ static int notifier_chain_unregister(str
>  	return -ENOENT;
>  }
>  
> +/*
> + * notifier_call_chain - Informs the registered notifiers about an event.
> + *
> + *	@nl:		Pointer to head of the blocking notifier chain
> + *	@val:		Value passed unmodified to notifier function
> + *	@v:		Pointer passed unmodified to notifier function
> + *	@nr_to_call:	Number of notifier functions to be called. Don't care
> + *		     	value of this parameter is -1.
> + *	@nr_calls:	Records the number of notifications sent. Don't care
> + *		   	value of this field is NULL.
> + *
> + * 	RETURN VALUE:	notifier_call_chain returns the value returned by the
> + *			last notifier function called.
> + */

You can make that comment block be kernel-doc format by using
/**
as the comment introduction and removing the blank line after the
function name & short description.

>  static int __kprobes notifier_call_chain(struct notifier_block **nl,
> -		unsigned long val, void *v)
> +					unsigned long val, void *v,
> +					int nr_to_call,	unsigned int *nr_calls)
>  {
>  	int ret = NOTIFY_DONE;
>  	struct notifier_block *nb, *next_nb;
...
>  }
> @@ -205,10 +227,13 @@ int atomic_notifier_chain_unregister(str
>  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
>  
>  /**
> - *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
> + *	__atomic_notifier_call_chain - Call functions in an atomic notifier
> + *				       chain

Don't break the short function description line; kernel-doc does not
support that.

>   *	@nh: Pointer to head of the atomic notifier chain
>   *	@val: Value passed unmodified to notifier function
>   *	@v: Pointer passed unmodified to notifier function
> + *	@nr_to_call: See the comment for notifier_call_chain.
> + *	@nr_calls: See the comment for notifier_call_chain.
>   *
>   *	Calls each function in a notifier chain in turn.  The functions
>   *	run in an atomic context, so they must not block.
> @@ -222,19 +247,27 @@ EXPORT_SYMBOL_GPL(atomic_notifier_chain_
>   *	of the last notifier function called.
>   */
>   
> -int __kprobes atomic_notifier_call_chain(struct atomic_notifier_head *nh,
> -		unsigned long val, void *v)
> +int __kprobes __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
> +					unsigned long val, void *v,
> +					int nr_to_call, unsigned int *nr_calls)
>  {
...
>  }
>  
> -EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
> +EXPORT_SYMBOL_GPL(__atomic_notifier_call_chain);
>  
> +int __kprobes atomic_notifier_call_chain(struct atomic_notifier_head *nh,
> +		unsigned long val, void *v)
> +{
> +	return __atomic_notifier_call_chain(nh, val, v, -1, NULL);
> +}
> +
> +EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
>  /*
>   *	Blocking notifier chain routines.  All access to the chain is
>   *	synchronized by an rwsem.
> @@ -304,10 +337,13 @@ int blocking_notifier_chain_unregister(s
>  EXPORT_SYMBOL_GPL(blocking_notifier_chain_unregister);
>  
>  /**
> - *	blocking_notifier_call_chain - Call functions in a blocking notifier chain
> + *	__blocking_notifier_call_chain - Call functions in a blocking notifier
> + *					 chain

kernel-doc requires that the function description fit on one source line,
so don't break it (even if it is > 80 columns; yes, I know it needs to be
fixed)

>   *	@nh: Pointer to head of the blocking notifier chain
>   *	@val: Value passed unmodified to notifier function
>   *	@v: Pointer passed unmodified to notifier function
> + *	@nr_to_call: See comment for notifier_call_chain.
> + *	@nr_calls: See comment for notifier_call_chain.
>   *
>   *	Calls each function in a notifier chain in turn.  The functions
>   *	run in a process context, so they are allowed to block.

> Index: hotplug/include/linux/notifier.h
> ===================================================================
> --- hotplug.orig/include/linux/notifier.h
> +++ hotplug/include/linux/notifier.h
> @@ -132,12 +132,20 @@ extern int srcu_notifier_chain_unregiste
>  
>  extern int atomic_notifier_call_chain(struct atomic_notifier_head *,
>  		unsigned long val, void *v);
> +extern int __atomic_notifier_call_chain(struct atomic_notifier_head *,

While you are changing these lines, please put a prototype parameter
name for all parameters; i.e., add something like "notifier" 
or "nh" after the '*' on all of these.

> +	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
>  extern int blocking_notifier_call_chain(struct blocking_notifier_head *,
>  		unsigned long val, void *v);
> +extern int __blocking_notifier_call_chain(struct blocking_notifier_head *,
> +	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
>  extern int raw_notifier_call_chain(struct raw_notifier_head *,
>  		unsigned long val, void *v);
> +extern int __raw_notifier_call_chain(struct raw_notifier_head *,
> +	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
>  extern int srcu_notifier_call_chain(struct srcu_notifier_head *,
>  		unsigned long val, void *v);
> +extern int __srcu_notifier_call_chain(struct srcu_notifier_head *,
> +	unsigned long val, void *v, int nr_to_call, unsigned int *nr_calls);
>  
>  #define NOTIFY_DONE		0x0000		/* Don't care */
>  #define NOTIFY_OK		0x0001		/* Suits me */
> -- 

---
~Randy
