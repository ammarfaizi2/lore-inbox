Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTFQDGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 23:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTFQDGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 23:06:16 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1007 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264542AbTFQDGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 23:06:14 -0400
Date: Tue, 17 Jun 2003 08:54:08 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: John Myers <jgmyers@netscape.com>
Cc: Daniel McNeil <daniel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH 2.5.71-mm1] aio process hang on EINVAL
Message-ID: <20030617085408.A1934@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1055810609.1250.1466.camel@dell_ss5.pdx.osdl.net> <3EEE6FD9.2050908@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EEE6FD9.2050908@netscape.com>; from jgmyers@netscape.com on Mon, Jun 16, 2003 at 06:33:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 06:33:13PM -0700, John Myers wrote:
> 
> Daniel McNeil wrote:
> 
> >Are there other error return values where it should jump to the
> >aio_put_req()?  Should the check be:
> >  
> >
> The situation is much worse.  The io_submit_one() code in 2.5.71 
> distinguishes between conditions where io_submit should fail (which goto 
> out_put_req) and conditions where the queued operation completes 
> immediately (which result in a call to aio_complete()).  The patch in 
> 2.5.71-mm1 which separates out aio_setup_iocb() loses track of this 
> distinction, mishandling any case where the queued operation completes 
> immediately.  Aio poll, for instance, depends on being able to indicate 
> immediate completion.

The code for aio_read/write does distinguish between these cases.
- if you spot a case where it doesn't do let me know.
aio_setup_iocb() just sets up the method after performing the 
specified checks. Its aio_run_iocb() which actually executes it.

> 
> So the part of aio-01-retry.patch that splits out aio_setup_iocb() is 
> completely broken.
> 

Actually, looking closer, I think its just aio poll that's 
incorrectly merged here. The right way to implement aio poll in
the new model would have been to setup a retry method for it
in aio_setup_iocb(), not run generic_aio_poll() directly there.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

