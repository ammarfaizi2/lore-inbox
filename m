Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966882AbWKUAeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966882AbWKUAeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965978AbWKUAeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:34:37 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:55961 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966882AbWKUAeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:34:36 -0500
Date: Mon, 20 Nov 2006 16:34:32 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] WorkStruct: Merge the pending bit into the wq_data
 pointer
Message-Id: <20061120163432.4824ffe7.randy.dunlap@oracle.com>
In-Reply-To: <20061120142720.12685.79394.stgit@warthog.cambridge.redhat.com>
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
	<20061120142720.12685.79394.stgit@warthog.cambridge.redhat.com>
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

On Mon, 20 Nov 2006 14:27:20 +0000 David Howells wrote:

> Reclaim a word from the size of the work_struct by folding the pending bit and
> the wq_data pointer together.  This shouldn't cause misalignment problems as
> all pointers should be at least 4-byte aligned.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  drivers/block/floppy.c    |    4 ++--
>  include/linux/workqueue.h |   19 +++++++++++++++----
>  kernel/workqueue.c        |   41 ++++++++++++++++++++++++++++++++---------
>  3 files changed, 49 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 0d5bbd4..67e6a7f 100644
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

Does 'T' mean true?  I think Linus's comment applies here also.

> +#define WORK_STRUCT_FLAG_MASK (3UL)
> +#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
>  	struct list_head entry;
>  	work_func_t func;
>  	void *data;
> -	void *wq_data;
>  };
>  
>  struct dwork_struct {

---
~Randy
