Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWG0HJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWG0HJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWG0HJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:09:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932524AbWG0HJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:09:01 -0400
Date: Thu, 27 Jul 2006 00:08:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johannes Weiner <hnazfoo@googlemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG() on apm resume in 2.6.18-rc2
Message-Id: <20060727000856.f75d2603.akpm@osdl.org>
In-Reply-To: <20060727062932.GA32598@leiferikson.gentoo>
References: <20060727033819.GA368@fieldses.org>
	<20060726231049.e9a0346e.akpm@osdl.org>
	<20060727062932.GA32598@leiferikson.gentoo>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 08:29:32 +0200
Johannes Weiner <hnazfoo@googlemail.com> wrote:

> Hi,
> 
> On Wed, Jul 26, 2006 at 11:10:49PM -0700, Andrew Morton wrote:
> > This?
> > 
> > --- a/./arch/i386/kernel/cpu/mcheck/mce.h~mce-section-fix
> > +++ a/./arch/i386/kernel/cpu/mcheck/mce.h
> > @@ -9,6 +9,6 @@ void winchip_mcheck_init(struct cpuinfo_
> >  /* Call the installed machine check handler for this CPU setup. */
> >  extern fastcall void (*machine_check_vector)(struct pt_regs *, long error_code);
> >  
> > -extern int mce_disabled __initdata;
> > +extern int mce_disabled;
> >  extern int nr_mce_banks;
> 
> What hinted you to that? I didn't read much oopses, so...
> 

(please always do reply-to-all)

That was an easy one - it crashed at

EIP is at mcheck_init+0x4/0x80

right at the start of mcheck_init(), so it had to be the access of
mce_disabled.

It accessed the address c0729c38:

BUG: unable to handle kernel paging request at virtual address c0729c38

and the code dump shows an access to that address.

And the only way in which an access to a global variable of this nature can
oops is if that variable has been unmapped from the kenrel address space. 
We unmap (and reuse) the __init memory, so it had to be a sectioning bug.
