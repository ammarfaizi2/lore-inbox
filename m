Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbUKKLow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbUKKLow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbUKKLow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:44:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:13223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262214AbUKKLoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:44:19 -0500
Date: Thu, 11 Nov 2004 03:43:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dwmw2@infradead.org, hch@infradead.org, torvalds@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH] VM routine fixes
Message-Id: <20041111034353.00d35589.akpm@osdl.org>
In-Reply-To: <24698.1100172576@redhat.com>
References: <20041110182659.3f8138d6.akpm@osdl.org>
	<20041109140122.GA5388@infradead.org>
	<20041109125539.GA4867@infradead.org>
	<200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com>
	<15068.1100008386@redhat.com>
	<4530.1100093877@redhat.com>
	<20041110110145.3751ae17.akpm@osdl.org>
	<1100135833.4631.10.camel@localhost.localdomain>
	<24698.1100172576@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> > > On Wed, 2004-11-10 at 11:01 -0800, Andrew Morton wrote:
> > > > Why _does_ !CONFIG_MMU futz around with page counts in such weird ways
> > > > anyway?  Why does it have requirements for higher-order pages which
> > > > differ from !CONFIG_MMU?
> 
> The problem is ptrace() and various /proc/<pid/ files; or more properly, the
> problem is access_process_vm() and suchlike.
> 
> When one process goes rooting around in another process's memory map, it
> increments the refcount on the page it is looking at to stop it going away.
> 
> The problem on uClinux is that a process can have multipage chunks mapped into
> userspace, and access_process_vm() can look at a page in the middle of such a
> span.
> 
> Without this change, bad_page() is called when access_process_vm() calls a
> put_page() on a page in the middle because its refcount would say it's no
> longer in use and then put_page() would then attempt to free the page.
> 
> access_process_vm() guards against the target page going away due to the
> target process exiting at an inconvenient moment by pinning the target mm and
> holding its semaphore.

Compound pages will fix all that up.  You take a ref on any of the subpages
and that will pin the entire higher-order page.

> > I assume the CONFIG_MMU logic assumes that it's legal to physically free a
> > single page from inside the middle of a higher-order page.
> 
> No, it isn't. munmap() is prohibited from releasing anything other than a
> complete mmap() on uClinux.

hrm.  I'd have thought that such a restriction would be unnecessary if we
get the page refcounting done right.  With, say, compound pages!

Maybe the restriction is there for other reasons.

> > See, if we enable the compound page logic if !CONFIG_MMU then all this
> > stuff just goes away and the page refcounting is controlled purely by the
> > head page.  A get_page() or a put_page() against any of the constituent
> > pages will manipulate the head page's refcount.
> 
> That's true to a point, and probably a reasonable idea, assuming that compound
> pages aren't limited in size to TLB-specific values. If they are, then it
> makes no real difference.

Compound pages are just a way of handling refcounting of a higher-order
page.  Nothing to do with TLBs at all.

