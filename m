Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263186AbUJ2AR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbUJ2AR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUJ2AIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:08:13 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:24464
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263160AbUJ2AFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:05:18 -0400
Date: Thu, 28 Oct 2004 16:56:58 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Meda, Prasanna" <pmeda@akamai.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com
Subject: Re: rcv_wnd = init_cwnd*mss
Message-Id: <20041028165658.753eee50.davem@davemloft.net>
In-Reply-To: <DB2C167D8FFDEA45B8FC0B1B75E3EE154A3B08@usca1ex-priv1.sanmateo.corp.akamai.com>
References: <DB2C167D8FFDEA45B8FC0B1B75E3EE154A3B08@usca1ex-priv1.sanmateo.corp.akamai.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 23:15:48 -0700
"Meda, Prasanna" <pmeda@akamai.com> wrote:

> Thanks, still it is unclear to me why are we
> downsizing the advertised window(rcv_wnd) to cwnd? 
> To defeat disobeying sender, or something like below?

There is never any reason to advertise a receive window
larger than the initial congestion window of the sender
could ever be.

Setting it properly like this also makes sure that we do
receive window update events at just the right place as
the sender starts sending us the initial data frames.

> And also in the following line,
> if (*rcv_wscale && sysctl_tcp_app_win && space>=mss &&
>                     space - max((space>>sysctl_tcp_app_win), mss>>*rcv_wscale) <
> 65536/2)
> 
> space is actual_space>>rcv_wscale, mss is actual value.
> Why are we checking space>=mss, which are in different
> scales? The second line is doing max on space and mss 
> on same scales, and looks right.

Yep, that space>=mss test looks super buggy for the *rcv_wscale
not zero case.

Good thing we don't have this buggy code in 2.6.x any more.
It's only present in 2.4.x
