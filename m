Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTKLUuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 15:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTKLUt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 15:49:59 -0500
Received: from palrel13.hp.com ([156.153.255.238]:49798 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261567AbTKLUtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 15:49:55 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16306.40177.200706.688936@napali.hpl.hp.com>
Date: Wed, 12 Nov 2003 12:49:53 -0800
To: Jack Steiner <steiner@sgi.com>
Cc: akpm@osdl.org, davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Inefficient TLB flushing 
In-Reply-To: <20031112200119.GA22429@sgi.com>
References: <20031112200119.GA22429@sgi.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 12 Nov 2003 14:01:19 -0600, Jack Steiner <steiner@sgi.com> said:

  Jack> Does this analysis look correct??

Yup.

  Jack> Here is the patch that I am currently testing:

  Jack> --- /usr/tmp/TmpDir.19957-0/linux/mm/memory.c_1.79	Wed Nov 12 13:56:25 2003
  Jack> +++ linux/mm/memory.c	Wed Nov 12 12:57:25 2003
  Jack> @@ -574,9 +574,10 @@
  Jack>  			if ((long)zap_bytes > 0)
  Jack>  				continue;
  Jack>  			if (need_resched()) {
  Jack> +				int fullmm = (*tlbp)->fullmm;
  Jack>  				tlb_finish_mmu(*tlbp, tlb_start, start);
  Jack>  				cond_resched_lock(&mm->page_table_lock);
  Jack> -				*tlbp = tlb_gather_mmu(mm, 0);
  Jack> +				*tlbp = tlb_gather_mmu(mm, fullmm);
  Jack>  				tlb_start_valid = 0;
  Jack>  			}
  Jack>  			zap_bytes = ZAP_BLOCK_SIZE;

I think the patch will work fine, but it's not very clean, because it
bypasses the TLB-flush API and directly accesses
implementation-specific internals.  Perhaps it would be better to pass
a "fullmm" flag to unmap_vmas().  Andrew?

	--david
