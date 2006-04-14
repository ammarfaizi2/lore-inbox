Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWDNVVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWDNVVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWDNVVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:21:14 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:19676 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965174AbWDNVVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:21:12 -0400
Date: Fri, 14 Apr 2006 14:21:12 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Poll microoptimizations.
In-Reply-To: <20060414123118.0a8fb24c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0604141413260.21335@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0604132115290.29982@shell3.speakeasy.net>
 <20060414123118.0a8fb24c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, Andrew Morton wrote:

> Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> >
> > Patch to provide some microoptimizations for the poll() system call
> > implementation. The loop that traverses over the "struct pollfd" entries
> > was moved from do_pollfd() to its single caller do_poll(), so that
> > do_pollfd() no longer mucks around with the "count" and the "pt"
> > variables that should belong to do_poll() alone. This saves unnecessary
> > levels of indirection. Modifications were run tested.
> >
> >
> > diff -Npru linux-2.6.17-rc1/fs/select.c linux-new/fs/select.c
> > --- linux-2.6.17-rc1/fs/select.c	2006-04-12 20:31:54.000000000 -0700
> > +++ linux-new/fs/select.c	2006-04-13 18:54:14.000000000 -0700
> > @@ -544,37 +544,30 @@ struct poll_list {
> >
> >  #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
> >
> > -static void do_pollfd(unsigned int num, struct pollfd * fdpage,
> > -	poll_table ** pwait, int *count)
> > +static int do_pollfd(struct pollfd * pollfd, poll_table * pwait)
>
> Please omit the space after the asterisk:
>
> 	static int do_pollfd(struct pollfd *pollfd, poll_table *pwait)
>
> because it doesn't impart any information, it is sightly misleading, it
> wastes screen real-estate and we should be consistent.

Will do. For better or worse, I was following the original do_pollfd()
declaration, which had the spaces in there.

> >  {
> > -	int i;
> > +	unsigned int mask;
> > +	int fd;
> >
> > -	for (i = 0; i < num; i++) {
> > -		int fd;
> > -		unsigned int mask;
> > -		struct pollfd *fdp;
> > -
> > -		mask = 0;
> > -		fdp = fdpage+i;
> > -		fd = fdp->fd;
> > -		if (fd >= 0) {
> > -			int fput_needed;
> > -			struct file * file = fget_light(fd, &fput_needed);
> > -			mask = POLLNVAL;
> > -			if (file != NULL) {
> > -				mask = DEFAULT_POLLMASK;
> > -				if (file->f_op && file->f_op->poll)
> > -					mask = file->f_op->poll(file, *pwait);
> > -				mask &= fdp->events | POLLERR | POLLHUP;
> > -				fput_light(file, fput_needed);
> > -			}
> > -			if (mask) {
> > -				*pwait = NULL;
> > -				(*count)++;
> > -			}
> > +	mask = 0;
> > +	fd = pollfd->fd;
> > +	if (fd >= 0) {
> > +		int fput_needed;
> > +		struct file * file;
> > +
> > +		file = fget_light(fd, &fput_needed);
> > +		mask = POLLNVAL;
> > +		if (file != NULL) {
> > +			mask = DEFAULT_POLLMASK;
> > +			if (file->f_op && file->f_op->poll)
> > +				mask = file->f_op->poll(file, pwait);
> > +			mask &= pollfd->events | POLLERR | POLLHUP;
> > +			fput_light(file, fput_needed);
> >  		}
> > -		fdp->revents = mask;
> >  	}
> > +	pollfd->revents = mask;
> > +
> > +	return (mask != 0);
> >  }
>
> So do_poll_fd() returns either 0 or 1.

Correct. It returns true if an event was seen, false otherwise. Should I
stick a comment in front of the function saying this?

> >  static int do_poll(unsigned int nfds,  struct poll_list *list,
> > @@ -592,10 +585,19 @@ static int do_poll(unsigned int nfds,  s
> >  		long __timeout;
> >
> >  		set_current_state(TASK_INTERRUPTIBLE);
> > -		walk = list;
> > -		while(walk != NULL) {
> > -			do_pollfd( walk->len, walk->entries, &pt, &count);
> > -			walk = walk->next;
> > +		for (walk = list; walk != NULL; walk = walk->next) {
> > +			struct pollfd * pfd, * pfd_end;
> > +
> > +			pfd = walk->entries;
> > +			pfd_end = pfd + walk->len;
> > +			for (; pfd != pfd_end; pfd++) {
> > +				int ev;
> > +
> > +				ev = do_pollfd(pfd, pt);
>
> `ev' is either 0 or 1.

Correct.

> > +				count += ev;
> > +				ev--;
>
> `ev' is either -1 or 0.

Correct.

> > +				pt = (poll_table*)((unsigned long)pt & ev);
>
> So as long as the sign-extension works as we hope (which I think it will),
> `pt' is either unaltered or is NULL.

Correct - this mimicks the original logic exactly, which "kills" pt as
soon as a single event was seen. If I understand correctly, this was
done so that none of the following pollfd entries register themselves in
the poll_table, just to be immediately removed when the poll() syscall
terminates.

I can put in a comment to explain what the code is doing, or if you
think that the bitmasking itself is "yuk", then I can easily transform
the code into an explicit "if () {}" block. :)

> Yuk.  Sorry, no.

Thank you for the review. The comments above are easy to address. Do you
like the main concept behind the patch? Should I correct and resubmit?

- Vadim Lobanov
