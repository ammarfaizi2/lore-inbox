Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279988AbRKVQau>; Thu, 22 Nov 2001 11:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280012AbRKVQal>; Thu, 22 Nov 2001 11:30:41 -0500
Received: from cnxt10002.conexant.com ([198.62.10.2]:28861 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S279988AbRKVQaY>; Thu, 22 Nov 2001 11:30:24 -0500
Date: Thu, 22 Nov 2001 17:30:14 +0100 (CET)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: <linux-kernel@vger.kernel.org>
Subject: Oops with proc filesystem.
Message-ID: <Pine.LNX.4.33.0111221704210.6357-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I'm seeing a Oops involving the proc filesystem and a module I wrote.
I'm using kernel 2.4.13 patched with kdb.
Apparently my "read_proc" function is still being called after the module,
(where it was defined) is removed.

It seems the fix would be to clear the "read_proc" field of the 
proc_dir_entry structure when "remove_proc_entry" is called.
In "proc_read_file" we already check for a valid "read_proc" pointer
(!= NULL).

Rui Sousa

To create the proc entries I use something like:

	proc_mkdir ("gateway", 0);
	sprintf(s, "gateway/stats");
	create_proc_read_entry (s, 0, 0, gateway_read_proc, NULL);

and to remove them:

	sprintf(s, "gateway/stats");
	remove_proc_entry(s, NULL);

	remove_proc_entry("gateway", NULL);


On remove the kernel outputs:
Nov 22 16:37:04 catalina4 kernel: remove_proc_entry: csm3/stats busy, 
count=1
Nov 22 16:37:04 catalina4 kernel: remove_proc_entry: gateway/csm3 busy, 
count=1

Nov 22 16:37:04 catalina4 kernel: remove_proc_entry: /proc/gateway busy, 
count=1


So we now the proc entry has been marked deleted.

kdb shows:
kdb> bt
    EBP       EIP         Function(args)
0xc2b35f98 0xc4b20cec <unknown>+0xc4b20cec (0xc217f000, 0xc2b35f94, 0x0, 0x400, 0xc2b35f90)
                               kernel <unknown> 0x0 0x0 0x0
           0xc01470a7 proc_file_read+0xe7 (0xc29150c0, 0x40469000, 0x400, 0xc29150e0)
                               kernel .text 0xc0100000 0xc0146fc0 0xc0147168
0xc2b35fbc 0xc012f336 sys_read+0x8e (0x26, 0x40469000, 0x400, 0x814cdd0, 0x40469000)
                               kernel .text 0xc0100000 0xc012f2a8 0xc012f370
           0xc0106c4b system_call+0x33
                               kernel .text 0xc0100000 0xc0106c18 0xc0106c50

kdb> lsmod
Module                  Size  modstruct     Used by
floppy                 52020  0xc4824000     0  (autoclean)






