Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269865AbUJGW0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269865AbUJGW0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269851AbUJGWZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:25:52 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:2472
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269865AbUJGWZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:25:13 -0400
Date: Thu, 7 Oct 2004 15:24:00 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Cc: cfriesen@nortelnetworks.com, hzhong@cisco.com, jst1@email.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041007152400.17e8f475.davem@davemloft.net>
In-Reply-To: <000901c4acc4$26404450$161b14ac@boromir>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
	<41658C03.6000503@nortelnetworks.com>
	<015f01c4acbe$cf70dae0$161b14ac@boromir>
	<4165B9DD.7010603@nortelnetworks.com>
	<20041007150035.6e9f0e09.davem@davemloft.net>
	<000901c4acc4$26404450$161b14ac@boromir>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2004 00:19:52 +0100
"Martijn Sipkema" <msipkema@sipkema-digital.com> wrote:

> So why not return EIO instead? It would be even better to have select()
> validate the data, but I think returning EIO is better than blocking and most
> likely POSIX compliant.

It's not EIO either, it's "queue empty" which means block.
-EIO is a hard error.  You're trying to find some clever way
to say "try again", but:

1) -EAGAIN is illegal on blocking sockets
2) -EIO is a hard error and does not mean "try again"

Therefore we block, which is the correct thing to do in this
situation.

Applications which wish not to block should (SURPRISE SURPRISE)
use non-blocking sockets, otherwise blocking is ok for them.

I can't believe this thread has lasted this long.  I think people
had cotton in their ears when I mentioned that every single 2.4.x
and 2.6.x existing system out there has this behavior, therefore
even if we changed the behavior some way today people still need
to handle this to work on all existing Linux systems.

Furthermore, returning -EAGAIN or any other kind of "try again"
_DOES_ break applications, that's why we changed it to block instead.
