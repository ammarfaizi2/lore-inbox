Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163212AbWLGTOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163212AbWLGTOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163217AbWLGTOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:14:24 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:24988 "HELO
	web31810.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1163212AbWLGTOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:14:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=TxdUuggps5EVjoftj6qZnhxx8mFzTVT9w/w68ZAko1c550eFd11vO1OzEV0KUFWVmZmr0AuerKDfvWtScozKZ2oyTCzl9NGSx/L3tGJgKl869Rxr7qTu+mUO6/7jTrlQokDlyQ0755TcM5J6ZZmsCLHn2DrAJPYDpJ4uZDftOKs=;
X-YMail-OSG: daCa2XIVM1mgrprWN1p7g9ZkDerkW7OyKfy8rJo4qdOpi92OwWnJmmvQlVKOhaEOOS3YnT6rcPqaQ4T4KtWadckt77U5yZzJTMTWLp1n5gNvCEe3_SxCqfahVCHrLwpvNj4UhrN1Xpw-
Date: Thu, 7 Dec 2006 11:14:22 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: Infinite retries reading the partition table
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, mdr@sgi.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1165515378.4698.24.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <367656.23632.qm@web31810.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Bottomley <James.Bottomley@SteelEye.com> wrote:
> On Wed, 2006-12-06 at 12:24 -0800, Luben Tuikov wrote:
> > NEEDS_RETRY _does_ terminate, after it exhausts the retries.  But since
> > by the ASC value we know that no amount of retries is going to work,
> > this chunk of the patch resolves it quicker, i.e. eliminates the
> > "NEEDS_RETRY" pointless retries (given the SK/ASC combination).
> 
> I agree that it's useful behaviour.  However, the change header should
> be something like "scsi_error: don't retry for unrecoverable medium
> errors" not "infinite retries .."
> 
> > > > -	if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
> > > > +	if (good_bytes &&
> > > > +	    scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
> > > >  		return;
> > > 
> > > What exactly is this supposed to be doing?  its result is identical to
> > > the code it's replacing (because of the way scsi_end_request() processes
> > > its second argument), so it can't have any effect on the stated problem.
> > 
> > I suppose this is true, but I'd rather it not even go in
> > scsi_end_request as (cmd, uptodate=1, good_bytes=0, retry=0) and complete
> > at the bottom as (cmd, uptodate=0, total_xfer, retry=0).
> 
> But, logically, this isn't part of the change set ... the behaviour
> you're altering is unrelated to the change set details, so this piece
> shouldn't be in.

It is.  If good_bytes=0 then nothing is up to date and uptodate should
be set to 0.

Look at my comment before the function call:
   /* A number of bytes were successfully read. ...

I repeat again: it doesn't make sense to call scsi_end_request
with uptodate=1 and good_bytes=0, since _no bytes are uptodate_.

