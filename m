Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbUKVWjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUKVWjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbUKVWgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:36:17 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:24977 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261151AbUKVWcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:32:53 -0500
Message-ID: <41A26910.7090401@yahoo.com.au>
Date: Tue, 23 Nov 2004 09:32:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Christoph Lameter <clameter@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 22 Nov 2004, Christoph Lameter wrote:
> 
>>The problem is then that the proc filesystem must do an extensive scan
>>over all threads to find users of a certain mm_struct.
> 
> 
> The alternative is to just add a simple list into the task_struct and the
> head of it into mm_struct. Then, at fork, you just finish the fork() with
> 
> 	list_add(p->mm_list, p->mm->thread_list);
> 
> and do the proper list_del() in exit_mm() or wherever.
> 
> You'll still loop in /proc, but you'll do the minimal loop necessary.
> 

Yes, that was what I was thinking we'd have to resort to. Not a bad idea.

It would be nice if you could have it integrated with the locking that
is already there - for example mmap_sem, although that might mean you'd
have to take mmap_sem for writing which may limit scalability of thread
creation / destruction... maybe a seperate lock / semaphore for that list
itself would be OK.

Deferred rss might be a practical solution, but I'd prefer this if it can
be made workable.

