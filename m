Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVJROhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVJROhD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 10:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVJROhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 10:37:03 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:43904 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750720AbVJROhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 10:37:01 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: file system block size
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Roushan Ali <roushan.ali@gmail.com>
Cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051019001218.B5830881@wobbly.melbourne.sgi.com>
References: <30b4e63b0510172252x1dfca9f2l75bb0f183aecf7bb@mail.gmail.com>
	 <20051019001218.B5830881@wobbly.melbourne.sgi.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 18 Oct 2005 15:36:52 +0100
Message-Id: <1129646212.15136.37.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 00:12 +1000, Nathan Scott wrote:
> On Tue, Oct 18, 2005 at 11:22:27AM +0530, Roushan Ali wrote:
> > Hi All,
> >          we want to write a new file system with block size more than
> > 4KB. Can anyone suggest us how should we proceed ?
> 
> With great difficulty. ;)

Indeed, it makes everything harder.  Have a look at ntfs in the kernel
which has to cope with file system block sizes between 512 bytes and
several hundred kiB (at least they are in powers of two thank
goodness...).  You end up not being able to use a lot of generic
functions as you for example need to lock multiple pages which needs to
be ordered correctly, etc...  If you look at the latest -mm kernel, the
ntfs driver there has file write(2) support for any cluster size and you
will see an example of the multiple page locking problem solution there.

Just one note is that I chose not to do full fs block size io in ntfs so
I avoid most of the big problems.  The only time it really hits is at
allocation time, because you can only allocate in units of fs block size
so when you write even one byte you need to lock the pages for the whole
byte range from the fs block start to block end that includes the byte
being written to.  If already allocated, ntfs simply only writes to that
one byte in the page it is in and ignores the other pages.  Makes life
much easier and faster given you save doing unnecessary writes to the
other pages.  (-:  In fact we would only write out the 512-byte block
containing the 1 written byte, so it is even faster than just page
granularity.  (-:

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

