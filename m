Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTDOScI (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbTDOScI 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:32:08 -0400
Received: from opersys.com ([64.40.108.71]:18698 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S263654AbTDOScF 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 14:32:05 -0400
Message-ID: <3E9C19C6.70B94C67@opersys.com>
Date: Tue, 15 Apr 2003 14:40:06 +0000
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Hicks <mort@wildopensource.com>
CC: Patrick Mochel <mochel@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       hpa@zytor.com, pavel@ucw.cz, jes@wildopensource.com,
       linux-kernel@vger.kernel.org, wildos@sgi.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [patch] printk subsystems
References: <20030408161010.25de9e09.rddunlap@osdl.org> <Pine.LNX.4.44.0304141325010.14087-100000@cherise> <20030415132741.GR3413@bork.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Hicks wrote:
> I'm not sure that this addresses the core problem that I'm trying to
> deal with.  The problem is that machines with certain configurations
> (large number of CPUs, Nodes, or a bunch of SCSI and disks) display far
> too many messages to the console, resulting in the log buffer being
> overflowed.  The method that I'm proposing simply allows you to decide
> what gets logged when a printk() happens, depending on the message's
> priority and which subsystem it originated from.

I'm not going to address the "filtering" aspect of the problem, but
I would like to point out that this issue of printk overflowing and
having multiple streams of printk is already solved by relayfs:
http://www.opersys.com/relayfs/

With relayfs, one could easily have multi-channel printks (e.g. one
for each "subsystem" and a main one for important messages of all
subsystems.) The advantages of relayfs are obvious:
- No more lost printks.
- A unified buffering scheme for all subsystems that need to send
data to user-space.
- Lockless per-cpu buffering.
- etc.

We've already started playing around with printk on relayfs, though
we don't have code to offer at this time.

In terms of init-time printk'ing with relayfs, this is the scheme
I suggest:
- Change all statically allocated printk buffers to __initdata.
- Add a registration function in kernel/printk.c which is called
during initialization.
- Said function:
	1) Allocates relayfs channel(s)
	2) Atomically copies existing init-time data to channel
	3) Starts using relayfs channel for all future transfers

That's it. Thereafter, all statically allocated printk buffers are
dropped and all buffer management is left to relayfs.

[The filtering aspect is not taken care of by relayfs because it
is not part of its "mandate". relayfs only aims at providing a
very reliable lightweight high-speed data transfer mechanism for
providing kernel data to user space. Higher-level mechanisms can
easily use different relayfs channels to filter/mux data.]

Karim

===================================================

                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
