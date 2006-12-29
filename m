Return-Path: <linux-kernel-owner+w=401wt.eu-S965025AbWL2JmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWL2JmD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 04:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWL2JmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 04:42:03 -0500
Received: from javad.com ([216.122.176.236]:4080 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965025AbWL2JmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 04:42:00 -0500
From: Sergei Organov <osv@javad.com>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: irq 4: nobody cared and I/O errors on serial ports.
Date: Fri, 29 Dec 2006 12:41:50 +0300
Message-ID: <874prfm42p.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems that the kernel has some problems/races in opening/closing of
serial ports. Simple C program below just opens/closes a port in a loop:

#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>

int main()
{
  while(1) {
    int fd = open("/dev/ttyS0", O_RDONLY | O_NOCTTY);
    if(fd < 0)
      fprintf(stderr, "%s\n", strerror(errno));
    else
      close(fd);
  }
}

I've noticed 2 problems running this program. I run 2.6.19.1 smp kernel
(I've also tested Debian 2.6.18.3 kernel, and it has the same issues) on
hyper-threaded Pentium 4 CPU.

1. When I run the program, I begin to get "irq 4: nobody cared" in dmesg even
   though the port is not connected (idle). Please find relevant part of dmesg
   below.

2. When two copies of this program are run simultaneously, each of
   copies start to randomly fail to open the port with errno=5
   (Input/output error).

Note that I've tested this both with standard PC port ttyS0 and with
serial ports of MOXA multi-port serial board (ttyM*), and [mis]behavior
is the same. Also note that opening /dev/null instead of serial port
doesn't have any problems.

Here are relevant parts from dmesg when open/close ttyS0:

irq 4: nobody cared (try booting with the "irqpoll" option)
 [<c0144ef2>] __report_bad_irq+0x36/0x7d
 [<c01450f4>] note_interrupt+0x1bb/0x1f7
 [<c0144665>] handle_IRQ_event+0x1a/0x3f
 [<c01458fd>] handle_edge_irq+0xde/0x109
 [<c010537d>] do_IRQ+0x7d/0xa4
 [<c01036ee>] common_interrupt+0x1a/0x20
 [<c01036ee>] common_interrupt+0x1a/0x20
 [<c021b63e>] serial_out+0x73/0x77
 [<c021cbb1>] serial8250_shutdown+0x71/0x148
 [<c0219c57>] uart_shutdown+0x83/0xad
 [<c021b16b>] uart_close+0x113/0x1a9
 [<c0209bf9>] tty_fasync+0x3a/0xaa
 [<c0209e48>] release_dev+0x1df/0x61e
 [<c016286d>] chrdev_open+0x12d/0x141
 [<c0162740>] chrdev_open+0x0/0x141
 [<c015ed34>] nameidata_to_filp+0x24/0x33
 [<c015ed75>] do_filp_open+0x32/0x39
 [<c01c1fa4>] __next_cpu+0x12/0x21
 [<c02964a3>] __sched_text_start+0x5a3/0x90a
 [<c020a296>] tty_release+0xf/0x18
 [<c0160f29>] __fput+0x96/0x16a
 [<c015ea56>] filp_close+0x52/0x59
 [<c015fa2b>] sys_close+0x65/0x99
 [<c0102cfd>] sysenter_past_esp+0x56/0x79
 =======================
handlers:
[<c021d9d4>] (serial8250_interrupt+0x0/0xdc)
Disabling IRQ #4
irq 4: nobody cared (try booting with the "irqpoll" option)
 [<c0144ef2>] __report_bad_irq+0x36/0x7d
 [<c01450f4>] note_interrupt+0x1bb/0x1f7
 [<c0144665>] handle_IRQ_event+0x1a/0x3f
 [<c01458fd>] handle_edge_irq+0xde/0x109
 [<c010537d>] do_IRQ+0x7d/0xa4
 [<c01036ee>] common_interrupt+0x1a/0x20
 [<c0101235>] mwait_idle_with_hints+0x3b/0x3f
 [<c0101245>] mwait_idle+0xc/0x1b
 [<c0101c7f>] cpu_idle+0x9f/0xb9
 [<c0333753>] start_kernel+0x39f/0x3a7
 [<c03331ae>] unknown_bootoption+0x0/0x206
 =======================
handlers:
Disabling IRQ #4
irq 4: nobody cared (try booting with the "irqpoll" option)
 [<c0144ef2>] __report_bad_irq+0x36/0x7d
 [<c01450f4>] note_interrupt+0x1bb/0x1f7
 [<c0144665>] handle_IRQ_event+0x1a/0x3f
 [<c01458fd>] handle_edge_irq+0xde/0x109
 [<c010537d>] do_IRQ+0x7d/0xa4
 [<c01036ee>] common_interrupt+0x1a/0x20
 [<c0101235>] mwait_idle_with_hints+0x3b/0x3f
 [<c0101245>] mwait_idle+0xc/0x1b
 [<c0101c7f>] cpu_idle+0x9f/0xb9
 [<c0333753>] start_kernel+0x39f/0x3a7
 [<c03331ae>] unknown_bootoption+0x0/0x206
 =======================
handlers:
Disabling IRQ #4
irq 4: nobody cared (try booting with the "irqpoll" option)
 [<c0144ef2>] __report_bad_irq+0x36/0x7d
 [<c01450f4>] note_interrupt+0x1bb/0x1f7
 [<c0144665>] handle_IRQ_event+0x1a/0x3f
 [<c01458fd>] handle_edge_irq+0xde/0x109
 [<c010537d>] do_IRQ+0x7d/0xa4
 [<c01036ee>] common_interrupt+0x1a/0x20
 [<c01036ee>] common_interrupt+0x1a/0x20
 [<c021b63e>] serial_out+0x73/0x77
 [<c021cbcb>] serial8250_shutdown+0x8b/0x148
 [<c0219c57>] uart_shutdown+0x83/0xad
 [<c021b16b>] uart_close+0x113/0x1a9
 [<c0209bf9>] tty_fasync+0x3a/0xaa
 [<c0209e48>] release_dev+0x1df/0x61e
 [<c016286d>] chrdev_open+0x12d/0x141
 [<c0162740>] chrdev_open+0x0/0x141
 [<c015ed34>] nameidata_to_filp+0x24/0x33
 [<c015ed75>] do_filp_open+0x32/0x39
 [<c01c1fa4>] __next_cpu+0x12/0x21
 [<c02964a3>] __sched_text_start+0x5a3/0x90a
 [<c020a296>] tty_release+0xf/0x18
 [<c0160f29>] __fput+0x96/0x16a
 [<c015ea56>] filp_close+0x52/0x59
 [<c015fa2b>] sys_close+0x65/0x99
 [<c0102cfd>] sysenter_past_esp+0x56/0x79
 =======================
handlers:
[<c021d9d4>] (serial8250_interrupt+0x0/0xdc)
Disabling IRQ #4
irq 4: nobody cared (try booting with the "irqpoll" option)
 [<c0144ef2>] __report_bad_irq+0x36/0x7d
 [<c01450f4>] note_interrupt+0x1bb/0x1f7
 [<c0144665>] handle_IRQ_event+0x1a/0x3f
 [<c01458fd>] handle_edge_irq+0xde/0x109
 [<c010537d>] do_IRQ+0x7d/0xa4
 [<c01036ee>] common_interrupt+0x1a/0x20
 [<c0101235>] mwait_idle_with_hints+0x3b/0x3f
 [<c0101245>] mwait_idle+0xc/0x1b
 [<c0101c7f>] cpu_idle+0x9f/0xb9
 [<c0333753>] start_kernel+0x39f/0x3a7
 [<c03331ae>] unknown_bootoption+0x0/0x206
 =======================
handlers:
Disabling IRQ #4


-- 
Sergei Organov.
