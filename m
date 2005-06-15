Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVFOUbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVFOUbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVFOUbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:31:24 -0400
Received: from mailhub128.itcs.purdue.edu ([128.210.5.128]:2445 "EHLO
	mailhub128.itcs.purdue.edu") by vger.kernel.org with ESMTP
	id S261544AbVFOUaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:30:11 -0400
User-Agent: Microsoft-Entourage/11.1.0.040913
Date: Wed, 15 Jun 2005 15:31:07 -0500
Subject: TCP prequeue performance
From: Chase Douglas <cndougla@purdue.edu>
To: lkml <linux-kernel@vger.kernel.org>
Message-ID: <BED5FA3B.2A0%cndougla@purdue.edu>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
X-PMX-Version: 4.7.1.128075
X-PerlMx-Virus-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working with tcp_recvmsg trying to implement a new feature. While
implementing this and benchmarking, I found something rather odd. I've
created a benchmark which connects to a server 100,000 times receiving two
10,000 byte messages each time. I used the time program to find out how much
system time was being used during the receives. The first data shows the
statistics on a normal receive call:

time ./client 10000 10000 100000 1 500000000 recv

real    1m27.301s
user    0m1.568s
sys     0m13.464s

I then disabled the prequeue mechanism by changing net/ipv4/tcp.c:1347 of
2.6.11:

if (tp->ucopy.task == user_recv) {
    to
if (0 && tp->ucopy.task == user_recv) {

The same benchmark then yielded:

time ./client 10000 10000 100000 1 500000000 recv

real    1m21.928s
user    0m1.579s
sys     0m8.330ss

Note the decreases in the system and real times. These numbers are fairly
stable through 10 consecutive benchmarks of each. If I change message sizes
and number of connections, the difference can narrow or widen, but usually
the non-prequeue beats the prequeue with respect to system and real time.

It might be that I've just found an instance where the prequeue is slower
than the "slow" path. I'm not quite sure why this would be. Does anyone have
any thoughts on this?

Thanks


