Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267684AbSLGAjV>; Fri, 6 Dec 2002 19:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267685AbSLGAjV>; Fri, 6 Dec 2002 19:39:21 -0500
Received: from holomorphy.com ([66.224.33.161]:18065 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267684AbSLGAjU>;
	Fri, 6 Dec 2002 19:39:20 -0500
Date: Fri, 6 Dec 2002 16:46:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021207004643.GV9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF13A54.927C04C1@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 04:01:24PM -0800, Andrew Morton wrote:
> One way to address this could be to find a way of making the
> pages present, but still cause a fault on first access.  Then
> have a special-case fastpath in the fault handler to really wipe
> the page just before it is used.  I don't know how though - maybe
> _PAGE_USER?

All of the problems there have to do with accounting which pieces of
the page are zeroed. The PTE's map the same size areas (MMUPAGE_SIZE
stays 4KB)... So after a partial zero we end up with a struct page
pointing at MMUPAGE_COUNT mmupages, and a PTE pointing at the one
that's been zeroed and not a whole lot of flag bits left to keep track
of which pieces are initialized. How about a single PG_zero flag and
map out which bits of the thing are already zeroed in page->private?
(basically the swapcache can be considered the owning fs and it then
 then uses page->private for those shenanigans).


On Fri, Dec 06, 2002 at 04:01:24PM -0800, Andrew Morton wrote:
> get_user_pages() would need attention too - you don't want to
> allow the user to perform O_DIRECT writes of uninitialised
> pages to their files...

Well, I'm not sure how that would happen. fs io should deal with
kernel PAGE_SIZE-sized units so we're dealing with anonymous memory
only. O_DIRECT if we perform a write would only find the part of the
page mapped by a PTE, which must have been pre-zeroed prior to being
mapped. Reads seem to be in equally good shape. Perhaps it's more of
"this is yet another things to audit when dealing with it"; I'll admit
that the audit needed for this thing is somewhat large.


Bill
