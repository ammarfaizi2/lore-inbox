Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUGCJDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUGCJDU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 05:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUGCJDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 05:03:19 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:1941 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262085AbUGCJDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 05:03:17 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] 3/5: Device-mapper: snapshots
Date: Sat, 3 Jul 2004 05:09:27 -0400
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@muc.de>, Alasdair G Kergon <agk@redhat.com>,
       linux-kernel@vger.kernel.org
References: <22Gkd-1AX-17@gated-at.bofh.it> <200407030130.02067.phillips@arcor.de> <40E64C50.5010906@pobox.com>
In-Reply-To: <40E64C50.5010906@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407030509.27762.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 July 2004 02:04, Jeff Garzik wrote:
> Daniel Phillips wrote:
> > It is designed to be crash-safe:
> >
> >   - Each snapshot exception is logged to disk by overwriting the last
> > sector of a grow-only list of snapshot exceptions.
> >
> >   - Write completion is not handed back up the chain until:
> >
> >       - the data to be overwritten has been copied to a new exception
> >       - the new exception has been logged to the snapshot store as above
> >
> > As far as I can see, the concept is leak-proof, except for being
> > sensitive to random garbage in the last few sector writes.  I suspect
> > that doesn't happen on modern disk drives.  If it does, I hope somebody
> > will shout.
> >
> > I am not sure what you mean about barriers, perhaps you were thinking of
> > synchronous waiting.  This snapshot driver does wait for completions, but
> > it pipelines the waits so throughput is not affected much (snapshot
> > overhead is dominated by copyouts).
>
> Barriers as discussed on lkml ensure your data is committed to stable
> storage, not simply completed requests.  In SCSI this means ordered
> tags, FUA, or cache flushing.  Ditto ATA (cache flushing, mostly).

I meant, I didn't know why he thought barriers might apply in this case, but 
now that you mention it, yes we risk the same bugs with certain hardware as, 
say, a journal commit does.  We need to do something about that at some 
point.  (I see that the barrier patch hasn't made it to mainline yet, and 
actually, that's good because it needs to be looked at critically.)

Anyway (reading Andi's mind) it seems the snapshot durability strategy just 
wasn't obvious on a light reading.  It certainly wasn't obvious to me without 
clarification from Joe Thornber, from whose fertile imagination this clever 
hack apparently sprang.  Yes, these details need to be documented.

Regards,

Daniel
