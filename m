Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWGGRKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWGGRKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGGRKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:10:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932196AbWGGRKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:10:03 -0400
Date: Fri, 7 Jul 2006 10:09:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <200607070623_MC3-1-C45A-2429@compuserve.com>
Message-ID: <Pine.LNX.4.64.0607071003140.3869@g5.osdl.org>
References: <200607070623_MC3-1-C45A-2429@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jul 2006, Chuck Ebbert wrote:
> 
> >  #define __raw_spin_unlock_string \
> >       "movb $1,%0" \
> > -             :"=m" (lock->slock) : : "memory"
> > +             :"+m" (lock->slock) : : "memory"
>  
> This really is just an overwrite of whatever is there.  OTOH I can't see
> how this change could hurt anything..

Yeah, I don't think any non-buggy sequence can make it matter.

In theory, you could have something like

 - create a spinlock already locked
 - add the object that contains the spinlock to some global queues
 - do some op on the object to finalize it
 - unlock the spinlock 

and then the "unlock" had better not optimize away the previous 
initialization.

HOWEVER, it can't really do that anyway, since anything that made the 
spinlock visible to anybody else would have had to serialize the lock 
state for _that_, so if the "+m" vs "=m" makes a difference, you'd have 
had a serious bug already for other reasons.

I'll leave it with a "+m". I've tested it locally, and looking at the 
patch it definitely fixes real bugs in the inline asms, but I still hope 
other people will take a look before I commit it, in case there are any 
other subtle cases.

(A "+m" should always be safer than a "=m", so the patch should be very 
safe, but hey, bugs happen to "obvious" code too)

			Linus
