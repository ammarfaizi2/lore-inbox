Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbRHOVl5>; Wed, 15 Aug 2001 17:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266464AbRHOVlr>; Wed, 15 Aug 2001 17:41:47 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:38587 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266417AbRHOVlj>; Wed, 15 Aug 2001 17:41:39 -0400
Date: Wed, 15 Aug 2001 14:41:15 -0700 (PDT)
From: Sridhar Samudrala <samudrala@us.ibm.com>
To: Manfred Bartz <mbartz@optushome.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: connect() does not return ETIMEDOUT
Message-ID: <Pine.LNX.4.21.0108151123510.4809-100000@w-sridhar2.des.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux has 2 queues associated with a listening socket to maintain incoming 
connections before they are accepted.  The first one is syntable which holds 
the partial connections (SYN received and SYN-ACK sent). This is a hash table 
and the maximum length is limited by /proc/sys/net/ipv4/tcp_syn_max_backlog.
The second one is called accept queue which hold the complete connections (3 
way handshake is complete). The length of this queue is limited by the backlog value specfied with listen(). It is actually backlog+1.

When the accept queue is full, new incoming SYNs are accepted in a burst of 
2 at a time. These are put in the SYN table expecting that the accept queue
will open up by the time we receive the ACK. If the accept queue doesn't get
open up, the ACK is simply dropped and SYN-ACK is sent again after a certain
timeout period. 

In your example, 6 connections succeed immediately.
But only 4 enter ESTABLISHED state.
2 are accepted by the server. 2 remain in the accept queue (backlog+1).
2 of them are added to the SYN table. 

Thanks
Sridhar


> Questions:

> Once the backlog is exhausted, shouldn't the server side 
> TCP stop sending SYNs and either be quiet or perhaps send 
> an appropriate ICMP response?

> Why does the server side keep sending SYNs after the connection
> handshake was apparently completed?

> -- 
> Manfred

