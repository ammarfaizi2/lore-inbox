Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVE0GHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVE0GHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVE0GHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:07:33 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19656 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261827AbVE0GHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:07:22 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata slab corruption saga
Date: Fri, 27 May 2005 08:37:11 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200505261032.23758.vda@ilport.com.ua> <42957EFE.2040005@pobox.com>
In-Reply-To: <42957EFE.2040005@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505270837.11695.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 10:47, Jeff Garzik wrote:
> Does the attached patch change things?

Yes. As soon as first ata error occurs:

22:01:59.006541500 kern.err: ata1: command 0x25 timeout, stat 0x50 host_stat 0x1
22:01:59.007252500 kern.alert: Unable to handle kernel paging request at virtual address 6b6b6b6b
22:01:59.008197500 kern.alert:  printing eip:
22:01:59.009304500 kern.info: c03b5d7a
22:01:59.010231500 kern.alert: *pde = 00000000
22:01:59.010919500 kern.alert: Oops: 0000 [#1]
22:01:59.011948500 kern.info: Modules linked in: snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_REDIRECT ipt_MASQUERADE ipt_multiport ipt_state iptable_nat ip_conntrack iptable_filter cls_u32 sch_htb iptable_mangle autofs ip_tables
22:01:59.012521500 kern.info: CPU:    0
22:01:59.013618500 kern.info: EIP:    0060:[<c03b5d7a>]    Not tainted VLI
22:01:59.014569500 kern.info: EFLAGS: 00010202   (2.6.12-rc2-cl)
22:01:59.015709500 kern.info: EIP is at scsi_try_to_abort_cmd+0xa/0x50
22:01:59.016749500 kern.info: eax: 6b6b6b6b   ebx: c19d0460   ecx: c19d0460   edx: c19d0478
22:01:59.017802500 kern.info: esi: c19cffb4   edi: c19cffb4   ebp: c19cff84   esp: c19cff80
22:01:59.018791500 kern.info: ds: 007b   es: 007b   ss: 0068
22:01:59.019865500 kern.info: Process scsi_eh_0 (pid: 478, threadinfo=c19cf000 task=c1968530)
22:01:59.020918500 kern.info: Stack: c19d0460 c19cff9c c03b5eb7 c19d0460 c19d0478 c19cffb4 00000246 c19cffc8
22:01:59.021945500 kern.info:        c03b6a92 c19cffb4 c19cffac c19cffac c19cffac c19d0478 c19d0478 c19cffd4
22:01:59.023051500 kern.info:        dfc1507c 00000000 c19cffec c03b6b16 dfc1507c 00000000 00000000 c19cffdc
22:01:59.023907500 kern.info: Call Trace:
22:01:59.025073500 kern.info:  [<c0103cc5>] show_stack+0x75/0x90
22:01:59.027613500 kern.info:  [<c0103e19>] show_registers+0x119/0x190
22:01:59.028311500 kern.info:  [<c0103ff5>] die+0xb5/0x130
22:01:59.029231500 kern.info:  [<c0110728>] do_page_fault+0x458/0x6d6
22:01:59.030303500 kern.info:  [<c01038ef>] error_code+0x4f/0x60
22:01:59.031213500 kern.info:  [<c03b5eb7>] scsi_eh_abort_cmds+0x37/0x90
22:01:59.032241500 kern.info:  [<c03b6a92>] scsi_invoke_strategy_handler+0xd2/0xf0
22:01:59.033137500 kern.info:  [<c03b6b16>] scsi_error_handler+0x66/0xd0
22:01:59.033840500 kern.info:  [<c0100cc5>] kernel_thread_helper+0x5/0x10
22:01:59.034854500 kern.info: Code: 00 00 00 5d c3 8b 43 38 89 43 34 8b 4d 0c 51 53 e8 1c ff ff ff 58 5a eb 88 90 8d b4 26 00 00 00 00 55 89 e5 8b 4d 08 53 8b 41 04 <8b> 00 8b 40 5c 8b 40 20 85 c0 ba 03 20 00 00 74 23 8b 59 2c 85

We hit use-after-free here:

static int scsi_try_to_abort_cmd(struct scsi_cmnd *scmd)
{
        unsigned long flags;
        int rtn = FAILED;

        if (!scmd->device->host->hostt->eh_abort_handler)
                return rtn;

Seems like struct scsi_cmnd pointed by scmd is filled by slab poisoning pattern:

000007d0 <scsi_try_to_abort_cmd>:
     7d0:       55                      push   %ebp
     7d1:       89 e5                   mov    %esp,%ebp
     7d3:       8b 4d 08                mov    0x8(%ebp),%ecx         ecx = scmd
     7d6:       53                      push   %ebx
     7d7:       8b 41 04                mov    0x4(%ecx),%eax         eax = scmd->device (0x6b6b6b6b6)
     7da:       8b 00                   mov    (%eax),%eax            trying to get scmd->device->host, BOOM
     7dc:       8b 40 5c                mov    0x5c(%eax),%eax
     7df:       8b 40 20                mov    0x20(%eax),%eax        
     7e2:       85 c0                   test   %eax,%eax
     7e4:       ba 03 20 00 00          mov    $0x2003,%edx
     7e9:       74 23                   je     80e <scsi_try_to_abort_cmd+0x3e>
--
vda

