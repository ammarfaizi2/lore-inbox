Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267231AbSLRMry>; Wed, 18 Dec 2002 07:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbSLRMry>; Wed, 18 Dec 2002 07:47:54 -0500
Received: from elin.scali.no ([62.70.89.10]:34823 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267231AbSLRMrw>;
	Wed, 18 Dec 2002 07:47:52 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Terje Eggestad <terje.eggestad@scali.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>, hpa@transmeta.com
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1040216143.23393.1427.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 18 Dec 2002 13:55:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


what about:

int (*_vsyscall) (int, ...);
_vsyscall = mmap(NULL, getpagesize(),  PROT_READ|PROT_EXEC,
MAP_VSYSCALL, , ); 

or if you're afraid of running out of MAP_* flags:

fd = open("/dev/vsyscall", );
_vsyscall = mmap(NULL, getpagesize(),  PROT_READ|PROT_EXEC, MAP_SHARED,
fd, 0);

Then you can leisurely map it in just after the programs text segment. 

TJ


On tir, 2002-12-17 at 18:55, Linus Torvalds wrote: 
> On Tue, 17 Dec 2002, Matti Aarnio wrote:
> >
> > On Tue, Dec 17, 2002 at 09:07:21AM -0800, Linus Torvalds wrote:
> > > On Tue, 17 Dec 2002, Hugh Dickins wrote:
> > > > I thought that last page was intentionally left invalid?
> > >
> > > It was. But I thought it made sense to use, as it's the only really
> > > "special" page.
> >
> >   In couple of occasions I have caught myself from pre-decrementing
> >   a char pointer which "just happened" to be NULL.
> >
> >   Please keep the last page, as well as a few of the first pages as
> >   NULL-pointer poisons.
> 
> I think I have a good clean solution to this, that not only avoids the
> need for any hard-coded address _at_all_, but also solves Uli's problem
> quite cleanly.
> 
> Uli, how about I just add one ne warchitecture-specific ELF AT flag, which
> is the "base of sysinfo page". Right now that page is all zeroes except
> for the system call trampoline at the beginning, but we might want to add
> other system information to the page in the future (it is readable, after
> all).
> 
> So we'd have an AT_SYSINFO entry, that with the current implementation
> would just get the value 0xfffff000. And then the glibc startup code could
> easily be backwards compatible with the suggestion I had in the previous
> email. Since we basically want to do an indirect jump anyway (because of
> the lack of absolute jumps in the instruction set), this looks like the
> natural way to do it.
> 
> That also allows the kernel to move around the SYSINFO page at will, and
> even makes it possible to avoid it altogether (ie this will solve the
> inevitable problems with UML - UML just wouldn't set AT_SYSINFO, so user
> level just wouldn't even _try_ to use it).
> 
> With that, there's nothing "special" about the vsyscall page, and I'd just
> go back to having the very last page unmapped (and have the vsyscall page
> in some other fixmap location that might even depend on kernel
> configuration).
> 
> Whaddaya think?
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

