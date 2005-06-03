Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVFCI56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFCI56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 04:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFCI56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 04:57:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:59611 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261192AbVFCI5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 04:57:30 -0400
Date: Fri, 3 Jun 2005 01:57:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@ucw.cz>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split the checkpoint lists
Message-Id: <20050603015717.7512ea3a.akpm@osdl.org>
In-Reply-To: <20050601080357.GF5933@atrey.karlin.mff.cuni.cz>
References: <20050601080357.GF5933@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@ucw.cz> wrote:
>
> 
>    attached patch (to be applied after my previous two bugfixes) is a new
>  version of my patch splitting the JBD checkpoint lists into two

Seems to have a use-after-free bug.  Did you test it with CONFIG_SLAB_DEBUG?


Unable to handle kernel paging request at virtual address 6b6b6b9b
 printing eip:                                                    
c01a8a88      
*pde = 00000000
Oops: 0000 [#1]
SMP            
Modules linked in: video thermal processor fan button battery ac
CPU:    0                                                       
EIP:    0060:[<c01a8a88>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12-rc5-mm3)         
EIP is at journal_clean_one_cp_list+0x18/0x6c
eax: 6b6b6b6b   ebx: 6b6b6b6b   ecx: 00000001   edx: c1ada000
esi: 00000000   edi: 6b6b6b6b   ebp: c1adbec8   esp: c1adbeb4
ds: 007b   es: 007b   ss: 0068                               
Process kjournald (pid: 971, threadinfo=c1ada000 task=cfd01030)
Stack: ce5e11a4 00000078 c1a20dac c1ada000 cdd767c8 c1adbee8 c01a8b29 6b6b6b6b 
       cddd8604 cfdddb08 cfdddb08 c1ada000 cddd8ec4 c1adbf78 c01a66de cfdddaf4 
       cfdddaf4 cfdddb08 cfdddb08 cfdddbb4 cfdddb48 cddd8640 cfdddb30 cfdddb08 
Call Trace:                                                                    
 [<c0103967>] show_stack+0x7b/0x88
 [<c0103aa6>] show_registers+0x112/0x188
 [<c0103c8f>] die+0xe7/0x168            
 [<c011225c>] do_page_fault+0x4e4/0x6e2
 [<c01035a3>] error_code+0x4f/0x54     
 [<c01a8b29>] __journal_clean_checkpoint_list+0x4d/0x70
 [<c01a66de>] journal_commit_transaction+0x33e/0x12c1  
 [<c01a9ccd>] kjournald+0x125/0x34c                  
 [<c0100fcd>] kernel_thread_helper+0x5/0xc
Code: 24 00 00 83 c4 08 31 c0 8d 65 f0 5b 5e 5f 89 ec 5d c3 90 55 89 e5 83 ec 08 57 56 53 8b 5d 08 89 df 31 f6 85 d 

I can't immediately spot the error.  It oopses here:

0xc01a5b78 is in journal_clean_one_cp_list (fs/jbd/checkpoint.c:583).
578             int ret = 0;
579     
580             if (!jh)
581                     return 0;
582     
583             last_jh = jh->b_cpprev;
584             do {
585                     jh = next_jh;
586                     next_jh = jh->b_cpnext;
587                     /* Use trylock because of the ranking */

Called from here:

	
0xc01a5c10 is in __journal_clean_checkpoint_list (fs/jbd/checkpoint.c:635).
630                             goto out;
631                     /* It is essential that we are as careful as in the case of
632                        t_checkpoint_list with removing the buffer from the list
633                        as we can possibly see not yet submitted buffers on
634                        io_list */
635                     ret += journal_clean_one_cp_list(transaction->
636                                     t_checkpoint_io_list);
637                     if (need_resched())
638                             goto out;
639             } while (transaction != last_transaction);
