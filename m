Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWBURgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWBURgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBURgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:36:05 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:50851 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750891AbWBURgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:36:04 -0500
Subject: Re: [PATCH 4/7] ppc64 - Specify amount of kernel memory at boot
	time
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0602211445160.4335@skynet.skynet.ie>
References: <20060217141552.7621.74444.sendpatchset@skynet.csn.ul.ie>
	 <20060217141712.7621.49906.sendpatchset@skynet.csn.ul.ie>
	 <1140196618.21383.112.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0602211445160.4335@skynet.skynet.ie>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 09:35:58 -0800
Message-Id: <1140543359.8693.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 14:51 +0000, Mel Gorman wrote:
> A new release of patches is a long time away but here is an early draft of 
> what the above currently looks like. Is this more or less what you were 
> thinking?

I think it may be a bit harder to understand than even the other
one.  :(

In a nutshell, get_zones_info() tries to do too much.  Six function
arguments should be a big, red, warning light that something is really
wrong.  Calling a function _info() is another bad sign.  It means that
you can't discretely describe what it does.

Remember, there are 3 distinct tasks here:

1. size the node information from init_node_data[]
2. size the easy reclaim zone based on the boot parameters
3. take holes into account when doing the reclaim zone sizing

You don't have to do all of those tasks in one pass.  This is not a
performance-critical path, so try to be as clear as possible, even if it
means an extra run or two through the data.

Maybe something like this?

	ZONE_DMA = all memory in node
	if (kernelcore was set)
		while (zone size with holes of ZONE_DMA > kernelcore)
			move memory into EASYRCLM
	zholes[DMA] = ...
	zholes[EASYRCLM] = ...
	free_area_init_node()

Those are all operations I can understand.

-- Dave

