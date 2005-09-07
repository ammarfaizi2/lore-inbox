Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVIGCfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVIGCfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 22:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVIGCfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 22:35:46 -0400
Received: from fmr19.intel.com ([134.134.136.18]:52380 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750753AbVIGCfp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 22:35:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/3 htlb-fault] Demand faulting for hugetlb
Date: Wed, 7 Sep 2005 10:33:24 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E8403365201@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3 htlb-fault] Demand faulting for hugetlb
Thread-Index: AcWzLo0RE3SGBWexReiqqGdlJHQJvAAIvxcw
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Adam Litke" <agl@us.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Sep 2005 02:34:41.0078 (UTC) FILETIME=[B2F25D60:01C5B354]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Adam Litke
>>Sent: Wednesday, September 07, 2005 5:59 AM
>>To: linux-kernel@vger.kernel.org
>>Cc: ADAM G. LITKE [imap]
>>Subject: Re: [PATCH 2/3 htlb-fault] Demand faulting for hugetlb

>>+retry:
>>+	page = find_get_page(mapping, idx);
>>+	if (!page) {
>>+		/* charge the fs quota first */
>>+		if (hugetlb_get_quota(mapping)) {
>>+			ret = VM_FAULT_SIGBUS;
>>+			goto out;
>>+		}
>>+		page = alloc_huge_page();
>>+		if (!page) {
>>+			hugetlb_put_quota(mapping);
>>+			ret = VM_FAULT_SIGBUS;
>>+			goto out;
>>+		}
>>+		if (add_to_page_cache(page, mapping, idx, GFP_ATOMIC)) {

Here you lost hugetlb_put_quota(mapping);


>>+			put_page(page);
>>+			goto retry;
>>+		}
>>+		unlock_page(page);

As for regular pages, kernel is used to unlock mm-> page_table_lock
before find_get_page and relock it before setting pte. Why isn't the
style followed by huge page fault?

