Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTDJXoU (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTDJXoU (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:44:20 -0400
Received: from mail1.3par.com ([66.126.187.159]:34294 "EHLO mail.3pardata.com")
	by vger.kernel.org with ESMTP id S264255AbTDJXoR (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:44:17 -0400
Date: Thu, 10 Apr 2003 16:55:40 -0700 (PDT)
From: Castor Fu <castor@3pardata.com>
X-X-Sender: <castor@marais>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS in ext3 kjournald -- 2.4.18
Message-ID: <Pine.LNX.4.33.0304101633300.12792-100000@marais>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently had a kernel OOPS accessing an ext3 filesystem using
kjournald on a system running 2.4.18 + our drivers.  We haven't seen this particular
OOPS before, and wanted to see if it was a known problem.

System: Dual processor Pentium-III

Thanks to LKCD, I've looked through the  buffer_head structure which looks
corrupted, but I haven't figured out why.  Suggestions are welcoe.

    Thanks!
    Castor Fu
    castor@3pardata.com

Traceback:

     #3 [52457e2c] page_fault (via error_code) at 401070fc
        EAX: 00002085  EBX: 00000003  ECX: 00000001  EDX: 00000001  EBP: 52457e2c
        DS:  0018      ESI: 00000009  ES:  0018      EDI: 00007000
        CS:  0010      EIP: 4013a323  ERR: ffffffff  EFLAGS: 00010202
     #4 [52457e2c] get_hash_table+115 at 4013a323
        (7000, 2085, 1000, 52a6b600, 5f8b2bb0)
     #5 [52457e4c] getblk at 4013ab8c
        (7000, 2085, 1000)
     #6 [52457e6c] journal_get_descriptor_buffer at 4016bd20
        (52a6b600)
     #7 [52457fc4] journal_commit_transaction at 40168d79
        (52a6b600)
     #8 [52457fec] kjournald at 4016b646
        (52a6b600)
     #9 [521c7dd8] kernel_thread at 40105690
        (0, 0, 0)

    crash> p *$bh
    $10 = {
      b_next = 0x1, b_blocknr = 8325, b_size = 28672, b_list = 26594, b_dev =
      28672, b_count = {
        counter = 0
      }, b_rdev = 28672, b_state = 25, b_flushtime = 0, b_next_free = 0x0,
      b_prev_free = 0x0, b_this_page = 0x52923f20, b_reqnext = 0x0, b_pprev
      = 0x418238a4, b_data = 0x47435000 "@;9\230", b_page = 0x411d0d40,
      b_end_io = 0x40168720 <journal_end_buffer_io_sync>, b_private = 0x0,
      b_rsector = 66600,
      b_wait = { lock = { lock = 1 },
    task_list = { next = 0x52923f6c, prev = 0x52923f6c } },
    b_inode = 0x0, b_inode_buffers = { next = 0x0, prev = 0x0 }
    }

b_next, b_size, and probably b_list are all corrupted.  We can compare the buffer
structures with that of the previous page:

    crash> x /24x $bh
    0x52923f20:     0x00000001      0x00002085      0x67e27000      0x00007000
    0x52923f30:     0x00000000      0x00007000      0x00000019      0x00000000
    0x52923f40:     0x00000000      0x00000000      0x52923f20      0x00000000
    0x52923f50:     0x418238a4      0x47435000      0x411d0d40      0x40168720
    0x52923f60:     0x00000000      0x00010428      0x00000001      0x52923f6c
    0x52923f70:     0x52923f6c      0x00000000      0x00000000      0x00000000

    crash> x /24x 0x52923e60
    0x52923e60:     0x00000000      0x00002084      0x00001000      0x00007000
    0x52923e70:     0x00000000      0x00007000      0x00000019      0x0018c78b
    0x52923e80:     0x00000000      0x00000000      0x52923e60      0x00000000
    0x52923e90:     0x41823084      0x4730c000      0x411cc300      0x40168720
    0x52923ea0:     0x00000000      0x00010420      0x00000001      0x52923eac
    0x52923eb0:     0x52923eac      0x00000000      0x57c7bdb8      0x57c7bdb8


