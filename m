Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWESKBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWESKBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWESKBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:01:47 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:32654 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932177AbWESKBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:01:45 -0400
Message-ID: <446D977B.3030809@bull.net>
Date: Fri, 19 May 2006 12:01:31 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>, Jan Kara <jack@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
References: <446C2F89.5020300@bull.net>	 <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>	 <446C8EB1.3090905@bull.net> <1147991117.5464.124.camel@sisko.sctweedie.blueyonder.co.uk>
In-Reply-To: <1147991117.5464.124.camel@sisko.sctweedie.blueyonder.co.uk>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/05/2006 12:04:50,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/05/2006 12:04:56,
	Serialize complete at 19/05/2006 12:04:56
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to take this opportunity to ask some questions
I always wanted to ask about committing a transaction(*)
but were afraid to ask :-)

We wait for several types of I/O-s:
- "Wait for all previously submitted IO to complete" (t_sync_datalist)
- wait_for_iobuf: (t_buffers)
- wait_for_ctlbuf: (t_log_list)
before "journal_write_commit_record()" gets invoked.

Why do not we wait for them at the very last moment in batch, is
it important that e.g. all the buffers from "t_buffers" be
completed before we start with the ones on "t_log_list"?

If "JFS_BARRIER" is set, why do we wait for these I/O-s at all?
(The "ordered" attribute is set => all the previous I/O-s must have hit
the permanent storage before the commit record can do.)

Why do we let the EXT3 layer to decide, why do not we ask the "bio"
if the "ordered" attribute is supported and use it systematically?

There is a comment in "journal_write_commit_record()":

	/* is it possible for another commit to fail at roughly
	 * the same time as this one?...

Another commit for the same journal?
(If not the same journal, why is it a problem?)

If a barrier-based sync has failed on a device, does the actual
I/O start by itself (not caring for the ordering issue)?

Thanks,

Zoltan
