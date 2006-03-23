Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWCWJDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWCWJDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWCWJDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:03:54 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:47966 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751329AbWCWJDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:03:53 -0500
Date: Thu, 23 Mar 2006 11:04:41 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: John Heffner <jheffner@psc.edu>, "David S. Miller" <davem@davemloft.net>,
       dror@xiv.co.il
Subject: Re: [TCP]: rcvbuf lock when tcp_moderate_rcvbuf enabled
Message-ID: <20060323090441.GA8502@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Below, I've forwarded change from 2.6.16 which I think may causes 
problems for applications that use setsockopt with SO_RCVBUF. We are 
using an implementation of an iSCSI target and according to network 
sniffs it seems that during data transfer the receive window 
unjustifyingly shrinks to a very low size (180 bytes). I can guess
that the code below indirectly affects the receive window size, but 
I'm not sure how it the logic works here, a clarification could be
helpful.

It's worth to mention that we have sysctl_tcp_moderate_rcvbuf=1, but 
I don't think it should interfere with applications that request to 
have a fixed receive buffer by the means of setsockopt(). I can also 
tell by experiment that reverting the change below makes the problem 
go away.

--- a97ed5416c28ee14ecab0ac4483c079a0c3e4c1d
+++ e9a54ae7d6903845598db14a8e1cba54026faf1b
@@ -456,7 +456,8 @@ void tcp_rcv_space_adjust(struct sock *s
 
 		tp->rcvq_space.space = space;
 
-		if (sysctl_tcp_moderate_rcvbuf) {
+		if (sysctl_tcp_moderate_rcvbuf &&
+		    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
 			int new_clamp = space;
 
 			/* Receive space grows, normalize in order to

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
