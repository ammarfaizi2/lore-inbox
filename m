Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAaXpw>; Wed, 31 Jan 2001 18:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129221AbRAaXpc>; Wed, 31 Jan 2001 18:45:32 -0500
Received: from zeus.kernel.org ([209.10.41.242]:3813 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129169AbRAaXpa>;
	Wed, 31 Jan 2001 18:45:30 -0500
Date: Wed, 31 Jan 2001 23:43:51 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: bsuparna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC:  Kernel mechanism: Compound event wait/notify + callback chains
Message-ID: <20010131234351.J11607@redhat.com>
In-Reply-To: <CA2569E4.001AB22F.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <CA2569E4.001AB22F.00@d73mta05.au.ibm.com>; from bsuparna@in.ibm.com on Tue, Jan 30, 2001 at 10:15:02AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 30, 2001 at 10:15:02AM +0530, bsuparna@in.ibm.com wrote:
> 
> Comments, suggestions, advise, feedback solicited !
 
My first comment is that this looks very heavyweight indeed.  Isn't it
just over-engineered?

We _do_ need the ability to stack completion events, but as far as the
kiobuf work goes, my current thoughts are to do that by stacking
lightweight "clone" kiobufs.  

The idea is that completion needs to pass upwards (a)
bytes-transferred, and (b) errno, to satisfy the caller: everything
else, including any private data, can be hooked by the caller off the
kiobuf private data (or in fact the caller's private data can embed
the clone kiobuf).

A clone kiobuf is a simple header, nothing more, nothing less: it
shares the same page vector as its parent kiobuf.  It has private
length/offset fields, so (for example) a LVM driver can carve the
parent kiobuf into multiple non-overlapping children, all sharing the
same page list but each one actually referencing only a small region
of the whole.

That ought to clean up a great deal of the problems of passing kiobufs
through soft raid, LVM or loop drivers.

I am tempted to add fields to allow the children of a kiobuf to be
tracked and identified, but I'm really not sure it's necessary so I'll
hold off for now.  We already have the "io-count" field which
enumerates sub-ios, so we can define each child to count as one such
sub-io; and adding a parent kiobuf reference to each kiobuf makes a
lot of sense if we want to make it easy to pass callbacks up the
stack.  More than that seems unnecessary for now.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
