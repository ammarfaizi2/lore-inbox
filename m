Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbVKHBSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbVKHBSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVKHBSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:18:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965063AbVKHBSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:18:33 -0500
Date: Mon, 7 Nov 2005 17:15:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: nickpiggin@yahoo.com.au, dm-devel@redhat.com, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, aherrman@de.ibm.com, bunk@stusta.de,
       cplk@itee.uq.edu.au
Subject: Re: [dm-devel] Re: [PATCH resubmit] do_mount: reduce stack
 consumption
Message-Id: <20051107171507.0b0dc83a.akpm@osdl.org>
In-Reply-To: <17263.63845.556511.171582@cse.unsw.edu.au>
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
	<17263.63845.556511.171582@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> On Tuesday November 8, nickpiggin@yahoo.com.au wrote:
> > Andrew Morton wrote:
> > > 
> > > More state in the task_strut is a bit sad, but not nearly as sad as deep
> > > recursion in our deepest codepath..
> > > 
> > > Possibly one could do:
> > > 
> > > struct make_request_state {
> > > 	struct bio *bio_list;
> > > 	struct bio **bio_tail;
> > > };
> > > 
> > > and stick a `struct make_request_state *' into the task_struct and actually
> > > allocate the thing on the stack.  That's not much nicer though.
> > 
> > Possibly it could go into struct io_context?
> > 
> 
> My quick reading of the code says that we could have to 
> allocate the struct right there in generic_make_request, and I don't
> think we can be certain that such an allocation will succeed.

With this sort of lifecycle it's more appropriat to allocate the struct on
the stack and to put a pointer to it into task_struct.

> Code that uses io_context can limp along if it doesn't exist.  
> The new generic_make_request needs this bio_list to be present 
> or it cannot do it's job.
> 
> Just how tight are we for space in task_struct?

I don't recall anyone getting outraged about it.

>  It seems to have a
> fair amount of cruft in it.

yup.

> Is it getting close to one-page or something?

1280 bytes on my x86

> Can we just split the less interesting stuff up into a separate
> structure, allocate a separate page for that are fork time, and leave 
> just a pointer in the task_struct?

Something like that, if it becomes a problem.

Probably there are various deporking opportunities in there.
