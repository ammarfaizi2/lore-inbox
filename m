Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282597AbRK2Tzq>; Thu, 29 Nov 2001 14:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282906AbRK2Tz1>; Thu, 29 Nov 2001 14:55:27 -0500
Received: from ns.suse.de ([213.95.15.193]:1803 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282597AbRK2TzU>;
	Thu, 29 Nov 2001 14:55:20 -0500
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: ethernet links should remember routes the same as addresses
In-Reply-To: <3C068ED1.D5E2F536@nortelnetworks.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Nov 2001 20:55:17 +0100
In-Reply-To: "Christopher Friesen"'s message of "29 Nov 2001 20:43:02 +0100"
Message-ID: <p73r8qhqrmi.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher Friesen" <cfriesen@nortelnetworks.com> writes:

> Suppose I have a fancy routing setup, dynamically configured by different
> binaries, scripts, etc, complete with multiple addresses per link, additional
> routing rules and tables specified using iproute2, etc.
> 
> An ethernet driver hangs.  Could be a software bug, an intermittent hardware
> issue, whatever.  It can be fixed up by setting the link down and up.
> 
> Currently, if I run "ip link set dev ethX down", all routes associated with that
> IP address in the additional routing tables are lost.  This is somewhat
> understandable, as the addresses are not actually available anymore.  However,
> the addresses are still visible associated with the link.  Then I run "ip link
> set dev ethX up".  The route in the main routing table comes back, but none of
> the other routes do.  Somehow, all of those additional routes must be re-added.

ip route list dev device > BACKUP

...

while read i ; do ip route add $i ; done < BACKUP


> 
> Wouldn't it be nice if we could keep track of these additional routes?  Then you
> could simply 'down' and 'up' the link and everything would be back the way it
> was before.
> 
> Does this sound like a good idea?  How hard would this be to implement (not
> knowing what the current code looks like, I don't know how this would be done)?

In kernel very easy. The IP addresses and the driver init/cleanup are 
completely separated and can be easily done independent. You may need
some way to prevent packets getting submitted to the driver (e.g. a
netif_carrier_off but make sure to not confuse it with a real 
netif_carrier_off done by the driver, so you'll likely need a new flag) 

I'm not sure it it worth it though given how easily it is to simulate
in user space. If you really wanted it I guess best would be to add new 
ioctls for it. Coding should be easy.

-Andi
