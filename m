Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269804AbUJGMgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269804AbUJGMgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269714AbUJGMdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:33:32 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:62385 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S263795AbUJGMcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:32:19 -0400
Message-ID: <001601c4ac72$19932760$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Paul Jakma" <paul@clubi.ie>,
       "Chris Friesen" <cfriesen@nortelnetworks.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       "David S. Miller" <davem@davemloft.net>, <joris@eljakim.nl>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com> <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 14:32:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul Jakma" <paul@clubi.ie>
Sent: Thursday, October 07, 2004 12:53


> On Thu, 7 Oct 2004, Chris Friesen wrote:
> 
> > Actually, in the single threaded case, the state did not change.  We just 
> > didn't actually check the state before returning from select().
> 
> Right, so our perception of state (which for all useful purposes /is/ 
> the state) changed - "we have data" -> "we had to throw out data due 
> to bad checksum" is a change in kernel state at least, if not in the 
> (now gone) data.
> 
> I'm not really a kernel person. From the application POV, in the 
> single-threaded case (cause the multi-threaded case is fairly 
> pathological anyway), there /will/ be time between the select and the 
> recvmsg, things /can/ change, and obviously they do.

That there is time between the select() and recvmsg() calls is not the
issue; the data is only checked in the call to recvmsg(). Actually the
longer the time between select() and recvmsg(), the larger the probability
that valid data has been received.

> Treating select as anything other than a useful hints mechanism is 
> going to get you into trouble - just see the Stevens' example others 
> gave for a long-standing example, in addition to this (sane imho) 
> Linuxism.

But the standard clearly says otherwise.

> > Actually, there wasn't.  The data was corrupt, therefore there was 
> > no data. Nothing changed with time, as the corrupt data was already 
> > present before we returned from select().
> 
> Perception of state is as good as state here.

Perhaps select()'s perception of state should be made to take possible
corruption into account.

> > POSIX says that if select() says a socket is readable, a read call 
> > will not block.  Obviously, we are not POSIX compliant.
> 
> Right, yes, that seems to be clear now.
> 
> Though, I'd still say that any app that calls read/write functions 
> without O_NONBLOCK set and that expects it will not block, is broken. 
> Basic common sense really, never mind the fine details of POSIX on 
> select(). ;)

Why would the POSIX standard say recvmsg() should not block if
it did not intend it to be used in that way?

> > There's nothing wrong with not being compliant, but it should be 
> > documented and we shouldn't claim to be compliant.
> 
> Right.

Wrong. IMHO it is not exactly a good thing to not be compliant on
such basic functionality.


--ms

