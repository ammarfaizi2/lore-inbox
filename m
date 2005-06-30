Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVF3RO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVF3RO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 13:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbVF3RO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 13:14:26 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:1976 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262790AbVF3ROR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 13:14:17 -0400
X-IronPort-AV: i="3.94,154,1118034000"; 
   d="scan'208"; a="260707072:sNHT24169024"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
Date: Thu, 30 Jun 2005 12:14:16 -0500
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B407434C@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcV9jvboLnykyAOORAS/GMIhlJZYBQABJtZgAAB8XiA=
From: <Stuart_Hayes@Dell.com>
To: <Stuart_Hayes@Dell.com>, <ak@suse.de>
Cc: <riel@redhat.com>, <andrea@suse.dk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jun 2005 17:14:16.0646 (UTC) FILETIME=[25223660:01C57D97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hayes, Stuart wrote:
> Andi Kleen wrote:
>> 
>> I only fixed it for x86-64 correct. Does it work for you on x86-64?
>> 
>> If yes then the changes could be brought over.
>> 
>> What do you all need this for anyways?
>> 
>> -Andi
> 
> We need this because the NVidia driver uses change_page_attr() to
> make pages non-cachable, which is causing systems to spontaneously
> reboot when it gets a page that's in the first 8MB of memory.  
> 
> I'll look at x86_64.  The problem was seen originally with i386, and
> I haven't taken much time to look at the x86_64 stuff yet. 
> 
> Thanks,
> Stuart

Doesn't x86_64 map the kernel code into a different virtual address
range than the direct mapping of physical memory--and __get_free_pages()
returns a pointer to the direct mapping area rather than to the kernel
text area?  This would prevent the problem, because I assume the entire
direct mapping of physical memory area is set to non-executable.

The problem with i386 occurs because the kernel code and kernel memory
is all mapped to the same virtual address range (at 0xC0000000), so
kernel code, and free pages returned by __get_free_pages(), both reside
in the same large page.

So, if I understand correctly what's going on in x86_64, your fix
wouldn't be applicable to i386.  In x86_64, every large page has a
correct "ref_prot" that is the normal setting for that page... but in
i386, the kernel text area does not--it should ideally be split into
small pages all the time if there are both kernel code & free pages
residing in the same 2M area.

Stuart



