Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317395AbSGDMf5>; Thu, 4 Jul 2002 08:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSGDMf4>; Thu, 4 Jul 2002 08:35:56 -0400
Received: from aboukir-101-1-23-willy.adsl.nerim.net ([62.212.114.60]:10003
	"EHLO www.home.local") by vger.kernel.org with ESMTP
	id <S317395AbSGDMfz>; Thu, 4 Jul 2002 08:35:55 -0400
Date: Thu, 4 Jul 2002 14:38:22 +0200
From: Willy Tarreau <willy@w.ods.org>
To: gphat@cafes.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large numbers of TCP resets
Message-ID: <20020704123822.GA26203@alpha.home.local>
References: <20020703201553.DE9FD68CB5EA@mail.cafes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020703201553.DE9FD68CB5EA@mail.cafes.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 08:15:53PM +0000, gphat@cafes.net wrote:
> Recently, the web-app at the company I work for started having problems load 
> balancing.  This was traced back to a large number of tcp-resets being sent 
> from the web servers to the clients.

aren't your load balancers Alteon ACE Directors ? If this is the case, I
suspect you use "fastage 0", which ends sessions prematurely. This
particularly happens in case of direct access mode (DAM) because the
switch needs to remap source ports, and when the session expires, it
simply routes packets from server to client without DNATing them.

The client then receives ACKs and/or FINs for closed ports, or for
open ports, but with bad sequence numbers, and then sends RESETS,
which the server doesn't understand. I observed real RST storms
during tens of minutes because of this. They disappeared when I
set "fastage" to something higher than 4 (=keep the session at least
16 seconds, even in final states).

I think this is not specific to Linux 2.4 since I observed a similar
behaviour with Solaris 8.

Cheers,
Willy

