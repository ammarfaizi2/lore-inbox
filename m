Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268527AbTBOEPw>; Fri, 14 Feb 2003 23:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268528AbTBOEPw>; Fri, 14 Feb 2003 23:15:52 -0500
Received: from almesberger.net ([63.105.73.239]:48143 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268527AbTBOEPv>; Fri, 14 Feb 2003 23:15:51 -0500
Date: Sat, 15 Feb 2003 01:25:38 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030215012538.E2791@almesberger.net>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> <XFMail.20030214115507.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20030214115507.pochini@shiny.it>; from pochini@shiny.it on Fri, Feb 14, 2003 at 11:55:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:
> IMHO it's not simply a signal delivery system, it's a message queue.

Not entirely, because - as I understand it - signals would be
aggregated, so you'd always get one item, no matter how many
signals are actually pending at that time.

For generalizing such mechanisms, it might be useful to have
an atomic "overwrite" operation for pipes, and maybe also for
some sockets, e.g. something like this:

    ssize_t overwrite(int fd,
      const void *data_if_empty,size_t size_if_empty,
      const void *data_if_full,size_t size_if_full,
      int *was_empty);

If there is no data in the pipe/queue, "overwrite" would
write "data_if_empty", and clear *was_empty. Otherwise, it
would discard what's there, then write "data_if_full", and
set *was_empty. The whole operation is atomic with respect
to readers/pollers.

E.g.

static int signal_set = 0;

... add_signal(int signum)
{
	int new_signal = 1 << signum;
	int was_empty;

	signal_set |= new_signal;
	overwrite(fd,&new_signal,sizeof(int),&signal_set,sizeof(int),
	    &was_empty);
	if (was_empty)
		signal_set = new_signal;
}

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
