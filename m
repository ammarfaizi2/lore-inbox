Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRDCWgj>; Tue, 3 Apr 2001 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRDCWgT>; Tue, 3 Apr 2001 18:36:19 -0400
Received: from dial023.za.nextra.sk ([195.168.64.23]:4 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S131733AbRDCWgM>;
	Tue, 3 Apr 2001 18:36:12 -0400
Date: Wed, 4 Apr 2001 02:39:11 +0200
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: Question about SysRq
Message-ID: <20010404023911.A1260@Boris>
In-Reply-To: <20010331230454.A801@Boris> <Pine.LNX.4.30.0104021654340.29684-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104021654340.29684-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Mon, Apr 02, 2001 at 04:59:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Unfortunately,
> the only one that responds is sysrq-b, which boots the box without
> syncing or unmounting the disks. Not only does that piss me off but it's
> led to some fs corruption as well (which pisses me off even more). sysrq-b
> is the *only* combination I can get working when this happens. 

I looked a bit at the source of sysrq handling. I've found there is
rather big difference between sysrq+b and other killers handling.
Sysrq+b is just called with pretty straitforward fashion - stops other 
processors on SMP and reboots directly (hardware impulse or triple fault)
or through the bios - so it just calls for the corruptions.

On the other side sysrq+s marks a single variable, which will be tested
next cycle in the bdflush kernel threads' main loop, and adds bdflush to
scheduler runqueue list. So it gets possibility to check for emergency
sync onle when gets next scheduled. Does it ?

Can you anyhow find something in your logs/console/serial console messages
like 13.13.2000 kernel : Sysrq: Emergency Sync (this should be present - is 
written within keyboard handler, not after shedule) and what's next logs ?
We could determine, if the bdflush thread got scheduled and called emergency 
syncing routine indeed.

As you wrote no of your processes does respond - probably telnet will 
not help. You may try to write experimental programme, that only log
say current time every n seconds, and see, if it just stopped to 
log messages after lockup-time. If not - it doesn't get scheduled.
If continues - there's problem with syncing. Again - try, as far
as i understand, log kernel messages to serial console or alike, because
the messages should not get written to logfiles - syslogd can't be woken up
eg.

Quick help against those corruptions, which comes on my mind, is use
the reiserfs. I have no real experiences with that and its reliability,
also as aj followed some of messages in this list about resierfs - it has
some problems too - but in definition it shoudn't get corrupted by not-
syncing reboot. But i see this not much helpfull ,cause if you really 
would depend on big reliability, you wouldn't intall 2.3.x-pre kernel :)

There go also occasionally discussions about watchdogs - it may be
helpfull - but none of the two really solve the problem.

LW: today a got ugly lockup with dosemu and experimental execution of
virtual pool ;). Neither Sysrq+b functioned. But that's probably another
story. Root or privilege suid processes (X server among them) need really 
just a 1-bit error to corrupt near what they like.

The least fsck sessions and nice day                                     B.
