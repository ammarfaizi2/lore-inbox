Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267496AbTBFWU4>; Thu, 6 Feb 2003 17:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbTBFWU4>; Thu, 6 Feb 2003 17:20:56 -0500
Received: from franka.aracnet.com ([216.99.193.44]:38106 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267496AbTBFWUu>; Thu, 6 Feb 2003 17:20:50 -0500
Date: Thu, 06 Feb 2003 14:30:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Bottomley <James.Bottomley@steeleye.com>, mikeand@us.ibm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <275930000.1044570608@[10.10.2.4]>
In-Reply-To: <265170000.1044564655@[10.10.2.4]>
References: <20030203233156.39be7770.akpm@digeo.com><167540000.1044346173@[10.10.2.4]> <20030204001709.5e2942e8.akpm@digeo.com><384960000.1044396931@flay> <211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I threw a little bit of debug in there:
> I'd show you the code, except it just ate my root filesystem.
> Likelihood of me doing further research is thus small.


Hmmmm .... did a disassemble of this on a similar machine (see end of email)
data seems to contradict what I was looking at previously ....
not sure what happened, but this set makes much more sense,
as it leads to 13c in the offset ;-)

0xc01c1ac6 <isp1020_intr_handler+486>:  mov    %eax,0x13c(%ebp)
which is drivers/scsi/qlogicisp.c:1051

Cmnd->result = isp1020_return_status(sts);

seemingly Cmnd is null ... this is in 
        while (out_ptr != in_ptr) {
                u_int cmd_slot;

                sts = (struct Status_Entry *) &hostdata->res_cpu[out_ptr];
                out_ptr = (out_ptr + 1) & RES_QUEUE_LEN;

                cmd_slot = sts->handle;
                Cmnd = hostdata->cmd_slots[cmd_slot];
                hostdata->cmd_slots[cmd_slot] = NULL;

                TRACE("done", out_ptr, Cmnd);

                if (le16_to_cpu(sts->completion_status) == CS_RESET_OCCURRED
                    || le16_to_cpu(sts->completion_status) == CS_ABORTED
                    || (le16_to_cpu(sts->status_flags) & STF_BUS_RESET))
                        hostdata->send_marker = 1;

                if (le16_to_cpu(sts->state_flags) & SF_GOT_SENSE)
                        memcpy(Cmnd->sense_buffer, sts->req_sense_data,
                               sizeof(Cmnd->sense_buffer));

                DEBUG_INTR(isp1020_print_status_entry(sts));

                if (sts->hdr.entry_type == ENTRY_STATUS)
                        Cmnd->result = isp1020_return_status(sts);
                else
                        Cmnd->result = DID_ERROR << 16;

                if (Cmnd->use_sg)
                        pci_unmap_sg(hostdata->pci_dev,
                                     (struct scatterlist *)Cmnd->buffer,
                                     Cmnd->use_sg,
                                     scsi_to_pci_dma_dir(Cmnd->sc_data_direction));
                else if (Cmnd->request_bufflen)
                        pci_unmap_single(hostdata->pci_dev,
#ifdef CONFIG_QL_ISP_A64
                                         (dma_addr_t)((long)Cmnd->SCp.ptr),
#else
                                         (u32)((long)Cmnd->SCp.ptr),
#endif
                                         Cmnd->request_bufflen,
                                         scsi_to_pci_dma_dir(Cmnd->sc_data_direction));

                isp_outw(out_ptr, host, MBOX5);
                (*Cmnd->scsi_done)(Cmnd);
        }

Changes in this patch to qlogicisp.c were as below. Looks suspciciously
close to the problem area to me, but I don't understand it enough to
say for sure (if this wasn't related to some SCSI subsystem change, 
can I just revert out this section?)

M.

#       drivers/scsi/qlogicisp.c        1.15    -> 1.17   
diff -Nru a/drivers/scsi/qlogicisp.c b/drivers/scsi/qlogicisp.c
--- a/drivers/scsi/qlogicisp.c  Mon Feb  3 21:31:47 2003
+++ b/drivers/scsi/qlogicisp.c  Mon Feb  3 21:31:47 2003
@@ -802,7 +802,7 @@
 
        ENTER("isp1020_queuecommand");
 
-       host = Cmnd->host;
+       host = Cmnd->device->host;
        hostdata = (struct isp1020_hostdata *) host->hostdata;
        Cmnd->scsi_done = done;
 
@@ -853,8 +853,8 @@
        cmd->hdr.entry_type = ENTRY_COMMAND;
        cmd->hdr.entry_cnt = 1;
 
-       cmd->target_lun = Cmnd->lun;
-       cmd->target_id = Cmnd->target;
+       cmd->target_lun = Cmnd->device->lun;
+       cmd->target_id = Cmnd->device->id;
        cmd->cdb_length = cpu_to_le16(Cmnd->cmd_len);
        cmd->control_flags = cpu_to_le16(CFLAG_READ | CFLAG_WRITE);
        cmd->time_out = cpu_to_le16(30);
@@ -1175,7 +1175,7 @@
 
        ENTER("isp1020_abort");
 
-       host = Cmnd->host;
+       host = Cmnd->device->host;
        hostdata = (struct isp1020_hostdata *) host->hostdata;
 
        for (i = 0; i < QLOGICISP_REQ_QUEUE_LEN + 1; i++)
@@ -1186,7 +1186,7 @@
        isp1020_disable_irqs(host);
 
        param[0] = MBOX_ABORT;
-       param[1] = (((u_short) Cmnd->target) << 8) | Cmnd->lun;
+       param[1] = (((u_short) Cmnd->device->id) << 8) | Cmnd->device->lun;
        param[2] = cmd_cookie >> 16;
        param[3] = cmd_cookie & 0xffff;
 
@@ -1214,7 +1214,7 @@
 
        ENTER("isp1020_reset");
 
-       host = Cmnd->host;
+       host = Cmnd->device->host;
        hostdata = (struct isp1020_hostdata *) host->hostdata;
 
        param[0] = MBOX_BUS_RESET;


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

Dump of assembler code for function isp1020_intr_handler:
0xc01c18e0 <isp1020_intr_handler>:      sub    $0x10,%esp
0xc01c18e3 <isp1020_intr_handler+3>:    push   %ebp
0xc01c18e4 <isp1020_intr_handler+4>:    push   %edi
0xc01c18e5 <isp1020_intr_handler+5>:    push   %esi
0xc01c18e6 <isp1020_intr_handler+6>:    push   %ebx
0xc01c18e7 <isp1020_intr_handler+7>:    mov    0x28(%esp,1),%eax
0xc01c18eb <isp1020_intr_handler+11>:   mov    %eax,0x1c(%esp,1)
0xc01c18ef <isp1020_intr_handler+15>:   mov    0x1c(%esp,1),%edx
0xc01c18f3 <isp1020_intr_handler+19>:   add    $0x9c,%eax
0xc01c18f8 <isp1020_intr_handler+24>:   mov    %eax,0x18(%esp,1)
0xc01c18fc <isp1020_intr_handler+28>:   mov    0x9c(%edx),%eax
0xc01c1902 <isp1020_intr_handler+34>:   test   %eax,%eax
0xc01c1904 <isp1020_intr_handler+36>:
    je     0xc01c1910 <isp1020_intr_handler+48>
0xc01c1906 <isp1020_intr_handler+38>:   movzwl 0xa(%eax),%eax
0xc01c190a <isp1020_intr_handler+42>:
    jmp    0xc01c191c <isp1020_intr_handler+60>
0xc01c190c <isp1020_intr_handler+44>:   lea    0x0(%esi,1),%esi
0xc01c1910 <isp1020_intr_handler+48>:   mov    0x1c(%esp,1),%eax
0xc01c1914 <isp1020_intr_handler+52>:   mov    0x6c(%eax),%edx
0xc01c1917 <isp1020_intr_handler+55>:   add    $0xa,%edx
0xc01c191a <isp1020_intr_handler+58>:   in     (%dx),%ax
0xc01c191c <isp1020_intr_handler+60>:   test   $0x4,%al
0xc01c191e <isp1020_intr_handler+62>:
    je     0xc01c1b66 <isp1020_intr_handler+646>
0xc01c1924 <isp1020_intr_handler+68>:   mov    0x1c(%esp,1),%edx
0xc01c1928 <isp1020_intr_handler+72>:   mov    0x9c(%edx),%eax
0xc01c192e <isp1020_intr_handler+78>:   test   %eax,%eax
0xc01c1930 <isp1020_intr_handler+80>:
    je     0xc01c1938 <isp1020_intr_handler+88>
0xc01c1932 <isp1020_intr_handler+82>:   movzwl 0x7a(%eax),%eax
0xc01c1936 <isp1020_intr_handler+86>:
    jmp    0xc01c1944 <isp1020_intr_handler+100>
0xc01c1938 <isp1020_intr_handler+88>:   mov    0x1c(%esp,1),%eax
0xc01c193c <isp1020_intr_handler+92>:   mov    0x6c(%eax),%edx
0xc01c193f <isp1020_intr_handler+95>:   add    $0x7a,%edx
0xc01c1942 <isp1020_intr_handler+98>:   in     (%dx),%ax
0xc01c1944 <isp1020_intr_handler+100>:  mov    0x1c(%esp,1),%edx
0xc01c1948 <isp1020_intr_handler+104>:  movzwl %ax,%eax
0xc01c194b <isp1020_intr_handler+107>:  mov    %eax,0x14(%esp,1)
0xc01c194f <isp1020_intr_handler+111>:  mov    $0x7000,%ecx
0xc01c1954 <isp1020_intr_handler+116>:  mov    0x9c(%edx),%eax
0xc01c195a <isp1020_intr_handler+122>:  test   %eax,%eax
0xc01c195c <isp1020_intr_handler+124>:
    je     0xc01c1967 <isp1020_intr_handler+135>
0xc01c195e <isp1020_intr_handler+126>:  mov    %cx,0xc0(%eax)
0xc01c1965 <isp1020_intr_handler+133>:
    jmp    0xc01c1978 <isp1020_intr_handler+152>
0xc01c1967 <isp1020_intr_handler+135>:  mov    0x1c(%esp,1),%eax
0xc01c196b <isp1020_intr_handler+139>:  mov    0x6c(%eax),%edx
0xc01c196e <isp1020_intr_handler+142>:  add    $0xc0,%edx
0xc01c1974 <isp1020_intr_handler+148>:  mov    %ecx,%eax
0xc01c1976 <isp1020_intr_handler+150>:  out    %ax,(%dx)
0xc01c1978 <isp1020_intr_handler+152>:  mov    0x1c(%esp,1),%edx
0xc01c197c <isp1020_intr_handler+156>:  mov    0x9c(%edx),%eax
0xc01c1982 <isp1020_intr_handler+162>:  test   %eax,%eax
0xc01c1984 <isp1020_intr_handler+164>:
    je     0xc01c1990 <isp1020_intr_handler+176>
0xc01c1986 <isp1020_intr_handler+166>:  movzwl 0xc(%eax),%eax
0xc01c198a <isp1020_intr_handler+170>:
    jmp    0xc01c199c <isp1020_intr_handler+188>
0xc01c198c <isp1020_intr_handler+172>:  lea    0x0(%esi,1),%esi
0xc01c1990 <isp1020_intr_handler+176>:  mov    0x1c(%esp,1),%eax
0xc01c1994 <isp1020_intr_handler+180>:  mov    0x6c(%eax),%edx
0xc01c1997 <isp1020_intr_handler+183>:  add    $0xc,%edx
0xc01c199a <isp1020_intr_handler+186>:  in     (%dx),%ax
0xc01c199c <isp1020_intr_handler+188>:  test   $0x1,%al
0xc01c199e <isp1020_intr_handler+190>:
    je     0xc01c1a34 <isp1020_intr_handler+340>
0xc01c19a4 <isp1020_intr_handler+196>:  mov    0x1c(%esp,1),%edx
0xc01c19a8 <isp1020_intr_handler+200>:  mov    0x9c(%edx),%eax
0xc01c19ae <isp1020_intr_handler+206>:  test   %eax,%eax
0xc01c19b0 <isp1020_intr_handler+208>:
    je     0xc01c19b8 <isp1020_intr_handler+216>
0xc01c19b2 <isp1020_intr_handler+210>:  movzwl 0x70(%eax),%eax
0xc01c19b6 <isp1020_intr_handler+214>:
    jmp    0xc01c19c4 <isp1020_intr_handler+228>
0xc01c19b8 <isp1020_intr_handler+216>:  mov    0x1c(%esp,1),%eax
0xc01c19bc <isp1020_intr_handler+220>:  mov    0x6c(%eax),%edx
0xc01c19bf <isp1020_intr_handler+223>:  add    $0x70,%edx
0xc01c19c2 <isp1020_intr_handler+226>:  in     (%dx),%ax
0xc01c19c4 <isp1020_intr_handler+228>:  movzwl %ax,%eax
0xc01c19c7 <isp1020_intr_handler+231>:  cmp    $0x4006,%eax
0xc01c19cc <isp1020_intr_handler+236>:
    jg     0xc01c19e5 <isp1020_intr_handler+261>
0xc01c19ce <isp1020_intr_handler+238>:  cmp    $0x4005,%eax
0xc01c19d3 <isp1020_intr_handler+243>:
    jge    0xc01c1a03 <isp1020_intr_handler+291>
0xc01c19d5 <isp1020_intr_handler+245>:  cmp    $0x4002,%eax
0xc01c19da <isp1020_intr_handler+250>:
    jg     0xc01c1a10 <isp1020_intr_handler+304>
0xc01c19dc <isp1020_intr_handler+252>:  cmp    $0x4001,%eax
0xc01c19e1 <isp1020_intr_handler+257>:
    jl     0xc01c1a10 <isp1020_intr_handler+304>
0xc01c19e3 <isp1020_intr_handler+259>:
    jmp    0xc01c1a03 <isp1020_intr_handler+291>
0xc01c19e5 <isp1020_intr_handler+261>:  cmp    $0x8001,%eax
0xc01c19ea <isp1020_intr_handler+266>:
    je     0xc01c19f3 <isp1020_intr_handler+275>
0xc01c19ec <isp1020_intr_handler+268>:  cmp    $0x8006,%eax
0xc01c19f1 <isp1020_intr_handler+273>:
    jne    0xc01c1a10 <isp1020_intr_handler+304>
0xc01c19f3 <isp1020_intr_handler+275>:  mov    0x18(%esp,1),%edx
0xc01c19f7 <isp1020_intr_handler+279>:  movl   $0x1,0xf8(%edx)
0xc01c1a01 <isp1020_intr_handler+289>:
    jmp    0xc01c1a10 <isp1020_intr_handler+304>
0xc01c1a03 <isp1020_intr_handler+291>:  push   $0xc0246f20
0xc01c1a08 <isp1020_intr_handler+296>:  call   0xc0119bd8 <printk>
0xc01c1a0d <isp1020_intr_handler+301>:  add    $0x4,%esp
0xc01c1a10 <isp1020_intr_handler+304>:  mov    0x1c(%esp,1),%edx
0xc01c1a14 <isp1020_intr_handler+308>:  mov    0x9c(%edx),%eax
0xc01c1a1a <isp1020_intr_handler+314>:  test   %eax,%eax
0xc01c1a1c <isp1020_intr_handler+316>:
    je     0xc01c1a26 <isp1020_intr_handler+326>
0xc01c1a1e <isp1020_intr_handler+318>:  movw   $0x0,0xc(%eax)
0xc01c1a24 <isp1020_intr_handler+324>:
    jmp    0xc01c1a34 <isp1020_intr_handler+340>
0xc01c1a26 <isp1020_intr_handler+326>:  mov    0x1c(%esp,1),%eax
0xc01c1a2a <isp1020_intr_handler+330>:  mov    0x6c(%eax),%edx
0xc01c1a2d <isp1020_intr_handler+333>:  add    $0xc,%edx
0xc01c1a30 <isp1020_intr_handler+336>:  xor    %eax,%eax
0xc01c1a32 <isp1020_intr_handler+338>:  out    %ax,(%dx)
0xc01c1a34 <isp1020_intr_handler+340>:  mov    0x18(%esp,1),%edx
0xc01c1a38 <isp1020_intr_handler+344>:  mov    0x14(%esp,1),%eax
0xc01c1a3c <isp1020_intr_handler+348>:  mov    0xf4(%edx),%edx
0xc01c1a42 <isp1020_intr_handler+354>:  mov    %edx,0x10(%esp,1)
0xc01c1a46 <isp1020_intr_handler+358>:  cmp    %eax,%edx
0xc01c1a48 <isp1020_intr_handler+360>:
    je     0xc01c1b58 <isp1020_intr_handler+632>
0xc01c1a4e <isp1020_intr_handler+366>:  mov    %esi,%esi
0xc01c1a50 <isp1020_intr_handler+368>:  mov    0x10(%esp,1),%ebx
0xc01c1a54 <isp1020_intr_handler+372>:  mov    0x18(%esp,1),%edx
0xc01c1a58 <isp1020_intr_handler+376>:  mov    0x18(%esp,1),%eax
0xc01c1a5c <isp1020_intr_handler+380>:  shl    $0x6,%ebx
0xc01c1a5f <isp1020_intr_handler+383>:  add    $0xfc,%eax
0xc01c1a64 <isp1020_intr_handler+388>:  add    0xe8(%edx),%ebx
0xc01c1a6a <isp1020_intr_handler+394>:  incl   0x10(%esp,1)
0xc01c1a6e <isp1020_intr_handler+398>:  andl   $0x7,0x10(%esp,1)
0xc01c1a73 <isp1020_intr_handler+403>:  mov    0x4(%ebx),%edx
0xc01c1a76 <isp1020_intr_handler+406>:  shl    $0x2,%edx
0xc01c1a79 <isp1020_intr_handler+409>:  mov    (%edx,%eax,1),%ebp
0xc01c1a7c <isp1020_intr_handler+412>:  movl   $0x0,(%edx,%eax,1)
0xc01c1a83 <isp1020_intr_handler+419>:  movzwl 0xa(%ebx),%eax
0xc01c1a87 <isp1020_intr_handler+423>:  add    $0xfffffffc,%ax
0xc01c1a8b <isp1020_intr_handler+427>:  cmp    $0x1,%ax
0xc01c1a8f <isp1020_intr_handler+431>:
    jbe    0xc01c1a97 <isp1020_intr_handler+439>
0xc01c1a91 <isp1020_intr_handler+433>:  testb  $0x8,0xe(%ebx)
0xc01c1a95 <isp1020_intr_handler+437>:
    je     0xc01c1aa5 <isp1020_intr_handler+453>
0xc01c1a97 <isp1020_intr_handler+439>:  mov    0x18(%esp,1),%eax
0xc01c1a9b <isp1020_intr_handler+443>:  movl   $0x1,0xf8(%eax)
0xc01c1aa5 <isp1020_intr_handler+453>:  testb  $0x20,0xd(%ebx)
0xc01c1aa9 <isp1020_intr_handler+457>:
    je     0xc01c1abb <isp1020_intr_handler+475>
0xc01c1aab <isp1020_intr_handler+459>:  lea    0xc0(%ebp),%edi
0xc01c1ab1 <isp1020_intr_handler+465>:  lea    0x20(%ebx),%esi
0xc01c1ab4 <isp1020_intr_handler+468>:  mov    $0x10,%ecx
0xc01c1ab9 <isp1020_intr_handler+473>:  repz movsl %ds:(%esi),%es:(%edi)
0xc01c1abb <isp1020_intr_handler+475>:  cmpb   $0x3,(%ebx)
0xc01c1abe <isp1020_intr_handler+478>:
    jne    0xc01c1ad1 <isp1020_intr_handler+497>
0xc01c1ac0 <isp1020_intr_handler+480>:  push   %ebx
0xc01c1ac1 <isp1020_intr_handler+481>:
    call   0xc01c1b70 <isp1020_return_status>
0xc01c1ac6 <isp1020_intr_handler+486>:  mov    %eax,0x13c(%ebp)
0xc01c1acc <isp1020_intr_handler+492>:  add    $0x4,%esp
0xc01c1acf <isp1020_intr_handler+495>:
    jmp    0xc01c1adb <isp1020_intr_handler+507>
0xc01c1ad1 <isp1020_intr_handler+497>:  movl   $0x70000,0x13c(%ebp)
0xc01c1adb <isp1020_intr_handler+507>:  cmpw   $0x0,0x9e(%ebp)
0xc01c1ae3 <isp1020_intr_handler+515>:
    je     0xc01c1af5 <isp1020_intr_handler+533>
0xc01c1ae5 <isp1020_intr_handler+517>:  cmpb   $0x3,0x52(%ebp)
0xc01c1ae9 <isp1020_intr_handler+521>:
    jne    0xc01c1b10 <isp1020_intr_handler+560>
0xc01c1aeb <isp1020_intr_handler+523>:  ud2a   
0xc01c1aed <isp1020_intr_handler+525>:  inc    %ebp
0xc01c1aee <isp1020_intr_handler+526>:  add    %ch,%bl
0xc01c1af0 <isp1020_intr_handler+528>:  out    %al,(%dx)
0xc01c1af1 <isp1020_intr_handler+529>:  and    %eax,%eax
0xc01c1af3 <isp1020_intr_handler+531>:
    jmp    0xc01c1b10 <isp1020_intr_handler+560>
0xc01c1af5 <isp1020_intr_handler+533>:  cmpl   $0x0,0x64(%ebp)
0xc01c1af9 <isp1020_intr_handler+537>:
    je     0xc01c1b10 <isp1020_intr_handler+560>
0xc01c1afb <isp1020_intr_handler+539>:  cmpb   $0x3,0x52(%ebp)
0xc01c1aff <isp1020_intr_handler+543>:
    jne    0xc01c1b10 <isp1020_intr_handler+560>
0xc01c1b01 <isp1020_intr_handler+545>:  ud2a   
0xc01c1b03 <isp1020_intr_handler+547>:  sbb    $0x0,%al
0xc01c1b05 <isp1020_intr_handler+549>:
    jmp    0xc01c1af5 <isp1020_intr_handler+533>
0xc01c1b07 <isp1020_intr_handler+551>:  and    %eax,%eax
0xc01c1b09 <isp1020_intr_handler+553>:  lea    0x0(%esi,1),%esi
0xc01c1b10 <isp1020_intr_handler+560>:  mov    0x1c(%esp,1),%edx
0xc01c1b14 <isp1020_intr_handler+564>:  mov    0x10(%esp,1),%ecx
0xc01c1b18 <isp1020_intr_handler+568>:  mov    0x9c(%edx),%eax
0xc01c1b1e <isp1020_intr_handler+574>:  test   %eax,%eax
0xc01c1b20 <isp1020_intr_handler+576>:
    je     0xc01c1b30 <isp1020_intr_handler+592>
0xc01c1b22 <isp1020_intr_handler+578>:  mov    %ecx,%edx
0xc01c1b24 <isp1020_intr_handler+580>:  mov    %dx,0x7a(%eax)
0xc01c1b28 <isp1020_intr_handler+584>:
    jmp    0xc01c1b3e <isp1020_intr_handler+606>
0xc01c1b2a <isp1020_intr_handler+586>:  lea    0x0(%esi),%esi
0xc01c1b30 <isp1020_intr_handler+592>:  mov    0x1c(%esp,1),%eax
0xc01c1b34 <isp1020_intr_handler+596>:  mov    0x6c(%eax),%edx
0xc01c1b37 <isp1020_intr_handler+599>:  add    $0x7a,%edx
0xc01c1b3a <isp1020_intr_handler+602>:  mov    %ecx,%eax
0xc01c1b3c <isp1020_intr_handler+604>:  out    %ax,(%dx)
0xc01c1b3e <isp1020_intr_handler+606>:  push   %ebp
0xc01c1b3f <isp1020_intr_handler+607>:  mov    0x108(%ebp),%eax
0xc01c1b45 <isp1020_intr_handler+613>:  call   *%eax
0xc01c1b47 <isp1020_intr_handler+615>:  add    $0x4,%esp
0xc01c1b4a <isp1020_intr_handler+618>:  mov    0x14(%esp,1),%edx
0xc01c1b4e <isp1020_intr_handler+622>:  cmp    %edx,0x10(%esp,1)
0xc01c1b52 <isp1020_intr_handler+626>:
    jne    0xc01c1a50 <isp1020_intr_handler+368>
0xc01c1b58 <isp1020_intr_handler+632>:  mov    0x10(%esp,1),%edx
0xc01c1b5c <isp1020_intr_handler+636>:  mov    0x18(%esp,1),%eax
0xc01c1b60 <isp1020_intr_handler+640>:  mov    %edx,0xf4(%eax)
0xc01c1b66 <isp1020_intr_handler+646>:  pop    %ebx
0xc01c1b67 <isp1020_intr_handler+647>:  pop    %esi
0xc01c1b68 <isp1020_intr_handler+648>:  pop    %edi
0xc01c1b69 <isp1020_intr_handler+649>:  pop    %ebp
0xc01c1b6a <isp1020_intr_handler+650>:  add    $0x10,%esp
0xc01c1b6d <isp1020_intr_handler+653>:  ret    
End of assembler dump.

