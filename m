Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWAJTpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWAJTpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWAJTpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:45:22 -0500
Received: from holomorphy.com ([66.93.40.71]:8641 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S932414AbWAJTpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:45:22 -0500
Date: Tue, 10 Jan 2006 11:44:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Hugetlb: Shared memory race
Message-ID: <20060110194446.GB9091@holomorphy.com>
References: <1136920951.23288.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136920951.23288.5.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 01:22:31PM -0600, Adam Litke wrote:
> I have discovered a race caused by the interaction of demand faulting
> with the hugetlb overcommit accounting patch.  Attached is a workaround
> for the problem.  Can anyone suggest a better approach to solving the
> race I'll describe below?  If not, would the attached workaround be
> acceptable?
> The race occurs when multiple threads shmat a hugetlb area and begin
> faulting in it's pages.  During a hugetlb fault, hugetlb_no_page checks
> for the page in the page cache.  If not found, it allocates (and zeroes)
> a new page and tries to add it to the page cache.  If this fails, the
> huge page is freed and we retry the page cache lookup (assuming someone
> else beat us to the add_to_page_cache call).
> The above works fine, but due to the large window (while zeroing the
> huge page) it is possible that many threads could be "borrowing" pages
> only to return them later.  This causes free_hugetlb_pages to be lower
> than the logical number of free pages and some threads trying to shmat
> can falsely fail the accounting check.
> The workaround disables the accounting check that happens at shmat time.
> It was already done at shmget time (which is the normal semantics
> anyway).

So that's where the ->i_blocks bit came from. This is too hacky for me.
Disabling the check raises the spectre of failures when there shouldn't
be. I'd rather have a more invasive fix than a workaround, however tiny.


-- wli
