Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287524AbSABNMO>; Wed, 2 Jan 2002 08:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287457AbSABNME>; Wed, 2 Jan 2002 08:12:04 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:44325 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S287454AbSABNLx>; Wed, 2 Jan 2002 08:11:53 -0500
Date: Wed, 2 Jan 2002 08:11:39 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Momchil Velikov <velco@fadata.bg>
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102081139.Y4087@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <87y9jh3v27.fsf@deneb.enyo.de> <874rm5yqzr.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <874rm5yqzr.fsf@fadata.bg>; from velco@fadata.bg on Wed, Jan 02, 2002 at 12:41:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 12:41:28PM +0200, Momchil Velikov wrote:
> >>>>> "Florian" == Florian Weimer <fw@deneb.enyo.de> writes:
> 
> Florian> Momchil Velikov <velco@fadata.bg> writes:
> >> -		strcpy(namep, RELOC("linux,phandle"));
> >> +		memcpy (namep, RELOC("linux,phandle"), sizeof("linux,phandle"));
> 
> Florian> Doesn't this still trigger undefined behavior, as far as the C
> Florian> standard is concerned?  It's probably a better idea to fix the linker,
> Florian> so that it performs proper relocation.
> 
> Well, strictly speaking it _is_ undefined, however adding/subtracting
> __PAGE_OFFSET is far too common operation and one can resonably expect
> to get away with it in the _vast_ majority of cases. IMHO, it is
> better to fix the particular case, which triggers the undefined
> behaviour, as these cases are bound to be _very_ rare.

IMHO the best thing is to change the RELOC macro, so that gcc cannot optimize
this.
E.g.:
-#define PTRRELOC(x)     ((typeof(x))((unsigned long)(x) + offset))
+#define PTRRELOC(x)     ({ unsigned long __x = (unsigned long)(x);	\
			    asm ("" : "=r" (__x) : "0" (__x));		\
			    (typeof(x))(__x + offset); })
This way gcc cannot assume anything about it.

	Jakub
