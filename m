Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266100AbTLIShW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266102AbTLIShW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:37:22 -0500
Received: from fmr05.intel.com ([134.134.136.6]:17801 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266100AbTLISff convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:35:35 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] ACPI global lock macros
Date: Tue, 9 Dec 2003 10:20:56 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EFB3@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI global lock macros
Thread-Index: AcO+NhAn90EkHop3QQepOQrPAtVYOgASF6+A
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Paul Menage" <menage@google.com>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 09 Dec 2003 18:20:57.0103 (UTC) FILETIME=[308BC1F0:01C3BE81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Len Brown (len.brown@intel.com) is now the guy for ACPI patch
submissions, but let me just comment that historically this was a "get
it working and leave it alone" area, so if you've found potential bugs
and fixed them, then great.

BTW, i386, x86_64 and ia64 all have this macro, so these all might need
to be looked at.

Regards -- Andy

PS the question that Arjan brought up about why ACPI needs its own lock
has come up before. Maybe we should add this reason to the comment above
these macros in include/asm-*/acpi.h.

> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net 
> [mailto:acpi-devel-admin@lists.sourceforge.net] On Behalf Of 
> Paul Menage

> Hi Andy,
> 
> The ACPI_ACQUIRE_GLOBAL_LOCK() macro in 
> include/asm-i386/acpi.h looks a 
> little odd:
> 
> #define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
>      do { \
>          int dummy; \
>          asm("1:     movl (%1),%%eax;" \
>              "movl   %%eax,%%edx;" \
>              "andl   %2,%%edx;" \
>              "btsl   $0x1,%%edx;" \
>              "adcl   $0x0,%%edx;" \
>              "lock;  cmpxchgl %%edx,(%1);" \
>              "jnz    1b;" \
>              "cmpb   $0x3,%%dl;" \
>              "sbbl   %%eax,%%eax" \
>              :"=a"(Acq),"=c"(dummy):"c"(GLptr),"i"(~1L):"dx"); \
>      } while(0)
> 
> 
> When compiled, it results in:
> 
>   266:   mov    0x0,%ecx
>                          268: R_386_32   acpi_gbl_common_fACS
>   26c:   mov    (%ecx),%eax
>   26e:   mov    %eax,%edx
>   270:   and    %ecx,%edx
>   272:   bts    $0x1,%edx
>   276:   adc    $0x0,%edx
>   279:   lock cmpxchg %edx,(%ecx)
>   27d:   jne    26c <acpi_ev_acquire_global_lock+0x2f>
>   27f:   cmp    $0x3,%dl
>   282:   sbb    %eax,%eax
> 
> So at location 270 we mask %edx with %ecx, which is the 
> address of the 
> global lock. Unless the global lock is aligned on a 2-byte but not 
> 4-byte boundary, which seems a little unlikely, then this is going to 
> clear both the owned and the pending bits in %edx, so we'll 
> always think 
> that the lock is not owned. Shouldn't the andl be masking 
> with %3 (which 
> is initialised as ~1) rather than %2 (the address of the lock)?
> 
> Given the comments above the definition, I'm guessing that 
> the "dummy" 
> parameter was added later for some reason (to tell gcc that ecx would 
> get clobbered? - but it doesn't seem to be clobbered), and 
> the parameter 
> substitutions in the asm weren't updated. Unless I'm missing 
> something 
> fundamental, shouldn't the definition be something more like this:
> 
> 
> #define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
>      do { \
>          asm volatile("1:movl   (%1),%%eax;" \
>              "movl   %%eax,%%edx;" \
>              "andl   %2,%%edx;" \
>              "btsl   $0x1,%%edx;" \
>              "adcl   $0x0,%%edx;" \
>              "lock;  cmpxchgl %%edx,(%1);" \
>              "jnz    1b;" \
>              "cmpb   $0x3,%%dl;" \
>              "sbbl   %0,%0" \
>              :"=r"(Acq):"r"(GLptr),"i"(~1L):"dx", "ax"); \
>      } while(0)
> 
> which compiles to:
> 
>   2e5:   mov    0x0,%ecx
>                          2e7: R_386_32   acpi_gbl_common_fACS
>   2eb:   mov    (%ecx),%eax
>   2ed:   mov    %eax,%edx
>   2ef:   and    $0xfffffffe,%edx
>   2f2:   bts    $0x1,%edx
>   2f6:   adc    $0x0,%edx
>   2f9:   lock cmpxchg %edx,(%ecx)
>   2fd:   jne    2eb <acpi_ev_acquire_global_lock+0x37>
>   2ff:   cmp    $0x3,%dl
>   302:   sbb    %cl,%cl
> 
> 
> which is identical to the ACPI spec reference implementation, 
> apart from 
> returning the result in %cl rather than %al (since we're cleanly 
> separating clobbered registers from input/output params, and 
> letting gcc 
> choose the param registers).
> 
> Alternatively it could be defined in C (as in ia64) which 
> would reduce 
> the likelihood of asm bugs. (Although it wouldn't be safe to use 
> __cmpxchg(), as that uses LOCK_PREFIX which is empty on UP, 
> rather than 
> an explicit "lock").
> 
> ACPI_RELEASE_GLOBAL_LOCK(), and the x86_64 variants of these, seem to 
> have similar issues.
