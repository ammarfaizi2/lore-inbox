Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267533AbUBTEiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 23:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUBTEiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 23:38:24 -0500
Received: from florence.buici.com ([206.124.142.26]:45216 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S267533AbUBTEiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 23:38:20 -0500
Date: Thu, 19 Feb 2004 20:38:19 -0800
From: Marc Singer <elf@buici.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm <linux-arm@lists.arm.linux.org.uk>
Subject: New 2.6 port: why would kernel not start /sbin/init?
Message-ID: <20040220043819.GA9592@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a port to a new chip (ARM920 core) that is very close to
booting.  There appears to be something keeping the /sbin/init process
from starting.

In this setup, I'm running a patched 2.6.2 kernel from flash memory.
The root filesystem is a JFFS2 partition in flash.  The
run_init_process() call appears to succeed because it doesn't return.

The sysrq-task list shows that there is an init task, but there seems
to be something wrong with the stack.

                         free                        sibling
  task             PC    stack   pid father child younger older
init          R current      0     1      0     2               (NOTLB)
[<c0021a88>] (show_state+0x44/0xac) from [<c0309e70>] (0xc0309e70)
Backtrace aborted due to bad frame pointer <c0308000>

I've traced through the elf binary loader and gotten to the point
where it does a start_thread().  The only odd thing I see is that that
the interpreter, elf_entry=0x400015f0, refers to an address that
doesn't appear to have any code there.  (I'm using gdb to debug the
kernel through a JTAG emulator.)

(gdb) x/20 elf_entry
0x400015f0:     0x00000000      0x00000000      0x00000000      0x00000000
0x40001600:     0x00000000      0x00000000      0x00000000      0x00000000
0x40001610:     0x00000000      0x00000000      0x00000000      0x00000000
0x40001620:     0x00000000      0x00000000      0x00000000      0x00000000
0x40001630:     0x00000000      0x00000000      0x00000000      0x00000000

My hardware debugger complains of a 'data abort' when I look at that
address which usually means that the CPU returned a page fault.

Should I expect that these pages be mapped already?  Can you offer any
suggestions as to where in the kernel to look for this kind of
failure?

Cheers.
