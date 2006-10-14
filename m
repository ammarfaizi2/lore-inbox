Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbWJNAOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbWJNAOL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 20:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWJNAOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 20:14:10 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:22956 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751616AbWJNAOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 20:14:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=GxqgUkjLLlre/TuuWqxosbZsUc6E5wJVsR/lxiuq97YfUB1iK+athOkAEY9EIFEs49zWRlLSWY8UXBhe34CGp+GLinryuCDgTwM8UvXmzLotY6w6GcXAO2IcBEdz9ExD4glJQoZbS8ftVRbVgho8900Mp9tTJjSQQ6EpT9boU8c=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [uml-devel] [PATCH 06/14] uml: make UML_SETJMP always safe
Date: Sat, 14 Oct 2006 02:13:55 +0200
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20061005213212.17268.7409.stgit@memento.home.lan> <20061005213852.17268.13871.stgit@memento.home.lan> <20061009180013.GB4931@ccure.user-mode-linux.org>
In-Reply-To: <20061009180013.GB4931@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610140213.56153.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 October 2006 20:00, Jeff Dike wrote:
> On Thu, Oct 05, 2006 at 11:38:52PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > If enable is moved by GCC in a register its value may not be preserved
> > after coming back there with longjmp(). So, mark it as volatile to
> > prevent this; this is suggested (it seems) in info gcc, when it talks
> > about -Wuninitialized. I re-read this and it seems to say something
> > different, but I still believe this may be needed.
> >
> > Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > ---
> >
> >  arch/um/include/longjmp.h |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/um/include/longjmp.h b/arch/um/include/longjmp.h
> > index e93c6d3..e860bc5 100644
> > --- a/arch/um/include/longjmp.h
> > +++ b/arch/um/include/longjmp.h
> > @@ -12,7 +12,8 @@ #define UML_LONGJMP(buf, val) do { \
> >  } while(0)
> >
> >  #define UML_SETJMP(buf) ({ \
> > -	int n, enable;	   \
> > +	int n;	   \
> > +	volatile int enable;	\
> >  	enable = get_signals(); \
> >  	n = setjmp(*buf); \
> >  	if(n != 0) \
>
> I agree with this, but not entirely with your reasoning.  The
> -Wuninitialized documentation just talks about when gcc emits a
> warning.
>
> What we want is a guarantee that enable is not cached in a register,
> but is stored in memory.  What documentation I can find seems to imply
> that is the case ("accesses to volatile objects must have settled
> before the next sequence point").
>
> However, given the prevailing opinion that essentially all volatile
> declarations are hiding bugs, I wouldn't mind a bit of review of this
> from someone holding this opinion.

I agree with that, so I think Al (whom I cc'ed) will be able to evaluate this.
 - however I think that the problem with volatile is that it does not have any 
semantic wrt cache - volatile does not even work with host-to-device 
operation (the thing it was thought for) if you have reasonable caches - 
unless the var is in a MMIO region with disabled caches.

So relying on volatile for variables shared between threads is not useful.

Note that raw_spinlock_t counter is volatile, however - separate caches 
flushes or atomic operations are needed, but it may avoid the need for a full 
barrier() operation or a volatile "memory" clobber - GCC knows only the 
volatile object has changed, while with barrier() it must assume everything 
must be reloaded. However, at least one barrier operation is needed for a 
spinlock to prevent GCC from moving code outside of critical sections.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
