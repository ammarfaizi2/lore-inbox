Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268533AbTBOFEN>; Sat, 15 Feb 2003 00:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268534AbTBOFEM>; Sat, 15 Feb 2003 00:04:12 -0500
Received: from almesberger.net ([63.105.73.239]:54031 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S268533AbTBOFEM>; Sat, 15 Feb 2003 00:04:12 -0500
Date: Sat, 15 Feb 2003 02:14:02 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030215021402.F2791@almesberger.net>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> <XFMail.20030214115507.pochini@shiny.it> <20030215012538.E2791@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215012538.E2791@almesberger.net>; from wa@almesberger.net on Sat, Feb 15, 2003 at 01:25:38AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>     ssize_t overwrite(int fd,
>       const void *data_if_empty,size_t size_if_empty,
>       const void *data_if_full,size_t size_if_full,
>       int *was_empty);

Bah, rubbish. Make this

    ssize_t overwrite(int fd,const void *data,size_t size);

If the pipe/queue is empty, don't write, and return 0. Now, this
could probably be implemented with a flag to send(2) (then this
wouldn't work for pipes, but you could use socketpair(2) for a
similar effect). Example:

void add_signal(int signum)
{
	static int signal_set = 0;
	int new_signal = 1 << signum;
	int sent;

	signal_set |= new_signal;
	sent = send(fd,&signal_set,sizeof(int),MSG_OVERWRITE);
	if (!sent) {
		send(fd,&new_signal,sizeof(int),0);
		signal_set = new_signal;
	}
}

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
