Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270509AbTGNCaR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 22:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270510AbTGNCaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 22:30:17 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:59784 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270509AbTGNCaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 22:30:06 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 19:37:28 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: "David S. Miller" <davem@redhat.com>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: POLLRDONCE optimisation for epoll users (was: epoll and half
 closed TCP connections)
In-Reply-To: <20030714022412.GD22769@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307131927580.15022@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com>
 <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com>
 <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com>
 <20030713191559.GA20573@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com>
 <20030714014135.GA22769@mail.jlokier.co.uk> <20030714022412.GD22769@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Jamie Lokier wrote:

> Jamie Lokier wrote:
> > Anyway, there is a correct answer and I have made the patch so wait
> > for next mail... :)
>
> The patch is included below.  Note, it compiles and has been carefully
> scrutinised by a team of master coders, but never actually run.  Eric,
> you may want to try it out :)
>
> The difference between this and POLLRDHUP is polarity, generality and
> correctness :)
>
> Eric, change the polarity of your test from
>
> 	if (events & POLLRDHUP)
> 		goto read_again;
>
> to
>
> 	if (!(events & POLLRDONCE))
> 		goto read_again;
>
> and it should (fingers crossed) work well.

Ouch, I definitely liked more the POLLHUP thing. It is not linked to epoll
at all. Ok, suppose that our super-fast app choses Edge Triggered epoll
and also, aiming at topp speeds, using the smart read(2) trick :


void my_process_read(my_data *d, unsigned int events) {
	int n, s;

	do {
		s = d->buffer_size - d->in_buffer;
		if ((n = read(d->fd, d->buffer + d->in_buffer, s)) > 0) {
			process_partial_buffer(d, s);
			d->in_buffer += s;
		}
	} while (n == s);
	if (s == -1 && errno != EAGAIN) {
		handle_read_error(d);
		return;
	}
	if (events & EPOLLRDHUP) {
		d->flags |= HANGUP;
		schedule_removal(d);
	}
}

Where this will break by using a POLLRDHUP ?



- Davide

