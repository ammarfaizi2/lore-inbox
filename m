Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbUBEBEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUBEBCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:02:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:11658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265205AbUBEAyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:54:54 -0500
Date: Wed, 4 Feb 2004 16:56:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       kmannth@us.ibm.com
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
 X  (fwd)
Message-Id: <20040204165620.3d608798.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402041639420.2086@home.osdl.org>
References: <51080000.1075936626@flay>
	<Pine.LNX.4.58.0402041539470.2086@home.osdl.org>
	<60330000.1075939958@flay>
	<64260000.1075941399@flay>
	<Pine.LNX.4.58.0402041639420.2086@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Wed, 4 Feb 2004, Martin J. Bligh wrote:
> > 
> > Oh hell ... I remember what's wrong with this whole bit. pfn_valid is
> > used inconsistently in different places, IIRC. Linus / Andrew ... what
> > do you actually want it to mean? Some things seem to use it to say
> > "the memory here is valid accessible RAM", some things "there is a 
> > valid struct page for this pfn". I was aiming for the latter, but a
> > few other arches seemed to disagree.
> > 
> > Could I get a ruling on this? ;-)
> 
> It _definitely_ means "there is a valid 'struct page' for this pfn". 
> 
> To test for "there is RAM" here, you need to first check that the pfn is
> valid, and then you can check what the page type is (usually that would be
> PageReserved(), but it could be a highmem check or something like that
> too).

pfn_valid() could become quite expensive indeed, and it lies on super-duper
hotpaths.

An alternative which is less conceptually clean but should work in this
case is to mark all vma's which were created by /dev/mem mappings as VM_IO,
and test that in remap_page_range().

The marking of mmap_mem() vma's as VM_IO has been in -mm for four months. 
But I didn't changelog it at the time and I've forgotten why I wrote it
(really).  It's something to do with get_user_pages() against a mapping of
/dev/mem :(

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc3/2.6.2-rc3-mm1/broken-out/get_user_pages-handle-VM_IO.patch

