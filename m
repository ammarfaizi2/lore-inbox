Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUIYFlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUIYFlC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 01:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269243AbUIYFlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 01:41:02 -0400
Received: from [207.168.29.180] ([207.168.29.180]:32896 "EHLO
	tugboat.mwwireless.net") by vger.kernel.org with ESMTP
	id S266069AbUIYFkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 01:40:52 -0400
Message-ID: <415504E1.9010107@mwwireless.net>
Date: Fri, 24 Sep 2004 22:40:49 -0700
From: Steve Longerbeam <stevel@mwwireless.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@sgi.com>
Cc: linux-mm <linux-mm@kvack.org>, lse-tech <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm: memory policy for page cache allocation
References: <fa.b014hh3.12l6193@ifi.uio.no> <fa.ep2m52m.1p0edrq@ifi.uio.no> <41544097.1020500@sgi.com>
In-Reply-To: <41544097.1020500@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ray Bryant wrote:

> Steve Longerbeam wrote:
>
>> Ray Bryant wrote:
>>
>>> Hi Steve,
>>>
>
> <snip>
>
>
>> So in MTA there is only one policy, which is very similar to the BIND 
>> policy in
>> 2.6.8.
>>
>> MTA requires per mapped file policies. The patch I posted adds a
>> shared_policy tree to the address_space object, so that every file
>> can have it's own policy for page cache allocations. A mapped file
>> can have a tree of policies, one for each mapped region of the file,
>> for instance, text and initialized data. With the patch, file mapped
>> policies would work across all filesystems, and the specific support
>> in tmpfs and hugetlbfs can be removed.
>>
>
> Just mapped files, not regular files as well?  So you don't care about
> placement of page cache pages for regular files?


MTA cares about placement for both mapped file pages and regular readahead
pages. Because if a regular file readahead sees that the region of the 
file being
read currently has a policy (by searching based on the page index in the 
inode's
mapping shared_policy tree), then the readahead needs to use that 
policy. Because
those pages allocated to the page cache will also be used by VMA's 
currently mapping
the file.


>
>> The goal of MTA is to direct an entire program's resident pages (text
>> and data regions of the executable and all its shared libs) to a
>> single node or a specific set of nodes. The primary use of MTA (by
>> the customer) is to allow portions of memory to be powered off for
>> low power modes, and still have critical system applications running.
>>
>
> Interesting.  Sounds like there is a lot of commonality between what you
> want and we want.


cool, so this should be easy!

>
>> In MTA the executable file's policies are stored in the ELF image.
>> There is a utility to add a section containing the list of prefered 
>> nodes
>> for the executable's text and data regions. That section is parsed by
>> load_elf_binary(). The section data is in the form of mnemonic node
>> name strings, which load_elf_binary() converts to a node id list.
>
>
> Above you said "per mapped file policies".  So it sounds as if you 
> could have different policies for different mapped files in a single 
> application.


right. For instance, the bash ELF image could be marked to have its text 
go in node 1,
and data go in node 2, but the libc ELF image could have its text go in 
node 0, and
data in node 3. That's just a wild example. Of course, if you wanted ALL 
of bash's
text and data to go in say node 1, bash and all of the shared libs 
loaded by bash would
have to be marked to go in node 1.

The useage idea is that critical apps (say bash, daemons, etc) and 
critical libs (ie libc)
can have their memory reside completely in nodes that never "go away". 
Non-critical
apps, and libs not used by critical apps, can be located in nodes that 
get powered down
in low power modes.

This info might help too. In MTA, on a page fault, there's three levels of
precedence when selecting a policy for a page alloc. File policy > VMA 
policy >
process policy > default policy (er, well that's four). In other words, 
if the
VMA is a file mapping, use the file's policy if there is one, otherwise 
use the
VMA's policy if there is one, otherwise use the process' policy if there 
is one,
otherwise use the default policy. In the case of a COW for a file 
mapping though,
the COW page is the process' own private page, so it can start from the 
VMA policy.

> How
> do you specify which mapped file gets which policy using the info in 
> the header?  (in particular, how do you match up info the header with 
> files in
> the application?  First one opened gets this policy, next gets that 
> one, or what?)  [I guess in this paragraph "policy" == "node list" for 
> your case.]


the file's policies are simply located in an ELF section of the file. We 
have a utility that will
add a section to the ELF image that contains the policy info. That 
section is parsed
by load_elf_image() for executables, and by ld.so in libc for shared 
objects.

A mapped file's mempolicy has to be specified by the file itself, not by 
the process
mapping the file. For instance, it's not possible for process A to want 
libc text in
node 0, while process B wants libc text in node 1, otherwise we have 
cache aliases.
So the page cache alloc policies have to be either global (which is what 
you want)
or per-file or both, with file policy taking precedence over global.

>
> Or is the policy description more general, i. e. all text pages on 
> nodes 3&5,
> all mapped file pages on nodes 4,7,9.
>
> Within a node list, is there any notion of local allocation?  That is, if
> the current policy puts mapped file pages on nodes 4, 7, 9, and a process
> on node 7 touches a page, is there a preference to allocate it on node 7?

No, not yet. But I'm not sure if that would make sense. If a file wants
text preferably in node 4, with fallback to node 7, it should try node
4 first, regardless of what some process wants.

>
>>
>> MTA also supports policies for the slab allocator.
>>
>
> Is that a global or per process policy or is it finer grained than that?
> (i. e. by cache type).


the policy is contained in the cache, using a new API called
kmem_cache_create_mempolicy(), so that allocations from that
cache use a policy.

>
>>>
>>> (Just trying to figure out how to work both of our requirements into
>>> the kernel in as simple as possible (but no simpler!) fashion.)
>>
>>
>>
>>
>> could we have both a global page cache policy as well as per file
>> policies. That is, if a mapped file has a policy, it overrides the
>> global policy. That would work fine for MTA.
>>
>
> I don't see why not.  You could fall back on that if there is no
> file policy.
>
> When you are done, is the intent to merge this into the mainline or does
> MontaVista intend to maintain a "added value" patch of some kind?


it would be cool if most of this has enough interest to go in mainline, 
otherwise
MontaVista has to maintain a large patch.

But in summary, the only major addition to the current NUMA mempolicy
for MTA support is policies for mapped files.

Steve
