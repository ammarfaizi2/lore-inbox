Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTFGSsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 14:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTFGSsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 14:48:53 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:47876 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263369AbTFGSsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 14:48:45 -0400
Date: Sat, 7 Jun 2003 21:01:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: wa@almesberger.net, <chas@cmf.nrl.navy.mil>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
In-Reply-To: <20030606.235811.39162108.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0306071922350.12110-100000@serv>
References: <20030606125416.C3232@almesberger.net>
 <200306062354.h56NsWsG002919@ginger.cmf.nrl.navy.mil> <20030606212026.I3232@almesberger.net>
 <20030606.235811.39162108.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 6 Jun 2003, David S. Miller wrote:

> unregister_netdevice() rips the device out and returns, and
> the problems we need to fix to make this work %100 are problems
> that exist regardless of whether things operate asynchronously
> or not.
> 
> For example, crap like this was always busted:
> 
> 	rmmod eth0 </proc/sys/net/ipv4/conf/eth0/whatever
> 
> and now the asynchornous model forces us to fix this.

The basic problem is still that module_exit is a synchronous interface, 
from where you can't call any asynchronous functions, unless you prevent 
new callbacks via try_module_get() or you have to wait for all pending 
events. This means you have to artificially turn an asynchronous interface 
into a synchronous one, if you want to use it from module_exit.
The current problems can be of course fixed within the current module 
model, but it certainly won't be simpler than the alternatives. An 
asynchronous module model would greatly help to avoid lots of 
try_module_get() in many code paths.

> It really showed how pointless linux-kernel discussion can
> be and how much such rediculious discussions can totally impede
> real progress because someone LOUD disagrees with someone's
> game plan.

Well, I certainly won't stand in the way, if people want to learn it the 
hard way. I can try to explain the problems, but I can't force anyone to 
listen. On the contrary I can only encourage everyone to fix the problems 
within the current module framework, it's certainly possible. The high 
level interfaces like file systems or network devices are rather simple, 
but the more fine-grained the modules become, the more interesting it will 
get. These problems need to be fixed anyway and once they are fixed, the 
easier it will be for me to demonstrate alternative solutions (for 2.6 
it's too late anyway and I don't have the time to fix all the problems 
myself) and until then I have no problem to just shut up if nobody wants 
to listen anyway.
The only thing I really regret are the complete new user utilities, this 
was completely unnecessary and it will likely change again anyway (by 
merging it with the hot plug interface).

bye, Roman

