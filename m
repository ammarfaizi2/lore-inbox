Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937591AbWLFUZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937591AbWLFUZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937617AbWLFUZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:25:04 -0500
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:34671 "HELO
	web31813.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937615AbWLFUZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:25:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=C621z6stBAvwmmMN7n7XnfpHAiX627ODkGnGLI9wY1391KvMDjmkiApxzDgy7V6pLPO1beOoaI9GWVQwPEcvWhlVMN8hSFcgGRhCukHGzLzywHqvd+0qDA6vXFzBHoU3eRzF+m4Q7eC/QQzk7o4m05EYjsgRgY/69u7Aet/EDOo=;
X-YMail-OSG: W6K9eBwVM1kGZnF4Dl9lf4mdMUf6glh30hFxe_oTCFA_U.H3VnUSj6yitWHds8CI482IBsP08YV5VCHXDTqCCL859ne5IX8_ckpUGHuBa2REqs8i3bz_ZPzaq75Q_lXf9MI6I0.rORSI2sGF4XmpkUnIseT5.Q--
Date: Wed, 6 Dec 2006 12:24:59 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: Infinite retries reading the partition table
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>
Cc: ltuikov@yahoo.com, mdr@sgi.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1165420788.2810.13.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <265807.57572.qm@web31813.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Bottomley <James.Bottomley@SteelEye.com> wrote:
> On Tue, 2006-12-05 at 21:08 -0800, Andrew Morton wrote:
> >  	case MEDIUM_ERROR:
> > +		if (sshdr.asc == 0x11 || /* UNRECOVERED READ ERR */
> > +		    sshdr.asc == 0x13 || /* AMNF DATA FIELD */
> > +		    sshdr.asc == 0x14) { /* RECORD NOT FOUND */
> > +			return SUCCESS;
> > +		}
> >  		return NEEDS_RETRY;
> 
> If the complaint is true; i.e. infinite retries, this is just a bandaid
> not a fix.  What it's doing is marking the unrecoverable medium errors
> for no retry.  However, what we really need to know is why NEEDS_RETRY
> isn't terminating after its allotted number of retries.  Can we please
> have a trace of this?

NEEDS_RETRY _does_ terminate, after it exhausts the retries.  But since
by the ASC value we know that no amount of retries is going to work,
this chunk of the patch resolves it quicker, i.e. eliminates the
"NEEDS_RETRY" pointless retries (given the SK/ASC combination).

> > -	if (scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
> > +	if (good_bytes &&
> > +	    scsi_end_request(cmd, 1, good_bytes, result == 0) == NULL)
> >  		return;
> 
> What exactly is this supposed to be doing?  its result is identical to
> the code it's replacing (because of the way scsi_end_request() processes
> its second argument), so it can't have any effect on the stated problem.

I suppose this is true, but I'd rather it not even go in
scsi_end_request as (cmd, uptodate=1, good_bytes=0, retry=0) and complete
at the bottom as (cmd, uptodate=0, total_xfer, retry=0).

    Luben

