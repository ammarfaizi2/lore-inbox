Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTFQUwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTFQUwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:52:50 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29323 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264955AbTFQUwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:52:47 -0400
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
From: Daniel McNeil <daniel@osdl.org>
To: suparna@in.ibm.com
Cc: John Myers <jgmyers@netscape.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20030617085408.A1934@in.ibm.com>
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net>
	<3EEE6FD9.2050908@netscape.com>  <20030617085408.A1934@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Jun 2003 14:06:47 -0700
Message-Id: <1055884008.1250.1479.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested 2.5.72-mm1 and, as expected, it fixes the hang.
Interestingly, the mm1 code behaves differently than generic
2.5.72 -- in the error case (like aio read from /dev/zero),
2.5.72-mm1 returns an EINVAL error on io_submit().  In 2.5.72 
io_submit succeeds and the i/o itself get an error.  I prefer
getting the error on io_submit.

Daniel

On Mon, 2003-06-16 at 20:24, Suparna Bhattacharya wrote:
> On Mon, Jun 16, 2003 at 06:33:13PM -0700, John Myers wrote:
> > 
> > Daniel McNeil wrote:
> > 
> > >Are there other error return values where it should jump to the
> > >aio_put_req()?  Should the check be:
> > >  
> > >
> > The situation is much worse.  The io_submit_one() code in 2.5.71 
> > distinguishes between conditions where io_submit should fail (which goto 
> > out_put_req) and conditions where the queued operation completes 
> > immediately (which result in a call to aio_complete()).  The patch in 
> > 2.5.71-mm1 which separates out aio_setup_iocb() loses track of this 
> > distinction, mishandling any case where the queued operation completes 
> > immediately.  Aio poll, for instance, depends on being able to indicate 
> > immediate completion.
> 
> The code for aio_read/write does distinguish between these cases.
> - if you spot a case where it doesn't do let me know.
> aio_setup_iocb() just sets up the method after performing the 
> specified checks. Its aio_run_iocb() which actually executes it.
> 
> > 
> > So the part of aio-01-retry.patch that splits out aio_setup_iocb() is 
> > completely broken.
> > 
> 
> Actually, looking closer, I think its just aio poll that's 
> incorrectly merged here. The right way to implement aio poll in
> the new model would have been to setup a retry method for it
> in aio_setup_iocb(), not run generic_aio_poll() directly there.
> 
> Regards
> Suparna
> 
> -- 
> Suparna Bhattacharya (suparna@in.ibm.com)
> Linux Technology Center
> IBM Software Labs, India


