Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267627AbTBFUli>; Thu, 6 Feb 2003 15:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTBFUli>; Thu, 6 Feb 2003 15:41:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:24210 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267627AbTBFUlg>; Thu, 6 Feb 2003 15:41:36 -0500
Date: Thu, 06 Feb 2003 12:50:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Bottomley <James.Bottomley@steeleye.com>, mikeand@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <265170000.1044564655@[10.10.2.4]>
In-Reply-To: <211570000.1044508407@[10.10.2.4]>
References: <20030203233156.39be7770.akpm@digeo.com><167540000.1044346173@[10.10.2.4]> <20030204001709.5e2942e8.akpm@digeo.com><384960000.1044396931@flay> <211570000.1044508407@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I threw a little bit of debug in there:
I'd show you the code, except it just ate my root filesystem.
Likelihood of me doing further research is thus small.

At the start of isp1020_intr_handler it basically checked if host, hostdata,
memaddr, or memaddr+MBOX5 was < 0xC0000000UL, and printk'ed if so.
It didn't printk

at first interrupt:

isp1020_intr_handler: host=f7c52800, hostdata=f7c5289c, memaddr=f8802000, MBOX5=0000007a, readaddr = f880207a

then later it panic'ed without hitting the debug (or at least no printk)

Unable to handle kernel NULL pointer dereference at virtual address 0000013c
 printing eip:
c01c19f6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c01c19f6>]    Not tainted
EFLAGS: 00010046
EIP is at isp1020_intr_handler+0x256/0x300
eax: 00000000   ebx: f7c42100   ecx: 00000000   edx: 00000080
esi: 00000002   edi: 00000013   ebp: 00000000   esp: c02aff20
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c02ae000 task=c0260140)
Stack: f7c42100 f7c52800 00000002 00000013 c02affa4 00000005 00000005 f7c5289c 
       f7c52800 c01c1791 00000013 f7c52800 c02affa4 f7ffe1e0 24000001 c010a815 
       00000013 f7c52800 c02affa4 c028fa60 00000260 00000013 c02aff9c c010a9e6 
Call Trace:
 [<c01c1791>] do_isp1020_intr_handler+0x25/0x34
 [<c010a815>] handle_IRQ_event+0x29/0x4c
 [<c010a9e6>] do_IRQ+0x96/0x100
 [<c0106ca0>] default_idle+0x0/0x34
 [<c0105000>] _stext+0x0/0x48
 [<c01094a8>] common_interrupt+0x18/0x20
 [<c0106ca0>] default_idle+0x0/0x34
 [<c0105000>] _stext+0x0/0x48
 [<c0106cc9>] default_idle+0x29/0x34
 [<c0106d53>] cpu_idle+0x37/0x48
 [<c0105045>] _stext+0x45/0x48

Code: 89 85 3c 01 00 00 83 c4 04 eb 0a c7 85 3c 01 00 00 00 00 07 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--On Wednesday, February 05, 2003 21:13:28 -0800 "Martin J. Bligh" <mbligh@aracnet.com> wrote:

>>> There are a lot of scsi updates in Linus's tree.  Can you please
>>> test just
>>> 
>>> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm8/broken-o
>>> ut/linus.patch
>> 
>> Yup, the SCSI code in Linus' tree has broken since 2.5.59.
>> I reproduced this on my 4-way SMP machine (panic from that below), 
>> so it's not just NUMA-Q wierdness ;-)
>> 
>> M.
> 
> elm3b13:~/linux/2.5.59-linus# addr2line -e vmlinux c01c1986
> /root/linux/2.5.59-linus/drivers/scsi/qlogicisp.c:632
> 
> which is the readw of:
> 
> static inline u_short isp_inw(struct Scsi_Host *host, long offset)
> {
>         struct isp1020_hostdata *h = (struct isp1020_hostdata
> *)host->hostdata;
>         if (h->memaddr)
>                 return readw(h->memaddr + offset);
>         else
>                 return inw(host->io_port + offset);
> }
>  
>> Unable to handle kernel NULL pointer dereference at virtual address
>> 0000013c  printing eip:
>> c01c1986
>> *pde = 00000000
>> Oops: 0002
>> CPU:    3
>> EIP:    0060:[<c01c1986>]    Not tainted
>> EFLAGS: 00010046
>> EIP is at isp1020_intr_handler+0x1e6/0x290
>> eax: 00000000   ebx: f7c42080   ecx: 00000000   edx: 00000054
>> esi: 00000002   edi: 00000013   ebp: 00000000   esp: f7f97efc
>> ds: 007b   es: 007b   ss: 0068
>> Process swapper (pid: 0, threadinfo=f7f96000 task=f7f9d240)
>> Stack: f7c42080 f7c52800 00000002 00000013 f7f97f80 00000003 00000003
>> f7c5289c         f7c52800 c01c1791 00000013 f7c52800 f7f97f80 f7ffe1e0
>> 24000001 c010a815         00000013 f7c52800 f7f97f80 c028fa60 00000260
>> 00000013 f7f97f78 c010a9e6  Call Trace:
>>  [<c01c1791>] do_isp1020_intr_handler+0x25/0x34
>>  [<c010a815>] handle_IRQ_event+0x29/0x4c
>>  [<c010a9e6>] do_IRQ+0x96/0x100
>>  [<c0106ca0>] default_idle+0x0/0x34
>>  [<c01094a8>] common_interrupt+0x18/0x20
>>  [<c0106ca0>] default_idle+0x0/0x34
>>  [<c0106cc9>] default_idle+0x29/0x34
>>  [<c0106d53>] cpu_idle+0x37/0x48
>>  [<c0119d21>] printk+0x149/0x160
>> 
>> Code: 89 85 3c 01 00 00 83 c4 04 eb 0a c7 85 3c 01 00 00 00 00 07 
>>  <0>Kernel panic: Aiee, killing interrupt handler!
>> In interrupt handler - not syncing
> 


