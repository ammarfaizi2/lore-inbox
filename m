Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSKIRpv>; Sat, 9 Nov 2002 12:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSKIRpv>; Sat, 9 Nov 2002 12:45:51 -0500
Received: from host194.steeleye.com ([66.206.164.34]:55056 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261433AbSKIRpu>; Sat, 9 Nov 2002 12:45:50 -0500
Message-Id: <200211091752.gA9HqR802867@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Nov 2002 12:52:27 -0500
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> having this config option ass-backwards is mind-bogglingly confusing,
> and there seems no real reason for it. John had a plan to just put  in
> CONFIG_X86_PIT instead as the inverse of this, and delete
> CONFIG_X86_TSC. He seems to have gone off this idea for some reason I
> can't understand ... I think it solves a lot of these issues ...

Actually, this is partly my fault.  When the subarch code went in, the meaning 
of CONFIG_X86_TSC got altered to mean, 'If not y, don't use tsc at all' (so I 
could disable the TSC entirely for Voyager). Then, when code moved to 
kernel/timers we got some code with the old meaning and some with the new, 
hence the confusion.

The CONFIG_X86_PIT was something I added to try to clarify.  There are three 
cases with this:

PIT y, TSC n: Never use TSC, always use PIT
PIT y, TSC y: Try TSC at first, if it doesn't work, fall back to PIT
PIT n, TSC y: TSC always works, use it without testing.

Obviously PIT n, TSC n is bogus.

There are also two distinct usages of TSC:

1. do_fast_gettimeofday (now in timers) which *requires* the TSCs to be 
synchronised across all CPUs
2. more accurate udelay (which already has the mechanisms in place to cope 
with TSCs running at different rates).

1. is usually the reason why numa like machines want to disable the TSC 
entirely.

Linus isn't very happy with the global TSC disable patch (see 
http://marc.theaimsgroup.com/?t=103652952900006&r=1&w=2).  And wants a better 
solution.  (Then, of course, there are the additional timer options, like the 
cyclone).

James





