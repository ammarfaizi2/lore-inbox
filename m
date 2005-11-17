Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbVKQXP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVKQXP0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVKQXP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:15:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23173 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965068AbVKQXPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:15:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       ak@suse.de
Subject: Re: [PATCH 9/10] kdump: read previous kernel's memory
References: <20051117131339.GD3981@in.ibm.com>
	<20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com>
	<20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com>
	<20051117132437.GI3981@in.ibm.com> <20051117132557.GJ3981@in.ibm.com>
	<20051117132659.GK3981@in.ibm.com> <20051117132850.GL3981@in.ibm.com>
	<20051117132944.GM3981@in.ibm.com>
	<20051117142023.43764d8b.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 17 Nov 2005 16:14:43 -0700
In-Reply-To: <20051117142023.43764d8b.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 17 Nov 2005 14:20:23 -0800")
Message-ID: <m18xvmooik.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Vivek Goyal <vgoyal@in.ibm.com> wrote:
>>
>> +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>> + size_t csize, unsigned long offset, int userbuf)
>> +{
>> +	void  *vaddr;
>> +
>> +	if (!csize)
>> +		return 0;
>> +
>> +	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
>> +
>> +	if (userbuf) {
>> +		if (copy_to_user(buf, (vaddr + offset), csize)) {
>> +			kunmap_atomic(vaddr, KM_PTE0);
>> +			return -EFAULT;
>
> The copy_*_user() inside kmap_atomic() is problematic.
>
> On some configs (eg, x86, highmem) the process is running atomically, hence
> the copy_*_user() will *refuse* to fault in the user's page if it's not
> present.  Because pagefaulting involves doing things which sleep.
>
> So
>
> a) This code will generate might_sleep() warnings at runtime and
>
> b) It'll return -EFAULT for user pages which haven't been faulted in yet.
>
>
> We do all sorts of gruesome tricks in mm/filemap.c to get around all this. 
> I don't think your code is as performance-sensitive, so a suitable fix
> might be to double-copy the data.  Make sure that the same physical page is
> used as a bounce page for each copy (ie: get the caller to pass it in) and
> that page will be cache-hot and the performance should be acceptable.
>
> If it really is performance-sensitive then you'll need to play filemap.c
> games.  It'd be better to use a sleeping kmap instead, if poss.  That's
> kmap().
>
> Please send an incremental patch when it's sorted.  

I'm going send my standard grumble that what is really needed
is to track why we can't use /dev/mem.  

We could solve this with a normal kmap except that we
quite possibly don't have a struct page for this page of memory.

/dev/mem does not allow reads in this situation because of how
problematic getting I/O reads correct is.  But not having a good
interface for mapping it into user space is similar.

Could we simply make this into a file that you can mmap
but you can't read?  I think that would be cleaner, and simpler.

Eric

