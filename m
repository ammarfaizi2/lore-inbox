Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSJVP5t>; Tue, 22 Oct 2002 11:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbSJVP5t>; Tue, 22 Oct 2002 11:57:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58158 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264756AbSJVP5r>; Tue, 22 Oct 2002 11:57:47 -0400
To: landley@trommello.org, Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<m1ptu3t3ec.fsf@frodo.biederman.org>
	<m1fzuyub3z.fsf@frodo.biederman.org>
	<200210212257.40050.landley@trommello.org>
	<m17kgattpw.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Oct 2002 10:02:03 -0600
In-Reply-To: <m17kgattpw.fsf@frodo.biederman.org>
Message-ID: <m11y6itqbo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Rob Landley <landley@trommello.org> writes:
> 
> > On Tuesday 22 October 2002 03:33, Eric W. Biederman wrote:
> > 
> > > j < Printed from the second callback in setup.S, just before the
> > > kernel decompresser is run >
> > >
> > >
> > > I have a very strange node that makes it all of the way to 'j' before
> > > rebooting. The concept that something is dying in protected mode will all
> > > of the interrupts disabled is so novel that I really don't know what to
> > > make of it, yet.
> > 
> > It would almost have to be the MMU.  Any way to dump the page tables?
> 
> I don't know yet.  I need to find a way to install some additional hooks
> at run time so I can narrow down where the failure is occuring.  I
> will have to look, but I should be able to set up an interrupt
> descriptor table and single step through the code.  

In the process of setting up hooks, I have run across a very interesting
data point.  If I load %ds, %es, %ss in my hook the problem goes away.
But I must load all 3.

Given that the code sequence that is executed if my hook is not run is:

	cld
	cli
	movl $(__KERNEL_DS),%eax
	movl %eax,%ds
	movl %eax,%es
	movl %eax,%fs
	movl %eax,%gs

	lss stack_start,%esp

I am rather confused.  I am not changing the gdt or anything like that so it
appears I may have found a way to tickle a processor errata.

Anyway Andy if you have a second please try kexec-tools 1.3 and see what
happens when you pass it the debug option.  I am really curious if your lockup
is anywhere near mine.  I doubt it as I am running on a P4.  But it appears
you never know what the problems will look like until you test them.

Eric
