Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWFVNRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWFVNRp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWFVNRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:17:45 -0400
Received: from gold.veritas.com ([143.127.12.110]:38275 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1161101AbWFVNRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:17:44 -0400
X-IronPort-AV: i="4.06,166,1149490800"; 
   d="scan'208"; a="60860941:sNHT465306348"
Date: Thu, 22 Jun 2006 14:17:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, dhowells@redhat.com,
       christoph@lameter.com, mbligh@google.com, npiggin@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
In-Reply-To: <1150976031.15744.122.camel@lappy>
Message-ID: <Pine.LNX.4.64.0606221358100.18020@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy>  <20060621225639.4c8bad93.akpm@osdl.org>
 <1150976031.15744.122.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Jun 2006 13:17:42.0747 (UTC) FILETIME=[3E61DAB0:01C695FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Peter Zijlstra wrote:
> On Wed, 2006-06-21 at 22:56 -0700, Andrew Morton wrote:
> 
> > > +		vma->vm_page_prot =
> > > +			__pgprot(pte_val
> > > +				(pte_wrprotect
> > > +				 (__pte(pgprot_val(vma->vm_page_prot)))));
> > > +
> > 
> > Is there really no simpler way?
>.... 
> Awell, thoughts, comments?

Just note vma->vm_page_prot before calling the ->mmap and check after.
If the driver has messed with it at all, it's not a mapping we want to
apply dirty capping to anyway.  If it's unchanged, and the other tests
pass, go ahead and reset readonly vm_page_prot via protection_map[].

This is of course a hack, as is the pgprotting code from drm.
The correct solution would be to set the proper backing_dev_info
in a number of drivers - we were too lazy when setting the default
in the first place; but even if we caught all the intree drivers,
we'd miss out-of-tree ones and suffer unnecessary pain from them.
So for now a hack is necessary, and I haven't thought of a better.

Other comments to follow...

Hugh
