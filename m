Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTFET1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbTFET1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:27:40 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:20749 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264917AbTFET1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:27:39 -0400
Date: Thu, 5 Jun 2003 20:41:11 +0100
From: Joe Thornber <thornber@sistina.com>
To: dm-devel@sistina.com
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC] device-mapper ioctl interface
Message-ID: <20030605194111.GA3022@fib011235813.fsnet.co.uk>
References: <20030605093943.GD434@fib011235813.fsnet.co.uk> <200306051147.10775.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306051147.10775.kevcorry@us.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 11:47:10AM -0500, Kevin Corry wrote:
> 1) Snapshots. Currently, the snapshot module, when it constructs a new table, 
> reads the header and existing exception tables from disk to determine the 
> initial state of the snapshot. With this new scheme, this setup really 
> shouldn't happen until the device is resumed (if it is done when the 
> "inactive" table is created, an existing "active" table could change the 
> on-disk information before the tables are switched). This kind of implies a 
> new entry-point into the target module will be required. 

See the suspend and resume target methods in my recent dev tree.
We'll have to delay the metadata reading for both the snapshots and
mirror to the first 'resume'.

> 2) Removing suspended devices. The current code (2.5.70) does not allow a 
> suspended device to be removed/unlinked from the ioctl interface, since 
> removing it would leave you with no way to resume it (and hence flush any 
> pending I/Os).

I think removing a device that has deferred io against it should not
be possible, since it can only be in that state if the device is open.
We shouldn't start ripping devices out from under people.

The one place where we do want to do this is for the DM_REMOVE_ALL
ioctl cmd.  Which is really an emergency panic button.  I'll just
error any deferred io in this case.

- Joe
