Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTLKRqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTLKRqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:46:34 -0500
Received: from root.org ([67.118.192.226]:45067 "HELO rootlabs.com")
	by vger.kernel.org with SMTP id S265176AbTLKRqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:46:31 -0500
Date: Thu, 11 Dec 2003 09:46:30 -0800 (PST)
From: Nate Lawson <nate@root.org>
To: "Yu, Luming" <luming.yu@intel.com>
cc: Paul Menage <menage@google.com>, agrover@groveronline.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: RE: [ACPI] ACPI global lock macros
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C22@PDSMSX403.ccr.corp.intel.com>
Message-ID: <20031211094510.J50052@root.org>
References: <3ACA40606221794F80A5670F0AF15F8401720C22@PDSMSX403.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Yu, Luming wrote:
> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-admin@lists.sourceforge.net]On Behalf Of Yu, Luming
> Sent: 2003?12?11? 15:06
> To: Paul Menage; agrover@groveronline.com
> Cc: linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net
> Subject: RE: [ACPI] ACPI global lock macros
>
>
> >>#define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
> >>     do { \
> >>        asm volatile("1:movl   (%1),%%eax;" \
> >>             "movl   %%eax,%%edx;" \
> >>             "andl   %2,%%edx;" \
> >>             "btsl   $0x1,%%edx;" \
> >>             "adcl   $0x0,%%edx;" \
> >>             "lock;  cmpxchgl %%edx,(%1);" \
> >>             "jnz    1b;" \
> >>             "cmpb   $0x3,%%dl;" \
> >>             "sbbl   %0,%0" \
> >>             :"=r"(Acq):"r"(GLptr),"i"(~1L):"dx", "ax"); \
> >>     } while(0)
>
> Above code have a bug! Considering below code:
>
> u8	acquired = FALSE;
>
> ACPI_ACQUIRE_GLOBAL_LOC(acpi_gbl_common_fACS.global_lock, acquired);
> if(acquired) {
> ....
> }
>
> Gcc will complain " ERROR: '%cl' not allowed with sbbl ". And I think any other compiler will
> complain that  too !
>
> How about  below changes to your proposal code.
>
> <             "sbbl   %0,%0" \
> <             :"=r"(Acq):"r"(GLptr),"i"(~1L):"dx","ax"); \
> ---
> >             "sbbl   %%eax,%%eax" \
> >             :"=a"(Acq):"r"(GLptr),"i"(~1L):"dx"); \

FYI, that's what we do in FreeBSD also.  The only difference after your
patch is that we use +m for GLptr.

#define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
    do { \
        asm("1:     movl %1,%%eax;" \
            "movl   %%eax,%%edx;" \
            "andl   %2,%%edx;" \
            "btsl   $0x1,%%edx;" \
            "adcl   $0x0,%%edx;" \
            "lock;  cmpxchgl %%edx,%1;" \
            "jnz    1b;" \
            "cmpb   $0x3,%%dl;" \
            "sbbl   %%eax,%%eax" \
            : "=a" (Acq), "+m" (GLptr) : "i" (~1L) : "edx"); \
    } while(0)

-Nate
