Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUCYVDC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 16:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbUCYVDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 16:03:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:13251 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263618AbUCYVC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 16:02:58 -0500
Date: Thu, 25 Mar 2004 13:04:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de, raybry@sgi.com,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [PATCH] [0/6] HUGETLB memory commitment
Message-Id: <20040325130433.0a61d7ef.akpm@osdl.org>
In-Reply-To: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> HUGETLB Overcommit Handling
> ---------------------------
> When building mappings the kernel tracks committed but not yet
> allocated pages against available memory and swap preventing memory
> allocation problems later.  The introduction of hugetlb pages has
> has significant ramifications for this accounting as the pages used
> to back them are already removed from the available memory pool.

Sorry, but I just don't see why we need all this complexity and generality.

If there was any likelihood that there would be additional memory domains
in the 2.6 future then OK.  But I don't think there will be.  We simply
need some little old patch which fixes this bug.

Such as adding a `vma' arg to vm_enough_memory() and vm_unacct_memory() and
doing

	if (is_vm_hugetlb_page(vma))
		return;

and

-	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
+	allowed = (totalram_pages - htlbpagemem << HPAGE_SHIFT) *
+			sysctl_overcommit_ratio / 100;

in cap_vm_enough_memory().

