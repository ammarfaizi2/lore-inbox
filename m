Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUJGPWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUJGPWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUJGPTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:19:35 -0400
Received: from brown.brainfood.com ([146.82.138.61]:52370 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S267294AbUJGPTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:19:01 -0400
Date: Thu, 7 Oct 2004 10:18:55 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <1097156929.31753.47.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0410071017300.1194@gradall.private.brainfood.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> 
 <20041006080104.76f862e6.davem@davemloft.net>  <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
  <20041006082145.7b765385.davem@davemloft.net> 
 <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> 
 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org>  <4164EBF1.3000802@nortelnetworks.com>
  <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> 
 <001601c4ac72$19932760$161b14ac@boromir>  <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>
  <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156929.31753.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Alan Cox wrote:

> On Iau, 2004-10-07 at 15:07, Martijn Sipkema wrote:
> > > Much can change between the select() and recvmsg - things outside of
> > > kernel control too, and it's long been known.
> >
> > There is no change; the current implementation just checks the validity of
> > the data in the recvmsg() call and not during select().
>
> The accept one is documented by Stevens and well known. In the UDP case
> currently we could get precise behaviour - by halving performance of UDP
> applications like video streaming. We probably don't want to  because we
> can respond intelligently to OOM situations by freeing the queue if we
> don't enforce such a silly rule.

Also, pkts could be dropped even for TCP sockets.  TCP will cause the pkt to
be retransmitted, but while that is occuring, the read that was prompted by
the select will still block.

So, any app that does not use O_NONBLOCK is broken, if they assume that a
successful select will indicate a nonblocking read/recvmsg.

