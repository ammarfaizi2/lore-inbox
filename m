Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSF1IUi>; Fri, 28 Jun 2002 04:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSF1IUh>; Fri, 28 Jun 2002 04:20:37 -0400
Received: from pat.uio.no ([129.240.130.16]:50116 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317025AbSF1IUg>;
	Fri, 28 Jun 2002 04:20:36 -0400
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: kuznet@ms2.inr.ac.ru
Subject: Re: Fragment flooding in 2.4.x/2.5.x
Date: Fri, 28 Jun 2002 10:22:50 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200206272207.CAA16913@sex.inr.ac.ru>
In-Reply-To: <200206272207.CAA16913@sex.inr.ac.ru>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_2YPE8Z8WJJSX7QIRB164"
Message-Id: <200206281022.51074.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_2YPE8Z8WJJSX7QIRB164
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Friday 28 June 2002 00:07, kuznet@ms2.inr.ac.ru wrote:

> I am saying absolutely seriously that there is nothing more stupid
> than preparation of skbs only to drop them and to return you EAGAIN.
> _Nothing_, do you hear this?

I hear, but you still haven't explained why? What exactly would trigger a 
BUG() as you mentioned?

> Repeating the third time in hope you eventually read the mail to the end:
> >>>Better way exists. Just use forced sock_wmalloc instead of
> >>>sock_alloc_send_skb on non-blocking send of all the fragments
> >>>but the first.

I heard you the first time, and have been looking into it. However that still 
does not address the problem of memory allocation failure (yes - I know you 
said that is the same as network loss - I still don't think we need to 
simulate that).
If I understand correctly, it also means that you have to estimate socket 
buffer memory useage prior to actually entering the loop (something which is 
impossible to do accurately). Attached is a patch that I hope you will 
comment on (without too many expletives please ;-))...

> And, yes, until this is done, I have to be serious when saying
> that any application using nonblocking sockets have to use select()
> or even SIOCOUTQ. Your patch does not change anything in this.

sendmsg() + select() alone should suffice. Anybody using those 2 should be 
able to expect optimal message output without the socket buffer getting 
filled with junk data.

Cheers,
  Trond

--------------Boundary-00=_2YPE8Z8WJJSX7QIRB164
Content-Type: text/plain;
  charset="iso-8859-1";
  name="estimate_buf_useage.dif"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="estimate_buf_useage.dif"

--- linux-2.4.19-smp/net/ipv4/ip_output.c.orig	Mon May 13 23:34:37 2002
+++ linux-2.4.19-smp/net/ipv4/ip_output.c	Fri Jun 28 10:07:16 2002
@@ -508,6 +508,16 @@
 		goto out;
 
 	/*
+	 * Rough estimate of socket memory useage. Doesn't take into account
+	 * the overhead due to fragment headers, alignment...
+	 */
+	if (flags&MSG_DONTWAIT && sk->sndbuf - atomic_read(&sk->wmem_alloc) < (int)length) {
+		set_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
+		set_bit(SOCK_NOSPACE, &sk->socket->flags);
+		return -EAGAIN;
+	}
+
+	/*
 	 *	Begin outputting the bytes.
 	 */
 
@@ -521,7 +531,11 @@
 		 *	Get the memory we require with some space left for alignment.
 		 */
 
-		skb = sock_alloc_send_skb(sk, fraglen+hh_len+15, flags&MSG_DONTWAIT, &err);
+		if (flags&MSG_DONTWAIT) {
+			err = -ENOBUFS;
+			skb = sock_wmalloc(sk, fraglen+hh_len+15, 1, sk->allocation);
+		} else
+			skb = sock_alloc_send_skb(sk, fraglen+hh_len+15, 0, &err);
 		if (skb == NULL)
 			goto error;
 

--------------Boundary-00=_2YPE8Z8WJJSX7QIRB164--
