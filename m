Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbTFEQdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbTFEQdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:33:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30419 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264689AbTFEQdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:33:53 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: dm-devel@sistina.com, Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] device-mapper ioctl interface
Date: Thu, 5 Jun 2003 11:47:10 -0500
User-Agent: KMail/1.5
References: <20030605093943.GD434@fib011235813.fsnet.co.uk>
In-Reply-To: <20030605093943.GD434@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306051147.10775.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 June 2003 04:39, Joe Thornber wrote:
> Here's the header file for the the proposed new ioctl interface for
> dm.  We've tried to change as little as possible to minimise code
> changes in LVM2 and EVMS.
>
> The changes address the following problems:
>
> o) Alignment mistakes in the ioctl structures
>
> o) Provide a way for the userland tools to back out of a series of
>    table updates without having to reload the orginal tables (remember
>    that an LV is often composed of a stack of 2 or more dm devices).

This should be very helpful for error recovery when setting up snapshots.

> o) Pre-loading of a new table may now occur without suspending the
>    device.  (Table loading can potentially allocate a lot of memory,
>    eg. mirror buffers).

Cool.

> o) Minimise the amount of time that a device is suspended.  eg. if a
>    simple linear mapping is being extended, there is no longer a need to
>    call the suspend ioctl in between the table load and the resume.
>    Instead the resume (which swaps in the new table), will do the right
>    thing.

Also very nice. This ought to elimate the possibility of deadlock due to 
suspending the device from user-space. I really like this solution!

I'll bring up a couple of the points Alasdair and I were discussing on irc 
yesterday:

1) Snapshots. Currently, the snapshot module, when it constructs a new table, 
reads the header and existing exception tables from disk to determine the 
initial state of the snapshot. With this new scheme, this setup really 
shouldn't happen until the device is resumed (if it is done when the 
"inactive" table is created, an existing "active" table could change the 
on-disk information before the tables are switched). This kind of implies a 
new entry-point into the target module will be required. 

2) Removing suspended devices. The current code (2.5.70) does not allow a 
suspended device to be removed/unlinked from the ioctl interface, since 
removing it would leave you with no way to resume it (and hence flush any 
pending I/Os). Alasdair mentioned a couple of new ideas. One would be to 
reload the device with an error-map and force it to resume, thus erroring any 
pending I/Os and allowing the device to be removed. This seems a bit 
heavy-handed. Another idea was to allow removing suspended-devices which 
aren't open. But that seems a bit racy. The current code doesn't seem to 
coordinate removal of a device from the interface with opening of the device. 
So you could potentially be opening the device at the same time you are 
removing it from the interface. Personally, I think the current behavior is 
fine. User-space can use the new list-devices command along with the 
dev-status command to determine if a device should be resumed before trying 
to remove it.

Any thoughts?

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

