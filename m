Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVHHR47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVHHR47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVHHR47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:56:59 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:28819 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932162AbVHHR46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:56:58 -0400
Date: Mon, 8 Aug 2005 10:56:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@sgi.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       amitkale@linsyssoft.com
Subject: Re: [patch 07/15] Basic x86_64 support
Message-ID: <20050808175657.GA3187@smtp.west.cox.net>
References: <20050804123900.GR8266@wotan.suse.de> <7681.1123375682@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7681.1123375682@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 10:48:02AM +1000, Keith Owens wrote:
> On Thu, 4 Aug 2005 14:39:00 +0200, 
> Andi Kleen <ak@suse.de> wrote:
> >> > That doesn't make much sense here. tasklet will only run when interrupts
> >> > are enabled, and that is much later. You could move it to there.
> >> 
> >> Where?  Keep in mind it's really only x86_64 that isn't able to break
> >> sooner.
> >
> >The local_irq_enable() call in init/main.c:start_kernel()
> >
> >If you want to run gdb earlier you need to do it without a tasklet.
> >
> >> > > --- linux-2.6.13-rc3/include/asm-x86_64/hw_irq.h~x86_64-lite	2005-07-29 13:19:10.000000000 -0700
> >> > > +++ linux-2.6.13-rc3-trini/include/asm-x86_64/hw_irq.h	2005-07-29 13:19:10.000000000 -0700
> >> > > @@ -55,6 +55,7 @@ struct hw_interrupt_type;
> >> > >  #define TASK_MIGRATION_VECTOR	0xfb
> >> > >  #define CALL_FUNCTION_VECTOR	0xfa
> >> > >  #define KDB_VECTOR	0xf9
> >> > > +#define KGDB_VECTOR	0xf8
> >> > 
> >> > I already allocated these vectors for something else.
> >> 
> >> Is there another we can use?  Just following what looked to be the
> >> logical order.
> >
> >How about you use KDB_VECTOR and rename it to DEBUG_VECTOR
> >and then just check if kgdb is currently active? 
> >
> >KDB can do the same.
> >
> >I changed the assignment in my tree like this:
> >
> >#define SPURIOUS_APIC_VECTOR    0xff
> >#define ERROR_APIC_VECTOR       0xfe
> >#define RESCHEDULE_VECTOR       0xfd
> >#define CALL_FUNCTION_VECTOR    0xfc
> >#define KDB_VECTOR              0xfb    /* reserved for KDB */
> >#define THERMAL_APIC_VECTOR     0xfa
> >/* 0xf9 free */
> >#define INVALIDATE_TLB_VECTOR_END       0xf8
> >#define INVALIDATE_TLB_VECTOR_START     0xf0    /* f0-f8 used for TLB flush */
> 
> Don't call it {KDB,KGDB,DEBUG}_VECTOR, call it NMI_VECTOR, which is
> what it really is.  default_do_nmi() determines if the nmi is due to a
> debugger or some other event.  That requires the debuggers to record if
> they are expecting their own nmi, putting all the load on the
> debuggers, where it belongs.
> 
> IOW, add NMI_VECTOR to the base code, then add debugger support on top of
> NMI_VECTOR.

Works for me.  I'll post something vs 2.6.13-rc6 later today hopefully
that does the rename.

-- 
Tom Rini
http://gate.crashing.org/~trini/
