Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbTCETBg>; Wed, 5 Mar 2003 14:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTCETBg>; Wed, 5 Mar 2003 14:01:36 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:33165 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267559AbTCETBa>; Wed, 5 Mar 2003 14:01:30 -0500
Message-ID: <3E665AD7.5030600@wanadoo.fr>
Date: Wed, 05 Mar 2003 20:15:19 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: oprofile-list@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Levon <levon@movementarian.org>
Subject: Re: Oops running oprofile in 2.5.62
References: <3E5DB057.60503@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> This happened while running dbench on 2.5.62.  I haven't seen it before,
> but I thought I'd report it anyway.  I'm using the 0.5 version of the
> userspace tools.
> 
> I'm pretty sure it happened on this line in oprofile_add_sample():
> 	cpu_buf->buffer[cpu_buf->pos].eip = eip;

yes, in the last chunk of code in oprofile_add_sample()

> Unable to handle kernel paging request at virtual address f8c3c000
> c0212022
> *pde = 00000000
> Oops: 0002
> CPU:    13
> EIP:    0060:[<c0212022>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010046
> eax: 40082d94   ebx: 00000340   ecx: 00002000   edx: f8c2c000
                                        ^^^^^^^^

buffer overrrun by one entry (8192 entry by default of 8 bytes
each on x86), potentially oprofile_add_sample() add 3 events
in buffer but the protection at begin of code protect against
two addition not three

The bug is rare because add_sample use three entry in rare case,
and thing are wrong only when cpu_buf->pos == buffer_size - 2
the code is not fixed in 2.5.64, John if you have not already
a patch pending for this can you push it in your tree ?

void oprofile_add_sample(unsigned long eip, unsigned int is_kernel,
	unsigned long event, int cpu)
.....
-	if (cpu_buf->pos > buffer_size - 2) {
+ 
if (cpu_buf->pos > buffer_size - 3) {
		cpu_buf->sample_lost_overflow++;
		goto out;
	}

>>>EIP; c0212022 <oprofile_add_sample+102/128>   <=====
>>
> 
>>>edi; c0310f00 <cpu_buffer+340/800>
>>
> 
> Trace; c02139f0 <ppro_check_ctrs+4c/80>
> Trace; c0213291 <nmi_callback+21/28>
> Trace; c010a1eb <do_nmi+2b/48>
> Trace; c010962e <nmi+1e/30>
> 
> Code;  c0212022 <oprofile_add_sample+102/128>
> 00000000 <_EIP>:
> Code;  c0212022 <oprofile_add_sample+102/128>   <=====
>    0:   89 04 ca                  mov    %eax,(%edx,%ecx,8)   <=====

ecx == cpu_bufffer->pos == buffer_size ... boom ...

regards,
Philippe Elie

