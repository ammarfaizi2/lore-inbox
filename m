Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWCAGaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWCAGaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 01:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWCAGaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 01:30:09 -0500
Received: from fmr17.intel.com ([134.134.136.16]:10443 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932511AbWCAGaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 01:30:08 -0500
Message-ID: <44053DC6.6060209@linux.intel.com>
Date: Wed, 01 Mar 2006 14:23:02 +0800
From: bibo mao <bibo_mao@linux.intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: prasanna@in.ibm.com
CC: "bibo,mao" <bibo.mao@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       hiramatu@sdl.hitachi.co.jp
Subject: Re: [PATCH]kprobe handler discard user space trap
References: <4403FA60.6060701@intel.com> <20060228113431.GG10512@in.ibm.com>
In-Reply-To: <20060228113431.GG10512@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes code in kprobe_handler() function which calculates 
user space int3 trap address in i386 architecture. And this patch is 
based on kprobe-handler-discard-user-space-trap.patch, against 
2.6.16-rc5-mm1.

Signed-off-by: bibo mao <bibo.mao@intel.com>

--- a/arch/i386/kernel/kprobes.c	2006-03-01 12:48:54.000000000 +0800
+++ b/arch/i386/kernel/kprobes.c	2006-03-01 14:08:12.000000000 +0800
@@ -203,7 +203,7 @@ static int __kprobes kprobe_handler(stru
  {
  	struct kprobe *p;
  	int ret = 0;
-	kprobe_opcode_t *addr = NULL;
+	kprobe_opcode_t *addr = (kprobe_opcode_t *)(regs->eip - 
sizeof(kprobe_opcode_t));
  	unsigned long *lp;
  	struct kprobe_ctlblk *kcb;
  #ifdef CONFIG_PREEMPT
@@ -217,17 +217,6 @@ static int __kprobes kprobe_handler(stru
  	preempt_disable();
  	kcb = get_kprobe_ctlblk();

-	/* Check if the application is using LDT entry for its code segment and
-	 * calculate the address by reading the base address from the LDT entry.
-	 */
-	if ((regs->xcs & 4) && (current->mm)) {
-		lp = (unsigned long *) ((unsigned long)((regs->xcs >> 3) * 8)
-					+ (char *) current->mm->context.ldt);
-		addr = (kprobe_opcode_t *) (get_desc_base(lp) + regs->eip -
-						sizeof(kprobe_opcode_t));
-	} else {
-		addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
-	}
  	/* Check we're not actually recursing */
  	if (kprobe_running()) {
  		p = get_kprobe(addr);

Prasanna S Panchamukhi wrote:
> On Tue, Feb 28, 2006 at 03:23:12PM +0800, bibo,mao wrote:
>> Currently kprobe handler traps only happen in kernel space, so function
>> kprobe_exceptions_notify should skip traps which happen in user space.
>> This patch modifies this, and it is based on 2.6.16-rc4.
> 
> You need to remove the code which calculates the
> user space address in kprobe_handler() and also you need 
> to remove the code that checks for VM86 in i386, since
> your patch check if user/vm86 at the top level.
> 
> Thanks
> Prasanna
> 
>> Signed-off-by: bibo mao <bibo.mao@intel.com>
>>
>> diff -Nruap a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
>> --- a/arch/i386/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
>> +++ b/arch/i386/kernel/kprobes.c    2006-03-01 10:37:50.000000000 +0800
>> @@ -463,6 +463,9 @@ int __kprobes kprobe_exceptions_notify(s
>>      struct die_args *args = (struct die_args *)data;
>>      int ret = NOTIFY_DONE;
>>
>> +    if (user_mode(args->regs))
>> +        return ret;
>> +
>>      switch (val) {
>>      case DIE_INT3:
>>          if (kprobe_handler(args->regs))
>> diff -Nruap a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
>> --- a/arch/ia64/kernel/kprobes.c    2006-02-25 17:08:53.000000000 +0800
>> +++ b/arch/ia64/kernel/kprobes.c    2006-03-01 10:39:15.000000000 +0800
>> @@ -740,6 +740,9 @@ int __kprobes kprobe_exceptions_notify(s
>>      struct die_args *args = (struct die_args *)data;
>>      int ret = NOTIFY_DONE;
>>
>> +    if (user_mode(args->regs))
>> +        return ret;
>> +
>>      switch(val) {
>>      case DIE_BREAK:
>>          /* err is break number from ia64_bad_break() */
>> diff -Nruap a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
>> --- a/arch/powerpc/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
>> +++ b/arch/powerpc/kernel/kprobes.c    2006-03-01 10:39:53.000000000 +0800
>> @@ -397,6 +397,9 @@ int __kprobes kprobe_exceptions_notify(s
>>      struct die_args *args = (struct die_args *)data;
>>      int ret = NOTIFY_DONE;
>>
>> +    if (user_mode(args->regs))
>> +        return ret;
>> +
>>      switch (val) {
>>      case DIE_BPT:
>>          if (kprobe_handler(args->regs))
>> diff -Nruap a/arch/sparc64/kernel/kprobes.c b/arch/sparc64/kernel/kprobes.c
>> --- a/arch/sparc64/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
>> +++ b/arch/sparc64/kernel/kprobes.c    2006-03-01 10:40:16.000000000 +0800
>> @@ -324,6 +324,9 @@ int __kprobes kprobe_exceptions_notify(s
>>      struct die_args *args = (struct die_args *)data;
>>      int ret = NOTIFY_DONE;
>>
>> +    if (user_mode(args->regs))
>> +        return ret;
>> +
>>      switch (val) {
>>      case DIE_DEBUG:
>>          if (kprobe_handler(args->regs))
>> diff -Nruap a/arch/x86_64/kernel/kprobes.c b/arch/x86_64/kernel/kprobes.c
>> --- a/arch/x86_64/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
>> +++ b/arch/x86_64/kernel/kprobes.c    2006-03-01 10:38:48.000000000 +0800
>> @@ -601,6 +601,9 @@ int __kprobes kprobe_exceptions_notify(s
>>      struct die_args *args = (struct die_args *)data;
>>      int ret = NOTIFY_DONE;
>>
>> +    if (user_mode(args->regs))
>> +        return ret;
>> +
>>      switch (val) {
>>      case DIE_INT3:
>>          if (kprobe_handler(args->regs))
> 

