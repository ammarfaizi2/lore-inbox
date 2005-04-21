Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVDUHKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVDUHKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVDUHKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:10:21 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:3769 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261346AbVDUHKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:10:06 -0400
Subject: Re: [patch] fix race in __block_prepare_write (again)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
References: <1114064046.5182.13.camel@npiggin-nld.site>
	 <Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 21 Apr 2005 08:10:01 +0100
Message-Id: <1114067401.11293.3.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And one more thing...

On Thu, 2005-04-21 at 08:01 +0100, Anton Altaparmakov wrote:
> On Thu, 21 Apr 2005, Nick Piggin wrote:
> > ... I somehow didn't send it to Andrew last time.
> > 
> > Fix a race where __block_prepare_write can leak out an in-flight
> > read against a bh if get_block returns an error. This can lead to
> > the page becoming unlocked while the buffer is locked and the read
> > still in flight. __mpage_writepage BUGs on this condition.
> [snip]
> > --- linux-2.6.orig/fs/buffer.c	2005-04-21 11:55:17.549614278 
> +1000
> > +++ linux-2.6/fs/buffer.c	2005-04-21 15:55:41.483826075 +1000
> > @@ -1988,6 +1988,7 @@
> >  			*wait_bh++=bh;
> >  		}
> >  	}
> > +out:
> >  	/*
> >  	 * If we issued read requests - let them complete.
> >  	 */
> > @@ -1996,8 +1997,9 @@
> >  		if (!buffer_uptodate(*wait_bh))
> >  			return -EIO;

This return is now wrong after your patch.  It should be "err = -EIO;"
otherwise you do not zero newly allocated blocks and thus risk exposing
stale data on buffer i/o errors. 

> >  	}
> > -	return 0;
> > -out:
> > +	if (!err)
> > +		return err;
> > +
> >  	/*
> >  	 * Zero out any newly allocated blocks to avoid exposing stale
> >  	 * data.  If BH_New is set, we know that the block was newly
> 
> Any reason why you left the goto out?  It would be IMO much cleaner to 
> remove the label "out" altogether and replace the single "goto out" with a 
> "break" (which is fine since the goto happens inside the for loop 
> immediately after which you place the label.)

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

