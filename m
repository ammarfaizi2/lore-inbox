Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbTAVDcG>; Tue, 21 Jan 2003 22:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267291AbTAVDcG>; Tue, 21 Jan 2003 22:32:06 -0500
Received: from c24.159.193.39.roc.mn.charter.com ([24.159.193.39]:180 "HELO
	rochester1.roc.mn.charter.com") by vger.kernel.org with SMTP
	id <S267289AbTAVDcF>; Tue, 21 Jan 2003 22:32:05 -0500
Message-ID: <3E2E12D7.4060707@charter.net>
Date: Tue, 21 Jan 2003 21:41:11 -0600
From: Brian King <brking@charter.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS in idescsi_end_request
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While burning a CD tonight I ended up taking an oops on my system. I had 
the lkcd patch applied to my 2.4.19 kernel, so I was able to look at the 
  oops after my system rebooted. After digging into it a little and 
looking at the ide-scsi code I think I found the problem but am not 
sure. How can idescsi_reset simply return SCSI_RESET_SUCCESS to the scsi 
mid layer? I think what is happening is that a command times out, 
idescsi_abort is called, which returns SCSI_ABORT_SNOOZE. Later on 
idescsi_reset gets called, which returns SCSI_RESET_SUCCESS. At this 
point the scsi mid-layer owns the scsi_cmnd and returns the failure back 
up the chain. Later on, the command gets run through 
idescsi_end_request, which then tries to access the scsi_cmnd structure 
which is it no longer owns.

Any help is appreciated. I have a complete lkcd dump of the failure if 
anyone would like more information...

-Brian King


Here is the last bit in the log buffer:

     <4>scsi : aborting command due to timeout : pid 2534304, scsi0, 
channel 0, id 1, lun 0 Write (10) 00 00 01 1e 91 00 00 1b 00
     <4>hdk: timeout waiting for DMA
     <4>ide_dmaproc: chipset supported ide_dma_timeout func only: 14
     <4>hdk: status timeout: status=0xd8 { Busy }
     <4>hdk: drive not ready for command
     <4>hdk: ATAPI reset complete
     <4>hdk: irq timeout: status=0x80 { Busy }
     <4>hdk: ATAPI reset complete
     <4>hdk: irq timeout: status=0x80 { Busy }
     <1>Unable to handle kernel NULL pointer dereference at virtual 
address 00000184
     <4> printing eip:
     <4>e0fd22f1
     <1>*pde = 00000000
     <4>Oops: 0002
     <4>CPU:    0
     <4>EIP:    0010:[<e0fd22f1>]    Tainted: PF
     <4>EFLAGS: 00010046
     <4>eax: 00000000   ebx: 00000000   ecx: dfef8000   edx: c75bcbc0
     <4>esi: 00000080   edi: c0491938   ebp: d5908000   esp: c0435ea4
     <4>ds: 0018   es: 0018   ss: 0018
     <4>Process swapper (pid: 0, stackpage=c0435000)
     <4>Stack: c0491938 00000000 00000000 c0491938 00000088 000001f4 
c03349e2 c75bcbc0
     <4>       ce0a3b80 c0491938 00000080 00000080 c75bcbc0 c0222d6c 
00000000 c1671580
     <4>       00000080 c04918f4 c0491938 c0434000 c1671580 e0fd2550 
c0223b30 c0491938
     <4>Call Trace:    [<c0222d6c>] [<e0fd2550>] [<c0223b30>] 
[<c0223990>] [<c0127af0>]
     <4>  [<c01233d4>] [<c01232a6>] [<c01230ed>] [<c010a97f>] 
[<c010d173>] [<c0106f80>]
     <4>  [<c0106fa3>] [<c0107012>] [<c0105000>]
     <4>
     <4>Code: c7 80 84 01 00 00 00 00 07 00 75 72 9c 5e fa bb 00 e0 ff ff


 From lkcd:

================================================================
STACK TRACE FOR TASK: 0xc0434000 (swapper)

  0 [ide-scsi]idescsi_end_request+129 [0xe0fd22f1]
TRACE ERROR 0x800000000
================================================================



