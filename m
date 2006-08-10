Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWHJXJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWHJXJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWHJXJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:09:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932153AbWHJXJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:09:57 -0400
Date: Thu, 10 Aug 2006 16:09:51 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Peter M" <peter.mdk@gmail.com>
Cc: linux-kernel@vger.kernel.org, bridge@osdl.org
Subject: Re: Oops in 2.6.17.7 running multiple eth bridges
Message-ID: <20060810160951.76e02bd3@localhost.localdomain>
In-Reply-To: <31296a430608101459g237ee2c8u509f6a19507d9c6c@mail.gmail.com>
References: <31296a430608101034v2ecfbf8an66510427da49af4d@mail.gmail.com>
	<20060810112847.3d868ccc@localhost.localdomain>
	<31296a430608101459g237ee2c8u509f6a19507d9c6c@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 23:59:56 +0200
"Peter M" <peter.mdk@gmail.com> wrote:

> The analyzer is a AMD Duron around 1200 MHz and has 128 MB of RAM.

Your trying to squeeze blood from a turnip (not tulip) by trying
to run 8 interfaces at once on that system.

> I can't remember if the crashes only comes when I'm running tcpdumps
> on several bridges at a time. But shouldn't the kernel handle it more
> gracefully if it uses up all the memory?
> 
> analyze-this:~# free
> Unknown HZ value! (91) Assume 100.
>              total       used       free     shared    buffers     cached
> Mem:        127280     124800       2480          0      21048      84044
> -/+ buffers/cache:      19708     107572
> Swap:       506036          0     506036
> 
> Regards
> Peter
> 
> 2006/8/10, Stephen Hemminger <shemminger@osdl.org>:
> > On Thu, 10 Aug 2006 19:34:22 +0200
> > "Peter M" <peter.mdk@gmail.com> wrote:
> >
> > > I have built a multi bridge i386 machine with 8 eth devices which
> > > keeps crashing on me.
> > >
> > > Kernel 2.6.7.17
> > >
> > > I'm using a network card with 4 ports (tulip) and 4 r8169 based cards.
> > >
> > > br0: eth0 eth1
> > > br1: eth2 eth3
> > > br2: eth3 eth4
> > > br3: eth5 eth6
> > >
> > > Below crash came when I unplugged a cable on a running bridge. Today I
> > > have had two crashes without touching the cables but didn't get any
> > > usable syslog.
> > >
> > > I have attached a number of info files which might help.
> > >
> > > Regards
> > > Peter M.
> >
> > Looks like you are running out of memory.  You will need more memory
> > to be able to hold all the receive rings data, as well as data in flight.
> > Rough estimate:
> >
> >         R8169 := 4 * 256 (ringsize) * 2K
> >         Tulip := 4 * 128  * 2K
> >
> > That comes out to 3 Meg in use just being idle. Once you get going
> > it could easily be 3x that.
> >
> > And that is for standard 1500 byte MTU. If you use large packets, you
> > will have problems with memory fragmentation and will probably have
> > to go to a bigger 64 bit machine and even more memory.
> >

The kernel should survive short term memory pressure (it will get noisy), 
but you can't survive that way forever. Unless memory is free soon,
it will deadlock itself because some critical operation can't get
memory.

You could try reducing the size of the transmit queues, and receive
rings, either with scripts or by modifying the drivers.
-- 
