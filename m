Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSILPdr>; Thu, 12 Sep 2002 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSILPdr>; Thu, 12 Sep 2002 11:33:47 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:24711 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316210AbSILPdq>; Thu, 12 Sep 2002 11:33:46 -0400
Date: Thu, 12 Sep 2002 08:39:23 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 SCSI core bug?
Message-ID: <20020912153923.GA8295@beaverton.ibm.com>
References: <20020911221859.A17951@flint.arm.linux.org.uk> <20020912100140.A32196@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020912100140.A32196@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King [rmk@arm.linux.org.uk] wrote:
> On Wed, Sep 11, 2002 at 10:19:00PM +0100, Russell King wrote:
> > Ok, so we were asking for 0xfe 512-byte sectors, which is 130048.
> > So why did SCSI tell me that it wanted 38400 bytes in
> > SCpnt->request_bufflen?
> 
> Ok, problem found.
> 
> There's a nice loop in scsi_send_eh_cmnd() which just loops endlessly
> trying to retry a SCpnt command on medium error without restoring it
> to its pristine state before giving it back to the host, or limiting
> the number of retries.


The scsi_eh_completed_normally function should be limiting your retries.
So you should not be looping endlessly unless the problem of sending
down a dirty command is causing another issue.

I have a cleanup patch for 2.5 scsi_error I will add this fix in.
scsi_send_eh_cmnd should not be retrying the command it should return to
the caller the status and let them decide. We also should create a
?restore_scsi_cb? function that is shared so that it is done
consistently.

Eventually the retry policy is going to be changed, but until then we
should fix this problem.

-andmike
-- 
Michael Anderson
andmike@us.ibm.com

