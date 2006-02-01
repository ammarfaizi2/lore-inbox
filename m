Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWBALgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWBALgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWBALgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:36:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13548 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932455AbWBALgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:36:36 -0500
Date: Wed, 1 Feb 2006 03:36:07 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jes Sorensen <jes@sgi.com>, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] SGIIOC4 limit request size
Message-ID: <20060201113607.GF152005@sgi.com>
References: <yq0vevzpi8r.fsf@jaguar.mkp.net> <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com> <20060201104913.GA152005@sgi.com> <58cb370e0602010308o4cde24aeg8d629b1b3d45cdd3@mail.gmail.com> <20060201111754.GB152005@sgi.com> <58cb370e0602010326k265ef278k4010df13fb5adf8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0602010326k265ef278k4010df13fb5adf8c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 12:26:26PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > I have no big problem with applying patch as it is but I think that
> > > it just hides the real problem and/or makes it harder to hit...
> > >
> > > Bartlomiej
> >
> > I agree.  I think I found the real problem.
> >
> > I'm going to test it and sleep on it, but here is the correct patch,
> > I think.  Hot off the press.
> >
> > Give us 16 hours  :-)
> 
> :-)
> 
> > The problem was that the chip actually likes a count of 0x10000 for
> > a 64K s/g, but the original author programmed 0 instead of 0x10000
> > for that amount (I don't know why).
> 
> original BM-DMA interprets 0 as 64K since length field is limited to 16-bits

That explains it.

> > I'll send a better patch tomorrow.  This one depends on a byte count
> > multiple of 2.  Though according to the chip docs, it ignores bit 0
> > of the byte count anyway (and the address for that matter).  So I
> > think this is functionally correct.  But I think the xcount variable
> > is superfluous.
> 
> it seems so

Here's one that removes xcount.  It seems to work too.
Should we set hwif->rqsize to 256, or are we pretty safe in
expecting that the default won't rise?  The driver should be
able to handle more, but this ioc4 hardware is weird, and it
probably wouldn't get tested if a general change were made :-)

jeremy

--- a/linux/drivers/ide/pci/sgiioc4.c	2006-02-01 03:29:34.000000000 -0800
+++ b/linux/drivers/ide/pci/sgiioc4.c	2006-02-01 03:21:40.413245446 -0800
@@ -510,7 +510,7 @@
 				       drive->name);
 				goto use_pio_instead;
 			} else {
-				u32 xcount, bcount =
+				u32 bcount =
 				    0x10000 - (cur_addr & 0xffff);
 
 				if (bcount > cur_len)
@@ -525,8 +525,7 @@
 				*table = 0x0;
 				table++;
 
-				xcount = bcount & 0xffff;
-				*table = cpu_to_be32(xcount);
+				*table = cpu_to_be32(bcount);
 				table++;
 
 				cur_addr += bcount;
