Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUDGTVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbUDGTVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:21:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23285 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264155AbUDGTVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:21:06 -0400
Subject: Re: [Lhms-devel] Re: [patch 0/3] memory hotplug prototype
From: Dave Hansen <haveblue@us.ibm.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20040407185953.GC4292@w-mikek2.beaverton.ibm.com>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
	 <29700000.1081361575@flay>
	 <20040407185953.GC4292@w-mikek2.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1081365642.19588.169.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Apr 2004 12:20:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 11:59, Mike Kravetz wrote:
> I've been thinking about how to take a section (or any 'block') of
> memory offline.  To do this the offlining code needs to somehow
> 'allocate' all the pages associated with the section.  After
> 'allocation', the code knows the pages are not 'in use' and safely
> offline.  Any suggestions on how to approach this?  I don't think
> we can add any infrastructure to section definitions as these will
> need to be relatively small.  Do we need to teach some of the code
> paths that currently understand zones about sections?

No, we don't need to teach zones about sections, yet (we may never have
to).  Zones currently know about contiguous pfn ranges. 
CONFIG_NONLINEAR (CNL) allows arbirary mappings from virtual and
physical memory locations to pfns.  Using this, we can keep zones
dealing with contiguous pfn ranges, and still back them with any random
memory that we want.

I think that the code changes that will be needed to offline sections
will be mostly limited to teaching the page allocator a few things about
allocating particular pfn (or physical) ranges.  If you can alloc() a
certain set of memory, then it's free to offline.

offline_section(section) {
	mark_section_going_offline(section)
	pfn = section_to_pfn(section)
	some_alloc_pages(SECTION_ORDER, pfn, ...)
	if alloc is ok
		mark_section_offline(section)
	else
		try smaller pieces
}

The mark_section_going_offline() will be used by the __free_pages() path
to intercept any page that's going offline from getting freed back into
the page allocator.  After being intercepted like this, the page can
then be considered "allocated" for the removal process.  

I think the mark_section_going_offline() stage is what some others have
referred to as a "caged" state before memory is offlined.

-- Dave

