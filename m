Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbUDTL3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUDTL3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 07:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUDTL3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 07:29:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52612 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262431AbUDTL3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 07:29:34 -0400
Message-ID: <40850987.1080603@redhat.com>
Date: Tue, 20 Apr 2004 01:29:11 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040418)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
References: <4083BA03.1090606@redhat.com> <20040419121225.GT1966@suse.de> <408471E2.8060201@redhat.com> <40848159.7090605@togami.com> <20040420070805.GC25806@suse.de> <4084D83D.8060405@redhat.com> <20040420080325.GD25806@suse.de> <4084E671.4090509@redhat.com> <20040420090523.GE25806@suse.de> <40850143.1090709@redhat.com> <20040420105622.GK25806@suse.de>
In-Reply-To: <20040420105622.GK25806@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>>>
>>>Repeat the tests that made it crash. The last patch I sent should work
>>>for you, at least until the real issue is found.
>>>
>>
>>Tested your patch, it indeed does seem to keep the system stable.  If I 
>>am understanding it right, the patch disables merging in the case where 
>>it would have caused a BUG condition?  (Less efficiency.)
> 
> 

Bad news... much later during the test the system locked up.  During 
this test we did not use "sync" but just let all four bonnie++'s run.

http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie3.txt
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at cfq_iosched:404
invalid operand: 0000 [1] SMP
CPU 0
Pid: 0, comm: swapper Not tainted 2.6.5-1.326changeme
RIP: 0010:[<ffffffff80234f74>] <ffffffff80234f74>{cfq_next_request+35}
RSP: 0018:ffffffff804a9048  EFLAGS: 00010046
RAX: 000001007f2c6000 RBX: 000001004483b340 RCX: 0000000000000000
RDX: 000001007f2ca600 RSI: 0000000000180000 RDI: 000001007f2c6000
RBP: 000001007f2c6000 R08: 0000010037ffa568 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000001000 R12: 000001007f2c6000
R13: 000001007f2c6000 R14: ffffffff804adf08 R15: 0000000000000000
FS:  0000002a9555f360(0000) GS:ffffffff804a4e80(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000856348 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, stackpage=ffffffff803cf5c0)
Stack: ffffffffa003a880 00000100348b2300 ffffffffa003a880 ffffffff8022b444
        00000100348b2300 ffffffffa003a880 000000000001ac00 ffffffffa0036b82
        ffffffff803f40a0 00000100629a5e80
Call Trace:<IRQ> <ffffffff8022b444>{elv_next_request+238} 
<ffffffffa0036b82>{:i2o_block:i2ob_request+233}
        <ffffffffa003670e>{:i2o_block:i2o_block_reply+1162}
        <ffffffff8013e13a>{__mod_timer+807} 
<ffffffff801310b5>{load_balance+1046}
        <ffffffff8013e7f9>{update_wall_time+12} 
<ffffffffa002908a>{:i2o_core:i2o_run_queue+124}
        <ffffffffa002b60e>{:i2o_core:i2o_pci_interrupt+9} 
<ffffffff80113d85>{handle_IRQ_event+44}
        <ffffffff801140b8>{do_IRQ+285} <ffffffff8013a894>{__do_softirq+76}
        <ffffffff8010f590>{default_idle+0} 
<ffffffff8011185f>{ret_from_intr+0}
         <EOI> <ffffffff8010f590>{default_idle+0} 
<ffffffff8010f5b4>{default_idle+36}
        <ffffffff8010f627>{cpu_idle+24} <ffffffff804af7ea>{start_kernel+512}
        <ffffffff804af17c>{x86_64_start_kernel+144}

Code: 0f 0b 78 3a 32 80 ff ff ff ff 94 01 f6 43 10 10 48 8b 73 68
RIP <ffffffff80234f74>{cfq_next_request+35} RSP <ffffffff804a9048>
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
  NMI Watchdog detected LOCKUP on CPU1, registers
CPU 1
Pid: 1525, comm: bonnie++ Not tainted 2.6.5-1.326changeme
RIP: 0010:[<ffffffff8022f332>] <ffffffff8022f332>{.text.lock.ll_rw_blk+95}
RSP: 0018:000001005b553808  EFLAGS: 00000086
RAX: 0000000000000000 RBX: 0000010037ffb118 RCX: 0000010064b61800
RDX: 0000000000000000 RSI: 000001005b553830 RDI: 000001007f2c6000
RBP: 000001007f2c6000 R08: 0000000000000000 R09: 00000100498666c0
R10: 00000100498666c0 R11: 00000100498666c0 R12: 0000000000000060
R13: 0000000000000008 R14: 00000000007ca9b7 R15: 0000000000000000
FS:  0000002a9555f360(0000) GS:ffffffff804a4f00(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a9555a000 CR3: 000000007fe2f000 CR4: 00000000000006e0
Process bonnie++ (pid: 1525, stackpage=1007e5363c0)
Stack: 0000010000000000 0000000000000001 000001005cc8d6e8 0000000000000000
        0000000000001000 00000100583a0cc0 000001005b553898 0000000000000000
        00000100583a0cc0 0000000000000060
Call Trace:<ffffffff8022e4a7>{generic_make_request+331} 
<ffffffff8022e5b1>{submit_bio+247}
        <ffffffff801961c6>{mpage_bio_submit+27} 
<ffffffff801964d7>{do_mpage_readpage+493}
        <ffffffff801b3f63>{ext2_get_block+0} 
<ffffffff801b3f63>{ext2_get_block+0}
        <ffffffff801b3f63>{ext2_get_block+0} 
<ffffffff8015428c>{add_to_page_cache+129}
        <ffffffff801b3f63>{ext2_get_block+0} 
<ffffffff80196653>{mpage_readpages+161}
        <ffffffff8015a5c3>{read_pages+57} 
<ffffffff80158035>{buffered_rmqueue+510}
        <ffffffff801580fe>{__alloc_pages+158} 
<ffffffff8015ab04>{do_page_cache_readahead+515}
        <ffffffff801545e8>{__lock_page+213} 
<ffffffff8015acbd>{page_cache_readahead+396}
        <ffffffff80154c04>{do_generic_mapping_read+193} 
<ffffffff80154e28>{file_read_actor+0}
        <ffffffff80155084>{__generic_file_aio_read+360} 
<ffffffff80155157>{generic_file_read+116}
        <ffffffff80181a75>{link_path_walk+2806} 
<ffffffff80165bf4>{vma_merge+166}
        <ffffffff802f5707>{thread_return+0} <ffffffff80172e01>{vfs_read+208}
        <ffffffff80173006>{sys_read+57} <ffffffff801112ba>{system_call+126}


Code: 7e f9 e9 aa ea ff ff 90 90 90 41 57 41 56 41 55 49 89 fd bf
console shuts up ...

