Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVLFUtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVLFUtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVLFUtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:49:20 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:12014 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932451AbVLFUtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:49:19 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] /dev/mem validate mmap requests
Date: Tue, 6 Dec 2005 13:49:11 -0700
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
References: <200512051700.20269.bjorn.helgaas@hp.com> <Pine.LNX.4.61.0512061832090.26899@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0512061832090.26899@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512061349.11895.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 11:39 am, Hugh Dickins wrote:
> On Mon, 5 Dec 2005, Bjorn Helgaas wrote:
> > Add a hook so architectures can validate /dev/mem mmap requests.
> 
> Not a comment on your patch at all, just an FYI in case you've missed
> it, and in case it makes any difference to your ia64 needs.
> 
> A side-effect of 2.6.15-rc's PageReserved changes is that a user with
> access to /dev/mem can now mmap any page of it, and see what's there
> rather than zeroes, whether or not it has been marked PageReserved.

Thanks for the pointer.

I think my patch is orthogonal to your PageReserved changes.

Here's a little more detail on the problem scenario.  An HP
sx1000 machine with VGA has a memory map like this:

	0-640K 		memory (supports only WB mappings)
	640K-768K	VGA frame buffer (MMIO, supports only UC mappings)
	768K-16M	memory (supports only WB mappings)

We use a 16MB "granule".  All mappings within a granule have to
be the same type to avoid attribute aliasing.  Since we're using
VGA, we have to use UC mappings for the MMIO frame buffer.  We
can't use UC mappings for the memory, because the sx1000 chipset
doesn't support that.  We can't use WB mappings, because that would
cause attribute aliasing.

Since we can't use WB mappings, the kernel ignores all that memory
between 0-16MB.  There aren't even any page structures for it.  But
without my patch, /dev/mem allows users to mmap it.  And there's no
safe way to allow access of any kind to that memory.

Bjorn
