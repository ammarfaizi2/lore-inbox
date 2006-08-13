Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWHMSnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWHMSnL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 14:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWHMSnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 14:43:10 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:46322 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750740AbWHMSnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 14:43:09 -0400
Message-ID: <44DF72E7.8070603@austin.rr.com>
Date: Sun, 13 Aug 2006 13:43:51 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops in close when exiting fsx
References: <200608130455_MC3-1-C7EE-44C7@compuserve.com>
In-Reply-To: <200608130455_MC3-1-C7EE-44C7@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <44DE2EA6.4060809@austin.rr.com>
>
> On Sat, 12 Aug 2006 14:40:22 -0500, Steve French wrote:
>
>   
>> ctl-c exiting fsx after a few hours with 2.6.18-rc4 got the following 
>> oops - anyone recognize it?
>> Although I didn't see cifs symbols on the call stack it is running on a 
>> cifs mount, but it is not
>> one I have seen before.
>>     
>
>   
>> EIP is at __down+0x56/0xc5
>>     
>
>   1a:   8d 43 08                  lea    0x8(%ebx),%eax  <= addr of sema wait queue list_head
>   1d:   8b 48 04                  mov    0x4(%eax),%ecx  <= list->prev
>   20:   8d 54 24 2c               lea    0x2c(%esp),%edx
>   24:   89 50 04                  mov    %edx,0x4(%eax)
>   27:   89 44 24 2c               mov    %eax,0x2c(%esp)
>    0:   89 11                     mov    %edx,(%ecx)   <===== list->prev->next = new
>
> The semaphore's wait queue head is corrupted: 'prev' is 0.
>
>   
>>  [<c1038908>] mempool_free+0x43/0x46
>>  [<c1013678>] default_wake_function+0x0/0xc
>>  [<c132ed37>] __down_failed+0x7/0xc
>>  [<fa2da685>] .text.lock.file+0x87/0x9a [cifs]      <=====
>>  [<c104e807>] __fput+0xab/0x148
>>  [<c104c453>] filp_close+0x4e/0x54
>>  [<c101773a>] put_files_struct+0x64/0xa6
>>  [<c1018581>] do_exit+0x1c7/0x675
>>  [<c10052b0>] do_syscall_trace+0x12b/0x172
>>  [<c1018a8b>] sys_exit_group+0x0/0xd
>>  [<c1002abf>] syscall_call+0x7/0xb
>>     
>
> It came from a lock section in the cifs code.  If you disassemble
> .text.lock.file in cifs.o, at offset 0x87 (or shortly after) you
> will see a jump back to the code that's trying to get the semaphore.
>
>   


Thanks - This is a part of new cifs code recently added to handle posix 
locks (it has not pushed to mainline yet) better

                down(&pSMBFile->lock_sem);
                list_for_each_entry_safe(li, tmp, &pSMBFile->llist, llist) {
                        list_del(&li->llist);
                        kfree(li);
                }
                up(&pSMBFile->lock_sem);


My guess is that there is a path in which the lock_sem is not 
initialized - will trace that.
