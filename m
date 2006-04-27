Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWD0Rwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWD0Rwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWD0Rwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 13:52:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11904 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965007AbWD0Rwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 13:52:37 -0400
Message-ID: <445104DC.90401@engr.sgi.com>
Date: Thu, 27 Apr 2006 10:52:28 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 5/8] taskstats interface
References: <444991EF.3080708@watson.ibm.com> <444996FB.8000103@watson.ibm.com> <44501A97.2060104@engr.sgi.com> <445041EB.7080205@watson.ibm.com> <20060427064237.GA14496@in.ibm.com>
In-Reply-To: <20060427064237.GA14496@in.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> On Thu, Apr 27, 2006 at 12:00:43AM -0400, Shailabh Nagar wrote:
> 
>>Jay Lan wrote:
>>
>>
>>>Hi Shailabh,
>>>
>>>Thanks for your effort in taskstats interface! Really appreciated!
>>>I think this interface can offer a good foundation for other packages
>>>to build on.
>>>
>>>Here are a few more comments:
>>>
>>>1) You mentioned the "version number within the (taskstats)
>>>  structure" in taskstats.txt and a few other places, but i do not see
>>>  that field defined in struct taskstats in taskstats.h?
>>>
>>>
>>
>>Missed out on that. Need to add it back in.
> 
> 
> There is a version field in genl_family as well. That can be used
> for versioning as well. When we user space tool queries for the family
> id, it can obtain and interpret the version information.

Hi Shailabh and Balbir,

Are TASKSTATS_GENL_VERSION and TASKSTATS_VERSION the same thing?
If they are meant to serve different purposes, we still need it.

> 
> 
>>>2) In taskstats.txt "Extending taskstats" section, you mentioned two
>>>  ways to extend the interface. The second method looks like a method
>>>  to encoureage other package developers to create their own interface
>>> (ie, not taskstats) based on generic netlink to avoid reading large
>>>number
>>>  of fields not interested to other particular applications? I will be
>>>fine
>>>  with this as long as it is understood and agreed.
>>>
>>>
>>
>>Yes, the second method is for other packages, which have very little in 
>>common with the struct
>>taskstats to extend the stats returned (using netlink attribs to extend 
>>rather than extending the structure).
> 
> 
> The second method will require the following
> 
> 1. An API to return the length of data it wants to fill in
> 2. Another API to fill in the statistics along with the type -
>    Like Shailabh mentioned, this will require creating a new TASKSTATS_TYPE_XXXX
> 
> 
>>>  Alternatively, you may have considered the pros and cons of #ifdef
>>>  fields specific to only one accounting package in the struct taskstats.
>>>  If you do, care to share your thoughts? 
>>>
>>
>>I'd rather avoid doing an #ifdef'ed definition of the fields based on 
>>configuration of one or the other
>>accounting package...it'll add complexity for userspace parsing of the 
>>structure.
>>
>>Its quite acceptable to have the fields have zero as content if the 
>>corresponding package isn't configured.
>>
> 
> 
> I agree with Shailabh, building in knowledge of other subsystems into
> taskstats.h might not be the best choice. 
>  
> 
>>>Specific payload information
>>>  can be carried in the version field. I am sure the version number of
>>>struct
>>>  taskstats does not need 64 bits. With the version number and payload
>>>  info, application can surely interpret the taskstats data correctly.  
>>>
>>>
>>
>>By "payload info" you mean some sort of bitmask (or encoding) which 
>>specifies which fields are present
>>or absent ? I suppose that could be done but it adds unnecessary 
>>complexity ? e.g once delay accounting is there,
>>all six to eight fields corresponding to it will be present...I don't 
>>see much value in further being able to configure
>>cpu delays, mem delays etc. separately. Is that different for CSA ?

I was thinking of a bitmask thing. But instead of keying specific
fields, one bit may be used to key delay accounting, and another bit
for CSA, el at. This way you do not need to have CSA-specifc fields
in the payload and applications know how to correctly interpret the
payload. Taskstats and application do not need to have knowledge of
accounting packages, only need to set the bitmasks correctly.

When we start sending sys stats of each tasks to userland, that is
s lot of data. Note that BSD accounting even uses encode_comp_t()
routine to compress data into a 13-bit fraction with 3-bit exponent
field to shrink its size. Even though you do not need to care
about those zero's in taskstats, they still need to be delievered
through netlink socket.

I must admit that this may create a point of failure due to the
payload info not set correctly according to the CONFIG flags.

The idea was to eliminate the need of #2 methods, but maybe
#2 method is better...

I am a little confused after reading Balbir's reply. It seems to
me that Shailabh suggested to create a different struct to contain
stats data. Is that also what Balbir talked about? If a different
package builds a different taskstat-like interface as suggested
in #2, would the data travel on the same socket as delay
accounting?

> 
> 
> Netlink attributes can be used to determine which attribute types are
> present in the payload. libnl does a great job of providing a good set of
> APIs to determine all attribute types present. This is one of the biggest
> advantages I see of genetlink (attributes are optional and can co-exist
> simultaneously)
> 
> 
>>
>>>3) In taskstats.txt "Usage" section, you mentioned "... in the Advanced
>>>  Usage section below...", but that section does not exist.
>>>
>>>
>>
>>Thanks for pointing it out. Should replace it with "per-tgid stats section".
>>
>>
>>>4) In do_exit() routine, you do:
>>>+ taskstats_exit_alloc(&tidstats, &tgidstats);
>>>
>>>  The tidstats and tgidstats are checked in taskstats_exit_send() in
>>>  taskstats.c for allocation failure, but a lot has been processed before
>>>  the check. The allocation failure happens when system is stressed in
>>>  memory. I  think we want to do the check earlier?
>>>
>>>
>>
>>Since accounting is non-critical, I didn't see the need for doing the 
>>check earlier if we're not going to do
>>anything about it. The first use of the allocated structure is in the 
>>taskstats_exit_send() where filling of the
>>stats is not done if allocation failed. What would you suggest we do, on 
>>allocation failure, if the check is
>>performed immediately after the alloc ?

I would suggest to do the check at the beginning of
taskstats_exit_send() before mutex_lock(&taskstats_exit_mutex).

Regards,
  - jay

