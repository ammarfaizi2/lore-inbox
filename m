Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWCTNsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWCTNsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWCTNsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:48:16 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:57032 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932215AbWCTNsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:48:15 -0500
Date: Mon, 20 Mar 2006 19:18:39 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Message-ID: <20060320134839.GF8662@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com> <20060320025311.419a44e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320025311.419a44e3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 02:53:11AM -0800, Andrew Morton wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
> >
> > This patch provides the feature of inserting probes on pages that are
> > not present in the memory during registration.
> > 
> > To add readpage and readpages() hooks, two new elements are added to
> > the uprobe_module object:
> > 	struct address_space_operations *ori_a_ops;
> > 	struct address_space_operations user_a_ops;
> > 
> > User-space probes allows probes to be inserted even in pages that are
> > not present in the memory at the time of registration. This is done
> > by adding hooks to the readpage and readpages routines. During
> > registration, the address space operation object is modified by
> > substituting user-space probes's specific readpage and readpages
> > routines. When the pages are read into memory through the readpage and
> > readpages address space operations, any associated probes are
> > automatically inserted into those pages. These user-space probes
> > readpage and readpages routines internally call the original
> > readpage() and readpages() routines, and then check whether probes are
> > to be added to these pages, inserting probes as necessary. The
> > overhead of adding these hooks is limited to the application on which
> > the probes are inserted.
> > 
> > During unregistration, care should be taken to replace the readpage and
> > readpages hooks with the original routines if no probes remain on that
> > application.
> > 
> 
> So...  The code's replacing the address_space's address_space_operations
> with a copy which has .readpage() and .readpages() modified, because it
> happens that filemap_nopage() uses those.
> 
> This is all rather hacky.
> 
> I think we need to step back and discuss what services this feature is
> trying to provide, and how it is to provide them.  Your covering
> description didn't describe that - it dives straigt into details without
> even describing what the patches are trying to achieve.
> 
> So.  What are we trying to achieve here, and how are we trying to achieve
> it?  What problems were encountered in the development of the feature and
> how were they solved?  What alternative solutions were there?
> 

The basic idea is to insert probes on user applications which may or
may not be in memory, at the time of probe insertion.

The base interface patch (1/3) allows the user to insert the probes on the
text pages that are already present in the memory. This is done by mapping
the page via kmap() and then insert the breakpoint instruction at the given
page offset.

Then comes the issue of inserting a probe on pages not currently in
memory. This is useful if we'd want to probe an application that hasn't
yet started executing. In such situations, we still want to insert the
probe, but defer insertion of actual probe until the text page is read
into the memory.

Here are a few ways to accomplish this:

1. Add a notifier in the readpage(), readpages() routine, which will
   notify when the text pages are read into the memory.

2. Reading the page from the executable into memory and then insert
   probes on that text page. But there are situations where the system
   can run into low memory problems and those text pages get discarded.

3. Change the readpage() and readpages() routines only for that application
   where probes will be inserted. This is done by hooking the readpage()
   and readpages() routines, which is limited to the probed application
   and will not change anything related to other applications.

The current patchset uses approach 3.

I'd like to know if there are better/cleaner ways to accomplish this?

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
