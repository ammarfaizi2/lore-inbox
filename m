Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWF3Cjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWF3Cjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWF3Cjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:39:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:55003 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750792AbWF3Cjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:39:53 -0400
Date: Thu, 29 Jun 2006 21:39:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Sam Vilain <sam@vilain.net>, hadi@cyberus.ca,
       Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, serue@us.ibm.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrey Savochkin <saw@swsoft.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strict isolation of net interfaces
Message-ID: <20060630023947.GA24726@sergelap.austin.ibm.com>
References: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com> <44A1689B.7060809@candelatech.com> <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net> <44A450D1.2030405@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A450D1.2030405@fr.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cedric Le Goater (clg@fr.ibm.com):
> Sam Vilain wrote:
> > jamal wrote:
> >>> note: personally I'm absolutely not against virtualizing
> >>> the device names so that each guest can have a separate
> >>> name space for devices, but there should be a way to
> >>> 'see' _and_ 'identify' the interfaces from outside
> >>> (i.e. host or spectator context)
> >>>
> >>>     
> >> Makes sense for the host side to have naming convention tied
> >> to the guest. Example as a prefix: guest0-eth0. Would it not
> >> be interesting to have the host also manage these interfaces
> >> via standard tools like ip or ifconfig etc? i.e if i admin up
> >> guest0-eth0, then the user in guest0 will see its eth0 going
> >> up.
> > 
> > That particular convention only works if you have network namespaces and
> > UTS namespaces tightly bound.  We plan to have them separate - so for
> > that to work, each network namespace could have an arbitrary "prefix"
> > that determines what the interface name will look like from the outside
> > when combined.  We'd have to be careful about length limits.
> > 
> > And guest0-eth0 doesn't necessarily make sense; it's not really an
> > ethernet interface, more like a tun or something.
> > 
> > So, an equally good convention might be to use sequential prefixes on
> > the host, like "tun", "dummy", or a new prefix - then a property of that
> > is what the name of the interface is perceived to be to those who are in
> > the corresponding network namespace.
> > 
> > Then the pragmatic question becomes how to correlate what you see from
> > `ip addr list' to guests.
> 
> 
> we could work on virtualizing the net interfaces in the host, map them to
> eth0 or something in the guest and let the guest handle upper network layers ?
> 
> lo0 would just be exposed relying on skbuff tagging to discriminate traffic
> between guests.

This seems to me the preferable way.  We create a full virtual net
device for each new container, and fully virtualize the device
namespace.

> host                  |  guest 0  |  guest 1  |  guest2
> ----------------------+-----------+-----------+--------------
>   |                   |           |           |
>   |-> l0      <-------+-> lo0 ... | lo0       | lo0
>   |                   |           |           |
>   |-> bar0   <--------+-> eth0    |           |
>   |                   |           |           |
>   |-> foo0   <--------+-----------+-----------+-> eth0
>   |                   |           |           |
>   `-> foo0:1  <-------+-----------+-> eth0    |
>                       |           |           |
> 
> 
> is that clear ? stupid ? reinventing the wheel ?

The last one in your diagram confuses me - why foo0:1?  I would
have thought it'd be

host                  |  guest 0  |  guest 1  |  guest2
----------------------+-----------+-----------+--------------
  |                   |           |           |
  |-> l0      <-------+-> lo0 ... | lo0       | lo0
  |                   |           |           |
  |-> eth0            |           |           |
  |                   |           |           |
  |-> veth0  <--------+-> eth0    |           |
  |                   |           |           |
  |-> veth1  <--------+-----------+-----------+-> eth0
  |                   |           |           |
  |-> veth2   <-------+-----------+-> eth0    |

I think we should avoid using device aliases, as trying to do
something like giving eth0:1 to guest1 and eth0:2 to guest2
while hiding eth0:1 from guest2 requires some uglier code (as
I recall) than working with full devices.  In other words,
if a namespace can see eth0, and eth0:2 exists, it should always
see eth0:2.

So conceptually using a full virtual net device per container
certainly seems cleaner to me, and it seems like it should be
simpler by way of statistics gathering etc, but are there actually
any real gains?  Or is the support for multiple IPs per device
actually enough?

Herbert, is this basically how ngnet is supposed to work?

-serge
