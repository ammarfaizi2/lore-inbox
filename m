Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264713AbTE1NCy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbTE1NCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:02:54 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:39867 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264713AbTE1NCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:02:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16084.46712.707240.943086@gargle.gargle.HOWL>
Date: Wed, 28 May 2003 15:15:36 +0200
From: mikpe@csd.uu.se
To: Pavel Machek <pavel@suse.cz>
Cc: Milton Miller <miltonm@bga.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] fix oops on resume from apm bios initiated suspend
In-Reply-To: <20030528111401.GB342@elf.ucw.cz>
References: <200305280643.h4S6hRQF028038@sullivan.realtime.net>
	<20030528111401.GB342@elf.ucw.cz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 
 > > Didn't know if you caught this one, but it fixes it for me and others
 > > who responded on the list.  
 > > 
 > > mm is NULL for kernel threads without their own context.  active_mm is
 > > maintained the one we lazly switch from.
 > > 
 > > Without this patch, apm bios initiated suspend events (eg panel close) 
 > > cause an oops on resume in the LDT restore, killing kapmd, which causes
 > > further events to not be polled.
 > 
 > Ouch, okay, this looks good. Andrew please apply.
 > 
 > [I guess this is trivial enough for trivial patch monkey if andrew
 > does not want to take it...]
 > 								Pavel
 > 
 > > ===== arch/i386/kernel/suspend.c 1.16 vs edited =====
 > > --- 1.16/arch/i386/kernel/suspend.c	Sat May 17 16:09:37 2003
 > > +++ edited/arch/i386/kernel/suspend.c	Sat May 24 05:00:02 2003
 > > @@ -114,7 +114,7 @@
 > >          cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 > >  
 > >  	load_TR_desc();				/* This does ltr */
 > > -	load_LDT(&current->mm->context);	/* This does lldt */
 > > +	load_LDT(&current->active_mm->context);	/* This does lldt */

No one has still explained WHY kapmd's current->mm is NULL for some people,
while it obviously is non-NULL for many others. That worries me a lot more.
