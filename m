Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267019AbSLXAPz>; Mon, 23 Dec 2002 19:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267020AbSLXAPz>; Mon, 23 Dec 2002 19:15:55 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:44736 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267019AbSLXAPy>;
	Mon, 23 Dec 2002 19:15:54 -0500
Date: Tue, 24 Dec 2002 11:22:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@transmeta.com, lk@tantalophile.demon.co.uk, mingo@elte.hu,
       drepper@redhat.com, bart@etpmod.phys.tue.nl, davej@codemonkey.org.uk,
       hpa@transmeta.com, terje.eggestad@scali.com, matti.aarnio@zmailer.org,
       hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-Id: <20021224112233.00e6295d.sfr@canb.auug.org.au>
In-Reply-To: <20021223232743.GC2907@ppc.vc.cvut.cz>
References: <Pine.LNX.4.44.0212221050210.2587-100000@home.transmeta.com>
	<Pine.LNX.4.44.0212222050030.1217-100000@home.transmeta.com>
	<20021223232743.GC2907@ppc.vc.cvut.cz>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2002 00:27:43 +0100 Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>
> On Sun, Dec 22, 2002 at 09:03:44PM -0800, Linus Torvalds wrote:
> > 
> > How does the attached patch work for people? I've verified that
> > single-stepping works, and I've also verified that it does improve
> > performance for simple system calls. Everything looks quite simple.
> 
> > ===== arch/i386/kernel/sysenter.c 1.4 vs edited =====
> > --- 1.4/arch/i386/kernel/sysenter.c	Sat Dec 21 16:02:02 2002
> > +++ edited/arch/i386/kernel/sysenter.c	Sun Dec 22 20:17:28 2002
> > @@ -54,19 +54,18 @@
> >  		0xc3			/* ret */
> >  	};
> >  	static const char sysent[] = {
> > -		0x9c,			/* pushf */
> >  		0x51,			/* push %ecx */
> >  		0x52,			/* push %edx */
> >  		0x55,			/* push %ebp */
> >  		0x89, 0xe5,		/* movl %esp,%ebp */
> >  		0x0f, 0x34,		/* sysenter */
> > +		0x00,			/* align return point */
> >  	/* System call restart point is here! (SYSENTER_RETURN - 2) */
> >  		0xeb, 0xfa,		/* jmp to "movl %esp,%ebp" */
> 
> Hi Linus,
> 
> Jump instruction should be 0xeb, 0xf9, with 0xeb, 0xfa it jumps into 
> the middle of movl %esp,%ebp because of added alignment.

And if you change the 0x00 use for alighment to 0x90 (nop) you can
use gdb to disassemble that array of bytes to check any changes ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
