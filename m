Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTENQbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTENQbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:31:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30420 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262538AbTENQbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:31:39 -0400
To: William Lee Irwin III <wli@holomorphy.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Race between vmtruncate and mapped areas? 
In-reply-to: Your message of Wed, 14 May 2003 08:06:53 PDT.
             <20030514150653.GM8978@holomorphy.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27942.1052930565.1@us.ibm.com>
Date: Wed, 14 May 2003 09:42:45 -0700
Message-Id: <E19FzL3-0007Gk-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003 08:06:53 PDT, William Lee Irwin III wrote:
> On Tuesday, May 13, 2003 18:10:18 -0700 Andrew Morton <akpm@digeo.com> wrote:
> >> That's the one.  Process is sleeping on I/O in filemap_nopage(), wakes up
> >> after the truncate has done its thing and the page gets instantiated in
> >> pagetables.
> >> But it's an anon page now.  So the application (which was racy anyway)
> >> gets itself an anonymous page.
> 
> On Wed, May 14, 2003 at 10:02:10AM -0500, Dave McCracken wrote:
> > Which the application thinks is still part of the file, and will expect its
> > changes to be written back.  Granted, if the page fault occurred just after
> > the truncate it'd get SIGBUS, so it's clearly not a robust assumption, but
> > it will result in unexpected behavior.  Note that if the application later
> > extends the file to include this page it could result in a corrupted file,
> > since all the pages around it will be written properly.
> 
> Well, for this one I'd say the app loses; it was its own failure to
> synchronize truncation vs. access, at least given that the kernel
> doesn't oops.

Hmm...  I'd disagree... The operations of truncation and access should
be synchronized with respect to the mm, even if multiple threads are
performing the operations.  The application *should* have synchronization
to understand which event will happen first, but the principle of least
surprise would suggest that either the access would happen first
followed by truncation (and future access might then extend the file,
putting in zero'd pages for the range that was trunacated) or the
truncation will happen first, and the access (beyond the new end
of the file) will behave as a normal access beyond the end of file.

Having truly garbage data between the previous end of file and the
new end of file is just wrong.

gerrit
