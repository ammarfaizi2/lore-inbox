Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUD0W2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUD0W2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUD0W2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:28:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:21433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264377AbUD0W2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:28:33 -0400
Date: Tue, 27 Apr 2004 15:28:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
Message-ID: <20040427152830.C21045@build.pdx.osdl.net>
References: <Pine.SGI.4.53.0404261656230.591647@subway.americas.sgi.com> <20040426163955.X21045@build.pdx.osdl.net> <Pine.SGI.4.53.0404271546410.632984@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.53.0404271546410.632984@subway.americas.sgi.com>; from erikj@subway.americas.sgi.com on Tue, Apr 27, 2004 at 03:51:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Erik Jacobson (erikj@subway.americas.sgi.com) wrote:
> I didn't choose to change the macros at this time - however, I'm not against
> changing them either - I just haven't done it yet.

OK.  I still think it's a good idea for readability and type safety.

> On Mon, 26 Apr 2004, Chris Wright wrote:
> > This looks like it's just the infrastructure, i.e. nothing is using it.
> > It seems like PAGG could be done on top of CKRM (albeit, with more
> > code).  But if the goal is to do some basic accounting, scheduling, etc.
> > on a resource group, wouldn't CKRM be more generic?
> 
> Right.  A couple examples of things we have that use it are CSA
> (oss.sgi.com/csa) and job.  job provides inescapable job containers that
> are also used by csa.
> 
> But what I presented here was just the infrastructure as you said.
> 
> Patches for inescapable job containers ('job') are available on the pagg web
> site as well (oss.sgi.com/pagg).

OK, thanks, I'll take a look.

> > > +       char		*name;	/* Name Key - restricted to 32 characters */
> >
> > why the restriction?
> 
> I'm open to suggestions.  Right now, this is usually set to something like
> "job" or similar.  The max length is enforced by the module that makes use
> of pagg.  For example, with the job package:

Right, if it's a pointer, and you guarantee it's NULL terminated, then I
don't see the point.  Otherwise, strncmp() or something?

> I fixed the tasklist issue you were concerned about.  Again, I didn't address
> the macro issue at this moment.

Alright, see below.

> > This looks like it leaks the just alloc'd to_pagg.
> 
> I agree that it looks suspect but I think it's OK.
> 
> You're talking about the case where the pagg was allocated, but couldn't
> attach I assume.
> 
> The alloc_pagg function adds that allocated pagg to the pagg list.  In
> error_return, detach_pagg_list is called so this pagg should be freed then.

Yes, I see it now, thanks.  BTW, I see a common idiom here of:

 if (!list_empty) {
	list_for_each() {
	}

 }

Seems like mostly an empty optimization, since list_for_each essentially
does that list_empty() check, no?

> +unregister_pagg_hook(struct pagg_hook *pagg_hook_old)
> +{
<snip>
> +	down_write(&pagg_hook_list_sem);
<snip>
> +		read_lock(&tasklist_lock);
> +		for_each_process(task) {
> +			struct pagg *pagg = NULL;
> +
> +			get_task_struct(task); /* So the task doesn't vanish on us */
> +			read_unlock(&tasklist_lock);

dropped tasklist_lock, task could exit, and unlink and potentially drop the 
only other ref.

> +			read_lock_pagg_list(task);
> +			pagg = get_pagg(task, pagg_hook_old->name);
> +			put_task_struct(task);

and this could have totally freed the memory to task.

still looks unsafe to me.

> +			/* 
> +			 * We won't be accessing pagg's memory, just need
> +			 * to see if one existed - so we can release the task
> +			 * lock now.
> +			 */
> +			read_unlock_pagg_list(task);
> +			if (pagg) {
> +				up_write(&pagg_hook_list_sem);
> +				return -EBUSY;
> +			}
> +
> +			/* lock the task list again so we get a valid task in the loop */
> +			read_lock(&tasklist_lock);
> +		}
> +		read_unlock(&tasklist_lock);
> +		list_del_init(&pagg_hook->entry);
> +		up_write(&pagg_hook_list_sem);

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
