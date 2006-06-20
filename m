Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWFTF2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWFTF2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWFTF2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:28:55 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:12657 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932497AbWFTF2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:28:54 -0400
Message-ID: <44978793.8070109@bigpond.net.au>
Date: Tue, 20 Jun 2006 15:28:51 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH 09/11] Task watchers:  Add support for per-task watchers
References: <20060613235122.130021000@localhost.localdomain> <1150242901.21787.149.camel@stark>
In-Reply-To: <1150242901.21787.149.camel@stark>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 20 Jun 2006 05:28:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> This introduces a second, per-task, blocking notifier chain. The per-task
> chain offers watchers the chance to register with a specific task nstead of
> all tasks. It also allows the watcher to associate a block of data with the task
> by wrapping the notifier block using containerof().
> 
> Both the global, all-tasks chain and the per-task chain are called from the samefunction. The two types of chains share the same set of notification
> values, however registration functions and the registered notifier blocks must
> be separate.
> 
> These notifiers are only safe if notifier blocks are registered with the current
> task while in the context of the current task. This ensures that there are no
> races between registration, unregistration, and notification.
> 
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> Cc: Jes Sorensen <jes@sgi.com>
> Cc: Chandra S. Seetharaman <sekharan@us.ibm.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
[bits deleted]

> Index: linux-2.6.17-rc6-mm2/kernel/sys.c
> ===================================================================
> --- linux-2.6.17-rc6-mm2.orig/kernel/sys.c
> +++ linux-2.6.17-rc6-mm2/kernel/sys.c
> @@ -450,13 +450,41 @@ int unregister_task_watcher(struct notif
>  	return blocking_notifier_chain_unregister(&task_watchers, nb);
>  }
>  
>  EXPORT_SYMBOL_GPL(unregister_task_watcher);
>  
> +static inline int notify_per_task_watchers(unsigned int val,
> +					   struct task_struct *task)
> +{
> +	if (get_watch_event(val) != WATCH_TASK_INIT)
> +		return raw_notifier_call_chain(&task->notify, val, task);
> +	RAW_INIT_NOTIFIER_HEAD(&task->notify);
> +	if (task->real_parent)
> +		return raw_notifier_call_chain(&task->real_parent->notify,
> +		   			       val, task);
> +}

It's possible for this task to exit without returning a result.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
