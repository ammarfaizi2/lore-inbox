Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUCXVke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUCXVke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:40:34 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:50884 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262017AbUCXVkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:40:31 -0500
Date: Wed, 24 Mar 2004 14:40:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anurekh Saxena <anurekh.saxena@timesys.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Kgdb-bugreport] kgdb_arch_set/remove_break() ?
Message-ID: <20040324214029.GL7126@smtp.west.cox.net>
References: <20040319160359.GD4569@smtp.west.cox.net> <200403242005.21197.amitkale@emsyssoft.com> <20040324202402.GA20260@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324202402.GA20260@timesys.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 03:24:02PM -0500, Anurekh Saxena wrote:

> 
> On Wed, Mar 24, 2004 at 08:05:21PM +0530, Amit S. Kale wrote:
> > On Friday 19 Mar 2004 9:33 pm, Tom Rini wrote:
> > > Hi.  Right now I'm writing up a porting doc that describes the various
> > > hook functions we've got.  I noticed that nothing is calling
> > > kgdb_arch_set/remove_break.  Is there some arch we're expecting will
> > > need this?  I'd like to just go ahead and remove them
> > 
> > I can't remember why that was done. A processor other than PPC, x86 and x86_64 
> > needs a special implementation of set and remove breakpoint, I guess.
> > 
> > Anurekh, who did initial implementation of arch independent-dependent split 
> > may have some comments on this.
> 
> *set_break
> *remove_break
> 
> These functions should only be defined for architecutes that support
> hardware breakpoint. Set KGDB_HW_BREAKPOINT flag.

Amit, I think we've got a bug on i386 then.  Looking at i386-lite.patch,
there's:
+void kgdb_correct_hw_break(void)
+int kgdb_remove_hw_break(unsigned long addr, int type)
+int kgdb_set_hw_break(unsigned long addr, int type)
+int remove_hw_break(unsigned breakno)
+int set_hw_break(unsigned breakno, unsigned type, unsigned len, unsigned addr)

Of these, only kgdb_correct_hw_break is called in core-lite.patch, and
set_hw_break/remove_hw_break (for y/Y packets) are called in
i386-lite.patch.

What I think we need to do is, since y/Y packets are reserved, I'm
assuming there's a special version of GDB using these for hw
breakpoints, and this needs to be handled in i386-lite.patch.
Since core-lite's handling of a z/Z* packet is to assume setting a
breakpoint, and hw or sw is controlled by the KGDB_HW_BREAKPOINT flag,
we need to make sure this (a) works and (b) is actually calling useful
functions.

-- 
Tom Rini
http://gate.crashing.org/~trini/
