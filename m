Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUIWXH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUIWXH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUIWXFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:05:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35826 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267511AbUIWXCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:02:22 -0400
Message-ID: <415355E0.9090202@mwwireless.net>
Date: Thu, 23 Sep 2004 16:01:52 -0700
From: Steve Longerbeam <stevel@mwwireless.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@sgi.com>
CC: linux-mm <linux-mm@kvack.org>, lse-tech <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm: memory policy for page cache allocation
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com> <20040920205509.GF4242@wotan.suse.de> <414F6C69.8060406@mwwireless.net> <4152F19C.4000804@sgi.com>
In-Reply-To: <4152F19C.4000804@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant wrote:

> Hi Steve,
>
> Steve Longerbeam wrote:
>
>> -------- original email follows ----------
>>
>> Hi Andi,
>>
>> I'm working on adding the features to NUMA mempolicy
>> necessary to support MontaVista's MTA.
>>
>> Attached is the first of those features, support for
>> global page allocation policy for mapped files. Here's
>> what the patch is doing:
>>
>> 1. add a shared_policy tree to the address_space object in fs.h.
>> 2. modify page_cache_alloc() in pagemap.h to take an address_space
>>    object and page offset, and use those to allocate a page for the
>>    page cache using the policy in the address_space object.
>> 3. modify filemap.c to pass the additional {mapping, page offset} pair
>>    to page_cache_alloc().
>> 4. Also in filemap.c, implement generic file {set|get}_policy() 
>> methods and
>>    add those to generic_file_vm_ops.
>> 5. In filemap_nopage(), verify that any existing page located in the 
>> cache
>>    is located in a node that satisfies the file's policy. If it's not 
>> in a node that
>>    satisfies the policy, it must be because the page was allocated 
>> before the
>>    file had any policies. If it's unused, free it and goto retry_find 
>> (will allocate
>>    a new page using the file's policy). Note that a similar operation 
>> is done in
>>    exec.c:setup_arg_pages() for stack pages.
>> 6. Init the file's shared policy in alloc_inode(), and free the 
>> shared policy in
>>    destroy_inode().
>>
>> I'm working on the remaining features needed for MTA. They are:
>>
>> - support for policies contained in ELF images, for text and data 
>> regions.
>> - support for do_mmap_mempolicy() and do_brk_mempolicy(). Do_mmap()
>>   can allocate pages to the region before the function exits, such as 
>> when pages
>>   are locked for the region. So it's necessary in that case to set 
>> the VMA's policy
>>   within do_mmap() before those pages are allocated.
>> - system calls for mmap_mempolicy and brk_mempolicy.
>>
>> Let me know your thoughts on the filemap policy patch.
>>
>> Thanks,
>> Steve
>>
>>
>
> Steve,
>
> I guess I am a little lost on this without understanding what MTA is.
> Is there a design/requirements document you can point me at?


Not yet, sorry. There is an internal wiki specification at MontaVista
Software, but it's specific to the 2.4.20 design of MTA.

>
> Also, can you comment on how the above is related to my page cache
> allocation policy patch?   Does having a global page cache allocation
> policy with a per process override satisfy your requirements at all
> or do you specifically have per file policies you want to specify?


MTA stands for "Memory Type-based Allocation" (the name was chosen by a
large customer of MontaVista). The idea behind MTA is identical to NUMA
memory policy in 2.6.8, but with extra features. MTA was developed
before NUMA mempolicy (it was originally developed in 2.4.20).

The basic idea of MTA is to allow file-mapped and anonymous VMA's
to contain a preference list of NUMA nodes that a page should be 
allocated from.
So in MTA there is only one policy, which is very similar to the BIND 
policy in
2.6.8.

MTA requires per mapped file policies. The patch I posted adds a
shared_policy tree to the address_space object, so that every file
can have it's own policy for page cache allocations. A mapped file
can have a tree of policies, one for each mapped region of the file,
for instance, text and initialized data. With the patch, file mapped
policies would work across all filesystems, and the specific support
in tmpfs and hugetlbfs can be removed.

The goal of MTA is to direct an entire program's resident pages (text
and data regions of the executable and all its shared libs) to a
single node or a specific set of nodes. The primary use of MTA (by
the customer) is to allow portions of memory to be powered off for
low power modes, and still have critical system applications running.

In MTA the executable file's policies are stored in the ELF image.
There is a utility to add a section containing the list of prefered nodes
for the executable's text and data regions. That section is parsed by
load_elf_binary(). The section data is in the form of mnemonic node
name strings, which load_elf_binary() converts to a node id list.

MTA also supports policies for the slab allocator.

>
> (Just trying to figure out how to work both of our requirements into
> the kernel in as simple as possible (but no simpler!) fashion.)


could we have both a global page cache policy as well as per file
policies. That is, if a mapped file has a policy, it overrides the
global policy. That would work fine for MTA.

Steve
