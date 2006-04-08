Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWDHBjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWDHBjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 21:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWDHBjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 21:39:52 -0400
Received: from wproxy.gmail.com ([64.233.184.230]:34292 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964990AbWDHBjv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 21:39:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rHPGNQ68uJibL6yQSfwIsTsJvtp+eGVEYDV6IodGtsz2BtG19gJYevcc3lFPMX/vtOw+VGJs97hti1RPNAfLBwyjr7P1984aRTHYtk+PWD9mMcbVHBYeKZTGJu8Z4OguOGFMcWvdBaULFFG+KUtWotbMcm3Wnz5XzkwhtH4qE5s=
Message-ID: <4ae3c140604071839v1b570d37y57c7e06233028e8f@mail.gmail.com>
Date: Fri, 7 Apr 2006 21:39:50 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Zach Brown" <zab@zabbo.net>
Subject: Re: How to know when file data has been flushed into disk?
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <4436A770.3080905@zabbo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140604070842x537353c4s9a60706c2a2d25d9@mail.gmail.com>
	 <4436A770.3080905@zabbo.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This answered all my questions! Many thanks! Will check the phase 2 code.

Xin


On 4/7/06, Zach Brown <zab@zabbo.net> wrote:
>
> > If a program access data like this:
> >
> > 1. open the file
> > 2. write a lot of data into this file
>
> You don't say if this is an extending write or overwriting existing file
> data.  I'm going to assume extending writes so that data=ordered kicks in.
>
> > 3. close the file
>
> > So my questions are:
> > 1. How will the file system be notified after all data has been
> > flushed into disk?
>
> Look at phase 2 in journal_commit_transaction().  The kjournald thread
> issues the writeback of the file data by walking t_sync_datalist and
> then waits for the writeback to complete by using wait_on_buffer()
> before committing the transaction.
>
> > 2. Unlike data=journal mode, in data=order mode, the data could be
> > lost if system crashes when data is being flushed to disk. When system
> > reboots, does journal contains the old meta data for undo?
>
> No, ext3 isn't roll-backward.  It doesn't store the *old* data in the
> journal and undo the change if it fails halfway through.  It's
> roll-forward.  It stores the *new* data in the journal and replays
> complete transactions in the journal that weren't moved out to their
> final place on disk at the time of the crash.
>
> So if the machine reboots during the writeback phase then the
> transaction won't be committed yet and recovery won't replay that
> transaction from the journal.  From the metadata's point of view the
> file extension will never have happened.
>
> > 3. Does sys_close() have to  be blocked until all data and metadata
> > are committed?
>
> No, and neither does sys_getpid() :)
>
> > to take subsequent operation. However, data flush could be failed. In
> > this case, file system seems to mislead the application. Is this true?
>
> No.  The application has no grounds for assuming that a successful
> close() has synced previous operations to disk.  It's simply not part of
> the API.
>
> > If so, any solutions?
>
> The application should rely on tools like fsync(), fdatasync(), O_SYNC,
> mount -o sync, etc.  Whatever suits it best.
>
> - z
>
