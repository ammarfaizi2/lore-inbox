Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVCPOjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVCPOjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVCPOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:38:56 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:12956 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262609AbVCPOhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:37:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: CPU hotplug on i386
Date: Wed, 16 Mar 2005 15:40:03 +0100
User-Agent: KMail/1.7.1
Cc: kernel list <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au
References: <20050316132151.GA2227@elf.ucw.cz>
In-Reply-To: <20050316132151.GA2227@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503161540.04480.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 16 of March 2005 14:21, Pavel Machek wrote:
> Hi!
> 
> I tried to solve long-standing uglyness in swsusp cmp code by calling
> cpu hotplug... only to find out that CONFIG_CPU_HOTPLUG is not
> available on i386. Is there way to enable CPU_HOTPLUG on i386?

Heh, that's exactly what I was thinking about.  ;-)

AFAICS we don't need the full CPU hotplug to do this.  For suspend, we need to
enable the CPU hotplug-related code in sched.c and cpu.c, and we need to
implement the functions __cpu_disable() and __cpu_die() (called from within
cpu.c) on each architecture for which we want swsusp to work on SMP.

If that's acceptable, the CPU hotplug code in sched.c and cpu.c may be
enabled by changing some #ifdefs there.  For example, we could replace the

#idef CONFIG_CPU_HOTPLUG

with

#if defined(CONFIG_CPU_HOTPLUG) || (defined(CONFIG_SOFTWARE_SUSPEND)
	&& defined(CONFIG_SMP))

wherever necessary.

The implementation of __cpu_disable() and __cpu_die() may be a bit more
tricky, however.  In __cpu_disable() we need to save the settings of the local
APIC of each CPU (on x86-64, at least) etc.  In __cpu_die() we should give the
"frozen" CPU some "neutral" code to execute, it seems (or "hlt" it?).

I've looked at the ia64 implementation of these functions, but I haven't fully
understood it yet.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
