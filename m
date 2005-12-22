Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbVLVIdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbVLVIdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbVLVIdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:33:06 -0500
Received: from smtp108.plus.mail.mud.yahoo.com ([68.142.206.241]:43371 "HELO
	smtp108.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965131AbVLVIdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:33:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KGKjF2v85LxCCRustEXbFWsPsdankZuKlETVC4KOCVEoA0pDtlHe41zUwE0oMq3vyZNtcF16e8BTV4mBiKQ4yHj+W+S0Q/5lZJ8hA6SwnVZ0QtE9HV4yX/66GTb34Hrpvo6vlRSPrFafPsN/qi+/fqywfecBicR6He4K8XdVY4Q=  ;
Message-ID: <43AA64B9.8050100@yahoo.com.au>
Date: Thu, 22 Dec 2005 19:32:57 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Jes Sorensen <jes@trained-monkey.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
References: <20051221155411.GA7243@elte.hu> <yq0irtiuxvv.fsf@jaguar.mkp.net>	 <43AA1134.7090704@yahoo.com.au> <20051222071940.GA16804@elte.hu>	 <43AA5C15.8060907@yahoo.com.au>	 <1135238423.2940.1.camel@laptopd505.fenrus.org>	 <43AA5F7B.7010407@yahoo.com.au> <1135239672.2940.7.camel@laptopd505.fenrus.org>
In-Reply-To: <1135239672.2940.7.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>I'd probably just call "bastard": it is probably _unlucky_ when _doesn't_
>>get to retake the lock, judging by the factor-of-4 speedup that Jes
>>demonstrated.
> 
> 
> I suspect that's more avoiding the double wakeup that semaphores have
> (semaphores aren't quite fair either)
> 

It would be great if that were the case.

> 
>>Which might be the right thing to do, but having the front waiter go to
>>the back of the queue I think is not.
> 
> 
> afaik that isn't happening though.
> 

AFAIKS it does.

Failed lockers will go through to __mutex_lock_nonatomic, which calls
__mutex_lock_common to queue it on the tail of the FIFO list race-free.

__mutex_lock_nonatomic then sleeps, waiting for the task to become head
of the list and be worken up.

__mutex_lock_nonatomic then removes this task from the FIFO and calls
__mutex_lock_common again.

If I read right, not only is it a fairness problem, but it could also
harm performance because it will cycle through all waiting tasks rather
than just the next one to go.

If I don't read right... can you explain how it works? :P

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
