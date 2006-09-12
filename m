Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWILWxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWILWxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWILWxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:53:34 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:36154 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932345AbWILWxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:53:33 -0400
Message-ID: <45073A35.10600@oracle.com>
Date: Tue, 12 Sep 2006 15:52:37 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
CC: linux-kernel@vger.kernel.org, linux-aio@kvack.org, drepper@redhat.com,
       suparna@in.ibm.com, pbadari@us.ibm.com, hch@infradead.org,
       johnpol@2ka.mipt.ru, davem@davemloft.net, Andrew Morton <akpm@osdl.org>
Subject: Re: [Resend PATCH AIO 1/2] Add AIO completion notification
References: <20060912094443.4a7b1c9a@frecb000686>
In-Reply-To: <20060912094443.4a7b1c9a@frecb000686>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>                       AIO completion notification

Thanks for sending this again.

>   The current 2.6 kernel does not support notification of user space via
> an RT signal upon an asynchronous IO completion. The POSIX specification
> states that when an AIO request completes, a signal can be delivered to
> the application as notification.

Does it say anything about the reliability of that signal delivery?  The
current implementation lets IO submission succeed but signal delivery
fail and that makes me nervous.  What are the API design goals here?  If
I missed some previous discussion could we have them summarized in a
comment above aio_send_signal() ?  More inline..

> +static void aio_send_signal(struct aio_notify *notify)
> +{
> +	struct siginfo info;

That's pretty big to be putting on the stack down under aio_complete()
which itself is called from block -> fs completion handlers.  It's a
path with pretty strong stack pressure.  It looks like we only use a
fraction of the struct, too, so can we rework the signal delivery code a
little to allow us to specify our inputs more efficiently?  I guess it's
not a big deal, but it'd be nice to get right if we can.

> +	info.si_code = SI_ASYNCIO;

It looks like USB (usbfs?  urb mumble something?) is already using
SI_ASYNCIO.  Is that a problem?

> +	if (notify->notify & SIGEV_THREAD_ID)
> +		ret = specific_send_sig_info(notify->signo, &info, p);
> +	else
> +		ret = __group_send_sig_info(notify->signo, &info, p);
> +
> +
> +	spin_unlock_irqrestore(&p->sighand->siglock, flags);
> +
> +	if (ret)
> +		printk(KERN_DEBUG "aio_send_signal: failed to send signal %d to %d\n",
> +		       notify->signo, notify->pid);

It looks like this is trivial to make fail if one submits more
operations than the RLIMIT_SIGPENDING rlimit will allow queued signals
for.  So we definitely don't want a printk that the user can generate.

This is where I'm nervous about what promises we've made about signal
delivery back at submit time :).  If the posix API allows lossy delivery
then we're OK.

And it can fail if delivery can't allocate a struct sigqueue.  I wonder
if we should allocate one at submit time and hang it off the iocb to be
used at completion.  It's just a little struct with a list_head.

> +static struct task_struct * good_sigevent(sigevent_t * event)

This is lifted directly from kernel/posix-timers.c, including the lack
of any indication that it has to be called with the tasklist_lock held
'cause it calls find_task_by_pid().  If we're making this a shared
notion lets put it somewhere that both posix-timers.c and aio.c can get
at.  kernel/signal.c, presumably?

> +	if (!access_ok(VERIFY_READ, user_event, sizeof(struct sigevent)))
> +		return -EFAULT;

You don't need this access_ok(), I don't think.  copy_from_user() should
return non-zero if something goes wrong.

> +	if (copy_from_user(&event, user_event, sizeof (event)))
> +		return -EFAULT;

sigevent is chock-full of members that need compat help when 32bit
userspace hands it to a 64bit kernel.  See compat_sys_timer_create() ->
get_compat_sigevent().

I'm not sure how best to handle this.  It'd be pretty gross to allocate
compat copies of every sigevent on the stack like compat_sys_io_submit()
seems to do for the 32bit iocb pointers.  I imagine you'll want to
conditionally call get_compat_sigevent() for each sigevent somehow.

Or push the problem to userspace by pointing from the iocb to a special
case sigevent with fixed width notify, signo, and value.

None of those options seem thrilling :/.

> +static void __aio_write_evt(struct kioctx *ctx, struct io_event *event)

Making this its own function seems to be unrelated to the completion
signaling work.  Please drop it from the patch so that we don't have to
audit it to make sure that code motion didn't mess something up.

- z
