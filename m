Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbTFEO3B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 10:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264698AbTFEO3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 10:29:00 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:9734 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264695AbTFEO26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 10:28:58 -0400
Subject: Re: [PATCH] megaraid driver fix for 2.5.70
From: James Bottomley <James.Bottomley@steeleye.com>
To: Mark Haverkamp <markh@osdl.org>
Cc: atulm@lsil.com, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <1054823593.13060.12.camel@markh1.pdx.osdl.net>
References: <1054650567.13617.12.camel@markh1.pdx.osdl.net>
	<1054822044.1792.48.camel@mulgrave> 
	<1054823593.13060.12.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 05 Jun 2003 10:42:22 -0400
Message-Id: <1054824142.1792.58.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 10:33, Mark Haverkamp wrote:
> On Thu, 2003-06-05 at 07:07, James Bottomley wrote:
> > On Tue, 2003-06-03 at 10:29, Mark Haverkamp wrote:
> > > A recent change to the megaraid driver to fix some memset calls resulted
> > > in overflowing the arrays being cleared and causing a system panic. 
> > > This patch fixes the problem by making sure that the arrays being
> > > cleared are dimensioned to the correct size.  The patch has been tested
> > > on osdl's stp machines that have megaraid controllers.
> > 
> > This patch doesn't quite look like a fix to me:  The megaraid mailboxes
> > are always >16 bytes *but* none of the setting commands is supposed to
> > touch any of the status parts (which begin at byte 15), so I don't see
> > how your patch would prevent a panic.
> 
> In the memset cases, what fixed the panic was that the size of the
> raw_mbox automatic was set to 16 and the memset was using
> sizeof(mbox_t).  I just increased the size of the raw_mbox so it
> wouldn't be overflowed.  It sounds like, from what you are saying, that
> the size of raw_mbox should have been left at 16 and the memset changed
> to fill 16 bytes and not the sizeof(mbox_t).

Ah, that's what I couldn't find in the source, thanks.

My observation is that only the first 15 bytes of mbox may be altered by
the user thus, since the issue_scb.. functions copy the mbox anyway,
there's not much point allocating the full mbox (although there's no
harm in doing so).  But rather than going back to the 16 byte
allocations and fixing the memset sizes, I think mbox_t should be split
into two pieces (and out and an in, with the issue_scb..() routines only
taking the in part) that way everything can be correctly written in
terms of sizeof.

I was also separately worried about the memcpy in the issue_scb..()
routines which looks like it will set the mbox->busy parameter
(controlled by the driver) to zero.  So I copied Atul to see if this is
a genuine problem or not.

James


