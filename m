Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTFFP6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTFFP6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:58:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:9098 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261960AbTFFP6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:58:36 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: dm-devel@sistina.com
Subject: Re: [dm-devel] Re: [RFC] device-mapper ioctl interface
Date: Fri, 6 Jun 2003 11:11:49 -0500
User-Agent: KMail/1.5
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030605093943.GD434@fib011235813.fsnet.co.uk> <200306051147.10775.kevcorry@us.ibm.com> <20030605194111.GA3022@fib011235813.fsnet.co.uk>
In-Reply-To: <20030605194111.GA3022@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306061111.49655.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 June 2003 14:41, Joe Thornber wrote:
> On Thu, Jun 05, 2003 at 11:47:10AM -0500, Kevin Corry wrote:
> > 1) Snapshots. Currently, the snapshot module, when it constructs a new
> > table, reads the header and existing exception tables from disk to
> > determine the initial state of the snapshot. With this new scheme, this
> > setup really shouldn't happen until the device is resumed (if it is done
> > when the "inactive" table is created, an existing "active" table could
> > change the on-disk information before the tables are switched). This kind
> > of implies a new entry-point into the target module will be required.
>
> See the suspend and resume target methods in my recent dev tree.
> We'll have to delay the metadata reading for both the snapshots and
> mirror to the first 'resume'.

Where is your dev tree located? I've checked your website on 
people.sistina.com and the various Sistina CVS trees, but I can't really find 
anything (regarding suspend and resume target methods) that's very recent. Do 
you have another ftp server somewhere?

> > 2) Removing suspended devices. The current code (2.5.70) does not allow a
> > suspended device to be removed/unlinked from the ioctl interface, since
> > removing it would leave you with no way to resume it (and hence flush any
> > pending I/Os).
>
> I think removing a device that has deferred io against it should not
> be possible, since it can only be in that state if the device is open.
> We shouldn't start ripping devices out from under people.

Right.

So are you saying it would be alright to remove a suspended device that has no 
pending I/O or isn't open? If so, the current code (in 2.5.70) doesn't seem 
to coordinate the removal of such a device with another process trying to 
open it or submit new I/O. Some new locking of the device would be necessary 
to prevent a device which is being removed from being opened at the same 
time.

Sorry if it sounds like I'm harping on this issue - I don't mean to. :)  Just 
interested in the details behind some of the proposed changes and some of the 
affects the changes might have. It will probably be much easier to just wait 
to see your new code, which will definitively answer these questions.

> The one place where we do want to do this is for the DM_REMOVE_ALL
> ioctl cmd.  Which is really an emergency panic button.  I'll just
> error any deferred io in this case.

Ok, this seems reasonable.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

