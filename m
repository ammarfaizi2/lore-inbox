Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758557AbWK2D4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557AbWK2D4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 22:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758644AbWK2D4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 22:56:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24260 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1758274AbWK2D4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 22:56:36 -0500
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Nicholas Miell <nmiell@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away 
In-reply-to: Your message of "Tue, 28 Nov 2006 19:08:25 -0800."
             <1164769705.2825.4.camel@entropy> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Nov 2006 14:56:20 +1100
Message-ID: <21982.1164772580@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell (on Tue, 28 Nov 2006 19:08:25 -0800) wrote:
>On Wed, 2006-11-29 at 13:22 +1100, Keith Owens wrote:
>> Compiling 2.6.19-rc6 with gcc version 4.1.0 (SUSE Linux),
>> wait_hpet_tick is optimized away to a never ending loop and the kernel
>> hangs on boot in timer setup.
>> 
>> 0000001a <wait_hpet_tick>:
>>   1a:   55                      push   %ebp
>>   1b:   89 e5                   mov    %esp,%ebp
>>   1d:   eb fe                   jmp    1d <wait_hpet_tick+0x3>
>> 
>> This is not a problem with gcc 3.3.5.  Adding barrier() calls to
>> wait_hpet_tick does not help, making the variables volatile does.
>> 
>> Signed-off-by: Keith Owens <kaos@ocs.com.au>
>> 
>> ---
>>  arch/i386/kernel/time_hpet.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> Index: linux-2.6/arch/i386/kernel/time_hpet.c
>> ===================================================================
>> --- linux-2.6.orig/arch/i386/kernel/time_hpet.c
>> +++ linux-2.6/arch/i386/kernel/time_hpet.c
>> @@ -51,7 +51,7 @@ static void hpet_writel(unsigned long d,
>>   */
>>  static void __devinit wait_hpet_tick(void)
>>  {
>> -	unsigned int start_cmp_val, end_cmp_val;
>> +	unsigned volatile int start_cmp_val, end_cmp_val;
>>  
>>  	start_cmp_val = hpet_readl(HPET_T0_CMP);
>>  	do {
>
>When you examine the inlined functions involved, this looks an awful lot
>like http://gcc.gnu.org/bugzilla/show_bug.cgi?id=22278
>
>Perhaps SUSE should fix their gcc instead of working around compiler
>problems in the kernel?

Firstly, the fix for 22278 is included in gcc 4.1.0.

Secondly, I believe that this is a separate problem from bug 22278.
hpet_readl() is correctly using volatile internally, but its result is
being assigned to a pair of normal integers (not declared as volatile).
In the context of wait_hpet_tick, all the variables are unqualified so
gcc is allowed to optimize the comparison away.

The same problem may exist in other parts of arch/i386/kernel/time_hpet.c,
where the return value from hpet_readl() is assigned to a normal
variable.  Nothing in the C standard says that those unqualified
variables should be magically treated as volatile, just because the
original code that extracted the value used volatile.  IOW, time_hpet.c
needs to declare any variables that hold the result of hpet_readl() as
being volatile variables.

