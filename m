Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSFTQ27>; Thu, 20 Jun 2002 12:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSFTQ26>; Thu, 20 Jun 2002 12:28:58 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:51963 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S315207AbSFTQ24>; Thu, 20 Jun 2002 12:28:56 -0400
Date: Thu, 20 Jun 2002 12:28:58 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] (resend) credentials for 2.5.23
Message-ID: <20020620122858.B4674@redhat.com>
References: <20020619212909.A3468@redhat.com> <1024540235.917.127.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1024540235.917.127.camel@sinai>; from rml@tech9.net on Wed, Jun 19, 2002 at 07:30:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 07:30:35PM -0700, Robert Love wrote:
> Yow, big patch... that is why it did not make it through.  Vger
> (silently) rejects email over ~20KB.

Silent is definately not good.  Oh well.

> Question: what semantics would be broken if CLONE_CRED was implied by
> CLONE_THREAD?  Regardless of code that needs this, it would be nice to
> just save the memory when using threads.  Hell,  as far as I am
> concerned as long as the tasks still share a VM they could share
> credentials - but I am sure that breaks something.

Changing semantics like that is dangerous.  We have no way of knowing if 
any applications rely on the existing behaviour, and furthermore if 
changing it will silently introduce security holes.

> Next, now that all this data no longer belongs solely to current... you
> need to be explicit about locking rules.  There is a capability_lock
> spinlock but the long semantics are not 100% respected.  I tried to firm
> them up in my capability.c cleanup one or two kernels ago... it should
> be good enough and not be highly contended.

Noted.  Perhaps the current usage counts of the various limits should 
be atomic types, or maybe the spinlock is enough.  If Linus is actually 
interested in the patch, this could be easily fixed up.  Also, a few 
parts of the kernel were suspiciously different in their use of euid/suid 
instead of the plain old uid.  It would be nice if someone could double 
check that these places are correct.

> I guess the only downside would be the extra overhead in our
> preciously-fast do_fork... another slab allocation etc. but that is
> countered if enough stuff starts using CLONE_CRED.

I would hope that the per-cpu slab caches are fast enough.

> Oh, and what is with the #if 0 over the set and getaffinity syscalls???
> That needs to go!

Whoops, that was a dirty workaround for the breakage of 2.5.23.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
