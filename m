Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVKHBDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVKHBDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVKHBDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:03:43 -0500
Received: from ns2.suse.de ([195.135.220.15]:21965 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965018AbVKHBDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:03:43 -0500
From: Neil Brown <neilb@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Tue, 8 Nov 2005 12:03:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17263.63845.556511.171582@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, dm-devel@redhat.com,
       heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       aherrman@de.ibm.com, bunk@stusta.de, cplk@itee.uq.edu.au
Subject: Re: [dm-devel] Re: [PATCH resubmit] do_mount: reduce stack consumption
In-Reply-To: message from Nick Piggin on Tuesday November 8
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
	<20051104084829.714c5dbb.akpm@osdl.org>
	<20051104212742.GC9222@osiris.ibm.com>
	<20051104235500.GE5368@stusta.de>
	<20051104160851.3a7463ff.akpm@osdl.org>
	<Pine.GSO.4.60.0511051108070.2449@mango.itee.uq.edu.au>
	<20051104173721.597bd223.akpm@osdl.org>
	<17260.17661.523593.420313@cse.unsw.edu.au>
	<17262.40176.342746.634262@cse.unsw.edu.au>
	<20051107153706.2f3c8b67.akpm@osdl.org>
	<436FF20D.8030200@yahoo.com.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday November 8, nickpiggin@yahoo.com.au wrote:
> Andrew Morton wrote:
> > 
> > More state in the task_strut is a bit sad, but not nearly as sad as deep
> > recursion in our deepest codepath..
> > 
> > Possibly one could do:
> > 
> > struct make_request_state {
> > 	struct bio *bio_list;
> > 	struct bio **bio_tail;
> > };
> > 
> > and stick a `struct make_request_state *' into the task_struct and actually
> > allocate the thing on the stack.  That's not much nicer though.
> 
> Possibly it could go into struct io_context?
> 

My quick reading of the code says that we could have to 
allocate the struct right there in generic_make_request, and I don't
think we can be certain that such an allocation will succeed.

Code that uses io_context can limp along if it doesn't exist.  
The new generic_make_request needs this bio_list to be present 
or it cannot do it's job.

Just how tight are we for space in task_struct?  It seems to have a
fair amount of cruft in it.
Is it getting close to one-page or something?
Can we just split the less interesting stuff up into a separate
structure, allocate a separate page for that are fork time, and leave 
just a pointer in the task_struct?

NeilBrown
