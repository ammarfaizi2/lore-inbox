Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262273AbRETXtX>; Sun, 20 May 2001 19:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262272AbRETXtN>; Sun, 20 May 2001 19:49:13 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:55812 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S262270AbRETXtA>;
	Sun, 20 May 2001 19:49:00 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15112.22465.860419.234933@tango.paulus.ozlabs.org>
Date: Mon, 21 May 2001 09:48:17 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: add page argument to copy/clear_user_page
In-Reply-To: <Pine.LNX.4.21.0105201143560.7553-100000@penguin.transmeta.com>
In-Reply-To: <15111.38049.614837.978468@tango.paulus.ozlabs.org>
	<Pine.LNX.4.21.0105201143560.7553-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> If you add the page argument, why leave the old arguments lingering there
> at all? They only create confusion, and add no information. 

You mean the `to' pointer argument, or the `vaddr' argument?  The
`vaddr' argument isn't redundant, it's the user virtual address where
the page is mapped, and sparc64 needs it in order to avoid D-cache
aliasing issues I believe. (Dave?)

As for the `to' argument, yes it is redundant since it is just kmap(page).
But copy/clear_user_page isn't the interface that gets called from the
MM stuff, copy/clear_user_highpage is, defined in include/linux/highmem.h.
These are two of a whole series of functions which all do kmap, do
something, kunmap.

IMHO having the kmap/kunmap calls in copy/clear_user_highpage in
include/linux/highmem.h is the best approach because it means that
most architectures can just #define copy/clear_user_page as
copy/clear_page in include/asm/page.h (as they do at the moment).  It
means that the kmap/kunmap calls are in one place only instead of
being duplicated in every architecture.

But we could instead push the kmap/kunmap down into copy/clear_user_page.
Then we might as well rename them into copy/clear_user_highpage.  Here
is how it might turn out in include/asm-i386/page.h (and asm-alpha,
asm-arm, asm-crus, asm-s390, asm-sh, asm-s390x...):

extern void clear_page(void *page);
extern void copy_page(void * _to, void * _from);

#define clear_user_highpage(page, vaddr)	\
do {						\
	struct page *__page = page;		\
	clear_page(kmap(__page));		\
	kunmap(__page);				\
} while (0)

#define copy_user_highpage(to, from, vaddr)	\
do {						\
	struct page *__to = to, *__from = from;	\
	copy_page(kmap(__to), kmap(__from));	\
	kunmap(__from);				\
	kunmap(__to);				\
} while (0)

Doing it with inline functions would be cleaner but would mean that we
would need the declaration of kmap/kunmap in page.h.  That would mean
that we would need to #include <linux/highmem.h> in include/asm/page.h
which is starting to get pretty messy and inviting circular
inclusions.  We could move these declarations to another file in
include/asm - include/asm/highmem.h might seem the natural place but
it is only used if CONFIG_HIGHMEM is defined and not all ports have
it.

I assume nobody wants to do these functions out-of-line. :)

So on the whole the way I had it seems cleanest to me.  But I can whip
up a patch to do the kmap/kunmap in the architecture-specific files
instead, if you prefer - if so, do you prefer the macro version or the
inline function version?

Paul.
