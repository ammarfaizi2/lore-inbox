Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993107AbWJURYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993107AbWJURYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993108AbWJURYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:24:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62848 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2993107AbWJURYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:24:06 -0400
Date: Sat, 21 Oct 2006 13:24:01 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [14/19] i386: Disable nmi watchdog on all ThinkPads
Message-ID: <20061021172401.GD30758@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	patches@x86-64.org, linux-kernel@vger.kernel.org
References: <20061021651.356252000@suse.de> <20061021165134.7ADBB13CB4@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061021165134.7ADBB13CB4@wotan.suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 06:51:34PM +0200, Andi Kleen wrote:
 > 
 > Even newer Thinkpads have bugs in SMM code that causes hangs with
 > NMI watchdog.
 > 
 > Signed-off-by: Andi Kleen <ak@suse.de>
 > 
 > ---
 >  arch/i386/kernel/nmi.c      |   10 +++++-----
 >  drivers/firmware/dmi_scan.c |   20 ++++++++++++++++++++
 >  include/linux/dmi.h         |    2 ++
 >  3 files changed, 27 insertions(+), 5 deletions(-)
 > 
 > Index: linux/arch/i386/kernel/nmi.c
 > ===================================================================
 > --- linux.orig/arch/i386/kernel/nmi.c
 > +++ linux/arch/i386/kernel/nmi.c
 > @@ -219,11 +219,11 @@ static int __init check_nmi_watchdog(voi
 >  	int cpu;
 >  
 >  	/* Enable NMI watchdog for newer systems.
 > -           Actually it should be safe for most systems before 2004 too except
 > -	   for some IBM systems that corrupt registers when NMI happens
 > -	   during SMM. Unfortunately we don't have more exact information
 > - 	   on these and use this coarse check. */
 > -	if (nmi_watchdog == NMI_DEFAULT && dmi_get_year(DMI_BIOS_DATE) >= 2004)
 > +	   Probably safe on most older systems too, but let's be careful.
 > +	   IBM ThinkPads use INT10 inside SMM and that allows early NMI inside SMM
 > +	   which hangs the system. Disable watchdog for all thinkpads */
 > +	if (nmi_watchdog == NMI_DEFAULT && dmi_get_year(DMI_BIOS_DATE) >= 2004 &&
 > +		!dmi_name_in_vendors("ThinkPad"))
 >  		nmi_watchdog = NMI_LOCAL_APIC;

This is going to get some people scratching their heads wondering
why it isn't working if they ever try nmi_watchdog on one of these.
How about adding an explanitory printk ?

	Dave

-- 
http://www.codemonkey.org.uk
