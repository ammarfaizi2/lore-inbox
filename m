Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTJTNL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTJTNL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:11:26 -0400
Received: from motgate5.mot.com ([144.189.100.105]:21729 "EHLO
	motgate5.mot.com") by vger.kernel.org with ESMTP id S262567AbTJTNLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:11:24 -0400
Message-ID: <EDFB2B1ED0A1D7118A0A00065BF2490D4B6240@il06exm13.corp.mot.com>
From: Veeriah Vijay-A19819 <vijaysv@motorola.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Problem: Active TCP connection  aborts  for no apparent reaso
	n
Date: Mon, 20 Oct 2003 08:11:06 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.2)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.4.22 kernel and seem to have a problem where my TCP connection aborts
when both the client and the server are, perfectly fine, up and running and sending 
data to each other. I have enabled keepalive on both the client and server side.

I was able to reproduce this problem by doing the following.
I  setup the tcp parameters to be as follows :
              tcp_keepalive_time =  2
              tcp_keepalive_probes = 1
              tcp_keepalive_intvl = 3
My server and client send data to each other approximately every 2 seconds.

>From tcpdump output I figured out the following.  After a keepalive_probe is sent out (at the expiry of  keepalive_time)
if it is immediately followed by some valid data, then the ack for the keepalive_probe from the remote side does 
not seem to reset the probes_out to 0. Because of  this when the keepalive_timer expires 
the next time it RSTs the connection.

The following code in tcp_input.c, seems to be the problem
	if ((prior_packets = tp->packets_out) == 0)
		goto no_queue;

	// Vijay's COMMENT - probes_out not being reset in this scenario.
            ....
	          return 1;

            no_queue:
                      tp->probes_out = 0
            ....

Since in my case prior_packets is not 0, because of the valid data, probes_out is not being reset. Is it okay to set       "tp->probes_out = 0" before the "return 1" line above ?

In tcp_timer.c, the following code seems to reset the connection on the next keepalive
timer expiry,
    if (!tp->keepalive_probes && tp->probes_out >= sysctl_tcp_keepalive_probes) ||
         ...)
    {
	tcp_SEnd_Active_reset (sk, GFP_ATOMIC);
	tcp_write_err(sk);
	goto out;
    }

Can somebody let me know  if  I am missing something here or is it a genuine problem that 
has been fixed in a later release. I see the same problem in 2.5.25 kernel sources as well.

I can provide the tcpdump if need be.

Thanks,
Vijay
