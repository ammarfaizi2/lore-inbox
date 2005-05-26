Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVEZHkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVEZHkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVEZHkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:40:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:47492 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261245AbVEZHj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:39:27 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: libata slab corruption saga
Date: Thu, 26 May 2005 10:32:23 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261032.23758.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

Unfortunately it still happens even without IRQ sharing.

2005-05-25_14:54:01.79454 kern.err: ata1: command 0x35 timeout, stat 0x50 host_stat 0x1
2005-05-25_14:54:04.10684 kern.err: Slab corruption: start=c19d02fc, len=344
2005-05-25_14:54:04.10985 kern.err: Redzone: 0x5a2cf071/0x5a2cf071.
2005-05-25_14:54:04.10987 kern.err: Last user: [<c03b29f9>](scsi_put_command+0x49/0x80)
2005-05-25_14:54:04.10989 kern.err: 010: 6b 6b 6b 6b 6b 6b 6b 6b 08 0a 9d c1 6b 6b 6b 6b

It's 'use after free', someone seems to store 4-byte word into offset 0x18.
This word seems to be a kernel pointer (0xc19d0a08).

I may be mistaken, but I think it is a scsi_cmnd.eh_entry.next.
It seems that scsi_cmnd was freed (see below) and scsi_cmnd offset 0x18
is eh_entry:

struct list_head {
         struct list_head *next, *prev;
};

struct scsi_cmnd {
        int     sc_magic;
        struct scsi_device *device;
        unsigned short state;
        unsigned short owner;
        struct scsi_request *sc_request;
        struct list_head list;  /* scsi_cmnd participates in queue lists */
        struct list_head eh_entry; /* entry for the host eh_cmd_q */

2005-05-25_14:54:04.10991 kern.err: Prev obj: start=c19d0198, len=344
2005-05-25_14:54:04.10993 kern.err: Redzone: 0x5a2cf071/0x5a2cf071.
2005-05-25_14:54:04.10995 kern.err: Last user: [<c03b29f9>](scsi_put_command+0x49/0x80)
2005-05-25_14:54:04.10996 kern.err: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
2005-05-25_14:54:04.10998 kern.err: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
2005-05-25_14:54:04.11002 kern.err: Next obj: start=c19d0460, len=344
2005-05-25_14:54:04.11004 kern.err: Redzone: 0x5a2cf071/0x5a2cf071.
2005-05-25_14:54:04.11006 kern.err: Last user: [<c03b29f9>](scsi_put_command+0x49/0x80)
2005-05-25_14:54:04.11007 kern.err: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
2005-05-25_14:54:04.11009 kern.err: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

Looks like "Last user scsi_put_command+0x49" corresponds to list_empty(),
although asm output is a bit strange. Judge for yourself:

void scsi_put_command(struct scsi_cmnd *cmd)
{
        struct scsi_device *sdev = cmd->device;
        struct Scsi_Host *shost = sdev->host;
        unsigned long flags;

        /* serious error if the command hasn't come from a device list */
        spin_lock_irqsave(&cmd->device->list_lock, flags);
        BUG_ON(list_empty(&cmd->list));
        list_del_init(&cmd->list);
        spin_unlock(&cmd->device->list_lock);
        /* changing locks here, don't need to restore the irq state */
        spin_lock(&shost->free_list_lock);
asm("#0");
        if (unlikely(list_empty(&shost->free_list))) {   <==============
asm("#1");
                list_add(&cmd->list, &shost->free_list);
                cmd = NULL;
        }
        spin_unlock_irqrestore(&shost->free_list_lock, flags);

        if (likely(cmd != NULL))
                kmem_cache_free(shost->cmd_pool->slab, cmd);

        put_device(&sdev->sdev_gendev);
}

Corresponding asm:

#APP
        #0
#NO_APP
        leal    20(%esi), %edx
        movl    20(%esi), %eax
        cmpl    %edx, %eax
        je      .L132
.L127:
#APP
        pushl %edi ; popfl
#NO_APP
        testl   %ebx, %ebx
        je      .L130
        pushl   %ebx
        movl    16(%esi), %eax
        movl    (%eax), %ecx
        pushl   %ecx
        call    kmem_cache_free
        popl    %eax    <========================== scsi_put_command+0x49
        popl    %edx
.L130:
        movl    -16(%ebp), %eax
        addl    $400, %eax
        movl    %eax, 8(%ebp)
        leal    -12(%ebp), %esp
        popl    %ebx
        popl    %esi
        popl    %edi
        popl    %ebp
        jmp     put_device
.L132:
#APP
        #1
#NO_APP

Hope this helps.
--
vda

