Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVBAEQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVBAEQG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 23:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVBAEQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 23:16:05 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:24665 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261535AbVBAEQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 23:16:00 -0500
Message-ID: <41FF0281.6090903@yahoo.com.au>
Date: Tue, 01 Feb 2005 15:16:01 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page fault scalability patch V16 [3/4]: Drop page_table_lock
 in handle_mm_fault
References: <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com> <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com> <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com> <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com> <20050114043944.GB41559@muc.de> <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com> <20050114170140.GB4634@muc.de> <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> The page fault handler attempts to use the page_table_lock only for short
> time periods. It repeatedly drops and reacquires the lock. When the lock
> is reacquired, checks are made if the underlying pte has changed before
> replacing the pte value. These locations are a good fit for the use of
> ptep_cmpxchg.
> 
> The following patch allows to remove the first time the page_table_lock is
> acquired and uses atomic operations on the page table instead. A section
> using atomic pte operations is begun with
> 
> 	page_table_atomic_start(struct mm_struct *)
> 
> and ends with
> 
> 	page_table_atomic_stop(struct mm_struct *)
> 

Hmm, this is moving toward the direction my patches take.

I think it may be the right way to go if you're lifting the ptl
from some core things, because some architectures won't want to
audit and stuff, and some may need the lock.

Naturally I prefer the complete replacement that is made with
my patch - however this of course means one has to move
*everything* over to be pte_cmpxchg safe, which runs against
your goal of getting the low hanging fruit with as little fuss
as possible for the moment.


