Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSKXUgt>; Sun, 24 Nov 2002 15:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbSKXUgt>; Sun, 24 Nov 2002 15:36:49 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:56213 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261689AbSKXUgr>;
	Sun, 24 Nov 2002 15:36:47 -0500
Date: Sun, 24 Nov 2002 20:46:33 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Felix von Leitner <felix-kerel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: epoll_wait conflicts with man page
Message-ID: <20021124204633.GA27151@bjl1.asuk.net>
References: <20021124174635.GB16255@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021124174635.GB16255@codeblau.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> Also, I would move the
> "int fd" out of the union because it is universally useful to know the
> file descriptor without having to save it in the opaque data.

Hi Felix,

It is not possible for epoll itself to keep track of the fd number,
because some more advanced applications can change or duplicate fd
numbers (using dup(), dup2() or fcntl(F_DUPFD)), and in some cases its
possible for an event to arrive on an object which doesn't even _any_
valid fd value in the current process (e.g. while it's being passed
from one process to another through a unix domain socket, or with
certain uses of clone()).

While this might seem peculiar, it is the sort of thing that some
kinds of scalable server software do, for good reasons.

The only thing epoll could report would be the initially registered
"fd" value, which is meaningful for some applications but not
universally correct.  As it would not always be correct, it is best
for the application itself to keep track of fd numbers.  In practice,
all applications either use the `fd' field in the union (and no other
user-data), or a pointer in the union to a structure of flags and
other per-fd data, and that structure always includes a correct `fd'
value anyway for other reasons.

So, the API is perfect as it is :)

-- Jamie
