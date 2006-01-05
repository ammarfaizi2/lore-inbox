Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWAEBQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWAEBQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWAEBQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:16:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751108AbWAEBQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:16:21 -0500
Date: Wed, 4 Jan 2006 17:18:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Latchesar Ionkov <lucho@ionkov.net>
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH 3/3] v9fs: zero copy implementation
Message-Id: <20060104171813.44f7e408.akpm@osdl.org>
In-Reply-To: <20060105005731.GC27375@ionkov.net>
References: <20060105005731.GC27375@ionkov.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latchesar Ionkov <lucho@ionkov.net> wrote:
>
> Performance enhancement reducing the number of copies in the data and
> stat paths.
> 
> ...
> diff --git a/fs/9p/mux.c b/fs/9p/mux.c
> index 884fa75..e58c6ed 100644
> --- a/fs/9p/mux.c
> +++ b/fs/9p/mux.c
> @@ -35,8 +35,8 @@
>  #include "debug.h"
>  #include "v9fs.h"
>  #include "9p.h"
> -#include "transport.h"
>  #include "conv.h"
> +#include "transport.h"
>  #include "mux.h"
>  
>  #define NELEM(x) (sizeof(x) / sizeof((x)[0]))
> @@ -76,6 +76,7 @@ struct v9fs_mux_data {
>  	wait_queue_head_t equeue;
>  	struct list_head req_list;
>  	struct list_head unsent_req_list;
> +	struct v9fs_fcall *rcall;
>  	int rpos;
>  	char *rbuf;
>  	int wpos;
> @@ -103,11 +104,15 @@ struct v9fs_mux_rpc {
>  	wait_queue_head_t wqueue;
>  };
>  
> +extern int v9fs_errstr2errno(char *str, int len);
> +

Please don't put extern declarations in .c files.  This declaraton is
already in error.h so I suspect it can just be axed.

>  static int v9fs_poll_proc(void *);
>  static void v9fs_read_work(void *);
>  static void v9fs_write_work(void *);
>  static void v9fs_pollwait(struct file *filp, wait_queue_head_t * wait_address,
>  			  poll_table * p);
> +static u16 v9fs_mux_get_tag(struct v9fs_mux_data *);
> +static void v9fs_mux_put_tag(struct v9fs_mux_data *, u16);
>  
>  static DECLARE_MUTEX(v9fs_mux_task_lock);
>  static struct workqueue_struct *v9fs_mux_wq;
> @@ -168,8 +173,9 @@ static void v9fs_mux_poll_start(struct v
>  			if (v9fs_mux_poll_tasks[i].task == NULL) {
>  				vpt = &v9fs_mux_poll_tasks[i];
>  				dprintk(DEBUG_MUX, "create proc %p\n", vpt);
> -				vpt->task = kthread_create(v9fs_poll_proc, 
> -					vpt, "v9fs-poll");
> +				vpt->task =
> +				    kthread_create(v9fs_poll_proc, vpt,
> +						   "v9fs-poll");

What happens if kthread_create() fails?

>  	dprintk(DEBUG_VFS, " \n");
>  
> -	v9ses = kcalloc(1, sizeof(struct v9fs_session_info), GFP_KERNEL);
> +	v9ses = kmalloc(sizeof(struct v9fs_session_info), GFP_KERNEL);
>  	if (!v9ses)
>  		return ERR_PTR(-ENOMEM);
>  
> +	memset(v9ses, 0, sizeof(struct v9fs_session_info));

We have nice kzalloc() which does this.  (If/when this is changed, please
convert all of v9fs in one patch).


