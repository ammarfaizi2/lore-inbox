Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967544AbWLAIcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967544AbWLAIcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 03:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967549AbWLAIcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 03:32:33 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:7335 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S967544AbWLAIcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 03:32:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Sg7vXNT1bN8EPRQYQZg/sxfkF6Yw2FoSL/ma6Ki/quQaDeuU+7TN8GML3WFrt1p7rb8AcNQxARfirv7RvtCWqsElMiGbf7DtX4Vp18WtTVtH6j6ytRvug1Na6zUBNtBjCCyPOx0WDPM4bzhRleG1fHzMts9VT5+gUcj+16x2yZ0=;
X-YMail-OSG: EiTy67kVM1m9P49uqdUVw1Vl.sPI2UdR6c439sKSACMlKYdAJHkx1JRs.lzVK1SCZg--
Date: Fri, 1 Dec 2006 00:32:31 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: Infinite retries reading the partition table
To: Andrew Morton <akpm@osdl.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061130232916.6cbd1408.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <520003.85125.qm@web31807.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 30 Nov 2006 22:34:57 -0800 (PST)
> Luben Tuikov <ltuikov@yahoo.com> wrote:
> 
> > --- Andrew Morton <akpm@osdl.org> wrote:
> > > On Wed, 29 Nov 2006 17:22:48 -0800 (PST)
> > > Luben Tuikov <ltuikov@yahoo.com> wrote:
> > > 
> > > > Suppose reading sector 0 always reports an error,
> > > > sense key HARDWARE ERROR.
> > > > 
> > > > What I'm observing is that the request to read sector 0,
> > > > reading partition information, is retried forever, ad infinitum.
> > > > 
> > > > Does anyone have a patch to resolve this? (2.6.19-rc6)
> > > > 
> > > 
> > > Please send a backtrace so we can see where the offending loop occurs.
> > 
> > I posted a patch to linux-scsi
> 
> hm.  Does sending patches to linux-scsi get them applied?  It might, I
> don't know.

Good question -- I don't know either.

> > which resolves this issue:
> > http://marc.theaimsgroup.com/?l=linux-scsi&m=116485834119885&w=2
> 
> That looks like it prevents the IO error.  But why was an IO error causing
> an infinite loop?   What piece of code was initiating the retries?

Here is what happens: sector 0 is broken -- the device cannot read
the media at that location.  The device properly returns a certain
type of uncorrectable MEDIUM ERROR (ASC: UNRECOVERABLE READ ERR).

SCSI Core loops around its retries (which this patch fixes) and
eventually gives up and sends it for "completion".  This is what
happens when scsi_check_sense() returns NEEDS_RETRY to
scsi_decide_disposition() to scsi_softirq().  The first chunk
of the patch fixes this.

We end up in scsi_io_completion(), where good_bytes = 0, and
result = 0x08000002 (DRIVER SENSE and CHECK CONDITION).

This statement in scsi_io_completion() causes the infinite retry loop:
   if (scsi_end_request(cmd, 1, good_bytes, !!result) == NULL)
         return;
substitute to get: scsi_end_request(cmd, uptodate=1, uptodate bytes=0, retry=1)
Yeah, but it doesn't make sense to call scsi_end_request() with uptodate=1 and
uptodate bytes = 0.  This causes the infinite retry, since the code
tries to re-read the whole xfer size (0 bytes were uptodate and retry=1),
from the bad media.

That is, we want to set uptodate=1 iff there was at least 1 byte up to date.
Else if nothing was read, uptodate bytes = 0, then we should pass
uptodate = 0, uptodate_bytes = total xfer, to mean the whole xfer is
not uptodate; and retry iff there was no error. (This is the very bottom
of the function.)

... I know, I know, but that's what we've got.

See this commit 03aba2f79594ca94d159c8bab454de9bcc385b76 as well.

      Luben

