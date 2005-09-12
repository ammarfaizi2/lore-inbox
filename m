Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVILXKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVILXKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVILXKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:10:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932342AbVILXKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:10:52 -0400
Date: Mon, 12 Sep 2005 16:10:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: serue@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Andi Kleen <ak@muc.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Dave C Boutcher <sleddog@us.ibm.com>
Subject: Re: ibmvscsi badness (Re: 2.6.13-mm3)
Message-Id: <20050912161013.76ef833f.akpm@osdl.org>
In-Reply-To: <20050912222437.GA13124@sergelap.austin.ibm.com>
References: <20050912024350.60e89eb1.akpm@osdl.org>
	<20050912222437.GA13124@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

serue@us.ibm.com wrote:
>
> Trying to get 2.6.13-mm running on a power5 lpar, I'm
> having scsi problems.

You should have cc'ed the scsi mailing list, no?

> With -mm2, I only get things like:
> 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> 	sda: Current: sense key: Aborted Command
> 	    Additional sense: No additional sense information
> 	Info fld=0x0
> 	end_request: I/O error, dev sda, sector 10468770
> 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> 	sda: Current: sense key: Aborted Command
> 	    Additional sense: No additional sense information
> 	Info fld=0x0
> 	end_request: I/O error, dev sda, sector 10468778
> 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> 	sda: Current: sense key: Aborted Command
> 	    Additional sense: No additional sense information
> 	Info fld=0x0
> 	end_request: I/O error, dev sda, sector 10468786
> 	sd 0:0:0:0: SCSI error: return code = 0x8000002
> 	sda: Current: sense key: Aborted Command
> 	    Additional sense: No additional sense information
> 	Info fld=0x0
> 	end_request: I/O error, dev sda, sector 10468794
> 
> When I copy the 2.6.13-rc6-mm2's drivers/scsi/ibmvscsi/ibmvscsi.{c,h}
> back (just changing the static vio_device_id initializer as per
> 
> @@ -1442,7 +1531,7 @@ static int ibmvscsi_remove(struct vio_de
>   */    
>  static struct vio_device_id ibmvscsi_device_table[] __devinitdata = {
>         {"vscsi", "IBM,v-scsi"},
> -       {0,}
> +       { "", "" } 
>  };                     
> 
> then this kernel boots fine.

There have been quite a lot of ibmvscsi changes since 2.6.13-rc6-mm2.

>  The same thing does not work for
> 2.6.13-mm3.  The console output of an attempted boot follows.
> (Seems the same with either version of ibmvscsi.{c,h}, so the
> problem appears to be elsewhere)
> 
> ...
> Remounting root filesystem in read-write mode:  [  OK  ]
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=128 NUMA PSERIES LPAR
> Modules linked in:
> NIP: C000000000087C1C XER: 20000010 LR: C000000000087D70 CTR: C0000000000830A4
> REGS: c0000000021dec00 TRAP: 0300   Not tainted  (2.6.13-mm3)
> MSR: 8000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 24044042
> DAR: c000000103c23c58 DSISR: 0000000040010000
> TASK: c00000000700d050[2236] 'hotplug' THREAD: c0000000021dc000 CPU: 0
> GPR00: 0000000000000001 C0000000021DEE80 C00000000056B0E8 0000000000000000
> GPR04: 0000000000000000 616C746976656300 0000000020713DFA 0000000000000000
> GPR08: 0000000000000000 C000000103C23C38 3C4E554C4C3E0000 C000000000384C68
> GPR12: C000000000384C68 C00000000043C800 C0000000021BB600 0000000000000006
> GPR16: 00000000F800F958 00000000F800FA88 0000000010000000 0000000000000010
> GPR20: 0000000002000000 0000000000000000 0000000000000000 C00000000700D050
> GPR24: 0000000020713DFA C000000087FF7D88 00000000800400D2 0000000000000001
> GPR28: 0000000000000000 C000000000384C68 C0000000004ABC38 0000000000000000
> NIP [c000000000087c1c] .zone_watermark_ok+0x50/0xac
> LR [c000000000087d70] .__alloc_pages+0xf8/0x5fc
> Call Trace:
> [c0000000021dee80] [c0000000021def20] 0xc0000000021def20 (unreliable)
> [c0000000021def70] [c0000000000aa1b4] .alloc_page_interleave+0x3c/0xb8
> [c0000000021deff0] [c00000000009af70] .do_no_page+0x5f8/0x710
> [c0000000021df0e0] [c00000000009b2b8] .__handle_mm_fault+0x230/0x694
> [c0000000021df1c0] [c00000000035be38] .do_page_fault+0x4e0/0x7e8
> [c0000000021df340] [c000000000004760] .handle_page_fault+0x20/0x54
> --- Exception: 301 at .__clear_user+0x14/0x7c
>     LR = .padzero+0x34/0x5c
> [c0000000021df630] [0000000000000000] .__start+0x4000000000000000/0x8 (unreliable)
> [c0000000021df6a0] [c00000000001441c] .load_elf_binary+0x171c/0x1abc
> [c0000000021df830] [c0000000000c3c80] .search_binary_handler+0x184/0x4bc
> [c0000000021df8e0] [c0000000000f20c4] .load_script+0x2d0/0x314
> [c0000000021dfa10] [c0000000000c3c80] .search_binary_handler+0x184/0x4bc
> [c0000000021dfac0] [c0000000000c41cc] .do_execve+0x214/0x394
> [c0000000021dfb70] [c00000000000de64] .sys_execve+0x74/0xf8
> [c0000000021dfc10] [c000000000009c00] syscall_exit+0x0/0x18
> --- Exception: c01 at .____call_usermodehelper+0xcc/0xf8
>     LR = .____call_usermodehelper+0x9c/0xf8
> [c0000000021dff90] [c000000000010060] .kernel_thread+0x4c/0x68
> Instruction dump:
> 419e0010 7ca00e74 7c000194 7ca02850 2fa70000 419e0010 7ca01674 7c000194
> 7ca02850 78c91f24 38600000 7d296214 <e8090020> 7c002a14 7faa0040 4c9d0020
>  Oops: Kernel access of bad area, sig: 11 [#2]
> SMP NR_CPUS=128 NUMA PSERIES LPAR
> Modules linked in: dm_mod

Interesting.  It could be Andi's recent mempolicy.c changes
(convert-mempolicies-to-nodemask_t.patch) or it could be some recent ppc64
change or it could be something else ;)

Could the ppc64 guys please take a look?  In particular, it would be good
to know if convert-mempolicies-to-nodemask_t.patch is innocent - I was
planning on merging that upstream today.
