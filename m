Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTGKO75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTGKO7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:59:46 -0400
Received: from waste.org ([209.173.204.2]:29667 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262931AbTGKO73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:59:29 -0400
Date: Fri, 11 Jul 2003 10:13:52 -0500
From: Matt Mackall <mpm@selenic.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: PATCH: seq_file interface to provide large data chunks
Message-ID: <20030711151352.GM27280@waste.org>
References: <3F0D217B.4040900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0D217B.4040900@intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 11:19:07AM +0300, Vladimir Kondratiev wrote:
> seq_file interface, as it exist in last official kernel, never provides 
> more then one page for each 'read' call. Old read_proc_t did loop to 
> fill more than one page.
> 
> Following patch against 2.4.21 fixes seq_file to provide more than one 
> page if user requests it.
> Many programs do read(large_buffer) once, instead of looping while 
> read()>0. They work wrong with seq_file. Also, one may expect read() to 
> provide whole information atomically (OK, relatively to other process 
> context stuff).
> This patch loops over while some space remains in user provided buffer.
> 
> I am not subscribed to lkml, thus please cc: me (Vladimir Kondratiev 
> <vladimir.kondratiev@intel.com>) explicitly.
> 
> +++ linux/fs/seq_file.c    2003-07-10 10:47:53.000000000 +0300
> @@ -55,6 +55,7 @@
>         return -EPIPE;
> 
>     down(&m->sem);
> +Again:
>     /* grab buffer if we didn't have one */
>     if (!m->buf) {
>         m->buf = kmalloc(m->size = PAGE_SIZE, GFP_KERNEL);
> @@ -123,11 +124,14 @@
>         goto Efault;
>     copied += n;
>     m->count -= n;
> +    size -= n;
> +    buf += n;
>     if (m->count)
>         m->from = n;
>     else
>         pos++;
>     m->index = pos;
> +    goto Again;
> Done:
>     if (!copied)
>         copied = err;

This patch looks rather tab damaged.

I think it's problematic in that it can hold the semaphore for an
unbounded amount of time.

I'd suggest dropping and acquiring the semaphore each time through the
loop, but then you get into a situation where a second process can
cause the returned results to no longer be coherent. Since we'd no
longer have a way to get single results, this'd be bad.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
