Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSKTD46>; Tue, 19 Nov 2002 22:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSKTD46>; Tue, 19 Nov 2002 22:56:58 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:62854 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265681AbSKTD45>; Tue, 19 Nov 2002 22:56:57 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 19 Nov 2002 20:04:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021120030919.GA9007@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211191957370.1107-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Jamie Lokier wrote:

> I have a question about:
>
> > struct epoll_fd {
> > 	int fd;
> > 	unsigned short events;
> > 	unsigned short revents;
> > 	__uint64_t obj;
> > };
>
> What value does the `fd' field have when a file descriptor being
> polled has been renumbered (by dup/close or dup2/close or
> fcntl(F_DUPFD)/close or passing through a unix domain socket)?
>
> If we are honest, the `obj' field is absolutely essential as its the
> only value which uniquely identifies the file descriptor if you have
> done anything unusual with the fds.
>
> The `fd' field, on the other hand, is not guaranteed to correspond
> with the correct file descriptor number.  So.... perhaps the structure
> should contain an `obj' field and _no_ `fd' field?
>
> This doesn't affect applications.  Those which use `obj' for something
> interesting (i.e. a pointer) will have the `fd' value stored in the
> pointed-to data structure, while simple applications can just store
> the original `fd' value in `obj' in the first place.

It's OK. I agree. We can remove the fd from inside the structure and have :

struct epoll_event {
	unsigned short events;
	unsigned short revents;
	__uint64_t obj;
};

int epoll_create(int size);
int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
int epoll_wait(int epfd, struct epoll_event *events, int maxevents,
               int timeout);


And the lower size of the structure will help to reduce the amount of
memory transfered to userspace. I just saw that adding the extra "obj"
member lowered performance of about 15% with crazy tests like Ben's
pipetest. This because it creates, on my machine, more than 400000 events
per second, and saving memory bandwidth on such conditions is a must. With
the "more human" http test performance are about the same.




- Davide


