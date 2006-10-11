Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWJKLIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWJKLIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 07:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWJKLIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 07:08:36 -0400
Received: from web25221.mail.ukl.yahoo.com ([217.146.176.207]:34397 "HELO
	web25221.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751205AbWJKLIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 07:08:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=SG8FD3iCEggAnyJviZ+XBWNPvJQlGUzW7hKTV9BAgZQxWZOlkal9crd0X5583bAiZtFnUf4AUfi/Kxdi3VucRq+s9rlz8pIxFBLYhfQEZs6yukbDGvqRjA+L6+2210rcdM2RLlKH3eoK9E9A2mSXZjHS9w/sxVYYfn+5U5c/yuk=  ;
Message-ID: <20061011110828.43576.qmail@web25221.mail.ukl.yahoo.com>
Date: Wed, 11 Oct 2006 13:08:27 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 01/14] uml: fix compilation options for USER_OBJS
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <20061009163208.GA4931@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Thu, Oct 05, 2006 at 11:38:36PM +0200, Paolo 'Blaisorblade'
> Giarrusso wrote:
> > Again, move inclusion of arch's Makefile after CFLAGS setting - I
> remember
> > merging the same patch eons ago in 2.6, so I added a comment.
> > 
> > I discovered this because debug info weren't enabled for
> USER_OBJS - they're
> > compiled with USER_CFLAGS which is calculated from CFLAGS (the
> whole thing is a
> > bit of an hack but fixing it is not easy, so we're leaving it
> as-is).
> 
> What's the matter with this:
> 
> Index: linux-2.6.18-mm/arch/um/Makefile
> ===================================================================
> --- linux-2.6.18-mm.orig/arch/um/Makefile       2006-10-03
> 17:44:32.000000000 -0400
> +++ linux-2.6.18-mm/arch/um/Makefile    2006-10-09
> 12:29:32.000000000 -0400
> @@ -64,9 +64,8 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
>  
>  AFLAGS += $(ARCH_INCLUDE)
>  
> -USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
> -USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS))
> $(ARCH_INCLUDE) \
> -       $(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
> +USER_CFLAGS = $(patsubst -D__KERNEL__,,$(patsubst -I%,,$(CFLAGS)))
> \
> +       $(ARCH_INCLUDE) $(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
>  
>  # -Derrno=kernel_errno - This turns all kernel references to errno
> into
>  # kernel_errno to separate them from the libc errno.  This allows
> -fno-common
> 
> The real problem is the use of := which assigns USER_CFLAGS from
> the
> current value of CFLAGS, which is incomplete, as you noted.

Ok, at a first glance this alternative solution is ok. Make sure (run
gdb on an userspace object file and saying list <function>) that it
works and we'll be ok.

> Moving the include around seems slightly bogus, since its precise
> location shouldn't matter.
> 
> If we switch to plain =, then it will be lazy-evaluated with the
> full
> CFLAGS.
> 
> And we should check other uses of := to make sure they don't have
> similar problems.

Maybe, but I hope not... however if CFLAGS is used elsewhere its
occurrences must be looked for and checked.
--
Paolo 'Blaisorblade' Giarrusso

__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tanto spazio gratuito per i tuoi file e i messaggi 
http://mail.yahoo.it 
