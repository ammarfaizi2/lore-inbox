Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268846AbUIXPnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268846AbUIXPnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268870AbUIXPnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:43:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33921 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268846AbUIXPil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:38:41 -0400
Message-ID: <41544097.1020500@sgi.com>
Date: Fri, 24 Sep 2004 10:43:19 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Steve Longerbeam <stevel@mwwireless.net>
CC: linux-mm <linux-mm@kvack.org>, lse-tech <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm: memory policy for page cache allocation
References: <fa.b014hh3.12l6193@ifi.uio.no> <fa.ep2m52m.1p0edrq@ifi.uio.no>
In-Reply-To: <fa.ep2m52m.1p0edrq@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Longerbeam wrote:
> Ray Bryant wrote:
> 
>> Hi Steve,
>>

<snip>


> So in MTA there is only one policy, which is very similar to the BIND 
> policy in
> 2.6.8.
>
> MTA requires per mapped file policies. The patch I posted adds a
> shared_policy tree to the address_space object, so that every file
> can have it's own policy for page cache allocations. A mapped file
> can have a tree of policies, one for each mapped region of the file,
> for instance, text and initialized data. With the patch, file mapped
> policies would work across all filesystems, and the specific support
> in tmpfs and hugetlbfs can be removed.
>

Just mapped files, not regular files as well?  So you don't care about
placement of page cache pages for regular files?

> The goal of MTA is to direct an entire program's resident pages (text
> and data regions of the executable and all its shared libs) to a
> single node or a specific set of nodes. The primary use of MTA (by
> the customer) is to allow portions of memory to be powered off for
> low power modes, and still have critical system applications running.
> 

Interesting.  Sounds like there is a lot of commonality between what you
want and we want.

> In MTA the executable file's policies are stored in the ELF image.
> There is a utility to add a section containing the list of prefered nodes
> for the executable's text and data regions. That section is parsed by
> load_elf_binary(). The section data is in the form of mnemonic node
> name strings, which load_elf_binary() converts to a node id list.

Above you said "per mapped file policies".  So it sounds as if you could have 
different policies for different mapped files in a single application.  How
do you specify which mapped file gets which policy using the info in the 
header?  (in particular, how do you match up info the header with files in
the application?  First one opened gets this policy, next gets that one, or 
what?)  [I guess in this paragraph "policy" == "node list" for your case.]

Or is the policy description more general, i. e. all text pages on nodes 3&5,
all mapped file pages on nodes 4,7,9.

Within a node list, is there any notion of local allocation?  That is, if
the current policy puts mapped file pages on nodes 4, 7, 9, and a process
on node 7 touches a page, is there a preference to allocate it on node 7?

> 
> MTA also supports policies for the slab allocator.
> 

Is that a global or per process policy or is it finer grained than that?
(i. e. by cache type).

>>
>> (Just trying to figure out how to work both of our requirements into
>> the kernel in as simple as possible (but no simpler!) fashion.)
> 
> 
> 
> could we have both a global page cache policy as well as per file
> policies. That is, if a mapped file has a policy, it overrides the
> global policy. That would work fine for MTA.
> 

I don't see why not.  You could fall back on that if there is no
file policy.

When you are done, is the intent to merge this into the mainline or does
MontaVista intend to maintain a "added value" patch of some kind?

> Steve
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


