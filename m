Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932687AbWF3NvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687AbWF3NvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWF3NvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:51:06 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:33002 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S932677AbWF3NvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:51:04 -0400
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Andrey Savochkin <saw@swsoft.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Dave Hansen <haveblue@us.ibm.com>, Ben Greear <greearb@candelatech.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, devel@openvz.org,
       viro@ftp.linux.org.uk, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
In-Reply-To: <20060630114551.A20191@castle.nmd.msu.ru>
References: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	 <44A1689B.7060809@candelatech.com>
	 <20060627225213.GB2612@MAIL.13thfloor.at>
	 <1151449973.24103.51.camel@localhost.localdomain>
	 <20060627234210.GA1598@ms2.inr.ac.ru>
	 <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	 <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2>
	 <44A44124.5010602@vilain.net> <1151626552.8922.70.camel@jzny2>
	 <20060630114551.A20191@castle.nmd.msu.ru>
Content-Type: text/plain
Organization: unknown
Date: Fri, 30 Jun 2006 09:50:52 -0400
Message-Id: <1151675452.5270.10.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

BTW - I was just looking at openvz, very impressive. To the other folks,
I am not putting down any of your approaches - just havent
had time to study them. Andrey, this is the same thing you guys have
been working on for a few years now, you just changed the name, correct?

Ok, since you guys are encouraging me to speak, here goes ;->
Hopefully this addresses the other email from Herbert et al.

On Fri, 2006-30-06 at 11:45 +0400, Andrey Savochkin wrote: 
> Hi Jamal,
> 
> On Thu, Jun 29, 2006 at 08:15:52PM -0400, jamal wrote:
> > On Fri, 2006-30-06 at 09:07 +1200, Sam Vilain wrote:
> [snip]

> 
> I do not have anything against guest-eth0 - eth0 pairs _if_ they are set up
> by the host administrators explicitly for some purpose.
> For example, if these guest-eth0 and eth0 devices stay as pure virtual ones,
> i.e. they don't have any physical NIC, host administrator may route traffic
> to guestXX-eth0 interfaces to pass it to the guests.
> 

Well there will be purely virtual of course.  Something along the lines
for openvz:

// create the guest
[host-node]# vzctl create 101 --ostemplate fedora-core-5-minimal 
// create guest101::eth0, seems to only create config to boot up with 
[host-node]# vzctl create 101 --netdev eth0
// bootup guest101
[host-node]# vzctl start 101

As soon as bootup of guest101 happens, creating guest101::eth0 should activate 
creation of the host side netdevice. This could be triggered for example by
the netlink event message seen on host whic- which is a result of creating guest101::eth0 
Which means control sits purely in user space.

at that point if i do ifconfig on host i see g101-eth0
on guest101 i see just name eth0.

My earlier suggestion was that instead of:
host-node]# vzctl set 101 --ipadd 10.1.2.3

you do:
host-node]# ip addr add g101-eth0 10.1.2.3/32
you should still use vzctl to save config for next bootup

> However, I oppose the idea of automatic mirroring of _all_ devices appearing
> inside some namespaces ("guests") to another namespace (the "host").
> This clearly goes against the concept of namespaces as independent realms,
> and creates a lot of problems with applications running in the host, hotplug
> scripts and so on.
> 

I was thinking that the host side is the master i.e you can peek at
namespaces in the guest from the host.
Also note that having the pass through device allows for guests to be
connected via standard linux schemes in the host side (bridge, point
routes, tc redirect etc); so you dont need a speacial device to hook
them together.

> > > Then the pragmatic question becomes how to correlate what you see from
> > > `ip addr list' to guests.
> > 
> > on the host ip addr and the one seen on the guest side are the same.
> > Except one is seen (on the host) on guest0-eth0 and another is seen 
> > on eth0 (on guest).
> 
> Then what to do if the host system has 10.0.0.1 as a private address on eth3,
> and then interfaces guest1-tun0 and guest2-tun0 both get address 10.0.0.1
> when each guest has added 10.0.0.1 to their tun0 device?
> 

Yes, that would be a conflict that needs to be resolved. If you look at
ip addresses as also belonging to namespaces, then it should work, no?
i am assuming a tag at the ifa table level.

cheers,
jamal


