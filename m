Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbULNQm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbULNQm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULNQm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:42:27 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:37009 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S261551AbULNQmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:42:19 -0500
Subject: Re: bind() udp behavior 2.6.8.1
From: Adam Denenberg <adam@dberg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
References: <1103038728.10965.12.camel@sucka>
	 <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
Content-Type: text/plain
Message-Id: <1103042538.10965.27.camel@sucka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Dec 2004 11:42:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry "closed" was the wrong term here.  We are using a PIX Firewall
Module and it keeps a state table of all connections (tcp and udp). 
Thus when a new udp connection comes in with same high numbered source
port and the firewall has not removed that connection from its state
table, the firewall drops the packet.  The firewall needs about 60ms in
order to clear that connection from the state table, so if a second udp
request with the same high number port/ip comes thru before the firewall
clears the connection from the state table, it will drop the connection
(which is what we are seeing).

FreeBSD seems to increment future udp requests which prevents this
problem.  It just seems strange that the kernel would not randomize or
increment these source ports for udp requests.

has anyone encountered this issue?

thanks
adam

please CC me I am not on the list.

On Tue, 2004-12-14 at 11:04, Jan Engelhardt wrote:
> >Hello,
> >
> > I am not subscribed to this list so please CC me personally in
> >response. 
> >
> > I am noticing some odd behavior with linux 2.6.8.1 on a redhat 8 box
> >when making udp requests.  It seems subsequent udp calls are all
> >allocating the same source ephemeral udp port.  I believe the kernel
> >should be randomizing these (or incrementing) these ports for subsequent
> >requests.
> 
> No, you can have a fixed port for any socket. (It's just a question whether 
> you actually get the socket, because it might be in use.)
> 
> See http://linux01.org:2222/f/UHXT/examples/src/fastsock.c , which contains an 
> example on how to choose a fixed port.
> 
> >  We ran a test C program that just put a gethostbyname_r call
> >in a for loop of 40 calls and all 40 requests used the same UDP source
> >port (32789).
> 
> Looks normal to me. It might select a random port upon "libc invocation" and 
> use it for all further requests. This is in fact very valid, because UDP is 
> connectionless; packets can go from anywhere to anywhere without any 
> pre-work.
> 
> >  This is causing our firewall to drop some packets since
> >it thinks it already closed that connection due to too many transactions
> >using same udp source/dest port passing thru in too short a time frame.
> 
> Then, the firewall UDP implementation is broken. Note, an UDP connection *can 
> not be closed*, because it never was "open". If it's trying to do something 
> like 
> 	iptables -p udp -m state --state RELATED
> it is doing it wrong, because that is an impossible situation.
> 
> 
> Jan Engelhardt

