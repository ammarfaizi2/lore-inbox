Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbUKQP3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUKQP3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbUKQP3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:29:22 -0500
Received: from imag.imag.fr ([129.88.30.1]:49391 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S262343AbUKQP3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:29:18 -0500
Date: Wed, 17 Nov 2004 16:29:14 +0100 (CET)
From: Catalin Drula <Catalin.Drula@imag.fr>
To: <linux-kernel@vger.kernel.org>
Subject: AF_UNIX sockets: strange behaviour
Message-ID: <Pine.GSO.4.33.0411171618260.8987-100000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Wed, 17 Nov 2004 16:29:15 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a small application that communicates over Bluetooth. I use
connection-oriented UNIX domain sockets (AF_UNIX, SOCK_STREAM) to
communicate between the applications's threads. When reading from
one of these sockets, I get a strange behaviour: if I read all the
bytes that are available (13, in this case) all at once, it's fine;
however, if I try to read in two smaller batches (say, first time
6, and second time 7), the first read returns (with the 6 bytes), but
the second read never returns.

As far as I know, this is not expected behaviour for SOCK_STREAM sockets.
I tried looking into the problem so I instrumented net/unix/af_unix.c to
see what is going on. More specifically, I was focusing on the function
unix_stream_recvmsg. Here is what I noticed:

  - there is a skb in the sk_receive_queue with a len of 13
  - 6 bytes are read from it
  - a skb with the remaining 7 bytes is requeued in sk_receive_queue
  - on the next call to unix_stream_recvmsg, the sk_receive_queue is
empty (!)

Thus, this confirms the behaviour observed from userspace. Is this a bug?
Who could be removing the skb from the receive_queue?

Thanks for any ideas/suggestions,

Catalin

ps Please cc: your replies to me.

