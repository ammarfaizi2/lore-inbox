Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263506AbTJ0TzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTJ0TzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:55:05 -0500
Received: from yakov.inr.ac.ru ([193.233.7.111]:49303 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S263506AbTJ0Ty7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:54:59 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200310271954.WAA07541@yakov.inr.ac.ru>
Subject: Re: Linux 2.6.0-test9
To: davem@redhat.com (David S. Miller)
Date: Mon, 27 Oct 2003 22:54:41 +0300 (MSK)
Cc: torvalds@osdl.org (Linus Torvalds), akpm@osdl.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
In-Reply-To: <20031026224358.233e6d1a.davem@redhat.com> from "David S. Miller" at Oct 26, 2003 10:43:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


> But I am starting to see that URG is different.  It is not like
> other socket errors that halt the socket and make no new data
> arrive after it happens.  Rather, URG can happen just about anywhere
> and more data can continue to flow into the socket buffers.
> 
> In fact, this means that our change can result in an application
> can never see the error if data continues to arrive faster than
> the application can pull it out, see?
> 
> Alexey, I think we did not understand this case fully when making this
> change.

No doubts taking into account that the things are so badly broken. :-)

But I was aware about this problem and even "proved" to you that the patch
will not change anything. :-) Remember this?


> I found only one more or less essential difference: when we have one oob
> octet in the stream with data following it, read() can return -EINTR/RESTART
> due to pending SIGURG and normal data will be read at the second read(),
> or, alternatively, it can return data following oob octet immediately.
>
> In practice there is no real difference: SIGURG is processed before read()
> returns in any case and even more, with restartable signals it is just
> exactly no difference.


Actually, I considered the same thing:

>--- 1.49/net/ipv4/tcp.c	Mon Oct 20 22:27:42 2003
>+++ edited/net/ipv4/tcp.c	Sun Oct 26 17:59:14 2003
>@@ -1536,9 +1536,15 @@
> 		struct sk_buff *skb;
> 		u32 offset;
> 
>-		/* Are we at urgent data? Stop if we have read anything. */
>-		if (copied && tp->urg_data && tp->urg_seq == *seq)
>-			break;
>+		/* Are we at urgent data? Stop if we have read anything or have SIGURG pending. */
>+		if (tp->urg_data && tp->urg_seq == *seq) {
>+			if (copied)
>+				break;
>+			if (signal_pending(current)) {
>+				copied = timeo ? sock_intr_errno(timeo) : -EAGAIN;
>+				break;
>+			}
>+		}
> 
> 		/* Next get a buffer. */
> 

as a reliable workaround for SIGURG situation, but then "figured out"
that this is not necessary (which was mistake). Though at the moment I still
do not understand what exactly is so wrong with that my argument, the signal
should be processed before read() returns, should not it? Maybe, rlogin
longjmp()s or something like this...

Alexey
