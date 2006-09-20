Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWITCDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWITCDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 22:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWITCDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 22:03:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:984 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750868AbWITCDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 22:03:18 -0400
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Waychison <mikew@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <451095F1.3000304@google.com>
References: <1158274508.14473.88.camel@localhost.localdomain>
	 <20060915001151.75f9a71b.akpm@osdl.org>  <45107ECE.5040603@google.com>
	 <1158709835.6002.203.camel@localhost.localdomain>
	 <451095F1.3000304@google.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 12:02:57 +1000
Message-Id: <1158717778.6002.234.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think the disconnect here is that the retries in the mmap_sem case and 
> the returning short for a signal are two different beasts, but they 
> would both want to use a NOPAGE_RETRY return code.
> 
> In the case of a signal, we definitely want to return back to userspace 
> and deliver it.  However, for dropping the mmap_sem while waiting for 
> the synchronous IO, it's a lot easier to directly rerun the fault 
> handler so that we can make another pass without allowing the for the 
> drop (avoiding livelock).

I'm not sure I see what your exactly livelock scenario is... 

> If we were to return to userspace after having dropped mmap_sem (without 
> updating pte, because mm/vmas may change) we would lose major vs minor 
> fault accounting as well.

My point is we do the looping in the fault handler if the PTE is still
absent and there is no signal pending and we return to userspace (and
drop the mmap_sem) if any of these criterias is met. We might want to
add a cond_resched() in the first case too.

Wouldn't that solve the livelock issue ?

Ben.


