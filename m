Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287855AbSABPzM>; Wed, 2 Jan 2002 10:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287852AbSABPzC>; Wed, 2 Jan 2002 10:55:02 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:3712 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287855AbSABPyr>; Wed, 2 Jan 2002 10:54:47 -0500
Date: Wed, 2 Jan 2002 08:54:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Momchil Velikov <velco@fadata.bg>, Florian Weimer <fw@deneb.enyo.de>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102155441.GB1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <87y9jh3v27.fsf@deneb.enyo.de> <874rm5yqzr.fsf@fadata.bg> <20020102081139.Y4087@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020102081139.Y4087@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 08:11:39AM -0500, Jakub Jelinek wrote:
> 
> On Wed, Jan 02, 2002 at 12:41:28PM +0200, Momchil Velikov wrote:
> > >>>>> "Florian" == Florian Weimer <fw@deneb.enyo.de> writes:
> >
> > Florian> Momchil Velikov <velco@fadata.bg> writes:
> > >> -		strcpy(namep, RELOC("linux,phandle"));
> > >> +		memcpy (namep, RELOC("linux,phandle"), sizeof("linux,phandle"));
> >
> > Florian> Doesn't this still trigger undefined behavior, as far as the C
> > Florian> standard is concerned?  It's probably a better idea to fix the linker,
> > Florian> so that it performs proper relocation.

This has been suggested too.  And if someone implemements this in the
2.5.x timeframe it might even go in (as long as it works w/ gcc-2.95.x,
which really should be doable).

> > Well, strictly speaking it _is_ undefined, however adding/subtracting
> > __PAGE_OFFSET is far too common operation and one can resonably expect
> > to get away with it in the _vast_ majority of cases. IMHO, it is
> > better to fix the particular case, which triggers the undefined
> > behaviour, as these cases are bound to be _very_ rare.
> 
> IMHO the best thing is to change the RELOC macro, so that gcc cannot optimize
> this.
> E.g.:
> -#define PTRRELOC(x)     ((typeof(x))((unsigned long)(x) + offset))
> +#define PTRRELOC(x)     ({ unsigned long __x = (unsigned long)(x);	\
> 			    asm ("" : "=r" (__x) : "0" (__x));		\
> 			    (typeof(x))(__x + offset); })
> This way gcc cannot assume anything about it.

This is what Franz Sirl suggested awhile back, which should work, but
doesn't look too nice.  If gcc-3.0.x is going to be expected to produce a
working kernel on all arches, I suppose this is the best fix for now.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
