Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUJHBbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUJHBbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269673AbUJGWHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:07:06 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:46759
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269715AbUJGWB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:01:57 -0400
Date: Thu, 7 Oct 2004 15:00:35 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: martijn@entmoot.nl, hzhong@cisco.com, jst1@email.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041007150035.6e9f0e09.davem@davemloft.net>
In-Reply-To: <4165B9DD.7010603@nortelnetworks.com>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
	<41658C03.6000503@nortelnetworks.com>
	<015f01c4acbe$cf70dae0$161b14ac@boromir>
	<4165B9DD.7010603@nortelnetworks.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2004 15:49:17 -0600
Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> In this case, select() returns with the socket readable, we call recvmsg() and 
> discover the message is corrupt.  At this point we throw away the corrupt 
> message, so we now have no data waiting to be received.  We return EAGAIN, and 
> userspace goes merrily on its way, handling anything else in its loop, then 
> going back to select().

Incorrect.  When the user specifies blocking on the file descriptor
we must give it what it asked for.  -EAGAIN on a blocking file descriptor
is always a bug, in all situations, that's what this code used to do and we
fixed it because it's a bug.

It goes "merrily on its way" if it marks the file descriptor as non-blocking.
