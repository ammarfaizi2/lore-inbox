Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269251AbUIYGxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269251AbUIYGxl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 02:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269252AbUIYGxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 02:53:41 -0400
Received: from holomorphy.com ([207.189.100.168]:40677 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269251AbUIYGxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 02:53:39 -0400
Date: Fri, 24 Sep 2004 23:53:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 0/76] convert remap_page_range() to remap_pfn_range() vs. 2.6.9-rc2-mm3
Message-ID: <20040925065335.GV9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series resolves a physical address overflow issue in the
remap_page_range() API by replacing it with remap_pfn_range(), which
accepts its physical address argument as a pfn, hence allowing the use
of a single-precision physical address argument without the risk of
overflow at the API boundary. The above issue has hobbled support for
various 32-bit architectures, including some embedded systems (ppc440
IIRC), caused persistent portability issues for sound drivers for
legacy systems (sparc32; unfortunately this patch alone does not fully
resolve those), and according to John Fusco's reports, made drivers for
some PCI-X hardware infeasible to port to recent ia32 PAE enterprise
systems. With this patch series applied, physical address overflows on
32-bit systems caused directly by remap_page_range() are gone forever,
and ca. 100LOC of cut-and-waste driver code are swept out of existence
alongside them.

vs. 2.6.9-rc2-mm3 and the scheduler header cleanups. The parts touching
mm.h should apply with just offsets if those aren't applied beforehand.
Successfully tested on x86-64.


-- wli

P.S.: The existing solution to the sparc32 issue was to pass a double
	precision representation of the physical address as 2 single-
	precision arguments in an API (io_remap_page_range()) whose
	argument corresponding to those two was a single single-
	precision argument on most/all other architectures. The
	sparc32-specific issue requires more work beyond these patches
	to rectify. The most apparent consequence of the API skew is
	that drivers don't compile on sparc32 when they use
	io_remap_page_range() due to passing insufficient arguments,
	or vice-versa for drivers originally written for sparc32.
