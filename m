Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTDKT4X (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTDKT4X (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:56:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:45749 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261609AbTDKT4V (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:56:21 -0400
Date: Fri, 11 Apr 2003 13:04:07 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Giuliano Pochini <pochini@shiny.it>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
Message-ID: <20030411130407.A9302@beaverton.ibm.com>
References: <200304101339.49895.pbadari@us.ibm.com> <XFMail.20030411100430.pochini@shiny.it> <20030411154450.GW31739@ca-server1.us.oracle.com> <200304110928.32978.pbadari@us.ibm.com> <20030411175736.GY31739@ca-server1.us.oracle.com> <20030411111232.A7756@beaverton.ibm.com> <20030411183543.GA31739@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030411183543.GA31739@ca-server1.us.oracle.com>; from Joel.Becker@oracle.com on Fri, Apr 11, 2003 at 11:35:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 11:35:43AM -0700, Joel Becker wrote:
> On Fri, Apr 11, 2003 at 11:12:32AM -0700, Patrick Mansfield wrote:
> > I'm trying to pull the current multi-path patch up to 2.5.66 (ouch). 
> 
> 	I wasn't aware of this work.  This is very interesting.  Two
> questions:
> 
> 1) When does it failover?  Meaning, if I I/O to a disk, but someone
> yanks the fibrechannel plug.  Does your multipath wait for a SCSI
> timeout to redirect the I/O?

> 2) If so, have you considered trapping loop up/down events to handle
> such a case?  Real users of multipath tech do not want to wait 90s for
> failover.
> 
> Joel

Generally it fails a path when we get a path specific error; it fails the
IO if we get a device (i.e. logical unit) error. If there are no paths
available, the IO is failed (though this could be changed to be
user-settable).

Behaviour on a cable removal is fibre, adapter, and adapter drive specific
- the qla driver has some sort of timeout on a port down that can be
lowered. It (fibre channel) can immediately complete (with failure) an
outstanding IO on a port down (or SCN notification). loop attached does
not always give you notification.

So with loop attached (AFAIK) you still might have to wait for a timeout
if you yank a disk.

Timeouts are the hardest to deal with - since we don't know where the
error occurred, so generally should not fail the IO (or path).

If we had user scanning, and some sort of hotplug for targets coming and
going, those be used to add and remove (or just fail) paths (at least for
switch attached).

-- Patrick Mansfield
