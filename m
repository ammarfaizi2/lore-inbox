Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWAKKOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWAKKOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 05:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWAKKOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 05:14:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21649 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932615AbWAKKOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 05:14:01 -0500
Date: Wed, 11 Jan 2006 05:13:00 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Ingo Molnar <mingo@elte.hu>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix i386 mutex fastpath on FRAME_POINTER &&  !DEBUG_MUTEXES
In-Reply-To: <200601110327_MC3-1-B5A3-6E0E@compuserve.com>
Message-ID: <Pine.LNX.4.58.0601110511590.24014@devserv.devel.redhat.com>
References: <200601110327_MC3-1-B5A3-6E0E@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2006, Chuck Ebbert wrote:

> In-Reply-To: <20060110210744.GA8850@elte.hu>
> 
> On Tue, 10 Jan 2006 at 22:07:44 +0100, Ingo Molnar wrote:
> 
> > --- linux.orig/include/asm-i386/mutex.h
> > +++ linux/include/asm-i386/mutex.h
> > @@ -28,7 +28,13 @@ do {                                                                       \
> >                                                                       \
> >       __asm__ __volatile__(                                           \
> >               LOCK    "   decl (%%eax)        \n"                     \
> > -                     "   js "#fail_fn"       \n"                     \
> > +                     "   js 2f               \n"                     \
> > +                     "1:                     \n"                     \
> > +                                                                     \
> > +             LOCK_SECTION_START("")                                  \
> > +                     "2: call "#fail_fn"     \n"                     \
> > +                     "   jmp 1b              \n"                     \
> > +             LOCK_SECTION_END                                        \
> >                                                                       \
> >               :"=a" (dummy)                                           \
> >               : "a" (count)                                           \
> 
> 
> But now it's inefficient again.
> 
> Why not this:
> 
>                 LOCK    "   decl (%%eax)        \n"                     \
>                         "   jns 1f              \n"                     \
>                         "   call "#fail_fn"     \n"                     \
>                         "1:                     \n"                     \
>                                                                         \
>                 :"=a" (dummy)                                           \
>                 : "a" (count)                                           \
> 
> 
> Will the extra taken forward conditional jump in the fastpath cause much
> of a slowdown?

yeah - the fastpath is much more common than the slowpath.

	Ingo
