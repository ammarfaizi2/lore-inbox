Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTKILn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 06:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTKILn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 06:43:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53008 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262395AbTKILnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 06:43:25 -0500
Date: Sun, 9 Nov 2003 11:43:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: crashme on ARM - unkillable processes
Message-ID: <20031109114322.A29553@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that running crashme on ARM running 2.6.0-test8 with the
following command:

# crashme +2000.4 666 100 1:0:0

results in crashme not running for very long before it locks up thusly:

Subprocess 2: try 20, offset 80
Subprocess 2: Got signal 4 illegal instruction
Subprocess 2: Barfed
Subprocess 2: try 21, offset 84
Subprocess 2: Got signal 11 segmentation violation
Subprocess 2: Barfed
Subprocess 2: try 22, offset 88
time limit reached on pid 1704 0x6A8. using kill.

At this point, PID1704 refuses to die.

Looking at the output of sysrq-p and sysrq-t, it would appear that the
subprocess is receiving SIGILL after SIGILL after SIGILL, virtually
continuously.

I suspect that either crashme's signal handler got corrupted somehow,
or else the longjmp out of the handler is not allowing the next signal
to be dequeued.

Looking at next_signal(), the kernel treats signals 1-8 as having higher
priority than signal 9.  Since we only ever dequeue one signal on return
to user space, we always find the SIGILL before SIGKILL, and the kill
signal remains indefinitely queued.  When considering the situations
where we deliver signals to processes, this means that if a process
makes both no further system calls and receives no interrupts between
SIGILL delivery and the next SIGILL being generated, the SIGKILL will
not be delivered.

I, therefore, put it to linux-kernel that this is a potential DoS
attack.  A normal user space program can fork() multiple instances
of itself, and then use this technique to place a heavy CPU intensive
load on the machine, and the result could be a hundred or so unkillable
processes.

Resource limits on the number of processes a user can create limit the
effect, but you will still end up with a number of unkillable processes
at the end of the day.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
