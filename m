Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751996AbWJMXdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbWJMXdO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWJMXdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:33:14 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:43908 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751996AbWJMXdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:33:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=HygSmjaxYUWTRswESCbZijIo9HdjMAyrfVyRPyxk8XAsPh9FrGGbaQKQhMVzpoUuQ1PWUTbcnwUcWl3nfkG1YJ0E+2NPu2aWQ4QzNYvEEzHMKnou8xfVyh9CXO8/TEejaAE9RKzrCBPSeigxipRs632gFzCoGFEsaNWzW6dG1So=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13 (CRITICAL???)
Date: Fri, 13 Oct 2006 16:33:03 -0700
User-Agent: KMail/1.7.1
Cc: Open Source <opensource3141@yahoo.com>,
       =?iso-8859-1?q?WolfgangM=FCes?= <wolfgang@iksw-muees.de>,
       linux-kernel@vger.kernel.org
References: <20061013193107.43500.qmail@web58109.mail.re3.yahoo.com>
In-Reply-To: <20061013193107.43500.qmail@web58109.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610131633.03809.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 October 2006 12:31 pm, Open Source wrote:
> 
> It seems like the unlinking of completed URBs
> happens asynchronously on a timer.  This is a
> surprise to me since I thought this was happening
> on an IRQ from the host controller.  But if what I'm
> surmising is correct it would explain everything
> I am seeing.

You didn't say what EHCI controller you're using.

The original reason for that timer was specifically
to handle bugs in VIA silicon:  that won't always issue
all of the IRQs it's supposed to.  Specifically the IAA
IRQ would never arrive, leading to unlink operations
wedging.

Later on that timer got overloaded (and hence it got
to be a bit of a mess) with two other tasks:

(a) deducing that an endpoint had been idle long enough
to take off the ring of active control/bulk queues,
which is what ensures that an idle controller isn't
wasting memory bandwidth by doing DMA all the time.

(It turns out to be a Bad Idea to take idle endpoints
off that ring the instant they become idle, since they
will as a rule be reused very quickly ... so immediate
removal slows things down a lot.  Plus it chases an
annoying number of races between driver and controller.)

(b) being a general I/O watchdog, since there were some
other (rare) cases where IRQs would appear to get lost


In short, except for (a) the only reason I know of
that changing HZ should affect system performance is
IRQ lossage ... of which the primary reason has always
been strange behavior from VIA controllers.

- Dave

 
