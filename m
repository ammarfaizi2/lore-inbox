Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVKGDoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVKGDoi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVKGDoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:44:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:31197 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932385AbVKGDoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:44:37 -0500
Date: Sun, 6 Nov 2005 19:44:25 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ak@suse.de, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051106194425.1f728fbf.pj@sgi.com>
In-Reply-To: <436EC2AF.4020202@yahoo.com.au>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<p73oe4z2f9h.fsf@verdi.suse.de>
	<20051105201841.2591bacc.pj@sgi.com>
	<200511061835.53575.ak@suse.de>
	<20051106124944.0b2ccca1.pj@sgi.com>
	<436EC2AF.4020202@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> I don't think so because if the cpuset can be freed, then its page
> might be unmapped from the kernel address space if use-after-free
> debugging is turned on. And this is a use after free :)

Yup - that is a showstopper.  If dereferencing a stale pointer, even if
one doesn't really care what is read, is a no-no, then this is a no-no.

Thanks, Nick, for catching this.

This puts more value on the other idea I had -  a global kernel flag
"cpusets_have_been_used", that could be used to short circuit all the
cpuset hooks on systems that never mucked with cpusets.

For any lurkers wondering why I am chasing stale pointers when I don't
care what I read, it's like this.  Essentially, the task doing this
read is looking for an asychronous incoming level triggered signal
(going from the two mems_generations being equal to them being unequal),
that in this case is coming in at about the same time we are sampling
for it.  Whether we realize this time that the signal came in, or
don't realize it until the next time we sample, doesn't really matter
to us.  One way or the other, we'll see it, for sure the next sample if
not this one.  So the details of what happened on this read (so long as
no one got annoyed that we tried to chase a stale pointer) don't really
matter.  Unfortunately, Nick reminds us that someone will get annoyed.
Oh well.

> Also, it may be reused for something else far into the future without
> having its value changed - is this OK?

That part would be ok.  If I failed to realize that the underlying
cpuset had changed this time through __alloc_pages(), I would see it
next time, when I picked up a fresh and useful copy of my task->cpuset
pointer, having long forgotten my stale copy.  My stale cpuset pointer
only had a lifetime of a couple machine instructions.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
