Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWJDTp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWJDTp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWJDTp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:45:27 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:57068 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750945AbWJDTpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:45:25 -0400
Date: Wed, 4 Oct 2006 15:44:41 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: linux-kernel@vger.kernel.org, Reloc Kernel List <fastboot@lists.osdl.org>,
       ebiederm@xmission.com, akpm@osdl.org, ak@suse.de, horms@verge.net.au,
       lace@jankratochvil.net, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 4/12] i386: define __pa_symbol()
Message-ID: <20061004194441.GF16218@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003171055.GD3164@in.ibm.com> <45237044.8090805@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45237044.8090805@innova-card.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 10:26:44AM +0200, Franck Bui-Huu wrote:
> hi,
> 
> Sorry for the late feedback...
> 
> Vivek Goyal wrote:
> > 
> > On x86_64 we have to be careful with calculating the physical
> > address of kernel symbols.  Both because of compiler odditities
> > and because the symbols live in a different range of the virtual
> > address space.
> > 
> 
> [snip]
> 
> > +#define __pa_symbol(x)          \
> > +	({unsigned long v;  \
> > +	  asm("" : "=r" (v) : "0" (x)); \
> > +	  __pa(v); })
> 
> Why not simply reusing RELOC_HIDE  like this ?
> 
> 	#define __pa_symbol(x)	__pa(RELOC_HIDE(x,0))
>

Thanks. Above did not work and compiler gave following warning message upon
using __pa_symbol(_text)

error: cast specified array type

Then I specifically typecasted x to unsigned long and it seems to be
fine. 

Regenerated patch is attached.

 


On x86_64 we have to be careful with calculating the physical
address of kernel symbols.  Both because of compiler odditities
and because the symbols live in a different range of the virtual
address space.

Having a defintition of __pa_symbol that works on both x86_64 and
i386 simplifies writing code that works for both x86_64 and
i386 that has these kinds of dependencies.

So this patch adds the trivial i386 __pa_symbol definition.

Added assembly magic similar to RELOC_HIDE as suggested by Andi Kleen.
Just picked it up from x86_64.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 include/asm-i386/page.h |    3 +++
 1 file changed, 3 insertions(+)

diff -puN include/asm-i386/page.h~i386-define-__pa_symbol include/asm-i386/page.h
--- linux-2.6.18-git17/include/asm-i386/page.h~i386-define-__pa_symbol	2006-10-02 14:39:18.000000000 -0400
+++ linux-2.6.18-git17-root/include/asm-i386/page.h	2006-10-04 14:48:54.000000000 -0400
@@ -124,6 +124,9 @@ extern int page_is_ram(unsigned long pag
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
 #define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
+/* __pa_symbol should be used for C visible symbols.
+   This seems to be the official gcc blessed way to do such arithmetic. */
+#define __pa_symbol(x)          __pa(RELOC_HIDE((unsigned long)x,0))
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
 #ifdef CONFIG_FLATMEM
_
 
