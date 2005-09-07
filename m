Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVIGOEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVIGOEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVIGOEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:04:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:2009 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751216AbVIGOEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:04:08 -0400
Subject: RE: [PATCH 2/3 htlb-fault] Demand faulting for hugetlb
From: Adam Litke <agl@us.ibm.com>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E8403365201@pdsmsx404>
References: <8126E4F969BA254AB43EA03C59F44E8403365201@pdsmsx404>
Content-Type: text/plain
Organization: IBM
Date: Wed, 07 Sep 2005 09:04:00 -0500
Message-Id: <1126101840.3123.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 10:33 +0800, Zhang, Yanmin wrote:
> >>-----Original Message-----
> >>From: linux-kernel-owner@vger.kernel.org
> >>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Adam Litke
> >>Sent: Wednesday, September 07, 2005 5:59 AM
> >>To: linux-kernel@vger.kernel.org
> >>Cc: ADAM G. LITKE [imap]
> >>Subject: Re: [PATCH 2/3 htlb-fault] Demand faulting for hugetlb
> 
> >>+retry:
> >>+	page = find_get_page(mapping, idx);
> >>+	if (!page) {
> >>+		/* charge the fs quota first */
> >>+		if (hugetlb_get_quota(mapping)) {
> >>+			ret = VM_FAULT_SIGBUS;
> >>+			goto out;
> >>+		}
> >>+		page = alloc_huge_page();
> >>+		if (!page) {
> >>+			hugetlb_put_quota(mapping);
> >>+			ret = VM_FAULT_SIGBUS;
> >>+			goto out;
> >>+		}
> >>+		if (add_to_page_cache(page, mapping, idx, GFP_ATOMIC)) {
> 
> Here you lost hugetlb_put_quota(mapping);

Whoops, thanks for catching that.

> >>+			put_page(page);
> >>+			goto retry;
> >>+		}
> >>+		unlock_page(page);
> 
> As for regular pages, kernel is used to unlock mm-> page_table_lock
> before find_get_page and relock it before setting pte. Why isn't the
> style followed by huge page fault?

As far as I can tell, we should be able to do that for large pages as
well.  I'll give it a spin.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

