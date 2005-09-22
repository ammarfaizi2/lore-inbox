Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVIVTqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVIVTqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVIVTqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:46:51 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:25223 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030191AbVIVTqu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:46:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Jir9gKIytV/0NTj7IjCPbfZ4o4bfgd0zCSRSOWMGidxJnrj6rT0rXPKTrZ8aAlv64jDPskXEL63/t16iHwROJDJBA4L3SSuUNklFI+lfZdwmOWs8aHV5qotGipiRCGcLa8aTx6KeBp6iWJyDHPTLCIXlZMFqxerYilSqdId3xDk=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while atomic
Date: Thu, 22 Sep 2005 21:37:41 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <200509211923.21861.blaisorblade@yahoo.it> <200509212222.50653.blaisorblade@yahoo.it> <20050921134724.52603016.akpm@osdl.org>
In-Reply-To: <20050921134724.52603016.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200509222137.41412.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 22:47, Andrew Morton wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > On Wednesday 21 September 2005 21:49, Andrew Morton wrote:
> > > "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > > > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> > > It has accidental side-effects,
> > > such as making copy_to_user() fail if inside spinlocks when
> > > CONFIG_PREEMPT=y.

> > Sorry, but should it ever succeed inside spinlocks? I mean, should it
> > ever call down() inside spinlocks? (We never do down_trylock, and ever if
> > we did the x86 trick, that wouldn't make the whole thing safe at all -
> > they still take the spinlock and potentially sleep. And it's legal only
> > if no spinlock is held).

> Not sure what you're asking here.

> copy_to/from_user() will fail inside spinlock if CONFIG_PREMPT=y and if the
> copy happens to cause a fault.

> Otherwise it will succeed inside spinlock, 
> and it won't spew a sleeping-while-atomic warning, because that uses
> in_atomic() too.

> It might deadlock if we schedule away and try to retake 
> the same lock.
Exactly - the point is: is it legal to call copy_from_user() while holding a 
spinlock (which is my original question)? Or should copy_from_user try to 
satisfy the fault, instead of seeing in_atomic() or something similar and 
fail?

>From what you say, copy_*_user is called in such a way, but it's 
deadlock-prone, when CONFIG_PREEMPT is disabled.
> > Even if spinlocks don't always trigger in_atomic() - which means that
> > we'd need to have a better fix for this.

> The patch you have will correctly cause copy_*_user()->pagefault to fail
> the copy if the caller has run inc_preempt_count().  It will not cause
> copy_*_user()->pagefault to fail inside spinlocks unless UML does
> inc_preempt_count() in its spinlock implementation.
No, it doesn't. But for that case, we're in the same situation as i386.

Consider even that while UML doesn't implement PREEMPT (but we'll fix that, 
sooner or later) it does implement HIGHMEM, and answering to your original 
question:

> So I think this change is only needed if UML implements kmap_atomic, as in
> arch/i386/mm/highmem.c, which it surely does not do?
Apart that anybody would make sure that atomic kmaps are indeed atomic, UML 
doesn't use a "similar implementation" - it verbatim symlinks the i386 file 
and builds it (see arch/um/sys-i386/Makefile and 
arch/um/scripts/Makefile.rules if you want).

Hmm, that's something worth considering... at least when debugging is enabled, 
for debugging purposes.
> > NACK, see above.

> Yup, the patch is needed for the futex code,
> and for general correct 
> implementation of inc_preempt_count()'s intended effect.
Ok, that's enough I guess (and I just read what Linus said).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
