Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966646AbWKOFA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966646AbWKOFA3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 00:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966645AbWKOFA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 00:00:28 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:20967 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S966646AbWKOFA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 00:00:27 -0500
Date: Wed, 15 Nov 2006 10:29:33 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ego@in.ibm.com, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, vatsa@in.ibm.com, dipankar@in.ibm.com,
       davej@redhat.com, mingo@elte.hu, kiran@scalex86.org
Subject: Re: [PATCH 1/4] Extend notifier_call_chain to count nr_calls made.
Message-ID: <20061115045933.GA7207@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061114121832.GA31787@in.ibm.com> <20061114122050.GB31787@in.ibm.com> <20061114101806.a14ef7b7.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114101806.a14ef7b7.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 10:18:06AM -0800, Randy Dunlap wrote:
> On Tue, 14 Nov 2006 17:50:51 +0530 Gautham R Shenoy wrote:
> 
> > Provide notifier_call_chain with an option to call only a specified number of 
> > notifiers and also record the number of call to notifiers made.
> > 
> > The need for this enhancement was identified in the post entitled 
> > "Slab - Eliminate lock_cpu_hotplug from slab" 
> > (http://lkml.org/lkml/2006/10/28/92) by Ravikiran G Thirumalai and 
> > Andrew Morton.
> > 
> > This patch adds two additional parameters to notifier_call_chain API namely 
> >  - int nr_to_calls : Number of notifier_functions to be called. 
> >  		     The don't care value is -1.
> > 
> >  - unsigned int *nr_calls : Records the total number of notifier_funtions 
> > 			    called by notifier_call_chain. The don't care
> > 			    value is NULL.
> 
> Those could (should?) be the same data type.

Whoops! Yes, they should be the same. 
I was trying to solve this problem with only one parameter 
(which we can, but the signature would look very confusing) and was
using the unsigned int* there. Will change it to int *. 
Thanks for pointing that out.
> 
> > Credit : Andrew Morton <akpm@osdl.org> 
> > Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
> > 
> > --
> >  include/linux/notifier.h |    8 +++
> >  kernel/sys.c             |   97 +++++++++++++++++++++++++++++++++++++++-------- 2 files changed, 89 insertions(+), 16 deletions(-)
> > 
> > Index: hotplug/kernel/sys.c
> > ===================================================================
> > --- hotplug.orig/kernel/sys.c
> > +++ hotplug/kernel/sys.c
> > @@ -134,19 +134,41 @@ static int notifier_chain_unregister(str
> >  	return -ENOENT;
> >  }
> >  
> > +/*
> > + * notifier_call_chain - Informs the registered notifiers about an event.
> > + *
> > + *	@nl:		Pointer to head of the blocking notifier chain
> > + *	@val:		Value passed unmodified to notifier function
> > + *	@v:		Pointer passed unmodified to notifier function
> > + *	@nr_to_call:	Number of notifier functions to be called. Don't care
> > + *		     	value of this parameter is -1.
> > + *	@nr_calls:	Records the number of notifications sent. Don't care
> > + *		   	value of this field is NULL.
> > + *
> > + * 	RETURN VALUE:	notifier_call_chain returns the value returned by the
> > + *			last notifier function called.
> > + */
> 
> You can make that comment block be kernel-doc format by using
> /**
> as the comment introduction and removing the blank line after the
> function name & short description.

Will do that. But out of curiousity, do the comments of even static functions
get reflected in kernel doc ? :?

> 
> >  static int __kprobes notifier_call_chain(struct notifier_block **nl,
> > -		unsigned long val, void *v)
> > +					unsigned long val, void *v,
> > +					int nr_to_call,	unsigned int *nr_calls)
> >  {
> >  	int ret = NOTIFY_DONE;
> >  	struct notifier_block *nb, *next_nb;
> ...
> >  }
> > @@ -205,10 +227,13 @@ int atomic_notifier_chain_unregister(str
> >  EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
> >  
> >  /**
> > - *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
> > + *	__atomic_notifier_call_chain - Call functions in an atomic notifier
> > + *				       chain
> 
> Don't break the short function description line; kernel-doc does not
> support that.

Ok. Didn't know that. Will correct it.

> 
> >   *	@nh: Pointer to head of the atomic notifier chain

[snip!]

> > Index: hotplug/include/linux/notifier.h
> > ===================================================================
> > --- hotplug.orig/include/linux/notifier.h
> > +++ hotplug/include/linux/notifier.h
> > @@ -132,12 +132,20 @@ extern int srcu_notifier_chain_unregiste
> >  
> >  extern int atomic_notifier_call_chain(struct atomic_notifier_head *,
> >  		unsigned long val, void *v);
> > +extern int __atomic_notifier_call_chain(struct atomic_notifier_head *,
> 
> While you are changing these lines, please put a prototype parameter
> name for all parameters; i.e., add something like "notifier" 
> or "nh" after the '*' on all of these.
>

Yup. Will do.

 
> ---
> ~Randy

thanks,
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
