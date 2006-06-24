Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWFXEfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWFXEfV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 00:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWFXEfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 00:35:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932178AbWFXEfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 00:35:20 -0400
Date: Fri, 23 Jun 2006 21:28:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: deweerdt@free.fr, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       linux-pm@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-Id: <20060623212854.5a38684a.akpm@osdl.org>
In-Reply-To: <200606232156_MC3-1-C354-D5AE@compuserve.com>
References: <200606232156_MC3-1-C354-D5AE@compuserve.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 21:54:00 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <20060623023124.138d432f.akpm@osdl.org>
> 
> On Fri, 23 Jun 2006 02:31:24 -0700, Andrew Morton wrote:
> 
> > > > Code: 05 c4 42 43 c0 31 43 43 c0 c3 8b 2d 68 6e 54 c0 8b 1d 60 6e 54 c0 8b 35 6c 6e 54 c0 8b 3d 70 6d 54 c0 ff 35 74 6e 54 c0 9d c3 90 <e8> 6d 38 ea ff e8 a2 ff ff ff 6a 03 e8 ec b6 de ff 83 c4 04 c3
> > > > EIP: [c043431c>] do_suspend_lowlevel+0x0/0x15 SS:ESP 0068:f6cb6ea4
> > >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Ha, wait a moment, this is interesting line. Can you trace down which
> > > instruction causes this?
> > > 
> > > We recently changed pagetable handling during swsusp, perhaps thats
> > > it? It went to Linus few minutes ago...
> > 
> > That's a good possibility.  It does appear to be oopsing at the first
> > instruction of arch/i386/kernel/acpi/wakeup.S:do_suspend_lowlevel(). 
> > Perhaps there's enough info in that oops trace to tell us whether it was
> > the instruction fetch which oopsed.
> > 
> > One wonders whether this will help...
> > 
> > --- a/arch/i386/kernel/acpi/wakeup.S~a
> > +++ a/arch/i386/kernel/acpi/wakeup.S
> > @@ -270,6 +270,7 @@ ALIGN
> >  ENTRY(saved_magic)   .long   0
> >  ENTRY(saved_eip)     .long   0
> >  
> > +.text
> >  save_registers:
> >       leal    4(%esp), %eax
> >       movl    %eax, saved_context_esp
> > @@ -304,6 +305,7 @@ ret_point:
> >       call    restore_processor_state
> >       ret
> >  
> > +.data
> >  ALIGN
> >  # saved registers
> >  saved_gdt:   .long   0,0
> 
> 
> This is in 2.6.17-mm1 already:
> 
> 
> From: Shaohua Li <shaohua.li@intel.com>
> 
> Move do_suspend_lowlevel to correct segment.  If it is in the same hugepage
> with ro data, mark_rodata_ro will make it unexecutable.
> 

OK.  But this bug report is against 2.6.17-mm1, isn't it?
