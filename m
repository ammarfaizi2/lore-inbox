Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264225AbUFXKsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbUFXKsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUFXKsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:48:16 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:55812 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S264225AbUFXKsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:48:04 -0400
Subject: Re: Process hangs copying large file to cifs
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: linux-cifs-client@lists.samba.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40DA47A7.6030300@austin.rr.com>
References: <40DA47A7.6030300@austin.rr.com>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 24 Jun 2004 11:48:00 +0100
Message-Id: <1088074080.2490.16.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2004 10:48:00.0539 (UTC) FILETIME=[B7D7AEB0:01C459D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CCing linux kernel ML because this might not be cifs related. I messed
up and sent the first email separately, sorry.

On Qua, 2004-06-23 at 22:16 -0500, Steve French wrote:
>  > This is copying a 197Mb from an my laptop's IDE hardisk to a cifs 
> mounted share that's on a Win2000 Server
> 
> This seems strange - looks like cifs simply called generic_write which 
> goes to the page manager which in this case had to
> rebalance/free up some pages which hung in local filesys routine outside 
> of my code which I do not recognize.

This apparently is memory pressure related, this never happened with
small files and this time around, when testing to get the info you
requested, I could copy the same file. Then I tried to copy a larger
(650Mb) file and it hang again.

> 
> [<c028dae0>] schedule_timeout+0x60/0xc0
> [<c0131541>] __alloc_pages+0x2c1/0x300
> [<c011eb00>] process_timeout+0x0/0x10
> [<c028da3e>] io_schedule_timeout+0xe/0x50
> [<c01ebe02>] blk_congestion_wait+0x72/0x90
> [<c0116470>] autoremove_wake_function+0x0/0x50
> [<c0116470>] autoremove_wake_function+0x0/0x50
> [<c0132212>] get_dirty_limits+0x12/0xd0
> [<c013238d>] balance_dirty_pages+0xbd/0x110
> [<c012f5ad>] generic_file_aio_write_nolock+0x3ed/0x980
> [<c012e2d0>] file_read_actor+0xc0/0xd0
> [<c012e477>] __generic_file_aio_read+0x197/0x1d0
> [<c012e210>] file_read_actor+0x0/0xd0
> [<c012fb9f>] generic_file_write_nolock+0x5f/0x80
> [<c014623f>] do_sync_read+0x6f/0xb0
> [<c01060a3>] do_IRQ+0x113/0x150
> [<c012fc8e>] generic_file_write+0x3e/0x60
> [<de9c05bc>] cifs_write_wrapper+0x4c/0xb0 [cifs]
> 
> As you mentioned the vi thread is another one of the threads blocked in 
> the local call "blk_congestion_wait" which may be useful to understand.

The vi isn't responsible for the problem, it's just that I run vi on a
file every now and then while testing to detect when the hang occurs. If
I can open (or close) the file with vi, it's still running, if the open
or close operation using vi hangs I know it will not recover anymore.
So it's not a problem, its a symptom.

> 
> I don't see any interesting threads in cifs at first glance, although 
> the call stack for the cifsoplock thread is a little odd looking (perhaps
> some junk being misinterpreted on the call stack).
> 
> Could you take a look at the /proc/fs/cifs/DebugData,  which (at least 
> on current 2.6.7) displays some often useful debug data
> including the lists of "MIDs" (multiplex ids - pending network 
> operations on the wire) if any and also /proc/fs/cifs/Stats and 
> SimultaneousOps
> which display counts of number of operations pending in the vfs which 
> looks like only one - in this case - which is blocked outside the cifs code.

Here's the requested data:
taz:/home/nmf# cat /proc/fs/cifs/DebugData
Display Internal CIFS Data Structures for Debugging
---------------------------------------------------
Servers:

1) Name: 10.1.1.1  Domain: GRAYCELL Mounts: 1 ServerOS: Windows 5.0
        ServerNOS: Windows 2000 LAN Manager     Capabilities: 0xf3fd
        SMB session status: 1   TCP status: 1
        Local Users To Server: 1 SecMode: 0x3 Req Active: 0

Shares:

1) \\ODIE\GRAYCELL Uses: 1 Type: NTFS Characteristics: 0x20 Attributes: 0x700ff
PathComponentMax: 255 Status: 1 type: DISK
taz:/home/nmf# cat /proc/fs/cifs/Stats
Resources in use
CIFS Session: 1
Share (unique mount targets): 1
SMB Request/Response Buffer: 1
Operations (MIDs): 0

0 session 0 share reconnects

1) \\ODIE\GRAYCELL
SMBs: 49779 Oplock Breaks: 0
Reads: 0 Bytes 0
Writes: 49741 Bytes: 2taz:/home/nmf# cat /proc/fs/cifs/SimultaneousOps
Total vfs operations: 199171 and maximum simultaneous serviced by this filesystem: 4


By the way, it appears like there is some problem with the /proc/fs/
cifs/Stats output.

> 
> My guess is that there actually aren't any interesting threads in cifs 
> at the moment, and that we need to understand the
> blk_congestion_wait calls are trying to do
> 
-- 
Nuno Ferreira

