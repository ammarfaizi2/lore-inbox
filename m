Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTI3SNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 14:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTI3SNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 14:13:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51341 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261640AbTI3SNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 14:13:34 -0400
Date: Tue, 30 Sep 2003 13:12:56 -0500
From: linas@austin.ibm.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [2.4 PATCH:] Lengthen SCSI timeouts to deal with broken hardware
Message-ID: <20030930131256.A24532@forte.austin.ibm.com>
References: <20030930120944.A31772@forte.austin.ibm.com> <20030930171619.GA22314@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030930171619.GA22314@gtf.org>; from jgarzik@pobox.com on Tue, Sep 30, 2003 at 01:16:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 01:16:19PM -0400, Jeff Garzik wrote:
> On Tue, Sep 30, 2003 at 12:09:44PM -0500, linas@austin.ibm.com wrote:
> > 
> > 
> > --- drivers/scsi/scsi_obsolete.c.orig	2003-09-29 17:47:26.000000000 -0500
> > +++ drivers/scsi/scsi_obsolete.c	2003-09-29 17:51:40.000000000 -0500
> > @@ -118,10 +118,19 @@ static void scsi_dump_status(void);
> >  #define ABORT_TIMEOUT SCSI_TIMEOUT
> >  #define RESET_TIMEOUT SCSI_TIMEOUT
> >  #else
> > +#if defined(__powerpc64__)
> > +/* Some Achip ARC765-based DVD-ROM's can take 15 seconds or more to reset.
> > + * All commands (sense, abort) will not get a response until the reset 
> > + * completes.  Lengthen timeouts to make up for this. */
> > +#define SENSE_TIMEOUT (20*HZ)
> > +#define RESET_TIMEOUT (2*HZ)
> > +#define ABORT_TIMEOUT (25*HZ)
> 
> This should be device-dependent, not platform-dependent.


Hi Jeff,

Easier said than done.  I could add a new bit to the device blacklist that
covers timeouts.   However, one of the timeouts pops during the scsi
inquiry, before we've even identified the device type.  

Let me review the changes to make this patch device-dependent:
-- add a new bitfield to the blacklist (in scsi_scan.c) for timeouts
-- add new fields to struct scsi_device that hold timeout values
-- make changes in various places to use the timeout value that
   was stored in Scsi_Device, including, possibly, no longer passing 
   the timeout as a subroutine arg.

This would be a consderably larger, possibly controversial patch.  
I suppose I can do it if that's what is needed, but I thought I'd opt
for the minimal, 'tactical' first, dirty as it is.

My goal is to get the fix in there, and make everybody happy in the 
process.  How should I proceed?

--linas

