Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUGHNWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUGHNWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUGHNWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:22:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46546 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264595AbUGHNVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:21:31 -0400
Date: Thu, 8 Jul 2004 19:00:29 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-aio@kvack.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6-bk] aio not returning error code(?)
Message-ID: <20040708133029.GA3459@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <Pine.LNX.4.60.0407071430170.28653@hermes-1.csi.cam.ac.uk> <20040707223302.GA6513@kvack.org> <1089291383.5891.69.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1089291383.5891.69.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 01:56:24PM +0100, Anton Altaparmakov wrote:
> On Wed, 2004-07-07 at 23:33, Benjamin LaHaise wrote:
> > On Wed, Jul 07, 2004 at 02:42:44PM +0100, Anton Altaparmakov wrote:
> > > --- bklinux-2.6/fs/aio.c	2004-07-01 11:19:35.000000000 +0100
> > > +++ bklinux-2.6/fs/aio.c.new	2004-07-07 14:26:19.445631304 +0100
> > > @@ -1086,7 +1086,7 @@ int fastcall io_submit_one(struct kioctx
> > >  	if (likely(-EIOCBQUEUED == ret))
> > >  		return 0;
> > >  	aio_complete(req, ret, 0);	/* will drop i/o ref to req */
> > > -	return 0;
> > > +	return ret;
> > 
> > That's wrong: you now get 2 results for the same operation -- an error on 
> > the submit, and an event with a return code.  In order for the user code 
> > to do the right thing, you must only get one or the other.  If io_submit 
> > fails for a particular iocb, there must be no event returned.
> 
> I see.  Perhaps the man page for io_sbumit(2) needs to be fixed or at
> least clarified.  It states:
> 
> "ERRORS
>        EINVAL The aio_context specified by ctx_id is invalid.  nr
>               is less than 0. The iocb at *iocbpp[0] is not prop­
>               erly initialized, or the operation specified is in­
>               valid for the file descriptor in the iocb."
> 
> Not a single file system in the kernel implements aio_fsync and
> according to the man page for io_submit as far as I understand what is
> written there if I call io_submit for an aio_fsync operation I should
> get an error code EINVAL returned.
> 
> You are saying that this is wrong and that no error code is returned
> from io_submit despite its manpage saying that it is so one of the two
> must be wrong, no?

Actually the semantics specified in the man page is reasonable. It is
just that you need to make sure that aio_complete() is not called 
for the case where we return an error from io_submit.

In my patchset, I broke up io_submit_one into two portions, aio_setup_iocb,
which checks for these error cases and hence returns rightaway, and then
the actual io submission path, which returns 0, and reports any errors 
from the fop aio routines via aio_complete(). So aio_fsync for example,
would return -EINVAL from io_submit.

Does that make sense ?

Regards
Suparna

> -- 
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
> Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
> WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

