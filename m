Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288238AbSACH1O>; Thu, 3 Jan 2002 02:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288236AbSACH1D>; Thu, 3 Jan 2002 02:27:03 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62726 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288235AbSACH0q>; Thu, 3 Jan 2002 02:26:46 -0500
Message-ID: <3C340601.E9A3507F@zip.com.au>
Date: Wed, 02 Jan 2002 23:19:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Momchil Velikov <velco@fadata.bg>
CC: Oliver Xymoron <oxymoron@waste.org>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org,
        "H . J . Lu" <hjl@lucon.org>
Subject: Re: Extern variables in *.c files
In-Reply-To: <02010216180403.01928@manta>
		<Pine.LNX.4.43.0201021322120.30079-100000@waste.org>
		<3C337EF1.4C7C72AB@zip.com.au>,
		<3C337EF1.4C7C72AB@zip.com.au> <87ell8wgo9.fsf@fadata.bg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Momchil Velikov wrote:
> 
> >>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:
> 
> Andrew> Oliver Xymoron wrote:
> >>
> >> On Wed, 2 Jan 2002, vda wrote:
> >>
> >> > I grepped kernel *.c (not *.h!) files for extern variable definitions.
> >> > Much to my surprize, I found ~1500 such defs.
> >> >
> >> > Isn't that bad C code style? What will happen if/when type of variable gets
> >> > changed? (int->long).
> >>
> >> Yes; Int->long won't change anything on 32-bit machines and will break
> >> silently on 64-bit ones. The trick is finding appropriate places to put
> >> such definitions so that all the things that need them can include them
> >> without circular dependencies.
> >>
> 
> Andrew> Isn't there some way to get the linker to detect the differing
> Andrew> sizes?
> `--warn-common'
>      Warn when a common symbol is combined with another common symbol
>      or with a symbol definition.  Unix linkers allow this somewhat
>      sloppy practice, but linkers on some other operating systems do
>      not.  This option allows you to find potential problems from
>      combining global symbols.  Unfortunately, some C libraries use
>      this practice, so you may get some warnings about symbols in the
>      libraries as well as in your programs.
> 

Alas, it doesn't quite work as we'd like:

akpm-1:/home/akpm> cat a.c
int a;

main()
{}
akpm-1:/home/akpm> cat b.c
extern char a;

int b()
{return a;}
akpm-1:/home/akpm> gcc -fno-common -Wl,--warn-common a.c b.c
akpm-1:/home/akpm> 

No warnings emitted.  If b.c doesn't use `extern' it will fail
to link because of -fno-common.

What we'd *like* to happen is for the linker to determine that
the `extern char' and the `int' declarations are a mismatch.
Maybe the object file doesn't have the size info for `extern'
variables.   The compiler emits it though.

We can actually get what we want by disabling `-fno-common' and enabling
`--warn-common', but that's rather awkward. 

Perhaps HJ can suggest a solution?

-
