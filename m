Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWCMPab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWCMPab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWCMPaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:30:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:427 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751440AbWCMPaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:30:30 -0500
Date: Mon, 13 Mar 2006 10:30:22 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Ulrich Drepper <drepper@gmail.com>
Cc: GOTO Masanori <gotom@sanori.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix sigaltstack corruption among cloned threads
Message-ID: <20060313153022.GP20301@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <81ek16loay.wl%gotom@sanori.org> <a36005b50603130716x4cc5306ex2f8ecf012ea052d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50603130716x4cc5306ex2f8ecf012ea052d1@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 07:16:17AM -0800, Ulrich Drepper wrote:
> On 3/13/06, GOTO Masanori <gotom@sanori.org> wrote:
> > +        * sigaltstack should be cleared when CLONE_SIGHAND (and CLONE_VM) is
> > +        * specified.
> > +        */
> > +       if (clone_flags & CLONE_SIGHAND)
> > +               p->sas_ss_sp = p->sas_ss_size = 0;
> 
> I agree in general, but why base it on CLONE_SIGHAND? The problem
> results from using the same address space.  So it should be
> 
>   if (clone_flags & CLONE_VM)
> 
> The fact that both these flags are used at the same time in all cases
> today shouldn't hide the real reason for this requirement which is
> sharing the address space.

Because vfork also sets CLONE_VM and vfork isn't supposed to reset
alternate stack setting.  For vfork that's not a problem, as the parent task
will not continue until the vfork child execve's.  So, if you want to use
CLONE_VM bit, you'd need to use
	if ((clone_flags & (CLONE_VM | CLONE_VFORK)) == CLONE_VM)
		p->sas_ss_sp = p->sas_ss_size = 0;

	Jakub
