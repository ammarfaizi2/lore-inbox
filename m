Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbUAEO1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 09:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbUAEO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 09:27:12 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17295 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264342AbUAEO1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 09:27:09 -0500
Subject: hang due to console driver
From: Anand Suvernkar <asuvernk@vxindia.veritas.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Jan 2004 20:10:15 +0530
Message-Id: <1073313615.19275.4734.camel@badam>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all,
    I faced a problem in the kernel module I am working on.
The context of the problem is..
   There are two kernel threads running in the system. One
thread is printing a message on the console using printk
every 100 milli seconds. And the other thread at some time faces some
error and tries to print the error and gets hung. It remains
in the hung state until I change the log levels to disallow 
printing on the serial console.

I artificially created a panic and found following stack trace.


[<c01c6920>] serial_console_write [kernel] 0x0 (0xedf0ddc4)
[<c01c0739>] serial_in [kernel] 0x19 (0xedf0dde8)
[<c01c69a0>] serial_console_write [kernel] 0x80 (0xedf0ddf8)
[<c0128473>] __call_console_drivers [kernel] 0x63 (0xedf0de20)
[<c0128596>] call_console_drivers [kernel] 0x86 (0xedf0de3c)
[<c0128975>] release_console_sem [kernel] 0x55 (0xedf0de60)
[<c0128893>] printk [kernel] 0x143 (0xedf0de74)
[<f98fecf2>] .rodata.str1.32 [vxio] 0x4ce72 (0xedf0de80)
[<f9830979>] ack_timeout [vxio] 0xc9 (0xedf0de94)


ack_timeout is a function in my module which calls printk.
and gets hung.

   So I am not able to find out the reason for this hang. The apparent
culprit is the second thread which is continuously printing some
messages. The implementation of printk is such that if the console
semaphore is held by someone, printk issued by other threads simply
writes the data in the log buffer and returns. It is the
responsibility of the console semaphore holder to print these messages
before it releases the lock.
  So the only plausible reason I can find is deadlock for the log
buffer. 

  Has anyone  faced this  problem before ? I will be greatly thankful if
someone has something to say about this problem.


Since I am not a subscribed member I  wish to be personally CC'ed the
answers/comments posted to the list in response to my mail

Thanks
Anand




