Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVFJOPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVFJOPd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVFJOPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:15:33 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:26755 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262522AbVFJOPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:15:18 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Bug in error recovery in fs/buffer.c::__block_prepare_write()
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1118408715.31710.62.camel@imp.csi.cam.ac.uk>
References: <1118408464.31710.54.camel@imp.csi.cam.ac.uk>
	 <1118408715.31710.62.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 10 Jun 2005 15:15:06 +0100
Message-Id: <1118412906.31710.74.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 14:05 +0100, Anton Altaparmakov wrote:
> Here is the second patch (patch B).
> 
> On Fri, 2005-06-10 at 14:01 +0100, Anton Altaparmakov wrote:
> [snip]
> > B) If we cannot safely allow buffer_new buffers to "leak out" of
> > __block_prepare_write(), then we simply would need to run a quick loop
> > over the buffers clearing buffer_new on each of them if it is set just
> > before returning "success" to the caller of __block_prepare_write().
> [snip]
> 
> The patch for this is simple, too (it is below).
> 
> > Andrew/Linus, I would suggest that you apply at least A and perhaps B if
> > you deem it necessary or want to be on the safe side.
> > 
> > Having had a look at the code it would seem perfectly safe to leave
> > buffer_new() set and ignore patch B but I may be wrong which is why I
> > did both.

I have changed my mind having had a look at the code some more.  Patch B
is definitely needed.

Otherwise you can get a situation where an allocating write followed by
an erring write to the same location would cause uptodate and already
written out buffers to be zeroed & written out thus overwritting
existing data with zero.

This could be worked around differently (e.g. by being more picky which
buffer_new buffers get zeroed&written in the error handling) it is
definitely safest to just apply patch B.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

