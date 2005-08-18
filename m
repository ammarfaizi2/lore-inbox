Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVHRWyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVHRWyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVHRWyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:54:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25225
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750710AbVHRWyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:54:17 -0400
Date: Thu, 18 Aug 2005 15:54:21 -0700 (PDT)
Message-Id: <20050818.155421.65905823.davem@davemloft.net>
To: seb@highlab.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.5 bug? per-socket TCP keepalive settings
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <E1E5sXs-00048w-Rv@highlab.com>
References: <E1E5sXs-00048w-Rv@highlab.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Kuzminsky <seb@highlab.com>
Date: Thu, 18 Aug 2005 16:07:32 -0600

> Linux provides 3 non-standard TCP socket options for tweaking the
> keepalive behavior of individual sockets: TCP_KEEPIDLE, TCP_KEEPCNT,
> and TCP_KEEPINTVL.  The values set on a socket with these options should
> override the system-wide default.

There is a fourth setting, the SO_KEEPALIVE socket option, which
also must be enabled explicitly by the application to enable keepalives.
It defaults to off.  Your application sets this, so all is fine so far.

> The right thing is to wait IDLE seconds, then send CNT probes INTVL
> seconds apart, then reset the TCP connection.
>
> The wrong behavior I'm seeing is the first probe goes out on schedule,
> and sometimes a few more probes go out on schedule, but then it stops
> sending anything at all.  It doesnt send the last of the probes, and it
> doesnt send the reset.  The connection is stuck in the ESTABLISHED state,
> according to netstat.

Your test case is questionable, because you do not receive even one
ACK in established state, thus the tp->rcv_tstamp variable has no
way to get initialized.  The only ACK you receive is the one in
response to the connection setup SYN, and we don't initialize
tp->rcv_stamp for that ACK.

The keepalive time checks absolutely require that tp->rcv_tstamp
has a valid value, and until you process an ACK in ESTABLISHED
state it does not.

If you send successfully or receive successfully at least one byte
over the connection, and thusly process at least one ACK in
ESTABLISHED state, I think you'll find that the keepalives behave
properly.
