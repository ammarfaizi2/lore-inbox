Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUJFOwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUJFOwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUJFOwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:52:31 -0400
Received: from [213.196.40.106] ([213.196.40.106]:57745 "EHLO
	eljakim.netsystem.nl") by vger.kernel.org with ESMTP
	id S269245AbUJFOw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:52:29 -0400
Date: Wed, 6 Oct 2004 16:52:27 +0200 (CEST)
From: Joris van Rantwijk <joris@eljakim.nl>
X-X-Sender: joris@eljakim.netsystem.nl
To: linux-kernel@vger.kernel.org
Subject: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem where the sequence of events is as follows:
 - application does select() on a UDP socket descriptor
 - select returns success with descriptor ready for reading
 - application does recvfrom() on this descriptor and this recvfrom()
   blocks forever

My understanding of POSIX is limited, but it seems to me that a read call
must never block after select just said that it's ok to read from the
descriptor. So any such behaviour would be a kernel bug.

This problem occurs repeatedly, but only once per week on average so it is
hard to debug but definitely a real problem. I know for a fact that the
sequence of events is as described above from strace output. My kernel
version is 2.6.7.

>From a brief look at the kernel UDP code, I suspect a problem in
net/ipv4/udp.c, udp_recvmsg(): it reads the first available datagram
from the queue, then checks the UDP checksum. If the UDP checksum fails at
this point, the datagram is discarded and the process blocks until the next
datagram arrives.

Could someone please help me track this problem?
Am I correct in my reasoning that the select() -> recvmsg() sequence must
never block?
If yes, is it possible that this problem is triggered by a failed UDP
checksum in the udp_recvmsg() function?
If yes, can we do something to fix this?

Thanks,
  Joris.
