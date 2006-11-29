Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936056AbWK2UOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936056AbWK2UOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936099AbWK2UOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:14:30 -0500
Received: from 1wt.eu ([62.212.114.60]:5893 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S936056AbWK2UOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:14:30 -0500
Date: Wed, 29 Nov 2006 21:14:10 +0100
From: Willy Tarreau <w@1wt.eu>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, Nicholas Miell <nmiell@comcast.net>,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Message-ID: <20061129201410.GB1736@1wt.eu>
References: <1164769705.2825.4.camel@entropy> <21982.1164772580@kao2.melbourne.sgi.com> <20061129090800.GI6570@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129090800.GI6570@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 04:08:00AM -0500, Jakub Jelinek wrote:
> On Wed, Nov 29, 2006 at 02:56:20PM +1100, Keith Owens wrote:
> > Nicholas Miell (on Tue, 28 Nov 2006 19:08:25 -0800) wrote:
> > >On Wed, 2006-11-29 at 13:22 +1100, Keith Owens wrote:
> > >> Compiling 2.6.19-rc6 with gcc version 4.1.0 (SUSE Linux),
> > >> wait_hpet_tick is optimized away to a never ending loop and the kernel
> > >> hangs on boot in timer setup.
> > >> 
> > >> 0000001a <wait_hpet_tick>:
> > >>   1a:   55                      push   %ebp
> > >>   1b:   89 e5                   mov    %esp,%ebp
> > >>   1d:   eb fe                   jmp    1d <wait_hpet_tick+0x3>
> > >> 
> > >> This is not a problem with gcc 3.3.5.  Adding barrier() calls to
> > >> wait_hpet_tick does not help, making the variables volatile does.
> > >> 
> > >> Signed-off-by: Keith Owens <kaos@ocs.com.au>
> > >> 
> > >> ---
> > >>  arch/i386/kernel/time_hpet.c |    2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> 
> > >> Index: linux-2.6/arch/i386/kernel/time_hpet.c
> > >> ===================================================================
> > >> --- linux-2.6.orig/arch/i386/kernel/time_hpet.c
> > >> +++ linux-2.6/arch/i386/kernel/time_hpet.c
> > >> @@ -51,7 +51,7 @@ static void hpet_writel(unsigned long d,
> > >>   */
> > >>  static void __devinit wait_hpet_tick(void)
> > >>  {
> > >> -	unsigned int start_cmp_val, end_cmp_val;
> > >> +	unsigned volatile int start_cmp_val, end_cmp_val;
> > >>  
> > >>  	start_cmp_val = hpet_readl(HPET_T0_CMP);
> > >>  	do {
> > >
> > >When you examine the inlined functions involved, this looks an awful lot
> > >like http://gcc.gnu.org/bugzilla/show_bug.cgi?id=22278
> > >
> > >Perhaps SUSE should fix their gcc instead of working around compiler
> > >problems in the kernel?
> > 
> > Firstly, the fix for 22278 is included in gcc 4.1.0.
> 
> This actually sounds more like http://gcc.gnu.org/PR27236
> And that one is broken in 4.1.0, fixed in 4.1.1.

Then why not simply check for gcc 4.1.0 in compiler.h and refuse to build
with 4.1.0 if it's known to produce bad code ? I find it a bit annoying
that we start fixing every place affected by buggy compiler versions,
especially when the fix is already available.

> 	Jakub

Regards,
Willy

