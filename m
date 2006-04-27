Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWD0GpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWD0GpY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWD0GpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:45:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:24735 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964927AbWD0GpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:45:23 -0400
Date: Thu, 27 Apr 2006 12:12:37 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Jay Lan <jlan@engr.sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 5/8] taskstats interface
Message-ID: <20060427064237.GA14496@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <444991EF.3080708@watson.ibm.com> <444996FB.8000103@watson.ibm.com> <44501A97.2060104@engr.sgi.com> <445041EB.7080205@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445041EB.7080205@watson.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 12:00:43AM -0400, Shailabh Nagar wrote:
> Jay Lan wrote:
> 
> >Hi Shailabh,
> >
> >Thanks for your effort in taskstats interface! Really appreciated!
> >I think this interface can offer a good foundation for other packages
> >to build on.
> >
> >Here are a few more comments:
> >
> >1) You mentioned the "version number within the (taskstats)
> >   structure" in taskstats.txt and a few other places, but i do not see
> >   that field defined in struct taskstats in taskstats.h?
> > 
> >
> Missed out on that. Need to add it back in.

There is a version field in genl_family as well. That can be used
for versioning as well. When we user space tool queries for the family
id, it can obtain and interpret the version information.

> 
> >2) In taskstats.txt "Extending taskstats" section, you mentioned two
> >   ways to extend the interface. The second method looks like a method
> >   to encoureage other package developers to create their own interface
> >  (ie, not taskstats) based on generic netlink to avoid reading large
> >number
> >   of fields not interested to other particular applications? I will be
> >fine
> >   with this as long as it is understood and agreed.
> > 
> >
> Yes, the second method is for other packages, which have very little in 
> common with the struct
> taskstats to extend the stats returned (using netlink attribs to extend 
> rather than extending the structure).

The second method will require the following

1. An API to return the length of data it wants to fill in
2. Another API to fill in the statistics along with the type -
   Like Shailabh mentioned, this will require creating a new TASKSTATS_TYPE_XXXX

> 
> >   Alternatively, you may have considered the pros and cons of #ifdef
> >   fields specific to only one accounting package in the struct taskstats.
> >   If you do, care to share your thoughts? 
> >
> I'd rather avoid doing an #ifdef'ed definition of the fields based on 
> configuration of one or the other
> accounting package...it'll add complexity for userspace parsing of the 
> structure.
> 
> Its quite acceptable to have the fields have zero as content if the 
> corresponding package isn't configured.
>

I agree with Shailabh, building in knowledge of other subsystems into
taskstats.h might not be the best choice. 
 
> 
> >Specific payload information
> >   can be carried in the version field. I am sure the version number of
> >struct
> >   taskstats does not need 64 bits. With the version number and payload
> >   info, application can surely interpret the taskstats data correctly.  
> > 
> >
> By "payload info" you mean some sort of bitmask (or encoding) which 
> specifies which fields are present
> or absent ? I suppose that could be done but it adds unnecessary 
> complexity ? e.g once delay accounting is there,
> all six to eight fields corresponding to it will be present...I don't 
> see much value in further being able to configure
> cpu delays, mem delays etc. separately. Is that different for CSA ?

Netlink attributes can be used to determine which attribute types are
present in the payload. libnl does a great job of providing a good set of
APIs to determine all attribute types present. This is one of the biggest
advantages I see of genetlink (attributes are optional and can co-exist
simultaneously)

> 
> 
> >3) In taskstats.txt "Usage" section, you mentioned "... in the Advanced
> >   Usage section below...", but that section does not exist.
> > 
> >
> Thanks for pointing it out. Should replace it with "per-tgid stats section".
> 
> >4) In do_exit() routine, you do:
> >+ taskstats_exit_alloc(&tidstats, &tgidstats);
> >
> >   The tidstats and tgidstats are checked in taskstats_exit_send() in
> >   taskstats.c for allocation failure, but a lot has been processed before
> >   the check. The allocation failure happens when system is stressed in
> >   memory. I  think we want to do the check earlier?
> > 
> >
> Since accounting is non-critical, I didn't see the need for doing the 
> check earlier if we're not going to do
> anything about it. The first use of the allocated structure is in the 
> taskstats_exit_send() where filling of the
> stats is not done if allocation failed. What would you suggest we do, on 
> allocation failure, if the check is
> performed immediately after the alloc ?
> 
> --Shailabh
> 
> >  
> >Regards,
> >- jay
> >
> > 
> >
> 
> 
>
<snip> 
					<---	Balbir
