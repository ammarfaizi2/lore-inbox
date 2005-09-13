Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVIMWnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVIMWnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVIMWnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:43:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:46047 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932266AbVIMWnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:43:05 -0400
Date: Tue, 13 Sep 2005 15:42:15 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       James Bottomley <James.Bottomley@SteelEye.com>, ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Message-ID: <20050913224215.GB1308@us.ibm.com>
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com> <1126368081.4813.46.camel@mulgrave> <4325997D.3050103@adaptec.com> <20050912162739.GA11455@us.ibm.com> <4326964B.9010503@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4326964B.9010503@torque.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 07:05:15PM +1000, Douglas Gilbert wrote:
> Patrick Mansfield wrote:
> > On Mon, Sep 12, 2005 at 11:06:37AM -0400, Luben Tuikov wrote:
> 
> <snip>
> 
> > IMO adding well known LUNs at this point to the standard added nothing of
> > value, the target firmware has to check for special paths no matter what,
> > adding a well known LUN does not change that. And most vendors will
> > (likely) have support for use without a well known LUN. (This does not
> > mean we should not support it in linux, I just don't know why this went
> > into the standard.)
> > 
> > Using well known LUNs will be another code path that will have to live
> > alongside existing ones, and will likely require further black listing
> > (similar to REPORT LUN vs scanning for LUNs).
> 
> Patrick,
> The technique of supporting REPORT_LUNS on lun 0 of
> a target in the case where there is no such device
> (logical unit) is a pretty ugly. It also indicates what
> is really happening: the target device intercepts
> REPORT_LUNS, builds the response and replies on behalf
> of lun 0.

It should ignore the lun value for REPORT LUNS.

> Turns out there are other reasons an application may want
> to "talk" to a target device rather than one of its logical
> units (e.g. access controls and log pages specific to
> the target's transport). Well known lus can be seen with the
> REPORT_LUNS (select_report=1) but there is no mechanism (that
> I am aware of) that allows anyone to access them
> from the user space with linux.

What I mean is that the target has to intercept the command whether it is
a REPORT LUN or for the well known (W_LUN).

The target (firmware) code has to have code today like:

	if (cmd == REPORT_LUN) {
		do_report_lun();
	}

For only W_LUN support, the code might be something like:

	if (lun == W_LUN) {
		if (cmd == REPORT_LUN) {
			do_report_lun();
		}
	}

But the first case above already covers even the W_LUN case.

So adding a W_LUN at this point does not add any value ... maybe it looks
nice in the spec and in someones firmware, but it does not add anything
that I can see.

Kind of like an 8 byte lun, it adds no meaningful functionallity. [I mean,
who would want 2^64 LUs on one target? Yeh, let's give everyone in the
world ... no in the universe their own private LUN on a single target. The
LUN hiearchy is a bad idea, I have not seen a device that supports it,
kind of like trying to implement network routing inside your storage box.
Don't let those storage or database experts design your network hardware.]

-- Patrick Mansfield
