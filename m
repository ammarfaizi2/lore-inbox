Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWHPKqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWHPKqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 06:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHPKqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 06:46:21 -0400
Received: from arrakeen.ouaza.com ([212.85.152.62]:62879 "EHLO
	arrakeen.ouaza.com") by vger.kernel.org with ESMTP id S1751097AbWHPKqU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 06:46:20 -0400
Date: Wed, 16 Aug 2006 12:45:59 +0200
From: Raphael Hertzog <hertzog@debian.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: How to avoid serial port buffer overruns?
Message-ID: <20060816104559.GF4325@ouaza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC me when replying)

Hello,

While using Linux on low-end (semi-embedded) hardware (386 SX 40Mhz, 8Mb
RAM), I discovered that Linux on that machine would suffer from serial
port buffer overruns quite easily if I use a baudrate high enough (I start
loosing bytes at >19200 bauds and I would like to make it reliable up to 
115 kbauds). I check if overruns are happening with
/proc/tty/driver/serial ("oe" field).

Back when I was using the 2.4 kernel, I reduced dramatically the frequency
of overruns by using the "low latency" and "preemptible kernel" patch [1]. But
it still happened sometimes at 115 kbauds if the system was a bit loaded
(with disk I/O for example).

Now I switched to stock 2.6 and while the stock kernel improved in
responsiveness, it still isn't enough by default (even with
CONFIG_PREEMPT=y and CONFIG_HZ=1000). So I wanted to try the "rt" patch of
Ingo Molnar and Thomas Gleixner, but the patched kernel doesn't boot (see
bug report in a separate mail on this list).

Other things that I tried which didn't help (enough) are:

- tuning with hdparm
  - make disk IRQ interruptible with hdparm -u 1 /dev/hda
  - activating DMA is suggested but my disk is a "disk on module"
    and doesn't support DMA
- using irqtune (http://cae.best.vwh.net/irqtune/) to reprioritize
  interrupts
  irqtune is old and it's very difficult to know if it still works
  reliably with recent kernel and as there's no way to "read" the
  interrupt priorities, I have no way to know if irqtune changed anything
  at all...

My questions are thus:
1/ Is there a way to patch the kernel to make it handle serial IRQ as
   the highest priority? If yes, how? Where should I look at to create
   such a patch?
2/ How can I identify why the serial interrupts are delayed? Or, in other
   words, how can I find the code blocking for too long the treatment of
   the serial IRQ?
   I suppose that network IRQ and disk IRQ are responsible for that but
   I'm not sure and furthermore disk interrupts are supposed to
   be interruptible given the hdparm config that I use.
3/ What other suggestions do you have to avoid those serial buffer
   overruns?

As usual, I'll gladly try out patches/ideas and will provide any
required additional information that I didn't include in this mail.

Some infos on the hardware:
http://www.icop.com.tw/products_detail.asp?ProductID=205
More detailed spec of the CPU are here:
http://www.dmp.com.tw/tech/m6117d/

bash-2.05a# cat /proc/interrupts
CPU0
0:   88503366          XT-PIC  timer
2:          0          XT-PIC  cascade
3:         11          XT-PIC  serial
4:         12          XT-PIC  serial
5:       4958          XT-PIC  NE2000
14:      10771          XT-PIC  ide0
NMI:          0
ERR:          0

Regards,

[1] I documented that in a blog post last year:
http://www.ouaza.com/wordpress/2005/10/19/serial-overrun-on-linux/
-- 
Raphaël Hertzog

Premier livre français sur Debian GNU/Linux :
http://www.ouaza.com/livre/admin-debian/
