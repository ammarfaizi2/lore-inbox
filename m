Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966435AbWK2JIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966435AbWK2JIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758805AbWK2JIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:08:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44775 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1758806AbWK2JIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:08:16 -0500
Date: Wed, 29 Nov 2006 04:08:00 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Message-ID: <20061129090800.GI6570@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1164769705.2825.4.camel@entropy> <21982.1164772580@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21982.1164772580@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 02:56:20PM +1100, Keith Owens wrote:
> Nicholas Miell (on Tue, 28 Nov 2006 19:08:25 -0800) wrote:
> >On Wed, 2006-11-29 at 13:22 +1100, Keith Owens wrote:
> >> Compiling 2.6.19-rc6 with gcc version 4.1.0 (SUSE Linux),
> >> wait_hpet_tick is optimized away to a never ending loop and the kernel
> >> hangs on boot in timer setup.
> >> 
> >> 0000001a <wait_hpet_tick>:
> >>   1a:   55                      push   %ebp
> >>   1b:   89 e5                   mov    %esp,%ebp
> >>   1d:   eb fe                   jmp    1d <wait_hpet_tick+0x3>
> >> 
> >> This is not a problem with gcc 3.3.5.  Adding barrier() calls to
> >> wait_hpet_tick does not help, making the variables volatile does.
> >> 
> >> Signed-off-by: Keith Owens <kaos@ocs.com.au>
> >> 
> >> ---
> >>  arch/i386/kernel/time_hpet.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> Index: linux-2.6/arch/i386/kernel/time_hpet.c
> >> ===================================================================
> >> --- linux-2.6.orig/arch/i386/kernel/time_hpet.c
> >> +++ linux-2.6/arch/i386/kernel/time_hpet.c
> >> @@ -51,7 +51,7 @@ static void hpet_writel(unsigned long d,
> >>   */
> >>  static void __devinit wait_hpet_tick(void)
> >>  {
> >> -	unsigned int start_cmp_val, end_cmp_val;
> >> +	unsigned volatile int start_cmp_val, end_cmp_val;
> >>  
> >>  	start_cmp_val = hpet_readl(HPET_T0_CMP);
> >>  	do {
> >
> >When you examine the inlined functions involved, this looks an awful lot
> >like http://gcc.gnu.org/bugzilla/show_bug.cgi?id=22278
> >
> >Perhaps SUSE should fix their gcc instead of working around compiler
> >problems in the kernel?
> 
> Firstly, the fix for 22278 is included in gcc 4.1.0.

This actually sounds more like http://gcc.gnu.org/PR27236
And that one is broken in 4.1.0, fixed in 4.1.1.

	Jakub
