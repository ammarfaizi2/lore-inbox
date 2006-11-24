Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757516AbWKXAOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516AbWKXAOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 19:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757520AbWKXAOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 19:14:10 -0500
Received: from berlioz.imada.sdu.dk ([130.225.128.12]:30460 "EHLO
	berlioz.imada.sdu.dk") by vger.kernel.org with ESMTP
	id S1757516AbWKXAOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 19:14:08 -0500
From: Hans Henrik Happe <hhh@imada.sdu.dk>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Date: Fri, 24 Nov 2006 01:14:04 +0100
User-Agent: KMail/1.9.5
Cc: Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
References: <11641265982190@2ka.mipt.ru> <456621AC.7000009@redhat.com> <45662522.9090101@garzik.org>
In-Reply-To: <45662522.9090101@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611240114.04877.hhh@imada.sdu.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 November 2006 23:48, Jeff Garzik wrote:
> I'm really wondering is designing for N-threads-to-1-ring is the wisest 
> choice?
> 
> Considering current designs, it seems more likely that a single thread 
> polls for socket activity, then dispatches work.  How often do you 
> really see in userland multiple threads polling the same set of fds, 
> then fighting to decide who will handle raised events?

They should not fight, but gently divide event handling work.
 
> More likely, you will see "prefork" (start N threads, each with its own 
> ring) 

One ring could be more busy than others, leaving all the work to one thread.

> or a worker pool (single thread receives events, then dispatches  
> to multiple threads for execution) or even one-thread-per-fd (single 
> thread receives events, then starts new thread for handling).

This is more like fighting :-) 
It adds context switches and therefore extra latency for event handling. 
 
> If you have multiple threads accessing the same ring -- a poor design 
> choice -- I would think the burden should be on the application, to 
> provide proper synchronization.

Comming from the HPC world I do not agree. Context switches should be avoided. 
This paper is a good example from the HPC world: 

http://cobweb.ecn.purdue.edu/~vpai/Publications/majumder-lacsi04.pdf.

The latency problems introduced by context switches in this work calls for 
even more functionality in event handling. I will not go into details now. 
There are enough problems with kevent's current feature set and I believe 
these extra features can be added later without breaking the API.

--

Hans Henrik Happe
