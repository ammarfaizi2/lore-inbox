Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTLKH1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTLKH1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:27:24 -0500
Received: from fmr05.intel.com ([134.134.136.6]:55471 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264371AbTLKH1O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:27:14 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] ACPI global lock macros
Date: Thu, 11 Dec 2003 15:27:09 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C22@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI global lock macros
Thread-Index: AcO+NiHM8fvw4HHhRdS72mZFlESBTQBfQIgwAAEtzXA=
From: "Yu, Luming" <luming.yu@intel.com>
To: "Paul Menage" <menage@google.com>, <agrover@groveronline.com>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 11 Dec 2003 07:27:09.0733 (UTC) FILETIME=[30099D50:01C3BFB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have filed a tracker http://bugme.osdl.org/show_bug.cgi?id=1669  , And a proposal patch based on Paul's proposal filed there.
--Luming

-----Original Message-----
From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-admin@lists.sourceforge.net]On Behalf Of Yu, Luming
Sent: 2003?12?11? 15:06
To: Paul Menage; agrover@groveronline.com
Cc: linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net
Subject: RE: [ACPI] ACPI global lock macros


>>#define ACPI_ACQUIRE_GLOBAL_LOCK(GLptr, Acq) \
>>     do { \
>>        asm volatile("1:movl   (%1),%%eax;" \
>>             "movl   %%eax,%%edx;" \
>>             "andl   %2,%%edx;" \
>>             "btsl   $0x1,%%edx;" \
>>             "adcl   $0x0,%%edx;" \
>>             "lock;  cmpxchgl %%edx,(%1);" \
>>             "jnz    1b;" \
>>             "cmpb   $0x3,%%dl;" \
>>             "sbbl   %0,%0" \
>>             :"=r"(Acq):"r"(GLptr),"i"(~1L):"dx", "ax"); \
>>     } while(0)

Above code have a bug! Considering below code:

u8	acquired = FALSE;

ACPI_ACQUIRE_GLOBAL_LOC(acpi_gbl_common_fACS.global_lock, acquired);
if(acquired) {
....
}

Gcc will complain " ERROR: '%cl' not allowed with sbbl ". And I think any other compiler will
complain that  too !

How about  below changes to your proposal code.

<             "sbbl   %0,%0" \
<             :"=r"(Acq):"r"(GLptr),"i"(~1L):"dx","ax"); \
---
>             "sbbl   %%eax,%%eax" \
>             :"=a"(Acq):"r"(GLptr),"i"(~1L):"dx"); \

PS. I'm very curious about how could you find this bug.  

Thanks
Luming



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Acpi-devel mailing list
Acpi-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/acpi-devel
