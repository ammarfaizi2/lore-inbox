Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269362AbUJFSqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269362AbUJFSqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUJFSqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:46:09 -0400
Received: from fmr06.intel.com ([134.134.136.7]:62390 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S269362AbUJFSqA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:46:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] S3 suspend/resume with noexec
Date: Wed, 6 Oct 2004 11:28:51 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60030A4229@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] S3 suspend/resume with noexec
Thread-Index: AcSrgdxM7GrFVvPsRpanb6+bnMsZBwAThCOA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Pavel Machek" <pavel@suse.cz>
Cc: <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Oct 2004 18:28:52.0844 (UTC) FILETIME=[54DC92C0:01C4ABD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Pavel Machek [mailto:pavel@suse.cz] 
>Sent: Wednesday, October 06, 2004 1:52 AM
>To: Pallipadi, Venkatesh
>Cc: akpm@osdl.org; Brown, Len; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] S3 suspend/resume with noexec
>
>Hi!
>
>> This patch is required for S3 suspend-resume to work on 
>noexec capable systems.
>> On these systems, we need to save and restore MSR_EFER during
>> suspend-resume.
>
>Hmm, I'm afraid similar patch will be needed for x86-64...

Yes. I am working on that. But, I don't yet have a system to 
test that.

>> --- linux-2.6.9-rc2/arch/i386/power/cpu.c.org	
>2004-09-01 19:05:41.997927104 -0700
>> +++ linux-2.6.9-rc2/arch/i386/power/cpu.c	2004-09-02 
>19:12:54.318407912 -0700
>> @@ -62,6 +62,10 @@ void __save_processor_state(struct saved
>>  	asm volatile ("movl %%cr0, %0" : "=r" (ctxt->cr0));
>>  	asm volatile ("movl %%cr2, %0" : "=r" (ctxt->cr2));
>>  	asm volatile ("movl %%cr3, %0" : "=r" (ctxt->cr3));
>> +#ifdef CONFIG_X86_PAE
>> +	if (cpu_has_pae && cpu_has_nx)
>> +		rdmsr(MSR_EFER, ctxt->efer_lo, ctxt->efer_hi);
>> +#endif
>>  	asm volatile ("movl %%cr4, %0" : "=r" (ctxt->cr4));
>>  }
>
>Are those #ifdefs good idea?


That CONFIG is required. Cpu_has_pae and cpu_has_nx doesn't 
imply that we are using nx. Only when PAE kernel is configured 
and these features are available, we use it.

Looking at the code again, I can remove that CONFIG_X86_PAE,
if I use an additional check for nx_enabled.

>> --- linux-2.6.9-rc2/arch/i386/kernel/acpi/wakeup.S.org	
>2004-09-01 21:02:14.639883944 -0700
>> +++ linux-2.6.9-rc2/arch/i386/kernel/acpi/wakeup.S	
>2004-09-02 21:35:02.791882872 -0700
>> @@ -59,6 +59,20 @@ wakeup_code:
>>  	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
>>  	movl	%eax, %cr3
>>  
>> +	testl	$1, real_efer_save_restore - wakeup_code
>> +	jz	4f
>> +	# restore efer setting
>> +	pushl    %eax
>> +	pushl    %ecx
>> +	pushl    %edx
>> +	movl	real_save_efer_edx - wakeup_code, %edx
>> +	movl	real_save_efer_eax - wakeup_code, %eax
>> +	mov     $0xc0000080, %ecx
>> +	wrmsr
>> +	popl    %edx
>> +	popl    %ecx
>> +	popl    %eax
>> +4:
>>  	# make sure %cr4 is set correctly (features, etc)
>>  	movl	real_save_cr4 - wakeup_code, %eax
>>  	movl	%eax, %cr4
>
>Please analyse surrounding code a bit more. You certainly do not need
>to push %eax, because it is scratch register.

Yes. I saw that eax was not used. But, I thought it is clean to save 
and restore every register that is being touched here. Just in case some

other code around these place starts using those registers in future.

If you think that is unnecessary, I will resend the patch with minimal 
push/pops.

>Is it neccessary to restore efer this soon, btw? We should be running
>from swapper_pg_dir. Does that use nx?

It seems necessary for swapper_pg_dir too as we use nx even for kernel
pages (stack, module, etc).

Thanks,
Venki
