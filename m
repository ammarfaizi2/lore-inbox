Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274549AbRJEX2g>; Fri, 5 Oct 2001 19:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274573AbRJEX21>; Fri, 5 Oct 2001 19:28:27 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:47121 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S274549AbRJEX2K>;
	Fri, 5 Oct 2001 19:28:10 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15294.16913.2117.383987@cargo.ozlabs.ibm.com>
Date: Sat, 6 Oct 2001 09:28:17 +1000 (EST)
To: Peter Rival <frival@zk3.dec.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        benh@kernel.crashing.org
Subject: Re: [PATCH] change name of rep_nop
In-Reply-To: <3BBDF6BC.5000300@zk3.dec.com>
In-Reply-To: <E15pW6U-0006Xx-00@the-village.bc.nu>
	<3BBDF6BC.5000300@zk3.dec.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Rival writes:

> You also need to move the call to smp_boot_cpus() below the 
> clear_bit(...) line in smp_init().  Without it, my Wildfire doesn't get 

No, that won't work for me, because cpu_online_map is set by
smp_boot_cpus(), at least on PPC (in fact each CPU sets its bit in
cpu_online_map as it spins up).

There shouldn't be a race on x86 at all, because the secondary
processors don't call init_idle until after they see that the primary
cpu has call smp_commence.  (There is currently a race on PPC since we
call init_idle before waiting for smp_commence, but that would not be
your problem.)

> past the while(wait_init_idle) loop - seems all of the CPUs have already 
> done their work before the mask is set.  Besides, it's the right place 
> for it anyway.

No, I think it should be smp_boot_cpus, set wait_init_idle,
smp_commence, then the secondaries start clearing their bits.  Which
AFAICS is the way it is on x86.  What architecture is your wildfire?

Paul.
