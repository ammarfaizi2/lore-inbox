Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbTLKHGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTLKHGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:06:19 -0500
Received: from fmr06.intel.com ([134.134.136.7]:34702 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264369AbTLKHGR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:06:17 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] ACPI global lock macros
Date: Thu, 11 Dec 2003 15:06:10 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720C21@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI global lock macros
Thread-Index: AcO+NiHM8fvw4HHhRdS72mZFlESBTQBfQIgw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Paul Menage" <menage@google.com>, <agrover@groveronline.com>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 11 Dec 2003 07:06:10.0967 (UTC) FILETIME=[41C12A70:01C3BFB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

