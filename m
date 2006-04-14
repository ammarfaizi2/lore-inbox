Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWDNT3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWDNT3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 15:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWDNT3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 15:29:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751430AbWDNT3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 15:29:13 -0400
Date: Fri, 14 Apr 2006 12:31:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Poll microoptimizations.
Message-Id: <20060414123118.0a8fb24c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0604132115290.29982@shell3.speakeasy.net>
References: <Pine.LNX.4.58.0604132115290.29982@shell3.speakeasy.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov <vlobanov@speakeasy.net> wrote:
>
> Patch to provide some microoptimizations for the poll() system call
> implementation. The loop that traverses over the "struct pollfd" entries
> was moved from do_pollfd() to its single caller do_poll(), so that
> do_pollfd() no longer mucks around with the "count" and the "pt"
> variables that should belong to do_poll() alone. This saves unnecessary
> levels of indirection. Modifications were run tested.
> 
> 
> diff -Npru linux-2.6.17-rc1/fs/select.c linux-new/fs/select.c
> --- linux-2.6.17-rc1/fs/select.c	2006-04-12 20:31:54.000000000 -0700
> +++ linux-new/fs/select.c	2006-04-13 18:54:14.000000000 -0700
> @@ -544,37 +544,30 @@ struct poll_list {
> 
>  #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
> 
> -static void do_pollfd(unsigned int num, struct pollfd * fdpage,
> -	poll_table ** pwait, int *count)
> +static int do_pollfd(struct pollfd * pollfd, poll_table * pwait)

Please omit the space after the asterisk:

	static int do_pollfd(struct pollfd *pollfd, poll_table *pwait)

because it doesn't impart any information, it is sightly misleading, it
wastes screen real-estate and we should be consistent.

>  {
> -	int i;
> +	unsigned int mask;
> +	int fd;
> 
> -	for (i = 0; i < num; i++) {
> -		int fd;
> -		unsigned int mask;
> -		struct pollfd *fdp;
> -
> -		mask = 0;
> -		fdp = fdpage+i;
> -		fd = fdp->fd;
> -		if (fd >= 0) {
> -			int fput_needed;
> -			struct file * file = fget_light(fd, &fput_needed);
> -			mask = POLLNVAL;
> -			if (file != NULL) {
> -				mask = DEFAULT_POLLMASK;
> -				if (file->f_op && file->f_op->poll)
> -					mask = file->f_op->poll(file, *pwait);
> -				mask &= fdp->events | POLLERR | POLLHUP;
> -				fput_light(file, fput_needed);
> -			}
> -			if (mask) {
> -				*pwait = NULL;
> -				(*count)++;
> -			}
> +	mask = 0;
> +	fd = pollfd->fd;
> +	if (fd >= 0) {
> +		int fput_needed;
> +		struct file * file;
> +
> +		file = fget_light(fd, &fput_needed);
> +		mask = POLLNVAL;
> +		if (file != NULL) {
> +			mask = DEFAULT_POLLMASK;
> +			if (file->f_op && file->f_op->poll)
> +				mask = file->f_op->poll(file, pwait);
> +			mask &= pollfd->events | POLLERR | POLLHUP;
> +			fput_light(file, fput_needed);
>  		}
> -		fdp->revents = mask;
>  	}
> +	pollfd->revents = mask;
> +
> +	return (mask != 0);
>  }

So do_poll_fd() returns either 0 or 1.

>  static int do_poll(unsigned int nfds,  struct poll_list *list,
> @@ -592,10 +585,19 @@ static int do_poll(unsigned int nfds,  s
>  		long __timeout;
> 
>  		set_current_state(TASK_INTERRUPTIBLE);
> -		walk = list;
> -		while(walk != NULL) {
> -			do_pollfd( walk->len, walk->entries, &pt, &count);
> -			walk = walk->next;
> +		for (walk = list; walk != NULL; walk = walk->next) {
> +			struct pollfd * pfd, * pfd_end;
> +
> +			pfd = walk->entries;
> +			pfd_end = pfd + walk->len;
> +			for (; pfd != pfd_end; pfd++) {
> +				int ev;
> +
> +				ev = do_pollfd(pfd, pt);

`ev' is either 0 or 1.

> +				count += ev;
> +				ev--;

`ev' is either -1 or 0.

> +				pt = (poll_table*)((unsigned long)pt & ev);

So as long as the sign-extension works as we hope (which I think it will),
`pt' is either unaltered or is NULL.

Yuk.  Sorry, no.

