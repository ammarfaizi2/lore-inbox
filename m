Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUIGQdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUIGQdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUIGQa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:30:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60366 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268153AbUIGQ3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:29:43 -0400
Date: Tue, 7 Sep 2004 11:28:52 -0500
From: Robin Holt <holt@sgi.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, dcn@sgi.com
Subject: Re: [IA64] allow OEM written modules to make calls to ia64 OEM SAL functions.
Message-ID: <20040907162852.GA29879@lnx-holt.americas.sgi.com>
References: <200409032207.i83M7CKj015068@hera.kernel.org> <1094280707.2801.0.camel@laptop.fenrus.com> <20040904103529.C13149@infradead.org> <20040904093745.GB5313@devserv.devel.redhat.com> <20040904152949.5bf7bca8.akpm@osdl.org> <20040904223642.GA27637@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904223642.GA27637@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can we hold off on reverting this until more discussion occurs.

SGI introduced this as part of our work to push the open source XPC code
into the kernel.  Tony Luck included the patch after discussions about
XPC splintered into a seperate discussion about what was acceptable for
the SAL call.  SGI had originally intended this to be part of that
patch set.

The OEM functions that are referred to do things like modify memory
timeout values on OEM equipment, adjust memory protections, inject double
bit errors to test error recovery, and adjust queue lengths inside
of hardware.  These things are extremely OEM specific.  Making the
SAL calls only rely on "Kernel Code" for the definition of the kernel
function calls which is a gateway into SAL.

What the kernel's SAL call is providing to the module is a pointer to
a generic function entry point for SAL that was provided to the kernel
by SAL.  This is the proscribed method defined in the Intel Itanium
System Abstraction Layer specification available on the Intel web site.
The kernel has no knowledge of what SAL will do with this function
code nor what the caller is asking.  In essence this is equivalent to
a PCI command.

Having this functionality in the kernel is important to SGI even
before the code is written.  This allows us to use the SAL call from
error injection diagnostics on older kernels.  The code limits the SAL
functions to those in the OEM range as defined by the Intel specification.

Robin Holt

On Sun, Sep 05, 2004 at 12:36:42AM +0200, Arjan van de Ven wrote:
> 
> On Sat, Sep 04, 2004 at 03:29:49PM -0700, Andrew Morton wrote:
> > Arjan van de Ven <arjanv@redhat.com> wrote:
> > >
> > > On Sat, Sep 04, 2004 at 10:35:29AM +0100, Christoph Hellwig wrote:
> > > > On Sat, Sep 04, 2004 at 08:51:47AM +0200, Arjan van de Ven wrote:
> > > > > On Wed, 2004-08-25 at 20:27, Linux Kernel Mailing List wrote:
> > > > > > ChangeSet 1.1803.128.1, 2004/08/25 18:27:33+00:00, dcn@sgi.com
> > > > > > 
> > > > > > 	[IA64] allow OEM written modules to make calls to ia64 OEM SAL functions.
> > > > > > 	
> > > > > > 	Add wrapper functions for SAL_CALL(), SAL_CALL_NOLOCK(), and
> > > > > > 	SAL_CALL_REENTRANT() that allow OEM written modules to make
> > > > > > 	calls to ia64 OEM SAL functions.
> > > > > > 	
> > > > > 
> > > > > are there any such modules? Are they GPL licensed or all proprietary ?
> > > > 
> > > > SGI has stated they have propritary modules that need this, that's why it's
> > > > got added despite my objections.
> > > 
> > > if there are no open source modules that use these exports I would like to
> > > ask these exports to be undone again..
> > 
> > Yes.  Guys, these are the rules we all live by.
> > 
> > Arjan, please submit a patch.
> 
> well all that is needed is to revert changeset                                                                                                               
> 1.1803.128.1 since that is the entire and exclusive purpose of this
> changeset.. but for your convenience below
> 
> --- b/arch/ia64/kernel/sal.c	2004-09-03 15:07:22 -07:00
> +++ a/arch/ia64/kernel/sal.c	2004-09-03 15:07:22 -07:00
> @@ -10,7 +10,6 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> -#include <linux/module.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>  
> @@ -263,40 +262,3 @@
>  		p += SAL_DESC_SIZE(*p);
>  	}
>  }
> -
> -int
> -ia64_sal_oemcall(struct ia64_sal_retval *isrvp, u64 oemfunc, u64 arg1,
> -		 u64 arg2, u64 arg3, u64 arg4, u64 arg5, u64 arg6, u64 arg7)
> -{
> -	if (oemfunc < IA64_SAL_OEMFUNC_MIN || oemfunc > IA64_SAL_OEMFUNC_MAX)
> -		return -1;
> -	SAL_CALL(*isrvp, oemfunc, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
> -	return 0;
> -}
> -EXPORT_SYMBOL(ia64_sal_oemcall);
> -
> -int
> -ia64_sal_oemcall_nolock(struct ia64_sal_retval *isrvp, u64 oemfunc, u64 arg1,
> -			u64 arg2, u64 arg3, u64 arg4, u64 arg5, u64 arg6,
> -			u64 arg7)
> -{
> -	if (oemfunc < IA64_SAL_OEMFUNC_MIN || oemfunc > IA64_SAL_OEMFUNC_MAX)
> -		return -1;
> -	SAL_CALL_NOLOCK(*isrvp, oemfunc, arg1, arg2, arg3, arg4, arg5, arg6,
> -			arg7);
> -	return 0;
> -}
> -EXPORT_SYMBOL(ia64_sal_oemcall_nolock);
> -
> -int
> -ia64_sal_oemcall_reentrant(struct ia64_sal_retval *isrvp, u64 oemfunc,
> -			   u64 arg1, u64 arg2, u64 arg3, u64 arg4, u64 arg5,
> -			   u64 arg6, u64 arg7)
> -{
> -	if (oemfunc < IA64_SAL_OEMFUNC_MIN || oemfunc > IA64_SAL_OEMFUNC_MAX)
> -		return -1;
> -	SAL_CALL_REENTRANT(*isrvp, oemfunc, arg1, arg2, arg3, arg4, arg5, arg6,
> -			   arg7);
> -	return 0;
> -}
> -EXPORT_SYMBOL(ia64_sal_oemcall_reentrant);
> reverted:
> --- b/include/asm-ia64/sal.h	2004-09-03 15:07:22 -07:00
> +++ a/include/asm-ia64/sal.h	2004-09-03 15:07:22 -07:00
> @@ -819,16 +819,6 @@
>  	long r8; long r9; long r10; long r11;
>  };
>  
> -#define IA64_SAL_OEMFUNC_MIN		0x02000000
> -#define IA64_SAL_OEMFUNC_MAX		0x03ffffff
> -
> -extern int ia64_sal_oemcall(struct ia64_sal_retval *, u64, u64, u64, u64, u64,
> -			    u64, u64, u64);
> -extern int ia64_sal_oemcall_nolock(struct ia64_sal_retval *, u64, u64, u64,
> -				   u64, u64, u64, u64, u64);
> -extern int ia64_sal_oemcall_reentrant(struct ia64_sal_retval *, u64, u64, u64,
> -				      u64, u64, u64, u64, u64);
> -
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_IA64_SAL_H */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
