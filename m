Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271319AbTHRHgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 03:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTHRHgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 03:36:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:48907 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271310AbTHRHge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 03:36:34 -0400
Date: Mon, 18 Aug 2003 09:29:22 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030818072922.GB15098@alpha.home.local>
References: <200308171555280781.0067FB36@192.168.128.16> <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk> <200308171759540391.00AA8CAB@192.168.128.16> <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk> <200308171827130739.00C3905F@192.168.128.16> <1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk> <20030817224849.GB734@alpha.home.local> <20030817222258.257694b9.davem@redhat.com> <20030818065652.GA15098@alpha.home.local> <20030818000139.6964cd04.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818000139.6964cd04.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 12:01:39AM -0700, David S. Miller wrote:
> On Mon, 18 Aug 2003 08:56:52 +0200
> Willy Tarreau <willy@w.ods.org> wrote:
> 
> > But I'm willing to try arpfilter if you show me where to start from.
> 
> There are tools at:
> 
> 	http://ebtables.sourceforge.net/

Thanks, I've downloaded them and will take a look at them. By the time, I did
some random tests with 'ip arp', and found a simple way to solve the problem
I reported initially. This can be of interest to others BTW :

Trivial example below :

   My host wants to use address 10.0.0.1 to talk to the world, but through
   the gateway 11.0.0.2 reachable from 11.0.0.1 :

   ip address add 10.0.0.1/24 dev eth0
   ip address add 11.0.0.1/24 dev eth0
   ip route   add default     via 11.0.0.2 src 10.0.0.1
=> same as before till this
   ip arp     append table output to 11.0.0.0/24 oif eth0 src 11.0.0.1
=> now it will use 11.0.0.1 to find its gateway (11.0.0.2)

So as a general rule of thumb, I would recommend people to systematically call
"ip arp append table output to [network] oif [NIC] src [local_ip]" after an
"ip address add [local_ip] dev [NIC]". And yes, I agree that these are standard
tools, but I maintain that the default behaviour should be cleaner.

I also found that I can filter incoming requests easily with "table input" :

   ip arp append table input deny
   ip arp add    table input allow from 11.0.0.0/24 to 11.0.0.0/24 iif eth0
   ip arp add    table input allow from 10.0.0.0/24 to 10.0.0.0/24 iif eth0

I don't understand how the forward table is used, BTW, but I'll search a bit
more. If I finally understand how all this works, I may propose a simple how-to
to put under Documentation/networking/arp.txt so solve most common problems.

Cheers,
Willy

