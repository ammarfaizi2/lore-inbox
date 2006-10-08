Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWJHCFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWJHCFf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 22:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWJHCFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 22:05:35 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:65130 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750745AbWJHCFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 22:05:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Wvkbg0dX5LSQR/kgfWWmg+k37McXT4tr7kgudZg5Z53N2efGJgUBcpNQi9qfe5izkTnOYY+56KWXtnHi+cyQJHE8teLFqE+wgGdzEtrXB51lm7Epde7ZJRpMiZ+WJLLCoaXyPu2mUkcT/FGyvsmyS6sRxtArFh0m5OKty9CHPpA=  ;
Message-ID: <45285CEA.1070104@yahoo.com.au>
Date: Sun, 08 Oct 2006 12:05:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] mm: fault vs invalidate/truncate race fix
References: <20061007105758.14024.70048.sendpatchset@linux.site>	<20061007105842.14024.85533.sendpatchset@linux.site> <20061007134401.a28b7735.akpm@osdl.org>
In-Reply-To: <20061007134401.a28b7735.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Sat,  7 Oct 2006 15:06:21 +0200 (CEST)
>Nick Piggin <npiggin@suse.de> wrote:
>
>
>>Fix the race between invalidate_inode_pages and do_no_page.
>>
>
>- In do_no_page() there's a `goto retry' where we appear to have
>  forgotten to (conditionally) unlock the page.
>

Hmm, the retry should be gone - it was only there for the
seqlock-ish truncate race code.

>- In do_no_page() the COW-break code seem to have forgotten to
>  (conditionally) unlock the page which it just COWed?
>

It keeps the 'nopage_page' around and unlocks it at the end.
Last time I looked, this is required because truncate wants to
unmap 'even_cows', so we must hold the pagecache page locked
while instantiating the mapping on the cow page.

>- In do_no_page(), the unlock_page() which _is_ there doesn't test
>  VM_CAN_INVALIDATE before deciding to unlock the page.
>

It does a conditional lock if !VM_CAN_INVALIDATE based on a
suggestion from Hugh. I don't disagree with that, but it can
go away in the next patch as we won't be calling into
->page_mkwrite (if that callback can be implemented with ->fault).

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
