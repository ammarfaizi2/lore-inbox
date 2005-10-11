Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbVJKIB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVJKIB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVJKIB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:01:26 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:63909 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751411AbVJKIBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:01:25 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH] Use of getblk differs between locations
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, glommer@br.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk
In-Reply-To: <20051010180705.0b0e3920.akpm@osdl.org>
References: <20051010204517.GA30867@br.ibm.com>
	 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
	 <20051010214605.GA11427@br.ibm.com>
	 <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
	 <20051010223636.GB11427@br.ibm.com>
	 <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk>
	 <20051010163648.3e305b63.akpm@osdl.org>
	 <Pine.LNX.4.62.0510110203430.27454@artax.karlin.mff.cuni.cz>
	 <20051010180705.0b0e3920.akpm@osdl.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Tue, 11 Oct 2005 09:01:19 +0100
Message-Id: <1129017679.12336.7.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 18:07 -0700, Andrew Morton wrote:
> Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
> >
> >  On Mon, 10 Oct 2005, Andrew Morton wrote:
> > 
> >  > Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >  >>
> >  >> > Maybe the best solution is neither one nor another. Testing and failing
> >  >> > gracefully seems better.
> >  >> >
> >  >> > What do you think?
> >  >>
> >  >>  I certainly agree with you there.  I neither want a deadlock nor
> >  >>  corruption.  (-:
> >  >
> >  > Yup.  In the present implementation __getblk_slow() "cannot fail".  It's
> >  > conceivable that at some future stage we'll change __getblk_slow() so that
> >  > it returns NULL on an out-of-memory condition.
> > 
> >  The question is if it is desired --- it will make bread return NULL on 
> >  out-of-memory condition, callers will treat it like an IO error, skipping 
> >  access to the affected block, causing damage on perfectly healthy 
> >  filesystem.
> 
> Yes, that is a bit dumb.  A filesystem might indeed want to take different
> action for ENOMEM versus EIO.
> 
> >  I liked what linux-2.0 did in this case --- if the kernel was out of 
> >  memory, getblk just took another buffer, wrote it if it was dirty and used 
> >  it. Except for writeable loopback device (where writing one buffer 
> >  generates more dirty buffers), it couldn't deadlock.
> 
> Wouldn't it be better if bread() were to return ERR_PTR(-EIO) or
> ERR_PTR(-ENOMEM)?    Big change.

It would indeed.  Much better.  And whilst at it, it would be even
better if we had a lot more error codes like "ERR_PTR(-EDEVUNPLUGGED)"
for example...  But that would be an even better change.  Anyone feeling
like touching every block driver in the kernel?  (-;

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

