Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263057AbTCLAXK>; Tue, 11 Mar 2003 19:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263042AbTCLAW5>; Tue, 11 Mar 2003 19:22:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:40084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262993AbTCLAVE>;
	Tue, 11 Mar 2003 19:21:04 -0500
Subject: Re: [PATCH] (8/8) Kill brlock
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <20030311.162323.94095868.davem@redhat.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
	 <1047428123.15872.113.camel@dell_ss3.pdx.osdl.net>
	 <20030311.162323.94095868.davem@redhat.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047429105.15875.123.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:31:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 16:23, David S. Miller wrote:
>    From: Stephen Hemminger <shemminger@osdl.org>
>    Date: 11 Mar 2003 16:15:23 -0800
> 
>    Previous patches killed all remaining uses of brlock so bye.
>    
> I'm all for this once patch 2/8 gets fixed up :-)
> 
> So what is the new way to say "stop all incoming packet
> processing while I update data structure X"?

The caller's didn't need to stop packet processing, just remove their type
from a list or some other call back hook.  A simple pointer update takes
care of removing a simple call back. The list delete rcu code takes care
of the memory barriers and doing the updates in the right order.
This ensures no future packet processing will grab that token

The next problem is how to ensure that packets in flight are not using
the hook.  This is handled by call_rcu() for the more general case where
processing can be deferred (only used a couple places).  Other places
use synchronize_kernel() which just waits.  What call_rcu() does is make sure
that every processor has seen the change.



