Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264280AbTLEQSH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTLEQSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:18:07 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:6580 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S264273AbTLEQR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:17:59 -0500
Date: Fri, 5 Dec 2003 11:16:51 -0500
Message-Id: <200312051616.hB5GGpef027492@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Erez Zadok <ezk@cs.sunysb.edu>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem 
In-reply-to: Your message of "Fri, 05 Dec 2003 12:20:50 +0100."
             <20031205112050.GA29975@wohnheim.fh-wedel.de> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031205112050.GA29975@wohnheim.fh-wedel.de>, =?iso-8859-1?Q?J=F6rn?= Engel writes:
> On Thu, 4 December 2003 14:41:48 -0500, Erez Zadok wrote:
> > 
> > Part of our stackable f/s project (FiST) includes a Gzipfs stackable
> > compression f/s.  There was a paper on it in Usenix 2001 and there's code in
> > the latest fistgen package.  See
> > http://www1.cs.columbia.edu/~ezk/research/fist/
> > 
> > Performance of Gzipfs is another matter, esp. for writes in the middle of
> > files. :-)
> 
> You don't seriously treat big files as a single gzip stream, do you?
> ;)

Of course not.  We're not *that* bad.  :-)

We compress each chunk separately; currently chunk==PAGE_CACHE_SIZE.  For
each file foo we keep an index file foo.idx that records the offsets in the
main file of where you might find the decompressed data for page N.  Then we
hook it up into the page read/write ops of the VFS.  It works great for the
most common file access patterns: small files, sequential/random reads, and
sequential writes.  But, it works poorly for random writes into large files,
b/c we have to decompress and re-compress the data past the point of
writing.  Our paper provides a lot of benchmarks results showing performance
and resulting space consumption under various scenarios.

We've got some ideas on how to improve performance for writes-in-the-middle,
but they may hurt performance for common cases.  Essentially we have to go
for some sort of O(log n)-like data structure, which'd make random writes
much better.  But since it may hurt performance for other access patterns,
we've been thinking about some way to support both modes and be able to
switch b/t the two modes on the fly (or at least let users "mark" a file as
one for which you'd expect a lot of random writes to happen).

If anyone has some comments or suggestions, we'd love to hear them.

BTW, our support in the stackable templates (described in the paper) is more
general than just for compression.  We support any (monotonically
continuous) size-changing algorithm: compression, encryption, etc.  In our
paper we also show a size-expanding file system called uuencodefs.

Cheers,
Erez.
