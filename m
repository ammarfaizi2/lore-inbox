Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWESM1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWESM1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 08:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWESM1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 08:27:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15512 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932299AbWESM1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 08:27:01 -0400
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: Jan Kara <jack@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <446D977B.3030809@bull.net>
References: <446C2F89.5020300@bull.net>
	 <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
	 <446C8EB1.3090905@bull.net>
	 <1147991117.5464.124.camel@sisko.sctweedie.blueyonder.co.uk>
	 <446D977B.3030809@bull.net>
Content-Type: text/plain
Date: Fri, 19 May 2006 13:26:45 +0100
Message-Id: <1148041606.5156.17.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-05-19 at 12:01 +0200, Zoltan Menyhart wrote:
> I'd like to take this opportunity to ask some questions
> I always wanted to ask about committing a transaction(*)
> but were afraid to ask :-)
> 
> We wait for several types of I/O-s:
> - "Wait for all previously submitted IO to complete" (t_sync_datalist)
> - wait_for_iobuf: (t_buffers)
> - wait_for_ctlbuf: (t_log_list)
> before "journal_write_commit_record()" gets invoked.
> 
> Why do not we wait for them at the very last moment in batch, is
> it important that e.g. all the buffers from "t_buffers" be
> completed before we start with the ones on "t_log_list"?

We don't.  We write the control and journaled metadata buffers first,
recording them on the t_buffers and t_log_list lists.  We then wait on
both of those lists, but there's no IO being submitted at that stage and
the order in which we wait on them has no effect at all on the progress
of the IO.

The sync_datalist writes could be waited for separately at the end if we
wanted too.  That code was written a _long_ time ago but I vaguely
recall some reasoning that we may have a lot more data than metadata, so
it would be reasonable to cleanup the data writes as quickly as possible
and to prevent data and metadata writes from getting submitted in
parallel and potentially causing seeks between the two.  The elevator
should prevent the latter effect, though, so it would be entirely
reasonable to move that wait to later on in commit if we wanted to.

> If "JFS_BARRIER" is set, why do we wait for these I/O-s at all?
> (The "ordered" attribute is set => all the previous I/O-s must have hit
> the permanent storage before the commit record can do.)

> Why do we let the EXT3 layer to decide, why do not we ask the "bio"
> if the "ordered" attribute is supported and use it systematically?

It would be entirely reasonable to do that, sure.  It just hasn't been
done yet.

> There is a comment in "journal_write_commit_record()":
> 
> 	/* is it possible for another commit to fail at roughly
> 	 * the same time as this one?...
> 
> Another commit for the same journal?

Not likely. :-)

> If a barrier-based sync has failed on a device, does the actual
> I/O start by itself (not caring for the ordering issue)?

It fails with EOPNOTSUPP and must be retried, iirc.  

--Stephen


