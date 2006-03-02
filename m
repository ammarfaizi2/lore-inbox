Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWCBJKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWCBJKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWCBJKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:10:48 -0500
Received: from fmr18.intel.com ([134.134.136.17]:26286 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932111AbWCBJKr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:10:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch] Move swiotlb_init early on X86_64
Date: Thu, 2 Mar 2006 17:09:37 +0800
Message-ID: <117E3EB5059E4E48ADFF2822933287A441C94D@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] Move swiotlb_init early on X86_64
Thread-Index: AcY9wOdNLltttlgOR8yfDIBgphfCAQAF+ogg
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Zou, Nanhai" <nanhai.zou@intel.com>, "Andi Kleen" <ak@suse.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, "LKML" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 02 Mar 2006 09:09:38.0294 (UTC) FILETIME=[084A9160:01C63DD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Zou Nan hai
>>Sent: 2006Äê3ÔÂ2ÈÕ 12:33
>>
>>Really, then how about the following patch?
>>
>>Let normal bootmem allocator go above 4G first.
>>This will save more memory with address less than 4G.
>>
>>Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>
>>
>>--- linux-2.6.16-rc5/mm/bootmem.c	2006-03-03 08:31:52.000000000 +0800
>>+++ b/mm/bootmem.c	2006-03-03 09:05:17.000000000 +0800
>>@@ -381,16 +381,24 @@ unsigned long __init free_all_bootmem (v
>> 	return(free_all_bootmem_core(NODE_DATA(0)));
>> }
>>
>>+#define LOW32LIMIT 0xffffffff
>>+
>> void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
>> {
>> 	pg_data_t *pgdat = pgdat_list;
>> 	void *ptr;
>>
>>+	if (goal < LOW32LIMIT) {
On i386, above is always true.


>>+		for_each_pgdat(pgdat)
>>+			if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
>>+						 align, LOW32LIMIT, 0)))
>>+			return(ptr);
>>+	}
