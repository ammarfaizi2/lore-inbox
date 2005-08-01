Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVHAK6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVHAK6V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 06:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVHAK6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 06:58:20 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:4968 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262114AbVHAK5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 06:57:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=g/ZZwTLGZXQfV7+/0Nzd/ew7GfajSByYpwBffmgnxuLspTZbLpySihQ8Rd2qla/iYZFCvMFFRy0/T79TMZfuf0VMWJcmTX4xdLlAz4c+/S006pHZdMM6VvS+erfOssg8L+sGKtGNOjXXIOlxT5WMkmWfC//LYrR2I0bz83NJ3hQ=  ;
Message-ID: <42EE0021.3010208@yahoo.com.au>
Date: Mon, 01 Aug 2005 20:57:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Roland McGrath <roland@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
References: <20050801032258.A465C180EC0@magilla.sf.frob.com> <42EDDB82.1040900@yahoo.com.au> <20050801091956.GA3950@elte.hu> <42EDEAFE.1090600@yahoo.com.au> <20050801101547.GA5016@elte.hu>
In-Reply-To: <20050801101547.GA5016@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> 
> Hugh's posting said:
> 
>  "it's trying to avoid an endless loop of finding the pte not writable 
>   when ptrace is modifying a page which the user is currently protected 
>   against writing to (setting a breakpoint in readonly text, perhaps?)"
> 
> i'm wondering, why should that case generate an infinite fault? The 
> first write access should copy the shared-library page into a private 
> page and map it into the task's MM, writable. If this make-writable 

It will be mapped readonly.

> operation races with a read access then we return a minor fault and the 
> page is still readonly, but retrying the write should then break up the 
> COW protection and generate a writable page, and a subsequent 
> follow_page() success. If the page cannot be made writable, shouldnt the 
> vma flags reflect this fact by not having the VM_MAYWRITE flag, and 
> hence get_user_pages() should have returned with -EFAULT earlier?
> 

If it cannot be written to, then yes. If it can be written to
but is mapped readonly then you have the problem.

Aside, that brings up an interesting question - why should readonly
mappings of writeable files (with VM_MAYWRITE set) disallow ptrace
write access while readonly mappings of readonly files not? Or am I
horribly confused?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
