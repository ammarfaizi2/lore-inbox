Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbRAKMMi>; Thu, 11 Jan 2001 07:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129894AbRAKMM2>; Thu, 11 Jan 2001 07:12:28 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:38922 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129878AbRAKMMP>;
	Thu, 11 Jan 2001 07:12:15 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: Antony Suter <antony@mira.net>,
        List Linux-Kernel <linux-kernel@vger.kernel.org>,
        Allen Unueco <allen@premierweb.com>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Thu, 11 Jan 2001 11:42:24 -0000."
             <5358.979213344@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 23:12:05 +1100
Message-ID: <16427.979215125@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001 11:42:24 +0000, 
David Woodhouse <dwmw2@infradead.org> wrote:
>Taking away get_module_symbol() and providing a replacement which has link 
>order problems wasn't really very sensible.
>
>It's too late to do the sensible thing and deprecate the old version rather 
>than having a 'flag day'. But can we at least fix the link order crap?
>
>struct static_inter_module_entry {
>	const char *im_name;
>	const void *userdata;
>};
>
>#define inter_module_register_static(x,y) \
> static struct static_inter_module_entry __ime_##x \
>	__attribute__((unused,__section__(".intermodule")) \
>	= { #x, y };
>
>.. and the obvious for looking in that table in inter_module_get().

If object X registers data for object Y to use then X _must_ initialise
before Y.  It does not matter whether the registration method is static
or dynamic, the initialisation order must be observed.

Q. With your suggested static method, what happens when Y initialises
   before X, calls inter_module_get, retrieves X's static data and
   starts to use it before X has initialised?
A. Oops!

The whole point of registration methods is that the owner of the data
decides when they are ready to provide the service.  Ensuring that code
is initialised in the correct order, with providers starting before
consumers, is a fact of life.

I dislike the method that the kernel uses to control initialisation
order, but that is an entirely separate problem from inter_module_xxx.
What we really want at startup is a correct initialisation order.  What
we have is the order that objects are selected in a Makefile which maps
to the link order of objects in vmlinux which maps to the listed order
of init routines in section .init.text which maps to initialisation
order.  The mechanism is three layers away from the problem and it is
difficult to understand for many people.

It would be much nicer to define ordering sets.  Code in driver foo
needs the code in driver bar to initialise first.  cfi_probe cannot
initialise until cfi_cmdset_0001 and cfi_cmdset_0002 have initialised.
Declare it that way so it is clear what is going on and why, instead of
being implied by the Makefile order via three layers of indirection.
Then let the kernel build system do whatever it takes to honour the
documented initialisation order.

The problem is, Linus likes the current method.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
