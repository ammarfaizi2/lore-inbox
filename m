Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVAQCcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVAQCcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 21:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVAQCcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 21:32:16 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:11406 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262669AbVAQCby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 21:31:54 -0500
Date: Mon, 17 Jan 2005 11:31:42 +0900 (JST)
From: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [PATCH] Restartable poll(2)
In-reply-to: <20050114.205214.74752151.maeda.naoaki@jp.fujitsu.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-id: <20050117.113142.41643336.maeda.naoaki@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7bit
References: <20050114.205214.74752151.maeda.naoaki@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does nobody think a system call is interrupted by SIGSTOP is
strange behaviour?

According to the man page, both of poll(2) and select(2) can be
interrupted by signals, but select(2) interrupted by SIGSTOP is
automatically restarted, and poll(2) isn't. 

If it is a specification of Linux, using job control or ptrace()
isn't safe because it changes the behaviour of target programs.

Following sample programs demonstrate the issue.

$ ./poll_test

[1]+  Stopped                 ./poll_test
$ fg
./poll_test
poll(): Interrupted system call
$
<-- poll() reteurns EINTR even if it is interrupted by SIGSTOP -->

$ ./select_test

[1]+  Stopped                 ./select_test
$ fg
./select_test

<-- select() is automatically restarted if it is interrupted by SIGSTOP -->

Thanks,
Naoaki Maeda

---- poll_test.c
#include <sys/poll.h>
#include <errno.h>

main()
{
	struct pollfd  pfd[1];
	int	retval;

	pfd[0].fd = 0;
	pfd[0].events = POLLIN;

	retval = poll (pfd, 1, 60*1000);		

	if (retval == -1)
		perror("poll()");
	else if (retval)
		printf("got data\n");
	else
		printf("No data entered\n");
}
----

---- select_test.c
#include <stdio.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

int
main(void) {

	fd_set rfds;
	struct timeval tv;
	int retval;

	FD_ZERO(&rfds);
	FD_SET(0, &rfds);

	tv.tv_sec = 60;
	tv.tv_usec = 0;

	retval = select(1, &rfds, NULL, NULL, &tv);

	if (retval == -1)
		perror("select()");
	else if (retval)
		printf("got data\n");
	else
		printf("No data entered\n");
}
----


From: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
Subject: [PATCH] Restartable poll(2)
Date: Fri, 14 Jan 2005 20:52:14 +0900 (JST)

> Hi,
> 
> There is an inconsistency between the behaviour of poll(2)
> and select(2) in terms of restartable. select(2) is restartable
> if it is interrupted by a signal, but poll(2) is not. 
> 
> I think it is not a good behaviour that poll(2) is interrupted by
> strace, gdb or job control, and returns EINTR .
> 
> This patch makes poll(2) restartable. Is it a sane idea?
> 
> Thanks,
> Maeda Naoaki
> 
> ---
> This patch makes poll(2) restartable in the face of signals.
> 
> Signed-off-by: Maeda Naoaki <maeda.naoaki@jp.fujitsu.com>
> ---
> 
>  linux-2.6.11-rc1-mm1-maeda/fs/select.c |  109 ++++++++++++++++++++++++++++++---
>  1 files changed, 102 insertions(+), 7 deletions(-)
> 
> diff -puN fs/select.c~poll_restart fs/select.c
> --- linux-2.6.11-rc1-mm1/fs/select.c~poll_restart	2005-01-14 18:09:28.703036795 +0900
> +++ linux-2.6.11-rc1-mm1-maeda/fs/select.c	2005-01-14 18:23:10.960839223 +0900
> @@ -432,12 +432,12 @@ static void do_pollfd(unsigned int num, 
>  }
>  
>  static int do_poll(unsigned int nfds,  struct poll_list *list,
> -			struct poll_wqueues *wait, long timeout)
> +			struct poll_wqueues *wait, long *timeout)
>  {
>  	int count = 0;
>  	poll_table* pt = &wait->pt;
>  
> -	if (!timeout)
> +	if (!*timeout)
>  		pt = NULL;
>   
>  	for (;;) {
> @@ -449,17 +449,104 @@ static int do_poll(unsigned int nfds,  s
>  			walk = walk->next;
>  		}
>  		pt = NULL;
> -		if (count || !timeout || signal_pending(current))
> +		if (count || !*timeout || signal_pending(current))
>  			break;
>  		count = wait->error;
>  		if (count)
>  			break;
> -		timeout = schedule_timeout(timeout);
> +		*timeout = schedule_timeout(*timeout);
>  	}
>  	__set_current_state(TASK_RUNNING);
>  	return count;
>  }
>  
> +static long sys_poll_restart(struct restart_block *restart)
> +{
> +	unsigned long expire = restart->arg0, now = jiffies;
> +	struct pollfd __user *ufds = (struct pollfd __user *)restart->arg1;
> +	unsigned int nfds = (unsigned int)restart->arg2;
> +	long timeout;
> +	struct poll_wqueues table;
> + 	int fdcount, err;
> + 	unsigned int i;
> +	struct poll_list *head;
> + 	struct poll_list *walk;
> +
> +	/* Sanity check on nfds was already done */
> +
> +	/* Did it expire while we handled signals? */
> +	if (!time_after(expire, now))
> +		timeout = 0;
> +	else /* Remaining timeout */
> +		timeout = expire - now; 
> +
> +	if (timeout) {
> +		/* Careful about overflow in the intermediate values */
> +		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
> +			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
> +		else /* Negative or overflow */
> +			timeout = MAX_SCHEDULE_TIMEOUT;
> +	}
> +
> +	poll_initwait(&table);
> +
> +	head = NULL;
> +	walk = NULL;
> +	i = nfds;
> +	err = -ENOMEM;
> +	while(i!=0) {
> +		struct poll_list *pp;
> +		pp = kmalloc(sizeof(struct poll_list)+
> +				sizeof(struct pollfd)*
> +				(i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i),
> +					GFP_KERNEL);
> +		if(pp==NULL)
> +			goto out_fds;
> +		pp->next=NULL;
> +		pp->len = (i>POLLFD_PER_PAGE?POLLFD_PER_PAGE:i);
> +		if (head == NULL)
> +			head = pp;
> +		else
> +			walk->next = pp;
> +
> +		walk = pp;
> +		if (copy_from_user(pp->entries, ufds + nfds-i, 
> +				sizeof(struct pollfd)*pp->len)) {
> +			err = -EFAULT;
> +			goto out_fds;
> +		}
> +		i -= pp->len;
> +	}
> +
> +	err = fdcount = do_poll(nfds, head, &table, &timeout);
> +	if (!fdcount && signal_pending(current))
> +		/* The 'restart' block is already filled in */
> +		err = -ERESTART_RESTARTBLOCK;
> +	if (err < 0)
> +		goto out_fds;
> +
> +	/* OK, now copy the revents fields back to user space. */
> +	walk = head;
> +	err = -EFAULT;
> +	while(walk != NULL) {
> +		struct pollfd *fds = walk->entries;
> +		if (copy_to_user(ufds, fds, sizeof(struct pollfd) * walk->len))
> +			goto out_fds;
> +		ufds += walk->len;
> +		walk = walk->next;
> +  	}
> +	err = fdcount;
> +out_fds:
> +	walk = head;
> +	while(walk!=NULL) {
> +		struct poll_list *pp = walk->next;
> +		kfree(walk);
> +		walk = pp;
> +	}
> +	poll_freewait(&table);
> +	return err;
> +}
> +
>  asmlinkage long sys_poll(struct pollfd __user * ufds, unsigned int nfds, long timeout)
>  {
>  	struct poll_wqueues table;
> @@ -467,6 +554,8 @@ asmlinkage long sys_poll(struct pollfd _
>   	unsigned int i;
>  	struct poll_list *head;
>   	struct poll_list *walk;
> +	struct restart_block *restart;
> +	struct pollfd __user *saved_ufds = ufds;
>  
>  	/* Do a sanity check on nfds ... */
>  	if (nfds > current->files->max_fdset && nfds > OPEN_MAX)
> @@ -510,9 +599,15 @@ asmlinkage long sys_poll(struct pollfd _
>  		i -= pp->len;
>  	}
>  
> -	err = fdcount = do_poll(nfds, head, &table, timeout);
> -	if (!fdcount && signal_pending(current))
> -		err = -EINTR;
> +	err = fdcount = do_poll(nfds, head, &table, &timeout);
> +	if (!fdcount && signal_pending(current)) {
> +		restart = &current_thread_info()->restart_block;
> +		restart->fn = sys_poll_restart;
> +		restart->arg0 = jiffies + timeout;
> +		restart->arg1 = (unsigned long) saved_ufds;
> +		restart->arg2 = (unsigned long) nfds; 
> +		err = -ERESTART_RESTARTBLOCK;
> +	}
>  	if (err < 0)
>  		goto out_fds;
>  
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
