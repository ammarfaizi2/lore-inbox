Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284638AbRLEUE4>; Wed, 5 Dec 2001 15:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284639AbRLEUEr>; Wed, 5 Dec 2001 15:04:47 -0500
Received: from ns.suse.de ([213.95.15.193]:18955 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284636AbRLEUEc>;
	Wed, 5 Dec 2001 15:04:32 -0500
To: Vladimir Ivaschenko <hazard@francoudi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendmsg() leaves Identification field in IP header empty
In-Reply-To: <3C0E6F8B.A6C85AB6@francoudi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Dec 2001 21:04:27 +0100
In-Reply-To: Vladimir Ivaschenko's message of "5 Dec 2001 20:08:57 +0100"
Message-ID: <p73d71t8md0.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Ivaschenko <hazard@francoudi.com> writes:

> Hi All,
> 
> I've been struggling to understand why an application which worked fine
> on 2.2.X stopped working on 2.4.7 (RH72) and found out that sendmsg()
> always leaves Identification field in IP header set to 0 (at least for
> UDP sockets). This confuses Cisco devices when you're doing
> WCCP negotiations with them. The application is "Oops!" proxy server -
> http://zipper.paco.net/~igor/oops.eng/

Linux does that for all sockets with DF set.  Don't ask why it is a long story;
in summary for some reason it gets rather expensive to compute ipid so it is
avoided as far as possible and it is not strictly needed for packets with 
DF set because the ipid should be only needed for defragmenting.

For TCP it caused serious problems with buggy VJ header compression functions
so a 'fake id' per socket is generated. This was not done for UDP however. 

For UDP you could get an IPID by turning path mtu discovery off; i.e.
using the IP_PMTU_DISCOVERY socket options. See ip(7) for more details.

In theory the hack from TCP could be ported to UDP too, but I'm not sure if it is
worth it for WCCP (to be honest I don't know what WCCP is so I cannot assess if 
it's important enough to add a workaround for it) 

Another way would be to switch back to traditional ipid computation, as the
'secure' ipid does not seem to be worth the effort and problems it causes.

> 
> Sorry if I'm wrong but I think this is a kernel problem because
> sendmsg() is a system call. On RH6.2 with 2.2.19 this doesn't happen,

It's strictly not a bug because the RFCs don't require an IPID for !DF.


-Andi

