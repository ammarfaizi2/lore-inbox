Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265928AbRGAV1n>; Sun, 1 Jul 2001 17:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265932AbRGAV1e>; Sun, 1 Jul 2001 17:27:34 -0400
Received: from gateway.sequent.com ([192.148.1.10]:14637 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S265928AbRGAV1V>; Sun, 1 Jul 2001 17:27:21 -0400
From: Nivedita Singhvi <nivedita@sequent.com>
Message-Id: <200107012127.OAA13394@eng4.sequent.com>
Subject: Re: Client receives TCP packets but does not ACK
To: robert@kleemann.org
Date: Sun, 1 Jul 2001 14:27:00 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The bad network behavior was due to shared irqs somehow screwing 
> things up. This explained most but not all of the problems. 

ah, that's why your test pgm succeeded on my systems..
 
> When I last posted I had a reproducible test case which spewed a bunch 
> of packets from a server to a client. The behavior is that the client 
> eventually stops ACKing and so the the connection stalls indefinitely. 
> packet. I added printk statements for each of these conditions in 
> hopes of detecting why the final packet is not acked. I recompiled 
> the kernel, and reran the test. The result was that the packet was 
> being droped in tcp_rcv_established() due to an invalid checksum. I 

Ouch!

In the interests of not having it be so painful to identify the
problem (to this point, i.e. TCP drops due to checksum failures) 
the next time around, I'd like to ask:

- Were you seeing any bad csum error messages in /var/log/messages?
  i.e. or else was it only TCP?

- Was the stats field /proc/net/snmp/Tcp:InErrs
  reflecting those drops?

- What additional logging/stats gathering would have made this
  (silent drops due to checksum failures by TCP) easier to detect?

  My 2c:

  The stat TcpInErrs is updated for most TCP input failures.
  So its not obvious (unless youre real familiar with TCP)
  that there are checksum failures happening. It actually 
  includes only these errors:
        - checksum failures
        - header len problems
        - unexpected SYN's
 
  Is this adequate as a diagnostic, or would adding a breakdown
  counter(s) for checksum (and other) failures be useful? 
  At the moment, there is no logging TCP does on a plain vanilla 
  kernel, you have to recompile the kernel with NETDEBUG in order 
  to see logged checksum failures, at least at the TCP level. 

  It would be nice to have people be able to look at a counter or 
  stat on the fly and tell whether they're having packets silently 
  dropped due to checksum failures (and other issues) without needing 
  to recompile the kernel...
   
Any thoughts?

thanks,
Nivedita

---
I'd appreciate a cc since I'm not subscribed..
nivedita@sequent.com
nivedita@us.ibm.com 
