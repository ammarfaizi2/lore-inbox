Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVATBpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVATBpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 20:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVATBpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 20:45:22 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:61369 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262029AbVATBoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 20:44:12 -0500
Message-ID: <41EF0CE5.7080305@yahoo.com.au>
Date: Thu, 20 Jan 2005 12:44:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Dominik Brodowski <linux@dominikbrodowski.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] interruptible rwsem operations (i386, core)
References: <20050119213834.GC8471@dominikbrodowski.de> <24595.1106176220@redhat.com>
In-Reply-To: <24595.1106176220@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Dominik Brodowski <linux@dominikbrodowski.de> wrote:
> 
> 
>>Add functions down_read_interruptible, and down_write_interruptible to rw
>>semaphores. Implement these for i386.
>>...
> 
> 
>>+static inline int
>>+rwsem_down_interruptible_failed_common(struct rw_semaphore *sem,
>>+			struct rwsem_waiter *waiter, signed long adjustment)
>>+{
>>...
> 
> 
> I wonder if you should check to see if there are any readers that can be woken
> up if a sleeping writer is interrupted, but I can't think of a simple way to
> do it.
> 
> 

I think it will, won't it?

>>-struct rw_semaphore fastcall __sched *
>>-rwsem_down_read_failed(struct rw_semaphore *sem)
>>+void fastcall __sched rwsem_down_read_failed(struct rw_semaphore *sem)
> 
> 
> Please don't.
> 
> 
>>@@ -199,14 +253,33 @@ rwsem_down_read_failed(struct rw_semapho
>> 				RWSEM_WAITING_BIAS - RWSEM_ACTIVE_BIAS);
>> 
>> 	rwsemtrace(sem, "Leaving rwsem_down_read_failed");
>>-	return sem;
> 
> 
> Ditto.
> 
> 
>>-struct rw_semaphore fastcall __sched *
>>-rwsem_down_write_failed(struct rw_semaphore *sem)
>>+void fastcall __sched rwsem_down_write_failed(struct rw_semaphore *sem)
> 
> 
> Ditto.
> 
> 
>>@@ -216,10 +289,31 @@ rwsem_down_write_failed(struct rw_semaph
>> 	rwsem_down_failed_common(sem, &waiter, -RWSEM_ACTIVE_BIAS);
>> 
>> 	rwsemtrace(sem, "Leaving rwsem_down_write_failed");
>>-	return sem;
> 
> 
> Ditto.
> 
> 
>>@@ -99,11 +103,12 @@ static inline void __down_read(struct rw
>> {
>> 	__asm__ __volatile__(
>> 		"# beginning down_read\n\t"
>>-LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
>>+LOCK_PREFIX	"  incl      %0\n\t" /* adds 0x00000001, returns the old value */
> 
> 
> Ditto.
> 
> 
>> 		"  js        2f\n\t" /* jump if we weren't granted the lock */
>> 		"1:\n\t"
>> 		LOCK_SECTION_START("")
>> 		"2:\n\t"
>>+		"  movl      %2,%%eax\n\t"
> 
> 
> Splat.
> 
> 
>> 		"  pushl     %%ecx\n\t"
>> 		"  pushl     %%edx\n\t"
>> 		"  call      rwsem_down_read_failed\n\t"
> 
> 
> Splat.
> 
> 
>>@@ -113,11 +118,41 @@ LOCK_PREFIX	"  incl      (%%eax)\n\t" /*
>> 		LOCK_SECTION_END
>> 		"# ending down_read\n\t"
>> 		: "=m"(sem->count)
>>-		: "a"(sem), "m"(sem->count)
>>+		: "m"(sem->count), "m"(sem)
>> 		: "memory", "cc");
>> }
> 
> 
> You appear to be corrupting EAX.
> 
> 
>>+static inline int __down_read_interruptible(struct rw_semaphore *sem)
> 
> 
> Will corrupt EAX.
> 

I'll fix these up. You're right by the looks.

> 
>> 		"# beginning down_write\n\t"
>>-LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
>>+LOCK_PREFIX	"  xadd      %%edx,%0\n\t" /* subtract 0x0000ffff, returns the old value */
> 
> 
> Again, please don't. It's a lot more readable when it mentions EAX directly,
> plus it's also independent of constraint reordering.
> 

OK I suppose so...

