Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVAHWv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVAHWv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVAHWv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:51:28 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:21957 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261203AbVAHWvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:51:20 -0500
Subject: Re: Make pipe data structure be a circular list of pages, rather
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux@horizon.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501081018271.2386@ppc970.osdl.org>
References: <20050108082535.24141.qmail@science.horizon.com>
	 <Pine.LNX.4.58.0501081018271.2386@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105216050.10519.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 08 Jan 2005 21:47:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-08 at 18:41, Linus Torvalds wrote:
> For all of those that are valid (certainly the signal case), you need to
> put the pipe into nonblocking mode anyway, so I don't think coalescing is
> really needed. SuS certainly does _not_ seem guarantee that you can do
> many nonblocking writes (small _or_ big). Let's see if somebody reports 
> any trouble with the new world order.

It breaks netscape 3 if I simulate it (but thats picking an app I know
makes silly assumptions).

>From the rules pasted below I think the 1 byte at a time 4K write is
guaranteed or at least strongly implied. The single write atomicity is
guaranteed but that is if anything made easier by the changes.

(From pathconf)

	fpathconf(_PC_PATH_BUF)

             returns  the  size of the pipe buffer, where filedes must
refer
              to a pipe or FIFO and path must refer to  a  FIFO.  The 
corre-
              sponding macro is _POSIX_PIPE_BUF.

(From pwrite)

Write requests of {PIPE_BUF} bytes or less shall not be interleaved with
data from other processes doing writes on the same pipe. Writes of
greater than {PIPE_BUF} bytes may have data interleaved, on arbitrary
boundaries, with writes by other processes, whether or not the
O_NONBLOCK flag of the file status flags is set.

[of O_NDELAY for pipe]
A write request for {PIPE_BUF} or fewer bytes shall have the following
effect: if there is sufficient space available in the pipe, write()
shall transfer all the data and return the number of bytes requested.
Otherwise, write() shall transfer no data and return -1 with errno set
to [EAGAIN].


