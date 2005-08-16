Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVHPXsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVHPXsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVHPXrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:47:48 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:54177 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1750745AbVHPXrq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:47:46 -0400
X-IronPort-AV: i="3.96,114,1122872400"; 
   d="scan'208"; a="299687715:sNHT25544370"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Date: Tue, 16 Aug 2005 18:47:45 -0500
Message-ID: <4277B1B44843BA48B0173B5B0A0DED43528193@ausx3mps301.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Thread-Index: AcWiuY7g1dwEuKQ9SsekeLBqLUqATwAAbO7w
From: <Michael_E_Brown@Dell.com>
To: <greg@kroah.com>
Cc: <mrmacman_g4@mac.com>, <linux-kernel@vger.kernel.org>,
       <Douglas_Warzecha@Dell.com>, <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 16 Aug 2005 23:47:46.0147 (UTC) FILETIME=[E6E86B30:01C5A2BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Tuesday, August 16, 2005 6:24 PM
> To: Brown, Michael E
> Cc: mrmacman_g4@mac.com; linux-kernel@vger.kernel.org; 
> Warzecha, Douglas; Domsch, Matt
> Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems 
> Management Base Driver (dcdbas) with sysfs support
> 
> 
> On Tue, Aug 16, 2005 at 06:11:13PM -0500, 
> Michael_E_Brown@Dell.com wrote:
> > 
> >     The main use of this driver by libsmbios will be to set BIOS F2
> > options. Based on your feedback, I will _NOT_ be implementing any 
> > fan/sensor functionality in libsmbios, but will work with 
> the lmsensors 
> > guys to do this instead. I only originally mentioned it because I 
> > thought it would be useful. My eyes have now been opened as 
> to the best 
> > way to do this, and we will do it that way.
> 
> Ok, sounds good.
> 
> Hm, what about my code comments, they seem to have been lost 
> in the noise...

No, they are not lost. Doug is working on them and will send you
something shortly (EOD today).

> 
> > And just to re-iterate one more time, we can already directly hook 
> > into
> > hardware from userspace without any kernel auditing. We are 
> just trying 
> > to set this out on the table for everybody to see.
> 
> So, this whole driver is not needed at all?  It can all be 
> done from userspace?  If so, then this shouldn't be added to 
> the kernel tree.

Several reasons:

A) Auditability: we don't do "secret" SMI calls behind people's backs.
This is an issue for some of our larger customers. This also provides a
legitimate reason that I can use to justify to management publicly
documenting the rest of the SMI calls that are not in use by our
software. Things like: "Hey, SomeBigDellCustomer wants to know what Dell
is doing with the open source dcdbas driver and all of the other SMI
function docs" pull a lot of weight.

B) Safety: It is easier to provide a single API with well defined
semantics so there are no race conditions when multiple programs try to
do SMI at the same time. SMI from userspace can be tricky, and I want to
make it easy to get right. Things like finding an usused BIOS reserved
area and coordinating access between multiple programs can be difficult.
Additionally, finding an area large enough to hold everything for the
larger SMI calls is tricky (ie. depends on which system, BIOS memory
layout, etc. Very difficult to safely code for and mostly not worth the
effort if we can get this driver in).

C) host control actions need to happen in kernel at shutdown, so that
part of the driver needs to be in the kernel. (this part isn't the part
that provides generic SMI stuff to userspace)

--
Michael
