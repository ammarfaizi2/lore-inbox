Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVAUW2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVAUW2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVAUW0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:26:05 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:9197 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262581AbVAUWXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:23:36 -0500
Date: Fri, 21 Jan 2005 23:23:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41F0A0A2.1010109@opersys.com>
Message-ID: <Pine.LNX.4.61.0501211754110.30794@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
 <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home>
 <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home>
 <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home>
 <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home>
 <41EC2DCA.50904@opersys.com> <Pine.LNX.4.61.0501172323310.30794@scrub.home>
 <41EC8AA2.1030000@opersys.com> <Pine.LNX.4.61.0501181359250.30794@scrub.home>
 <41F0A0A2.1010109@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Jan 2005, Karim Yaghmour wrote:

> I should have avoided earlier confusing the use of a certain type of
> relayfs channel for a given purpose (i.e. LTT should not necessarily
> depend on the managed mode.) I believe that there is a need for
> more than one mode in relayfs independently of LTT. There are users
> who want to be able to manage the data in a buffer (by manage I mean:
> receive notification of important buffer events, be able to insert
> important data at boundaries, etc.), and there are users who just
> want to dump as much information as possible in as fast a way as
> possible without having to deal with non-essential codepaths.

Well, let's concentrate for a moment on the last thing and check later 
if and how they fit into relayfs. Since ltt will be first main user, let's 
optimize it for this.
Also since relayfs is intended for large, fast data transfers, per cpu 
buffers are pretty much always required, so it would make sense to leave 
this to relayfs (less to get wrong for the client).

> looking at this code:

I have to modify it a little (only the if (!buffer) part is new):

	cpu = get_cpu();
	buffer = relay_get_buffer(chan, cpu);
	while(1) {
		offset = local_add_return(buffer->offset, length);
		if (likely(offset + length <= buffer->size))
			break;
		buffer = relay_switch_buffer(chan, buffer, offset);
		if (!buffer) {
			put_cpu();
			return;
		}
	}
	memcpy(buffer->data + offset, data, length);
	put_cpu();

This has a very short fast path and I need very good reasons to change/add 
anything here. OTOH the slow path with relay_switch_buffer() is less 
critical and still leaves a lot of flexibility.

> 1) get_cpu() and put_cpu() won't do. You need to outright disable
> interrupts because you may be called from an interrupt handler.

Look closer, it's already interrupt safe, the synchronization for the 
buffer switch is left to relay_switch_buffer().

> 3) I'm unclear about the need for local_add_return(), why not
> just:
> 	if (likely(buffer->offset + length <= buffer->size)
> In any case, here's what we do in relay_write():
> 	write_pos = relay_reserve(rchan, count, &reserve_code, &interrupting);

Ok, let's take a closer look at the fast path of relay_write (via 
relay_managed.c):

> 	rchan_get(rchan);

This is not needed, it's the responsibility of the client to keep a 
reference to the channel. A synchronize_kernel() is enough to get rid of 
current users of the channel on other cpus.

> 	relay_lock_channel(rchan, flags);

what becomes:

>	FLAGS = 0;
>	if (RCHAN->flags & RELAY_USAGE_SMP) local_irq_save(FLAGS);
>	else spin_lock_irqsave(&(RCHAN)->mode.managed.lock, FLAGS);

This adds a conditional and is not really needed. Above shows how to make 
it interrupt safe and if the clients wants to reuse the same buffer, leave 
the locking to the client.

> 	write_pos = relay_reserve(rchan, count, &reserve_code, &interrupting);

what becomes:

> 	if (rchan == NULL) ...

Is this really needed?

> 	if (slot_len >= rchan->buf_size) ...

You can leave it to caller to check for this, a BUG_ON should be enough 
here.

>	if (rchan->initialized == 0) ...

Does this really have to be in the fast path?

> 	if (in_progress_event_size(rchan)) ...

What's the point of this? You already disable interrupts, so how can 
anything else be in progress?

> 	if (cur_write_pos(rchan) + slot_len > write_limit(rchan)) ...

Ok. This leads to the slow path and not interesting right now.

> 	if (likely(write_pos != NULL)) {

After 7 conditions we finally have a valid write position (and that's 
without ltt).

> 	relay_write_direct(write_pos, data_ptr, count);

If write_pos is just a normal memory pointer, why not also just use 
memcpy?

> 	relay_commit(rchan, write_pos, count, reserve_code, interrupting);

what becomes:

> 	if (rchan == NULL)
> 		return;

Hopefully no comment needed.

> 	if (interrupting) ...

Same comment as above for in_progress_event_size().

> 	if (deliver) ...
> 	...
> 	if (deliver &&  waitqueue_active(&rchan->mmap_read_wait))

Why is that hook needed here? Why can't this be done by the client?
A buffer switch notification can be done somewhere else.

> 	relay_unlock_channel(rchan, flags);
> 	rchan_put(rchan);

Same comment as above.

That's quite a lot of code with at least 14 conditions (or 13 conditions 
too much) and this is just relayfs.

> The difference between these modes is akin the
> difference between GFP_KERNEL, GFP_ATOMIC, GFP_USER, etc.: same API,
> different underlying functionality.

That's not always true, where perfomance matters we provide different 
functions (e.g. spinlocks), so having an alternative version of 
relay_write is a possibility (although I'd like to see the user first).

bye, Roman
