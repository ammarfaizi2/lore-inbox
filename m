Return-Path: <linux-kernel-owner+w=401wt.eu-S932552AbXAGOjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbXAGOjh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbXAGOjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:39:36 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:45909 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552AbXAGOjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:39:35 -0500
Message-ID: <45A10627.9080301@vmware.com>
Date: Sun, 07 Jan 2007 06:39:35 -0800
From: Zachary Amsden <zach@vmware.com>
Reply-To: Andrew Morton <akpm@osdl.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
       kiran@scalex86.org, ak@suse.de, md@google.com, mingo@elte.hu,
       pravin.shelar@calsoftinc.com, shai@scalex86.org
Subject: Re: +	spin_lock_irq-enable-interrupts-while-spinning-i386-implementation.patch
 added to -mm tree
References: <200701032112.l03LCnVb031386@shell0.pdx.osdl.net>	 <1168122953.26086.230.camel@imap.mvista.com>	 <20070106232641.68511f15.akpm@osdl.org> <1168176285.26086.241.camel@imap.mvista.com>
In-Reply-To: <1168176285.26086.241.camel@imap.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------020006020607050906000806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020006020607050906000806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Walker wrote:
> On Sat, 2007-01-06 at 23:26 -0800, Andrew Morton wrote:
>
>   
>> diff -puN include/asm-i386/spinlock.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix include/asm-i386/spinlock.h
>> --- a/include/asm-i386/spinlock.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix
>> +++ a/include/asm-i386/spinlock.h
>> @@ -86,17 +86,19 @@ static inline void __raw_spin_lock_flags
>>  static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
>>  {
>>  	asm volatile("\n1:\t"
>> -		     LOCK_PREFIX " ; decb %0\n\t"
>> +		     LOCK_PREFIX " ; decb %[slock]\n\t"
>>  		     "jns 3f\n"
>>  		     STI_STRING "\n"
>>  		     "2:\t"
>>  		     "rep;nop\n\t"
>> -		     "cmpb $0,%0\n\t"
>> +		     "cmpb $0,%[slock]\n\t"
>>  		     "jle 2b\n\t"
>>  		     CLI_STRING "\n"
>>  		     "jmp 1b\n"
>>  		     "3:\n\t"
>> -		     : "+m" (lock->slock) : : "memory");
>> +		     : [slock] "+m" (lock->slock)
>> +		     : __CLI_STI_INPUT_ARGS
>> +		     : "memory" CLI_STI_CLOBBERS);
>>  }
>>  #endif
>>     
>
> Now it fails with CONFIG_PARAVIRT off .
>   

Now it compiles both ways.  Or at least asm-offsets.c does.  Testing 
full build...

Zach

--------------020006020607050906000806
Content-Type: text/plain;
 name="paravirt-assembler-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="paravirt-assembler-fix"

diff -r 94a7e766e5ea include/asm-i386/spinlock.h
--- a/include/asm-i386/spinlock.h	Sun Jan 07 06:17:42 2007 -0800
+++ b/include/asm-i386/spinlock.h	Sun Jan 07 06:28:51 2007 -0800
@@ -86,7 +86,7 @@ static inline void __raw_spin_lock_irq(r
 static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
 {
 	asm volatile("\n1:\t"
-		     LOCK_PREFIX " ; decb %0\n\t"
+		     LOCK_PREFIX " ; decb %[slock]\n\t"
 		     "jns 3f\n"
 		     STI_STRING "\n"
 		     "2:\t"
@@ -96,7 +96,10 @@ static inline void __raw_spin_lock_irq(r
 		     CLI_STRING "\n"
 		     "jmp 1b\n"
 		     "3:\n\t"
-		     : "+m" (lock->slock) : : "memory");
+		     : [slock] "+m" (lock->slock)
+		     : [dummy] "i" (0xdeadbeaf)
+		       CLI_STI_INPUT_ARGS
+		     : "memory" CLI_STI_CLOBBERS);
 }
 #endif
 

--------------020006020607050906000806--
