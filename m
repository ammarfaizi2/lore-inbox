Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbUJ0KVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUJ0KVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbUJ0KUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:20:34 -0400
Received: from gprs214-182.eurotel.cz ([160.218.214.182]:44935 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262372AbUJ0KBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 06:01:07 -0400
Date: Wed, 27 Oct 2004 12:00:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: ncunningham@linuxmail.org, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fixing MTRR smp breakage and suspending sysdevs.
Message-ID: <20041027100046.GB26265@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >One thing I have noticed is that by adding the sysdev suspend/resume
> >calls, I've gained a few seconds delay. I'll see if I can track down
> the
> >cause.
> Is the problem MTRR resume must be with IRQ enabled, right? Could we
> implement a method sysdev resume with IRQ enabled? MTRR driver isn't
> the

MTRR does not deserve to be sysdev. It is not essential for the
system, it only makes it slow.

> only case. The ACPI Link device is another case, it's a sysdev (it must
> resume before any PCI device resumed), but its resume (it uses semaphore
> and non-atomic kmalloc) can't invoked with IRQ enabled. I guess cpufreq
> driver is another case when suspend/resume SMP is supported.

I do not see how enabling interrupts before setting up IRQs is good
idea.

What about this one, instead?

* ACPI Link device should allocate with GFP_ATOMIC

* during suspend, locks can't be taken. (We stop userland, etc). So it
should be okay to down_trylock() and panic if that does not work.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
