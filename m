Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSFTRLX>; Thu, 20 Jun 2002 13:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSFTRLU>; Thu, 20 Jun 2002 13:11:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7929 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315431AbSFTRLM>; Thu, 20 Jun 2002 13:11:12 -0400
Subject: Re: [patch] (resend) credentials for 2.5.23
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020620122858.B4674@redhat.com>
References: <20020619212909.A3468@redhat.com>
	<1024540235.917.127.camel@sinai>  <20020620122858.B4674@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jun 2002 10:11:06 -0700
Message-Id: <1024593066.922.149.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-20 at 09:28, Benjamin LaHaise wrote:

> On Wed, Jun 19, 2002 at 07:30:35PM -0700, Robert Love wrote:
>
> > Question: what semantics would be broken if CLONE_CRED was implied by
> > CLONE_THREAD?  Regardless of code that needs this, it would be nice to
> > just save the memory when using threads.  Hell,  as far as I am
> > concerned as long as the tasks still share a VM they could share
> > credentials - but I am sure that breaks something.
> 
> Changing semantics like that is dangerous.  We have no way of knowing if 
> any applications rely on the existing behaviour, and furthermore if 
> changing it will silently introduce security holes.

OK, understood.  I just see an opportunity to save memory and would love
to take advantage of it.  We should definitely look into giving pthreads
(maybe via NGPT) the ability to specify CLONE_CRED.  I suspect 90% of
the cases retain the same credentials anyhow.  Copy-on-write? :) 

> > Next, now that all this data no longer belongs solely to current... you
> > need to be explicit about locking rules.  There is a capability_lock
> > spinlock but the long semantics are not 100% respected.  I tried to firm
> > them up in my capability.c cleanup one or two kernels ago... it should
> > be good enough and not be highly contended.
> 
> Noted.  Perhaps the current usage counts of the various limits should 
> be atomic types, or maybe the spinlock is enough.  If Linus is actually 
> interested in the patch, this could be easily fixed up.  Also, a few 
> parts of the kernel were suspiciously different in their use of euid/suid 
> instead of the plain old uid.  It would be nice if someone could double 
> check that these places are correct.

I am not so much worried about the ref counting (I think it looks right)
but just the general behavior.  I.e., you do not need to code anything
but you need to lay out right now what the locking rules need to be or
it will be a mess.

There is going to be code reading and writing p->cred data now
simultaneously and that should probably always be done under lock.

Another example: see fs/open.c :: sys_access().  I added that FIXME
there a couple kernel revisions ago...

> > Oh, and what is with the #if 0 over the set and getaffinity syscalls???
> > That needs to go!
> 
> Whoops, that was a dirty workaround for the breakage of 2.5.23.

Oh, OK - I thought you hated my syscalls :)

There is a patch in Linus's BK for it, or you can define cpu_online_map
to 1 on UP.

	Robert Love

