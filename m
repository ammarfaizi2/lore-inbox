Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269963AbUICW6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269963AbUICW6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269971AbUICW6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:58:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:36750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269963AbUICW6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:58:15 -0400
Subject: Re:  [Bug 3317] New: Kernel oops in aio_complete while running AIO
	application
From: Daniel McNeil <daniel@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1094226765.3628.112.camel@dyn318077bld.beaverton.ibm.com>
References: <20040831081835.08942f70.akpm@osdl.org>
	 <1094226765.3628.112.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1094252275.2299.11.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 15:57:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 08:52, Badari Pulavarty wrote:
> On Tue, 2004-08-31 at 08:18, Andrew Morton wrote:
> > Begin forwarded message:
> > 
> > Date: Tue, 31 Aug 2004 06:15:18 -0700
> > From: bugme-daemon@osdl.org
> > To: bugme-new@lists.osdl.org
> > Subject: [Bugme-new] [Bug 3317] New: Kernel oops in aio_complete while running AIO application
> > 
> > 
> > http://bugme.osdl.org/show_bug.cgi?id=3317
> > 
> 
> Hi Andrew,
> 
> I debugged this some more. Here is whats happening:
> 
> The test program used program text address as buffer to do the READ to.
> DIO get_user_pages() returned EFAULT. We called finished_one_bio()
> as part of dropping the ref. to dio. It called aio_complete().
> do_direct_IO() returned EFAULT to the caller. aio_run_iocb() expects
> to see EIOCBQUEUED/RETRY, otherwise it calls aio_complete() with the
> "ret" value. This is where the second aio_complete() is coming from.
> So we cleanup "req" and on the next de-ref we get OOPS.
> 
> The problem here is, finished_one_bio() shouldn't call aio_complete()
> since no work has been done. I have a fix for this - can you verify this
> ? I am not really comfortable with this "tweaking". (I am not really
> sure about IO errors like EIO etc. - if they can lead to calling
> aio_complete() twice)
> 
> 
> Fix is to call aio_complete() ONLY if there is something to report.
> Note the we don't update dio->result with any error codes from
> get_user_pages(), they just passed as "ret" value from do_direct_IO().
> 
> Thanks,
> Badari

Badari,

This does fix the problem when running on my system (ext3).

One question, finished_one_bio() is called in 3 places,
are you sure the other places won't be harmed by this
change?

I'm also looking over the code and will let you know if
I see any problems.

Daniel

