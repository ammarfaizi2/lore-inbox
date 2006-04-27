Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWD0Df1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWD0Df1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWD0Df1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:35:27 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:26726 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964911AbWD0Df1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:35:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KFo3Ze4kPpND2U5gUKekeXptJI4kVTlFuWKrp5dLFpUkdf36/Ed+7tWs72OlYPuMgR8jHC4HLvm55Qa8pLztmEYuiybf/FsalHbY8dnhPvhkbKw5qzEq9IE7vH3rAWn6sBFonQ/+r+bG+uJ/pbg6xJ5lVDRSUKEpC2UuxjmxP80=  ;
Message-ID: <44503BA2.7000405@yahoo.com.au>
Date: Thu, 27 Apr 2006 13:33:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Peterson <dsp@llnl.gov>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, riel@surriel.com,
       akpm@osdl.org
Subject: Re: [PATCH 1/2] mm: serialize OOM kill operations
References: <200604251701.31899.dsp@llnl.gov> <444EF2CF.1020100@yahoo.com.au> <200604261014.15008.dsp@llnl.gov>
In-Reply-To: <200604261014.15008.dsp@llnl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson wrote:

>On Tuesday 25 April 2006 21:10, Nick Piggin wrote:
>
>>Firstly why not use a semaphore and trylocks instead of your homebrew
>>lock?
>>
>
>Are you suggesting something like this?
>
>	spinlock_t oom_kill_lock = SPIN_LOCK_UNLOCKED;
>
>	static inline int oom_kill_start(void)
>	{
>		return !spin_trylock(&oom_kill_lock);
>	}
>
>	static inline void oom_kill_finish()
>	{
>		spin_unlock(&oom_kill_lock);
>	}
>
>If you prefer the above implementation, I can rework the patch as
>above.
>

I think you need a semaphore? Either way, drop the trivial wrappers.

>
>>Second, can you arrange it without using the extra field in mm_struct
>>and operation in the mmput fast path?
>>
>
>I'm open to suggestions on other ways of implementing this.  However I
>think the performance impact of the proposed implementation should be
>miniscule.  The code added to mmput() executes only when the referece
>count has reached 0; not on every decrement of the reference count.
>Once the reference count has reached 0, the common-case behavior is
>still only testing a boolean flag followed by a not-taken branch.  The
>use of unlikely() should help the compiler and CPU branch prediction
>hardware minimize overhead in the typical case where oom_kill_finish()
>is not called.
>

Mainly the cost of increasing cacheline footprint. I think someone
suggested using a flag bit somewhere... that'd be preferable.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
