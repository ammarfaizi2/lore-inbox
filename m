Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752741AbWKBIt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbWKBIt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbWKBIt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:49:57 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:34788 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752741AbWKBIt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:49:56 -0500
Date: Thu, 2 Nov 2006 11:46:08 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: zhou drangon <drangon.mail@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061102084608.GB22909@2ka.mipt.ru>
References: <20061101160551.GA2598@elf.ucw.cz> <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz> <20061101185745.GA12440@2ka.mipt.ru> <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com> <aaf959cb0611011829k36deda6ahe61bcb9bf8e612e1@mail.gmail.com> <aaf959cb0611011830j1ca3e469tc4a6af3a2a010fa@mail.gmail.com> <4549A261.9010007@cosmosbay.com> <20061102080122.GA1302@2ka.mipt.ru> <4549A9EF.9000303@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4549A9EF.9000303@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 02 Nov 2006 11:46:40 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 09:18:55AM +0100, Eric Dumazet (dada1@cosmosbay.com) wrote:
> Evgeniy Polyakov a écrit :
> >pipes will work with kevent's poll mechanisms only, so there will not be
> >any performance gain at all since it is essentially the same as epoll
> >design with waiting and rescheduling (all my measurements with 
> >epoll vs. kevent_poll always showed the same rates), pipes require the same
> >notifications as sockets for maximum perfomance.
> >I've put it into todo list.
> 
> Evgeniy I think this part is *important*. I think most readers of lkml are 
> not aware of exact mechanisms used in epoll, kevent poll, and 'kevent'
> 
> I dont understand why epoll is bad for you, since for me, 
> ep_poll_callback() is fast enough, even if we can make it touch less cache 
> lines if reoredering 'struct epitem' correctly. My epoll_pipe_bench doesnt 
> change the rescheduling rate of the test machine.
> 
> Could you in your home page add some doc that clearly show the path taken 
> for those 3 mechanisms and different events sources (At least sockets)

It is.

"It [kevent] supports socket notifications (accept, sending and receiving),
network AIO (aio_send(), aio_recv() and aio_sendfile()), inode
notifications (create/remove), generic poll()/select() notifications and
timer notifications."
In each patch I give a short description and socket notification patch

By poll design we have to setup following data:
poll_table_struct, which contains a callback
that callback will be called in each
sys_poll()->drivers_poll()->poll_wait(),
callback will allocate new private structure, which must have
wait_queue_t (it's callback will be invoked each time wake_up() is
called for given wait_queue_head), which should be linked to the given
wait_queue_head.

Kevent has different approach: so called origins (files, inodes,
sockets and so on) have a queues of userspace requests, for example
socket origin can only have a queue which will contain one of the
following events ($type.$event): socket.send, socket.recv,
socket.accept. So when new data has arrived, appropriate event is marked
as ready and moved into ready queue (very short operations) and
requested thread is awakened, which can then get ready events and
requeue them back (or remove, depending on flags). There are no
allocations in kevent_get_events() (epoll_wait() does not have it too),
no potentially long lists of wait_queue linked to the same 
wait_queue_head_t, which is traversed each time we call wake_up(),
it has much smaller memory footprint compared to epoll (there is only
one kevent compared to epitem and eppoll_entry).

> Eric

-- 
	Evgeniy Polyakov
