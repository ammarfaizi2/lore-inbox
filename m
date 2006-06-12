Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWFLVmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWFLVmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWFLVmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:42:22 -0400
Received: from xenotime.net ([66.160.160.81]:42630 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932179AbWFLVmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:42:21 -0400
Date: Mon, 12 Jun 2006 14:45:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt Mackall <mpm@selenic.com>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, tim.bird@am.sony.com
Subject: Re: [PATCH] x86 built-in command line
Message-Id: <20060612144505.ee4788f0.rdunlap@xenotime.net>
In-Reply-To: <20060612204925.GT24227@waste.org>
References: <20060611215530.GH24227@waste.org>
	<200606121712.k5CHClUE017185@terminus.zytor.com>
	<20060612204925.GT24227@waste.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 15:49:25 -0500 Matt Mackall wrote:

> On Mon, Jun 12, 2006 at 10:12:47AM -0700, H. Peter Anvin wrote:
> > Followup to:  <20060611215530.GH24227@waste.org>
> > By author:    Matt Mackall <mpm@selenic.com>
> > In newsgroup: linux.dev.kernel
> > >
> > > This patch allows building in a kernel command line on x86 as is
> > > possible on several other arches.
> > > 
> > > Index: linux/arch/i386/kernel/setup.c
> > > ===================================================================
> > > --- linux.orig/arch/i386/kernel/setup.c	2006-05-26 16:18:13.000000000 -0500
> > > +++ linux/arch/i386/kernel/setup.c	2006-06-11 16:23:51.000000000 -0500
> > > @@ -713,6 +713,10 @@ static void __init parse_cmdline_early (
> > >  	int len = 0;
> > >  	int userdef = 0;
> > >  
> > > +#ifdef CONFIG_CMDLINE_BOOL
> > > +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > > +#endif
> > > +
> > >  	/* Save unparsed command line copy for /proc/cmdline */
> > >  	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
> > >  
> > 
> > NAK.
> > 
> > a. Please make the patch available for x86-64 as well as x86.  The two
> > are coupled enough that they need to agree.
> 
> I don't think that's a show-stopper. I'll provide one after we decide
> how this should work.
>  
> > b. This patch will override a user-provided command line if one
> > exists.  This is the wrong behaviour; instead, the builtin command
> > line should only apply if no user-specified command line is present.
> 
> There are four possible behaviors:
> 
> a) internal supercedes external (what's in the patch)
> b) external supercedes internal (what you proposed)
> c) external is appended to internal (what Tim proposed)
> d) internal is appended to external (not very interesting)

where internal ::= the new CONFIG_CMDLINE option ?
  and external  ::= what a user can add via a boot loader ?


> And there are some possible uses:
> 
> 1) bootloader doesn't support command line
> 2) bootloader has hardcoded or otherwise difficult-to-change command line
> 3) automated testing for tftp boot, etc.
> 4) bypassing boot protocol command line length (not yet supported)
> 5) setting defaults like ACPI off, etc.
> 
> (a) works for 1, 2, 3, and 4.
> (b) works for 1, 3, and 4, provided you clear the command line in your
> boot loader
> (c) works for 1, 3, and 4, provided you're not trying to override
> earlier arguments
> 
> (5) generally is unworkable because our parser doesn't generally do the
> right thing for options like "acpi=on acpi=off" (though it might work
> in the specific case of acpi, haven't checked). If, for instance, you
> try to override console, you'll get two consoles.
> 
> So I think (a) is the way to go. If there's a use case for (b) that's
> important, it's not jumping out at me. Finally, at least the arch I
> inspected when preparing this patch had gone with (a) too.

I frequently override command line options.  I guess I have no
use for this patch.

> (As an example of (2), the last x86 bootloader I dealt with was written
> in Forth, and getting a fresh build of it meant getting some cycles
> from the last two Forth hackers on the planet.)

That's not helping your argument IMO.

---
~Randy
