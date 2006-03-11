Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWCKEyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWCKEyu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 23:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWCKEyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 23:54:50 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:34423 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932447AbWCKEyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 23:54:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ro1yFeQBtmUgr3n9hq90OEIq4itJtNZOHsEuLSxAygQlYpZ8hYO00QK+rOoIe9dXoI13H+oAr/vzGjKNLb887UH2AjWXvswMO+oIBjw99FzQ2QgNgjW2dyandCV+ndSpuz8951gywemU+o7RSGDRsmuWlZDMATuqvCVFZ1ofs6M=  ;
Message-ID: <44125812.1090408@yahoo.com.au>
Date: Sat, 11 Mar 2006 15:54:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: gerg@uclinux.org, Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Subject: Re: [patch][rfc] nommu: reverse mappings for nommu to solve get_user_pages
 problem
References: <20060311032606.GK26501@wotan.suse.de>
In-Reply-To: <20060311032606.GK26501@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>  int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  	unsigned long start, int len, int write, int force,
>  	struct page **pages, struct vm_area_struct **vmas)
>  {
>  	int i;
> -	static struct vm_area_struct dummy_vma;
> +	struct page *__page;
> +	static struct vm_area_struct *__vma;
> +	unsigned long addr = start;
>  
>  	for (i = 0; i < len; i++) {
> +		__vma = find_vma(mm, addr);
> +		if (!__vma)
> +			goto out_failed;
> +
> +		__page = virt_to_page(addr);
> +		if (!__page)
> +			goto out_failed;
> +
> +		BUG_ON(page_vma(__page) != __vma);
> +

Actually this check is leftover from a previous version. I think it
needs to be removed.

>  		if (pages) {
> -			pages[i] = virt_to_page(start);
> -			if (pages[i])
> -				page_cache_get(pages[i]);
> +			if (!__page->mapping) {
> +				printk(KERN_INFO "get_user_pages on unaligned"
> +						"anonymous page unsupported\n");				dump_stack();
> +				goto out_failed;
> +			}
> +

And this could trigger for file-backed pages that have been truncated meanwhile
I think. It wouldn't be a problem for a simple test-run, but does need to be
reworked slightly in order to be correct. Sub-page anonymous mappings cause a
lot of headaches :)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
