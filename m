Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbULWVBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbULWVBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 16:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbULWVBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 16:01:37 -0500
Received: from ozlabs.org ([203.10.76.45]:22505 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261293AbULWVBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 16:01:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16843.12842.127923.387226@cargo.ozlabs.ibm.com>
Date: Fri, 24 Dec 2004 08:01:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: unlisted-recipients:;;;akpm@osdl.org; (no To-header on input),
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)akpm@osdl.org
								     ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)akpm@osdl.org
								     ^-missing end of address
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
In-Reply-To: <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	<41C20E3E.3070209@yahoo.com.au>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> The most expensive operation in the page fault handler is (apart of SMP
> locking overhead) the zeroing of the page. This zeroing means that all
> cachelines of the faulted page (on Altix that means all 128 cachelines of
> 128 byte each) must be loaded and later written back. This patch allows to
> avoid having to load all cachelines if only a part of the cachelines of
> that page is needed immediately after the fault.

On ppc64 we avoid having to zero newly-allocated page table pages by
using a slab cache for them, with a constructor function that zeroes
them.  Page table pages naturally end up being full of zeroes when
they are freed, since ptep_get_and_clear, pmd_clear or pgd_clear has
been used on every non-zero entry by that stage.  Thus there is no
extra work required either when allocating them or freeing them.

I don't see any point in your patches for systems which don't have
some magic hardware for zeroing pages.  Your patch seems like a lot of
extra code that only benefits a very small number of machines.

Paul.
