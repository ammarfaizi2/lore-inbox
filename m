Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUFXDRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUFXDRG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 23:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUFXDRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 23:17:06 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:63711 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263743AbUFXDRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 23:17:02 -0400
Message-ID: <40DA47A7.6030300@austin.rr.com>
Date: Wed, 23 Jun 2004 22:16:55 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-cifs-client@lists.samba.org
Subject: Re: Process hangs copying large file to cifs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > This is copying a 197Mb from an my laptop's IDE hardisk to a cifs 
mounted share that's on a Win2000 Server

This seems strange - looks like cifs simply called generic_write which 
goes to the page manager which in this case had to
rebalance/free up some pages which hung in local filesys routine outside 
of my code which I do not recognize.

[<c028dae0>] schedule_timeout+0x60/0xc0
[<c0131541>] __alloc_pages+0x2c1/0x300
[<c011eb00>] process_timeout+0x0/0x10
[<c028da3e>] io_schedule_timeout+0xe/0x50
[<c01ebe02>] blk_congestion_wait+0x72/0x90
[<c0116470>] autoremove_wake_function+0x0/0x50
[<c0116470>] autoremove_wake_function+0x0/0x50
[<c0132212>] get_dirty_limits+0x12/0xd0
[<c013238d>] balance_dirty_pages+0xbd/0x110
[<c012f5ad>] generic_file_aio_write_nolock+0x3ed/0x980
[<c012e2d0>] file_read_actor+0xc0/0xd0
[<c012e477>] __generic_file_aio_read+0x197/0x1d0
[<c012e210>] file_read_actor+0x0/0xd0
[<c012fb9f>] generic_file_write_nolock+0x5f/0x80
[<c014623f>] do_sync_read+0x6f/0xb0
[<c01060a3>] do_IRQ+0x113/0x150
[<c012fc8e>] generic_file_write+0x3e/0x60
[<de9c05bc>] cifs_write_wrapper+0x4c/0xb0 [cifs]

As you mentioned the vi thread is another one of the threads blocked in 
the local call "blk_congestion_wait" which may be useful to understand.

I don't see any interesting threads in cifs at first glance, although 
the call stack for the cifsoplock thread is a little odd looking (perhaps
some junk being misinterpreted on the call stack).

Could you take a look at the /proc/fs/cifs/DebugData,  which (at least 
on current 2.6.7) displays some often useful debug data
including the lists of "MIDs" (multiplex ids - pending network 
operations on the wire) if any and also /proc/fs/cifs/Stats and 
SimultaneousOps
which display counts of number of operations pending in the vfs which 
looks like only one - in this case - which is blocked outside the cifs code.

My guess is that there actually aren't any interesting threads in cifs 
at the moment, and that we need to understand the
blk_congestion_wait calls are trying to do

