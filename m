Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUGFUsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUGFUsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUGFUsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:48:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:37773 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264501AbUGFUrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:47:07 -0400
Date: Tue, 6 Jul 2004 11:18:50 -0500
From: linas@austin.ibm.com
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 PPC64 EEH unbalanced dev_get/put calls
Message-ID: <20040706111850.A21634@forte.austin.ibm.com>
References: <20040702134539.W21634@forte.austin.ibm.com> <16614.16478.9599.463185@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16614.16478.9599.463185@cargo.ozlabs.ibm.com>; from paulus@samba.org on Sat, Jul 03, 2004 at 03:13:02PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 03:13:02PM +1000, Paul Mackerras wrote:
> Linas,
> 
> > This patch fixes some unbalanaced usage of pci_dev_get()/pci_dev_put() calls
> > in the eeh code.  The old code had too many calls to dev_put, which could
> > cause memory structs to be freed prematurely, possibly leading to bad
> > bad pointer derefs in certain cases.
> 
> When I apply this I end up with one pci_dev_get() call in
> __pci_addr_cache_insert_device and no pci_dev_put() calls.  That can't
> be right, surely?  If it is it needs a big fat comment explaining why.


No, that's right. The device is gotten for the length of time that 
it is in the cache, and is put when it is removed from the cache.
In this way, the device is not free()'ed as long as the cache holds 
a reference to it.

I can add a comment, but it seemed 'obvious' from the description of the
cache that it would be holding a reference to the device for an indefinite 
period of time.

The patch was really to fix the result of a misunderstanding of what 
the poorly-named routine "pci_get_device()" does:  yes, it does a get(), 
but it also does a put(), which one wouldn't guess from the name :(

A better name for this might be "pci_next_device()" or 
"pci_obtain_device()" or something like that ...


> > Cross-ref LTC bug 9283
> Confused - that's the bug about not using ibm,fw-phb-id.

Oops.

--linas

