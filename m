Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSILI4z>; Thu, 12 Sep 2002 04:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSILI4y>; Thu, 12 Sep 2002 04:56:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38670 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314278AbSILI4y>; Thu, 12 Sep 2002 04:56:54 -0400
Date: Thu, 12 Sep 2002 10:01:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 SCSI core bug?
Message-ID: <20020912100140.A32196@flint.arm.linux.org.uk>
References: <20020911221859.A17951@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020911221859.A17951@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Sep 11, 2002 at 10:19:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 10:19:00PM +0100, Russell King wrote:
> Ok, so we were asking for 0xfe 512-byte sectors, which is 130048.
> So why did SCSI tell me that it wanted 38400 bytes in
> SCpnt->request_bufflen?

Ok, problem found.

There's a nice loop in scsi_send_eh_cmnd() which just loops endlessly
trying to retry a SCpnt command on medium error without restoring it
to its pristine state before giving it back to the host, or limiting
the number of retries.

The end result is that the SCSI command says N sectors, the request
list may say N * sector size bytes, but SCpnt->request_bufflen may
be complete rubbish, since the HBA driver is allowed to modify this
field during the processing of a command.

We do have a specific function to restore the SCSI command data to
a pristine state (scsi_eh_retry_command).

Ok, so there's two bugs here:

1. It's possible for SCSI to completely bring a box to a complete
   standstill when it encounters a SCSI error.

2. Not retrying the command in its correct state.

I'll look at cooking up a patch for both of these in the next few days
or so.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

