Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755350AbWKVQcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbWKVQcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755351AbWKVQcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:32:23 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:41867 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1755350AbWKVQcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:32:22 -0500
Date: Wed, 22 Nov 2006 08:32:23 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] WorkStruct: Merge the pending bit into the wq_data
 pointer [try #2]
Message-Id: <20061122083223.6e0e5b76.randy.dunlap@oracle.com>
In-Reply-To: <20061122130229.24778.13876.stgit@warthog.cambridge.redhat.com>
References: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>
	<20061122130229.24778.13876.stgit@warthog.cambridge.redhat.com>
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

On Wed, 22 Nov 2006 13:02:29 +0000 David Howells wrote:

> Reclaim a word from the size of the work_struct by folding the pending bit and
> the wq_data pointer together.  This shouldn't cause misalignment problems as
> all pointers should be at least 4-byte aligned.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  drivers/block/floppy.c    |    4 ++--
>  include/linux/workqueue.h |   27 +++++++++++++++++++++++----
>  kernel/workqueue.c        |   41 ++++++++++++++++++++++++++++++++---------
>  3 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index cef40b2..ecc017d 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -14,11 +14,15 @@ struct workqueue_struct;
>  typedef void (*work_func_t)(void *data);
>  
>  struct work_struct {
> -	unsigned long pending;
> +	/* the first word is the work queue pointer and the pending flag
> +	 * rolled into one */
> +	unsigned long management;
> +#define WORK_STRUCT_PENDING 0		/* T if work item pending execution */

s/T/True/ # or whatever it means there

> +#define WORK_STRUCT_FLAG_MASK (3UL)
> +#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
>  	struct list_head entry;
>  	work_func_t func;
>  	void *data;
> -	void *wq_data;
>  };
>  
>  struct delayed_work {
> @@ -75,6 +79,21 @@ #define INIT_DELAYED_WORK(_work, _func, 
>  		init_timer(&(_work)->timer);			\
>  	} while (0)
>  
> +/**
> + * work_pending - Find out whether a work item is currently pending
> + * @work: The work item in question
> + */
> +#define work_pending(work) \
> +	test_bit(WORK_STRUCT_PENDING, &(work)->management)
> +
> +/**
> + * delayed_work_pending - Find out whether a delayable work item is currently
> + * pending

kernel-doc short function description needs to be on one line only.
If more description is needed, please put it after the parameter(s) list
and a "blank" ("*" only) line.

> + * @work: The work item in question
> + */
> +#define delayed_work_pending(work) \
> +	test_bit(WORK_STRUCT_PENDING, &(work)->work.management)
> +
>  
>  extern struct workqueue_struct *__create_workqueue(const char *name,
>  						    int singlethread);


---
~Randy
