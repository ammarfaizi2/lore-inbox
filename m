Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTGHMq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTGHMq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:46:58 -0400
Received: from 65-124-64-15.rdsl.ktc.com ([65.124.64.15]:64436 "EHLO
	csi.csimillwork.com") by vger.kernel.org with ESMTP id S261245AbTGHMql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:46:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: vincent.touquet@pandora.be, linux-kernel@vger.kernel.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Date: Tue, 8 Jul 2003 09:59:54 -0400
User-Agent: KMail/1.4.3
References: <20030706210243.GA25645@lea.ulyssis.org> <20030708101950.GB14044@ns.mine.dnsalias.org>
In-Reply-To: <20030708101950.GB14044@ns.mine.dnsalias.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307080959.54247.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent - 
I wonder if what is really happening is a problem in the in the arbitration 
between the PCI bus and the local bus that the onboard IDE devices are.  In 
your case the problem (onboard IDE device data corruption) manifests when you 
are performing sustained transfers (large files) between the onboard IDE 
device and a PCI block device (the 3ware RAID). In my case, the same problem 
manifests when I have sustained data activity from multiple frame grabbers to 
memory, then from memory to RAID.  When the system drive is used (code load, 
swap, etc.) it gets corrupted.  My point is, the onboard data device only 
seems to get corrupted when there is lots of i/o activity with PCI 
bus-masters that are DMA'ing data to/from memory.  What do you think?


On Tuesday 08 July 2003 06:19 am, Vincent Touquet wrote:
> After my search for what caused my hangs, I decided to wonder if DMA could
> be the culprit. I put ide=nodma in the commandline and the system is still
> not hanging under the copy task (the system hangs when copying from an ide
> disk to a raid array).
>
> Looking at the output of vmstat with dma on:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105759652518028&w=2
>
> You can see that sometimes there are stalls on the blocks in (bi) side
> [reading data from the IDE disk]. Performance is rather 'stellar' with on
> average 20.000 blocks per second input from the ide disk, but sometimes
> this drops to zero. This could be problems with reading from the disk (or
> is the write-out not happening fast enough ?)
>
> Vmstat without dma on the ide disk is much more moderate (reading less
> blocks per second from the ide disk):
>
> Extract from the now ongoing copy process.
>  2  0   3968   9568  20624 915104    0    0  3972     0  605   748  1 51 48
>  0 1  0   3968   9472  20652 915132    0    0  3588 14980  700   795  1 52
> 47  0 0  1   3968   9488  20644 915212    0    0  3972     0  613   751  0
> 48 51  0 1  0   3968   9540  20652 915092    0    0  3972     0  603   756 
> 3 45 51  0 0  1   3968   9564  20668 915036    0    0  4108     0  616  
> 752  0 56 44  0 1  0   3968   9456  20688 915072    0    0  3976     0  605
>   749  2 43 55  0 1  1   3968   9532  20700 914960    0    0  3532 19344 
> 716   873  1 43 56  0 3  0   3968   9460  20712 915100    0    0  3832    
> 4  609   727  3 50 48  0 1  1   3968   9508  20724 915032    0    0  4108  
>   0  601   761  0 48 51  0 0  1   3968   9480  20752 915040    0    0  4112
>     0  613   814  1 52 47  0 0  4   3968   9532  20780 914888    0    0 
> 3720 19316  610   704  3 48 50  0 1  0   3968   9500  20836 914764    0   
> 0  2100    88  535   782  3 33 64  0
>
> There seem to be no stalls on the reader side.
>
> Now the big question is: is dma really at fault here, or are there problems
> on the write-out side ? [if dma is the problem, maybe we should reopen the
> discussion of enabling dma by default ;)]
>
> I think the answer is in the traces near the point were the machine hangs:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105759465915936&w=2
>
> This snippet then again, makes me think there is something wrong on the
> scsi side... Or is the problem with the IDE somehow also disturbing the
> scsi system (PCI bus hang ?).
>
> Jul  7 17:52:52 kalimero kernel: kupdated      D 00000001  5204     7     
> 1         8     6 (L-TLB) Jul  7 17:52:52 kalimero kernel: Call Trace:   
> [__down+192/352]  [log_start_commit+216/256] [__down_failed+11/20]
> [.text.lock.super+279/550]  [sync_old_buffers+94/336] Jul  7 17:52:52
> kalimero kernel:   [kupdate+418/480] [kupdate+0/480] [rest_init+0/144]
> [rest_init+0/144] [kernel_thread+46/64] [kupdate+0/480] Jul  7 17:52:52
> kalimero kernel: scsi_eh_0     S 00000000  6080     8      1         9    
> 7 (L-TLB) Jul  7 17:52:52 kalimero kernel: Call Trace:   
> [vsnprintf+500/1056] [__down_interruptible+221/416]
> [__down_failed_interruptible+10/16] [.text.lock.scsi_error+229/290]
> [kernel_thread+46/64] Jul  7 17:52:52 kalimero kernel:  
> [scsi_error_handler+0/608]
>
> I wonder how I could decide the case of dma vs. scsi (as the root cause of
> the problem).
>
> best regards,
>
> Vincent
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
