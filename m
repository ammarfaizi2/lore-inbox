Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266389AbUHBJ7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266389AbUHBJ7h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 05:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUHBJ7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 05:59:35 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:10671 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S266425AbUHBJ6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 05:58:11 -0400
Date: Mon, 2 Aug 2004 12:57:41 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <20040731143330.A25736@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.44.0408021234290.15888-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Mon, 02 Aug 2004 12:57:47 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2004, Francois Romieu wrote:

> Pasi Sjoholm <ptsjohol@cc.jyu.fi> :
> [interesting report]
>> The hardest part is to tell where the problem is but I think that 
>> rtl8139_poll-function would be good place to start looking for the bug?
>> readprofile didn't tell much.. Where to go next? I'm not so good 
>> programmer that I could find the right place to fix..

> In case it could make a difference: did you check if CONFIG_8139_OLD_RX_RESET
> changes the behavior or not ?

Yep, I tried that one also, didn't help a thing.
 
> If it does not, I'd welcome a test report + log with the two attached patch
> applied. The first one is just a placebo but the second one could help.

We are making some sort of a progress but not enough. 

Patch r8139-20.patch didn't help. I made some printk(...)-debug messages
and that part of a code was never ran.

With both patch applied and RTL8139DEBUG = 1 I couldn't make the driver 
crash but without DEBUG it did crash. I assume that it has something to 
with fact that syslog did take so much io-bandwidth. (a couple of minutes log 
was ~1GB =))

But without: 

--
@@ -2024,17 +2024,17 @@ static int rtl8139_rx(struct net_device

                cur_rx = (cur_rx + rx_size + 4 + 3) & ~3;
                RTL_W16 (RxBufPtr, (u16) (cur_rx - 16));
+       }

-               /* Clear out errors and receive interrupts */
-               status = RTL_R16 (IntrStatus) & RxAckBits;
-               if (likely(status != 0)) {
-                       if (unlikely(status & (RxFIFOOver | RxOverflow))) 
{
-                               tp->stats.rx_errors++;
 -                               if (status & RxFIFOOver)
-                                       tp->stats.rx_fifo_errors++;
-                       }
-                       RTL_W16_F (IntrStatus, RxAckBits);
+       /* Clear out errors and receive interrupts */
+       status = RTL_R16 (IntrStatus) & RxAckBits;
+       if (likely(status != 0)) {
+               if (unlikely(status & (RxFIFOOver | RxOverflow))) {
+                       tp->stats.rx_errors++;
+                       if (status & RxFIFOOver)
+                               tp->stats.rx_fifo_errors++;
                }
+               RTL_W16_F (IntrStatus, RxAckBits);
        }

  done:
--

the driver crashed... even with debug-option was turned on.
Everytime the ksoftirqd started to take cpu-time there were this line in 
the logs:

--
Aug  2 12:10:37 139_interrupt: eth0:.....
--

Notice the 139... it should read rtl8139_interrupt:



Here is a snapshot from the log file when driver is crashing: 
Full logfile is available from: 

http://www.cc.jyu.fi/~ptsjohol/syslog-debug.gz

--
Aug  2 12:10:37 rtl8139_rx: eth0: In rtl8139_rx(), current 03ac BufAddr 036c, free to 039c, Cmd 0c.
Aug  2 12:10:37 rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0000.
Aug  2 12:10:37 rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0001.
Aug  2 12:10:37 rtl8139_rx: eth0: In rtl8139_rx(), current 0484 BufAddr 0444, free to 0474, Cmd 0c.
Aug  2 12:10:37 rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0000.
Aug  2 12:10:37 139_interrupt: eth0: exiting interrupt, intr_status=0x0010.
Aug  2 12:10:37 rtl8139_rx: eth0: In rtl8139_rx(), current 04d0 BufAddr 04cc, free to 04c0, Cmd 0d.
Aug  2 12:10:37 rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0010.
Aug  2 12:10:37 rtl8139_rx: eth0: In rtl8139_rx(), current 04d0 BufAddr 04cc, free to 04c0, Cmd 0d.
Aug  2 12:10:37 rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0010.
Aug  2 12:10:37 rtl8139_rx: eth0: In rtl8139_rx(), current 04d0 BufAddr 04cc, free to 04c0, Cmd 0d.
......
......
Aug  2 12:12:11 rtl8139_rx: eth0: In rtl8139_rx(), current 04d0 BufAddr 04cc, free to 04c0, Cmd 0d.
Aug  2 12:12:11 rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0050.
Aug  2 12:12:11 rtl8139_rx: eth0: In rtl8139_rx(), current 04d0 BufAddr 04cc, free to 04c0, Cmd 0d.
Aug  2 12:12:11 rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0050.
Aug  2 12:12:11 rtl8139_rx: eth0: In rtl8139_rx(), current 04d0 BufAddr 04cc, free to 04c0, Cmd 0d.
Aug  2 12:12:11 rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0050.
--


--
Pasi Sjöholm

