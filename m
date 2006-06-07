Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWFGHUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWFGHUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 03:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWFGHUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 03:20:30 -0400
Received: from mail.suse.de ([195.135.220.2]:3306 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751101AbWFGHUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 03:20:30 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: NMI problems with Dell SMP Xeons
Date: Wed, 7 Jun 2006 09:20:23 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Brendan Trotter" <btrotter@gmail.com>
References: <6143.1149655751@kao2.melbourne.sgi.com>
In-Reply-To: <6143.1149655751@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606070920.23436.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 06:49, Keith Owens wrote:
> Following a suggestion by Brendan Trotter, I ran some more tests to
> track down the problem with sending NMI IPI on Dell Xeons.
>
> BIOS Logical    OS ACPI     Cpus    IPI 2             NMI IPI
>  Processor                BIOS  OS                 (APIC_DM_NMI)
>
> Enabled         Enabled    4    4  Not delivered   Delivered as NMI
> Enabled         Disabled   4    2  Machine reset   Machine reset
> Disabled        Enabled    2    2  Not delivered   Delivered as NMI
> Disabled        Disabled   2    2  Not delivered   Delivered as NMI
>
> So the killer combination with this motherboard is when the BIOS knows
> about logical processors but the OS does not.  Sending IPI 2 or NMI IPI
> with that combination kills the machine.  Brendan suggested that the
> BIOS is seeing the broadcast NMI on the logical processors which are
> not under OS control and that the BIOS cannot cope.

How did you manage that? Normally the OS should use all CPUs
known to BIOS. Or did you boot with special boot options to limit it?

> Should we change the x86_64 send_IPI_allbutself() so it is only
> delivered to cpus that the OS knows about, instead of doing a general
> broadcast. 

Hmm, we should be doing that already to avoid races for CPU hotplug.  But 
maybe it's not working correctly for KDB.  Does it go away when you
enable CPU hotplug? Anyways, should be a SMOP to force it. I wouldn't
have a problem to use sequence ipis  always and get rid of the broadcasts.
There were benchmarks at some point and there wasn't a noticeable
difference. 

-Andi


