Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966454AbWKTTRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966454AbWKTTRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966452AbWKTTRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:17:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966456AbWKTTRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:17:24 -0500
Date: Mon, 20 Nov 2006 11:17:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] WorkStruct: Shrink work_struct by two thirds
Message-Id: <20061120111712.5e399d12.akpm@osdl.org>
In-Reply-To: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
References: <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 14:27:13 +0000
David Howells <dhowells@redhat.com> wrote:

> The workqueue struct is huge, and this limits it's usefulness.  On a 64-bit
> architecture it's nearly 100 bytes in size, of which the timer_list is half.
> These patches shrink work_struct by 8 of the 12 words it ordinarily consumes.
> This is done by:
> 
>  (1) Splitting the timer out so that delayable work items are defined by a
>      separate structure which incorporates a basic work_struct and a timer.
> 
>  (2) Folding the pending bit and wq_data data together
> 
>  (3) Removing the private data.  This can almost always be derived from the
>      address of the work_struct using container_of() and the selection of the
>      work function.  For the cases where the container of the work_struct may
>      go away the moment the pending bit is cleared, it is made possible to
>      defer the release of the structure by deferring the clearing of the
>      pending bit.
> 
> 
> These patches reduce the size of the work_struct thusly:
> 
> 			#WORDS		32-bit arch	64-bit arch
> 			===============	===============	===============
> 	As is		12		48 bytes	96 bytes
> 	Non-delayable	4		16 bytes	32 bytes
> 	Delayable	10		40 bytes	80 bytes
> 
> I've looked through most of the usages of work_structs, and I think that
> probably fewer than half the work_structs used actually require delayability,
> and I'm not sure that it's absolutely necessary in all cases.

via this:

> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -17,6 +17,10 @@ struct work_struct {
>  	void (*func)(void *);
>  	void *data;
>  	void *wq_data;
> +};
> +
> +struct dwork_struct {
> +	struct work_struct work;
>  	struct timer_list timer;
>  };
>

Could we reduce the migration pain by leaving the work_struct as-is and
defining a new, leaner one and then incrementally migrating stuff over to
it?

struct work_struct_lite {
	unsigned long pending;
	struct list_head entry;
	void (*func)(void *);
	void *data;
	void *wq_data;
};

struct work_struct {
	struct work_struct_lite w;
	struct timer_list timer;
}


or even

struct work_struct {
	union {
		struct work_struct_lite w;
		struct {
			unsigned long pending;
			struct list_head entry;
			void (*func)(void *);
			void *data;
			void *wq_data;
		};
	}
	struct timer_list timer;
};


