Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWJWBrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWJWBrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 21:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWJWBrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 21:47:16 -0400
Received: from xenotime.net ([66.160.160.81]:63705 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751134AbWJWBrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 21:47:14 -0400
Date: Sun, 22 Oct 2006 18:48:53 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andi Kleen <ak@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-Id: <20061022184853.7f8ae81a.rdunlap@xenotime.net>
In-Reply-To: <20061023013604.GF25210@parisc-linux.org>
References: <20061018091944.GA5343@martell.zuzino.mipt.ru>
	<200610230242.58647.ak@suse.de>
	<20061023010812.GE25210@parisc-linux.org>
	<200610230331.16573.ak@suse.de>
	<20061023013604.GF25210@parisc-linux.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006 19:36:04 -0600 Matthew Wilcox wrote:

> On Mon, Oct 23, 2006 at 03:31:16AM +0200, Andi Kleen wrote:
> > On Monday 23 October 2006 03:08, Matthew Wilcox wrote:
> > > On Mon, Oct 23, 2006 at 02:42:58AM +0200, Andi Kleen wrote:
> > > > 
> > > > > /*+
> > > > >  * Provides: struct sched
> > > > >  * Provides: total_forks, nr_threads, process_counts, nr_processes()
> > > > >  * Provides: nr_running(), nr_uninterruptible(), nr_active(), nr_iowait(), weighted_cpuload()
> > > > >  */
> > > > 
> > > > That's ugly.  If it needs that i don't think it's a good idea.
> > > > We really want standard C, not some Linux dialect.
> > > 
> > > Um, that's a comment.  It's standard C.
> > 
> > If you require it to do something it isn't a comment anymore -- it would become
> > a language extension.
> 
> How is this any different from __iomem annotations?
> 
> > > Here's the problem.  If a file needs canonicalize_irq(), it should
> > > include <linux/interrupt.h> (which eventually ends up including
> > > asm/irq,h), and not <asm/irq.h> (where it's defined).
> > > If a file needs add_wait_queue(), it should include <linux/wait.h>
> > > (where it's defined) and not <linux/fs.h> (which directly includes
> > > linux/wait.h>.
> > > 
> > > Please define an algorithm which distinguishes the two cases.
> > 
> > Needs are inside {} or in a macro definition
> > So if the identifier happens after #define or inside {} assume the symbol
> > is needed from somewhere else, otherwise it is declared here.
> > 
> > That is likely not 100% foolproof, but should be good enough and
> > the mismatches can be resolved by hand.
> 
> Let me try to explain the problem again, because what you wrote has
> nothing to do with the problem.
> 
> canonicalize_irq() is defined in <asm/irq.h>.  No .c file should be
> including <asm/irq.h> in order to get it.  It should be including
> <linux/interrupt.h>, which will indirectly pull in <asm/irq.h>

We can add #error or #warning to asm/irq.h when that is done &
detected hence caught and will be fixed.
Don't we already have a few like that?  ("don't include this file
directly")  I looked quickly but didn't see them...

> add_wait_queue() is defined in <linux/wait.h>.  .c files wishing to use
> add_wait_queue() should be including <linux/wait.h> rather than relying
> on it being pulled in through some other path.
> 
> This needs annotations to fix, or a big bag of unreliable heuristics.


---
~Randy
