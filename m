Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVBIFGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVBIFGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 00:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVBIFGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 00:06:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:31935 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261783AbVBIFFp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 00:05:45 -0500
Date: Wed, 9 Feb 2005 10:37:19 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suparna@in.ibm.com
Subject: Re: 2.6.10 kprobes/jprobes panic
Message-ID: <20050209050719.GA12528@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <1107907174.20053.52.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107907174.20053.52.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badri,

> Hi,
> 
> I ran into this while playing with jprobes in 2.6.10.
> 
> I tried to install jprobe handler on a invalid address,

User should prevent inserting jprobes on an invalid address.

> I get OOPS. I was hoping for a error check and a graceful
> exit rather than kernel Oops.
> 

Error check and graceful exit can be done in the jprobe handler
module. In the jprobe network packet logging patch, error check
was taken care by using kallsyms_lookup_name() as shown below.

	nt->jp.kp.addr = (kprobe_opcode_t *)
		    kallsyms_lookup_name(nt->funcname);
		if (nt->jp.kp.addr) {
			printk("plant jprobe at %s (%p), handler addr %p\n",
			       nt->funcname, nt->jp.kp.addr, nt->jp.entry);
			register_jprobe(&nt->jp);
		} else {
			printk("couldn't find %s to plant jprobe\n",
			       nt->funcname);
		}. 

Please see the patch at the URL for more details.
http://lkml.org/lkml/2004/8/16/179

Thanks
Prasanna


> Unable to handle kernel paging request at 00000000c01836b0 RIP:
> <ffffffff8026e622>{__memcpy+114}
> PML4 17d6cf067 PGD 0
> Oops: 0000 [1] SMP
> CPU 1
> Modules linked in: diotest
> Pid: 14225, comm: insmod Not tainted 2.6.10n
> RIP: 0010:[<ffffffff8026e622>] <ffffffff8026e622>{__memcpy+114}
> RSP: 0018:000001019b841d58  EFLAGS: 00010047
> RAX: ffffff0000a70000 RBX: 00000101bfa44200 RCX: 0000000000000000
> RDX: 000000000000000f RSI: 00000000c01836b0 RDI: ffffff0000a70000
> RBP: ffffffffa00008e0 R08: 0000010180000000 R09: 0000000000000000
> R10: 00000101bfa44218 R11: 0000000000000111 R12: 0000000000000216
> R13: ffffffff804f1440 R14: 0000000000000020 R15: 0000000000000002
> FS:  0000002a9588e6e0(0000) GS:ffffffff80628800(0000)
> knlGS:0000000055970080
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00000000c01836b0 CR3: 00000001a072c000 CR4: 00000000000006e0
> Process insmod (pid: 14225, threadinfo 000001019b840000, task
> 00000101bf9394e0)
> Stack: 00000101bfa44200 ffffffff8011edcc 0000000000000212
> ffffffffa00008e0
>        00000000ffffffef ffffffff80158542 ffffffff804f1480
> ffffffffa0000940
>        ffffffff804f1440 ffffffffa000005c
> Call Trace:<ffffffff8011edcc>{arch_prepare_kprobe+300}
> <ffffffff80158542>{register_kprobe+82}
>        <ffffffffa000005c>{:diotest:init_dmods+44}
> <ffffffff80150823>{sys_init_module+6387}
>        <ffffffff8015e9c0>{__pagevec_free+32}
> <ffffffff8016490e>{release_pages+382}
>        <ffffffff8016d4e6>{do_munmap+918}
> <ffffffff803ebb11>{__down_read+49}
>        <ffffffff8026bc90>{__up_write+48}
> <ffffffff8010e4ce>{system_call+126}
>                                                                                                              
>                                                                                                              
> Code: 4c 8b 06 4c 89 07 48 8d 7f 08 48 8d 76 08 75 ee 89 d1 83 e1
> RIP <ffffffff8026e622>{__memcpy+114} RSP <000001019b841d58>
> CR2: 00000000c01836b0
> 
> 
> 

-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
