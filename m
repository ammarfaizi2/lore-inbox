Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVIVUd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVIVUd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVIVUd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:33:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:45739 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751148AbVIVUd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:33:58 -0400
Message-ID: <43331517.3080800@us.ibm.com>
Date: Thu, 22 Sep 2005 13:33:27 -0700
From: Haren Myneni <haren@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Dave Anderson <anderson@redhat.com>, Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO	tokernel
   core dumps
References: <20050921065633.GC3780@in.ibm.com>	<m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com>	<43317980.D6AEA859@redhat.com>	<m1d5n1cw89.fsf@ebiederm.dsl.xmission.com>	<20050922140824.GF3753@in.ibm.com> <4332C87C.9CE47E8D@redhat.com> <m1zmq5awsn.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1zmq5awsn.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry. Reposting since it did not made to LKML due to my stupid mistake; 
Also posting Dave Anderson's reponse:

Eric W. Biederman wrote:

>Dave Anderson <anderson@redhat.com> writes:
>
>  
>
>>Just flagging the cpu, and then mapping that to the stack pointer found in
>>the associated NT_PRSTATUS register set should work OK too.  It gets
>>a little muddy if it crashed while running on an IRQ stack, but it still can be
>>tracked back from there as well.  (although not if the crashing task overflowed
>>the IRQ stack)
>>    
>>
>
>You can't track it back from the crashing cpu if the IRQ stack overflows
>either.  So I would rather have crash confused when trying to find the
>task_struct.  Then to have the kernel fail avoidably while attempting
>to capture a core dump.  
>
>Even if you overflow the stack wit a bit of detective work it should still
>be possible to show the stack overflowed and correct for it when analyzing
>the crash dump.  Doing anything like that from a crashing cpu (in a
>reliable way) is very hard. 
>
>  
>
>>The task_struct would be ideal though -- if the kernel's use of task_structs
>>changes in the future, well, then crash is going to need a serious re-write
>>anyway...  FWIW, netdump and diskdump use the NT_TASKSTRUCT note
>>note to store just the "current" pointer, and not the whole task_struct itself,
>>which would just be a waste of space in the ELF header for crash's purposes.
>>And looking at the gdb sources, it appears to be totally ignored.  Who
>>uses the NT_TASKSTRUCT note anyway?
>>    
>>
>
>Good question, especially as the kernel exports whatever we have for
>a task struct today in the ELF note.  No ABI compatibility is
>maintained.
>
>Given all of that I recommend an empty NT_TASKSTRUCT to flag the
>crashing cpu, for now.
>  
>
At present /proc/kcore writes the complete task structure for 
NT_TASKSTRUCT note section. Thought it is the standard. Hence created 
separate note section. The other option is the crash tool can directly 
read "crashing_cpu variable" from the vmcore to determine the panic cpu. 
Similarly, we can define panic_task variable in the kernel.

Dave Anderson (anderson@redhat.com) reponse:

" So does elf_core_dump() as well, but to gdb it's useless AFAICT...

Hey -- I wasn't even aware of the "crashing_cpu" variable.  
That would work just fine.

Still a "panic_task", and perhaps even a "crash_page_size" variable
would be nice as well.   No additional notes required...

Dave "

Basically, we can use some global structure in the kernel and dump any 
needed information which we do not need to invoke any analysis tools 
(crash, gdb). Dumping CPU control registers can also be done this way 
without creating separate note section.

Thanks
Haren

>Eric
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>fastboot mailing list
>fastboot@lists.osdl.org
>https://lists.osdl.org/mailman/listinfo/fastboot
>  
>

