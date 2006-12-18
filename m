Return-Path: <linux-kernel-owner+w=401wt.eu-S1753360AbWLRGR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbWLRGR4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 01:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbWLRGR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 01:17:56 -0500
Received: from hera.kernel.org ([140.211.167.34]:43835 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbWLRGRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 01:17:55 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: IO-APIC + timer doesn't work
Date: Mon, 18 Dec 2006 01:16:57 -0500
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>,
       Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <Pine.LNX.4.64.0612161603070.3479@woody.osdl.org> <m1d56jt7uj.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1d56jt7uj.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612180116.58175.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 December 2006 00:22, Eric W. Biederman wrote:

> Actually can anyone tell me how try_apic_pin is supposed to work at
> all?
> 
> It doesn't appear to be programming the io_apic.

magic:-)

ACPI can't even _describe_ the scenarios being tried by check_timer(),
which is trying to navigate the minefield of all possible undocumented
chipset dependent bugs.  (ie, tinkering with the PIT when in IOAPIC mode...)

The chipset vendors can create new bugs in this area
faster than we can fix them, and there is a reason for this.

The public info on Windows says that they use 100HZ IRQ0 8254 only for UP.
On SMP, they use 64 HZ RTC on IRQ8 instead.

This means that for the population of system vendors that validate only with Windows,
only those timers are getting validated, and Linux on IRQ0 is exposed to HW bugs.

So the RTC looks like a safe path for a validated periodic ticker
when our first choice doesn't work.  But the RTC isn't without problems.
It can tick only in powers of 2 HZ, and 100/250/300/1000 are not powers of 2.
Dunno if close counts -- 256 is close to our 250, and 1024 is close to our 1000,
but we don't have any choices close to 100 or 300 HZ.

-Len

ps.
Moving to the RTC from the PIT would move us 3 years forward
in hardware technology, from 1981 to 1984:-)
