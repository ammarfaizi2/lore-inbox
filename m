Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbWGJSVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWGJSVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWGJSVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:21:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37308 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965200AbWGJSVK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:21:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>,
       vgoyal@in.ibm.com, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) - safe_smp_processor_id
References: <1152517852.2120.107.camel@localhost.localdomain>
	<1152540988.7275.7.camel@mulgrave.il.steeleye.com>
Date: Mon, 10 Jul 2006 12:20:07 -0600
In-Reply-To: <1152540988.7275.7.camel@mulgrave.il.steeleye.com> (James
	Bottomley's message of "Mon, 10 Jul 2006 09:16:28 -0500")
Message-ID: <m1irm5nwyw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:

> On Mon, 2006-07-10 at 16:50 +0900, Fernando Luis Vázquez Cao wrote:
>> diff -urNp linux-2.6.18-rc1/include/asm-i386/smp.h
>> linux-2.6.18-rc1-sof/include/asm-i386/smp.h
>> --- linux-2.6.18-rc1/include/asm-i386/smp.h     2006-07-10
>> 11:00:05.000000000 +0900
>> +++ linux-2.6.18-rc1-sof/include/asm-i386/smp.h 2006-07-10
>> 15:34:26.000000000 +0900
>> @@ -89,12 +89,20 @@ static __inline int logical_smp_processo
>>  
>>  #endif
>>  
>> +#ifdef CONFIG_X86_VOYAGER
>> +extern int hard_smp_processor_id(void);
>> +#define safe_smp_processor_id() hard_smp_processor_id()
>> +#else
>> +extern int safe_smp_processor_id(void);
>> +#endif
>> +
>
> Argh, no, don't do this.  The Subarchitecture specific code should never
> appear in the standard include directory (that was about the whole
> point).  The extern for hard_smp_processor_id should just be global,
> since it's common to all architectures, and the voyager specific define
> should be in a voyager specific header file.
>
> As an aside, it shows the problems x86 got itself into with it's
> inconsistent direction of physical vs logical CPUs.  The idea was that
> smp_processor_id() and hard_smp_processor_id() were supposed to return
> the same thing, only hard_... went to the actual SMP registers to get
> it.

I agree that it shows the problem, and that voyager is different from the
rest of the x86 implementations. 

At least for things like the cpumask_t density of processor ids
is still an interesting property.  The basic issue is that apicids are
not in general dense on x86.  Not being able compile with support
for only two cpus because your cpus happen to be apicid 0 and apicid
6 by default is an issue.

To some extent this also shows the mess that the x86 subarch code is
because it is never clear if code is implemented in a subarchitecture
or not.

Fernando can you just put a trivial voyager specific definition of
safe_smp_processor_id in mach-voyager/voyager_smp.c.  It isn't a fast
path so the little extra overhead of making two separate functions
is not an issue and then the generic header doesn't have to have
subarch breakage.  Just a definition of safe_smp_processor_id().

Eric
