Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTJOVQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 17:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbTJOVQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 17:16:30 -0400
Received: from ftpbox.mot.com ([129.188.136.101]:41378 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id S261940AbTJOVQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 17:16:28 -0400
Message-ID: <EDFB2B1ED0A1D7118A0A00065BF2490D4B6232@il06exm13.corp.mot.com>
From: Veeriah Vijay-A19819 <vijaysv@motorola.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Veeriah Vijay-A19819 <vijaysv@motorola.com>,
       "'vsankarz@yahoo.com'" <vsankarz@yahoo.com>
Subject: PROBLEM: TCP keepalive probe count
Date: Wed, 15 Oct 2003 16:15:57 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.2)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.4.7 kernel and seem to have a problem where my TCP connection aborts when both the 
client and the server are, perfectly fine, up and running and sending data to each other. 

I was able to reproduce this problem by doing the following.
I  setup the tcp parameters to be as follows :
              tcp_keepalive_time =  2
              tcp_keepalive_probes = 1
              tcp_keepalive_intvl = 3
My server and client send data to each other every 2 seconds.

>From tcpdump output I figured out the following.  After a keepalive_probe is sent out (at the expiry of  keepalive_time)
if it is immediately followed by some valid data, then the ack for the keepalive_probe from the remote side does 
not seem to reset the probes_out to 0. Because of  this when the keepalive_timer expires the next time it RSTs the
connection.
The following code in tcp_input.c, seems to be the problem
	if ((prior_packets = tp->packets_out) == 0)
		goto no_queue;
            ....
	          return 1;

            no_queue:
                      tp->probes_out = 0
            ....

Since in my case prior_packets is not 0, because of the valid data, probes_out is not being reset.
Can somebody let me know  if  I am missing something here or is it a genuine problem that has been fixed in
a later release.

Thanks,
Vijay


