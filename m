Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVBOSkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVBOSkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVBOSkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:40:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:11918 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261812AbVBOSkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:40:00 -0500
Message-ID: <421241A2.8040407@sgi.com>
Date: Tue, 15 Feb 2005 12:38:26 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de>
In-Reply-To: <20050215121404.GB25815@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> [Sorry, didn't answer to everything in your mail the first time. 
> See previous mail for beginning]
> 
> On Mon, Feb 14, 2005 at 06:29:45PM -0600, Ray Bryant wrote:
> 
>>migrating, and figure out from that what portions of which pid's
>>address spaces need to migrated so that we satisfy the constraints
>>given above.  I admit that this may be viewed as ugly, but I really
>>can't figure out a better solution than this without shuffling a
>>ton of ugly code into the kernel.
> 
> 
> I like the concept of marking stuff that shouldn't be migrated
> externally (using NUMA policy) better. 
> 

I really don't have an objection to that for the case of the shared
libraries in, for example, /lib and /usr/lib.  I just worry about making
sure that all of the libraries have so been marked.  I can do this
in a much simpler way by just adding a list of "do not migrate stuff"
to the migration library rather than requiring Steve Longerbeam's
API.

> 
>>One issue that hasn't been addressed is the following:  given a
>>particular entry in /proc/pid/maps, how does one figure out whether
>>that entry is mapped into some other process in the system, one
>>that is not in the set of processes to be migrated?   One could
> 
> 
> [...]
> 
> Marking things externally would take care of that.
> 

So the default would be that if the file is not mapped as "not-migratable",
then the file would be migratable, is that the idea?

> 
>>If we did this, we still have to have the page migration system call
>>to handle those cases for the tmpfs/hugetlbfs/sysv shm segments whose
>>pages were placed by first touch and for which there used to not be
>>a memory policy.  As discussed in a previous note, we are not in a
> 
> 
> You can handle those with mbind(..., MPOL_F_STRICT); 
> (once it is hooked up to page migration) 

Making memory migration a subset of page migration is not a general
solution.  It only works for programs that are using memory policy
to control placement.   As I've tried to point out multiple times
before, most programs that I am aware of use placement based on
first-touch.  When we migrate such programs, we have to respect
the placement decisions that the program has implicitly made in
this way.

Requiring memory migration to be a subset of the NUMA API is a
non-starter for this reason.   We have to follow the approach
of doing the correct migration, followed by fixing up the NUMA
policy to match the new reality.  (Perhaps we can do this as
part of memory migration.)

Until ALL programs use the NUMA mempolicy for placement
decisions, we cannot support page migration under the NUMA
API.

I don't understand why this is not clear to you.  Are you
assuming that you can manufacture a NUMA API for the new
location of the job that correctly represents the placement
information and toplogy of the job on the old set of nodes?

> 
> Just mmap the tmpfs/shm/hugetlb file in an external program and apply
> the policy. That is what numactl supports today too for shm
> files like this.
> 
> It should work later.
>

Wait.  As near as I can tell you

> 
> -Andi
> 


-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------
