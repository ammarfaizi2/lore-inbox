Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVCIX0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVCIX0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCIX0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:26:49 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:33917 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262206AbVCIXZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:25:59 -0500
Message-ID: <422F85F6.40305@yahoo.com.au>
Date: Thu, 10 Mar 2005 10:25:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] ptwalk: copy_pte_range hang
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com> <Pine.LNX.4.61.0503092212440.6070@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0503092212440.6070@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> This patch is the odd-one-out of the sequence.  The one before adjusted
> copy_pte_range from a for loop to a do while loop, and it was therefore
> simplest to check for lockbreak before copying pte: possibility that it
> might keep getting preempted without making progress under some loads.
> 
> Some loads such as startup: 2*HT*P4 with preemption cannot even reach
> multiuser login.  Suspect needs_lockbreak is broken, can get in a state
> when it remains forever true.  Investigate that later: for now, and for
> all time, it makes sense to aim for a little progress before breaking
> out; and we can manage more pte_nones than copies.
> 

(Just to reiterate a private mail sent to Hugh earlier)

Yeah I think lockbreak is broken. Because the inner spinlock never
has a cond_resched_lock performed on it, so its break_lock is
never set to 0, but need_lockbreak still always returns 1 for it.

IMO, spin_lock should set break_lock to 0, then cond_resched_lock
need not bother with it.

