Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268775AbUHaRSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268775AbUHaRSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUHaRRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:17:20 -0400
Received: from mail.tmr.com ([216.238.38.203]:20230 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265086AbUHaRMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:12:54 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: PATCH: Root reservations for strict overcommit
Date: Tue, 31 Aug 2004 13:13:42 -0400
Organization: TMR Associates, Inc
Message-ID: <ch2b68$985$1@gatekeeper.tmr.com>
References: <20040831143449.GA26680@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093971977 9477 192.168.12.100 (31 Aug 2004 17:06:17 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040831143449.GA26680@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This was on my TODO list for a while and it turns out someone already fixed the
> armwaving overcommit mode for the same problem. It is easy to get into a
> situation where you have no overcommit and nothing can be done because there is
> no memory to clean up the stable but non-useful state of the machine.
> 
> The fix is trivial and duplicated from the armwaving overcommit code path.
> The last 3% of the memory can be claimed by root processes only. It isn't a
> cure but it does seem to solve the real world problems - at least providing
> you have enough memory for 3% to be useful 8).
> 
> --- security/commoncap.c~	2004-08-31 15:27:46.777504736 +0100
> +++ security/commoncap.c	2004-08-31 15:27:46.778504584 +0100
> @@ -357,6 +357,11 @@
>  
>  	allowed = (totalram_pages - hugetlb_total_pages())
>  	       	* sysctl_overcommit_ratio / 100;
> +	/*
> +	 * Leave the last 3% for root
> +	 */
> +	if (!capable(CAP_SYS_ADMIN))
> +		allowed -= allowed / 32;
>  	allowed += total_swap_pages;
>  
>  	if (atomic_read(&vm_committed_space) < allowed)

Would it be a problem to put a lower bound on how much to leave for 
root? If it's really too small to be useful, perhaps one of (a) reserve 
enough to be useful or (b) don't bother to reserve at all, should be 
selected.

I don't know what you have in mind for "useful," but it seems likely 
that a really small machine would be better off giving up any memory 
unless it was useful.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
