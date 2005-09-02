Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVIBGZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVIBGZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbVIBGZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:25:44 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:59263 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030328AbVIBGZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:25:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=K7nube8j72PXCo667/bLQ7thJxXr8Mx4UMyoJEe00KB3IoW7aJKvWlbj9BTMSoPvY0jmuhUfzJxL62Ai0a33kKN+vhO4z7YkrJOV0ChfM4/vmYW5B+ZAre/Q2VH5ns0UlQX1jBH6RfXWoA64bypqXl0L4Z0msGaePDP0uKxq6t0=  ;
Message-ID: <4317F071.1070403@yahoo.com.au>
Date: Fri, 02 Sep 2005 16:25:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: New lockless pagecache
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were a number of problems with the old lockless pagecache:

- page_count of free pages was unstable, which meant an extra atomic
   operation when allocating a new page (had to use get_page instead
   of set_page_count).

- This meant a new page flag PG_free had to be introduced.

- Also needed a spin loop and memory barriers added to the page
   allocator to prevent a free page with a speculative reference on
   it from being allocated.

- This introduced the requirement that interrupts be disabled in
   page_cache_get_speculative to prevent deadlock, which was very
   disheartening.

- Too complex.

- To cap it off, there was an "unsolvable" race whereby a second
   page_cache_get_speculative would not be able to detect it had
   picked up a free page, and try to free it again.

The elegant solution was right under my nose the whole time.
I introduced an atomic_cmpxchg and use that to ensure we don't
touch ->_count of a free page. This solves all the above problems.

I think this is getting pretty stable. No guarantees of course,
but it would be great if anyone gave it a test.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
