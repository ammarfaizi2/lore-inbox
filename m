Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312978AbSDGGsf>; Sun, 7 Apr 2002 01:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312980AbSDGGse>; Sun, 7 Apr 2002 01:48:34 -0500
Received: from ucsu.Colorado.EDU ([128.138.129.83]:4587 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S312978AbSDGGs0>; Sun, 7 Apr 2002 01:48:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: Urban Widmark <urban@teststation.com>
Subject: Re: Via-Rhine stalls - transmit errors
Date: Sat, 6 Apr 2002 23:43:05 -0700
X-Mailer: KMail [version 1.2]
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02040623430505.00818@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding, issue #6 (or whatever one that was)
Ownership bits, tx rings and other fun stuff:
Here's a bunch of logs I generated which clearly show a problem
with perhaps missed interrupts? mishandled ownership bits??
I do not know the cause but here's the evidence.

Info: 
Logs are generated using a modified kernel driver.
Major changes in operation include abort handling from linuxfet driver.
However, you'll notice the problem I'm talking about does not occur
after either Abort or Aborted interrupt. In fact, I think I have previously 
detected the same problem with the original driver.

More Info:
These are sections of a dmesg -c >> log of an scp transfer
between laptop and desktop. The desktop stubbornly refused to stall this time
(but it stalls other times!), however, the laptop stalled every once in a 
while so it generated the timeout messages I was looking for. The transfer 
has to be INITIATED from the laptop - didn't stall otherwise (but I'm not 
sure about any hardware tests - I'd prefer to look at logs)

So, here are the logs with commentary:

At the beginning, a normal? log
//--------------------------------------------------------
Tx descriptor slot 0: tx_status: 00000000, addr: 13350000, next_desc: 1352a110
Tx descriptor slot 1: tx_status: 00000000, addr: 13350600, next_desc: 1352a120
Tx descriptor slot 2: tx_status: 00000000, addr: 13350c00, next_desc: 1352a130
Tx descriptor slot 3: tx_status: 00000000, addr: 13351200, next_desc: 1352a140
Tx descriptor slot 4: tx_status: 00000000, addr: 13351800, next_desc: 1352a150
Tx descriptor slot 5: tx_status: 00000000, addr: 13351e00, next_desc: 1352a160
Tx descriptor slot 6: tx_status: 00000000, addr: 13352400, next_desc: 1352a170
Tx descriptor slot 7: tx_status: 00000000, addr: 13352a00, next_desc: 1352a180
Tx descriptor slot 8: tx_status: 00000000, addr: 13353000, next_desc: 1352a190
Tx descriptor slot 9: tx_status: 00000000, addr: 13353600, next_desc: 1352a1a0
Tx descriptor slot 10: tx_status: 00000000, addr: 00000000, next_desc:
1352a1b0
Tx descriptor slot 11: tx_status: 00000000, addr: 00000000, next_desc: 
1352a1c0
Tx descriptor slot 12: tx_status: 00000000, addr: 00000000, next_desc: 
1352a1d0
Tx descriptor slot 13: tx_status: 00000000, addr: 00000000, next_desc: 
1352a1e0
Tx descriptor slot 14: tx_status: 00000000, addr: 00000000, next_desc: 
1352a1f0
Tx descriptor slot 15: tx_status: 00000000, addr: 00000000, next_desc: 
1352a100
//-----------------------------------------------------//
frame number is evidence that my frame-1 fix is working.
this log seems normal, except
1) are the addresses supposed to be initialized ? rx addresses are ...
2) what exactly do addr and next_desc point to? how can i check those 
addresses.

------------------------------------------------------
Anyway, here's the abnormal piece causing the problems:
Look at txstatus - notice one 0002 interrupt (tx done) removes 2 ownership 
bits, after which another interrupt removes 0, transmit stops soon, and the 
queue keeps going on until timeout. In another log, I recorded many 
exit_status interrupts between the ownership lock
and the NETDEV timeout. After the timeout, addr fields are marked bad.
Here's the log:

Descriptor messages PRECEDE the interrupt message.
(Interrupt has occured but you get the message after the ownership logs)

Notice the cur->tx and dirty->tx reported after timeout.

0002 is the transmit interrupt, 0001 is the receive one

Tx descriptor slot 0: tx_status: 00000000, addr: 13350000, next_desc: 1352a110
Tx descriptor slot 1: tx_status: 00000000, addr: 13350600, next_desc: 1352a120
Tx descriptor slot 2: tx_status: 00000000, addr: 13350c00, next_desc: 1352a130
Tx descriptor slot 3: tx_status: 00000000, addr: 13351200, next_desc: 1352a140
Tx descriptor slot 4: tx_status: 80000000, addr: 13351800, next_desc: 1352a150
Tx descriptor slot 5: tx_status: 80000000, addr: 13351e00, next_desc: 1352a160
Tx descriptor slot 6: tx_status: 80000000, addr: 13352400, next_desc: 1352a170
Tx descriptor slot 7: tx_status: 00000000, addr: 13352a00, next_desc: 1352a180
Tx descriptor slot 8: tx_status: 00000000, addr: 13353000, next_desc: 1352a190
Tx descriptor slot 9: tx_status: 00000000, addr: 13353600, next_desc: 1352a1a0
Tx descriptor slot 10: tx_status: 00000000, addr: 13353c00, next_desc: 
1352a1b0
Tx descriptor slot 11: tx_status: 00000000, addr: 13354200, next_desc: 
1352a1c0
Tx descriptor slot 12: tx_status: 00000000, addr: 13354800, next_desc: 
1352a1d0
Tx descriptor slot 13: tx_status: 00000000, addr: 13354e00, next_desc: 
1352a1e0
Tx descriptor slot 14: tx_status: 00000000, addr: 13355400, next_desc: 
1352a1f0
Tx descriptor slot 15: tx_status: 00000000, addr: 13355a00, next_desc: 
1352a100
eth0: Interrupt, status 0002.
eth0: exiting interrupt, status=0x0000.
Tx descriptor slot 0: tx_status: 00000000, addr: 13350000, next_desc: 1352a110
Tx descriptor slot 1: tx_status: 00000000, addr: 13350600, next_desc: 1352a120
Tx descriptor slot 2: tx_status: 00000000, addr: 13350c00, next_desc: 1352a130
Tx descriptor slot 3: tx_status: 00000000, addr: 13351200, next_desc: 1352a140
Tx descriptor slot 4: tx_status: 00000000, addr: 13351800, next_desc: 1352a150
Tx descriptor slot 5: tx_status: 00000000, addr: 13351e00, next_desc: 1352a160
Tx descriptor slot 6: tx_status: 80000000, addr: 13352400, next_desc: 1352a170
Tx descriptor slot 7: tx_status: 00000000, addr: 13352a00, next_desc: 1352a180
Tx descriptor slot 8: tx_status: 00000000, addr: 13353000, next_desc: 1352a190
Tx descriptor slot 9: tx_status: 00000000, addr: 13353600, next_desc: 1352a1a0
Tx descriptor slot 10: tx_status: 00000000, addr: 13353c00, next_desc: 
1352a1b0
Tx descriptor slot 11: tx_status: 00000000, addr: 13354200, next_desc: 
1352a1c0
Tx descriptor slot 12: tx_status: 00000000, addr: 13354800, next_desc: 
1352a1d0
Tx descriptor slot 13: tx_status: 00000000, addr: 13354e00, next_desc: 
1352a1e0
Tx descriptor slot 14: tx_status: 00000000, addr: 13355400, next_desc: 
1352a1f0
Tx descriptor slot 15: tx_status: 00000000, addr: 13355a00, next_desc: 
1352a100
eth0: Interrupt, status 0002.
eth0: exiting interrupt, status=0x0000.
Tx descriptor slot 0: tx_status: 00000000, addr: 13350000, next_desc: 1352a110
Tx descriptor slot 1: tx_status: 00000000, addr: 13350600, next_desc: 1352a120
Tx descriptor slot 2: tx_status: 00000000, addr: 13350c00, next_desc: 1352a130
Tx descriptor slot 3: tx_status: 00000000, addr: 13351200, next_desc: 1352a140
Tx descriptor slot 4: tx_status: 00000000, addr: 13351800, next_desc: 1352a150
Tx descriptor slot 5: tx_status: 00000000, addr: 13351e00, next_desc: 1352a160
Tx descriptor slot 6: tx_status: 80000000, addr: 13352400, next_desc: 1352a170
Tx descriptor slot 7: tx_status: 00000000, addr: 13352a00, next_desc: 1352a180
Tx descriptor slot 8: tx_status: 00000000, addr: 13353000, next_desc: 1352a190
Tx descriptor slot 9: tx_status: 00000000, addr: 13353600, next_desc: 1352a1a0
Tx descriptor slot 10: tx_status: 00000000, addr: 13353c00, next_desc: 
1352a1b0
Tx descriptor slot 11: tx_status: 00000000, addr: 13354200, next_desc: 
1352a1c0
Tx descriptor slot 12: tx_status: 00000000, addr: 13354800, next_desc: 
1352a1d0
Tx descriptor slot 13: tx_status: 00000000, addr: 13354e00, next_desc: 
1352a1e0
Tx descriptor slot 14: tx_status: 00000000, addr: 13355400, next_desc: 
1352a1f0
Tx descriptor slot 15: tx_status: 00000000, addr: 13355a00, next_desc: 
1352a100
eth0: Interrupt, status 0001.
 In via_rhine_rx(), entry 14 status 00468f00.
  via_rhine_rx() status is 00468f00.
eth0: exiting interrupt, status=0x0000.
eth0: Transmit frame #6807 queued in slot 7.
eth0: Transmit frame #6808 queued in slot 8.
eth0: Transmit frame #6809 queued in slot 9.
eth0: Transmit frame #6810 queued in slot 10.
eth0: Transmit frame #6811 queued in slot 11.
eth0: Transmit frame #6812 queued in slot 12.
eth0: Transmit frame #6813 queued in slot 13.
eth0: Transmit frame #6814 queued in slot 14.
eth0: Transmit frame #6815 queued in slot 15.
NETDEV WATCHDOG: eth0: transmit timed out
Tx descriptor slot 0: tx_status: 00000000, addr: 13350000, next_desc: 1352a110
Tx descriptor slot 1: tx_status: 00000000, addr: 13350600, next_desc: 1352a120
Tx descriptor slot 2: tx_status: 00000000, addr: 13350c00, next_desc: 1352a130
Tx descriptor slot 3: tx_status: 00000000, addr: 13351200, next_desc: 1352a140
Tx descriptor slot 4: tx_status: 00000000, addr: 13351800, next_desc: 1352a150
Tx descriptor slot 5: tx_status: 00000000, addr: 13351e00, next_desc: 1352a160
Tx descriptor slot 6: tx_status: 80000000, addr: 13352400, next_desc: 1352a170
Tx descriptor slot 7: tx_status: 80000000, addr: 13352a00, next_desc: 1352a180
Tx descriptor slot 8: tx_status: 80000000, addr: 13353000, next_desc: 1352a190
Tx descriptor slot 9: tx_status: 80000000, addr: 13353600, next_desc: 1352a1a0
Tx descriptor slot 10: tx_status: 80000000, addr: 13353c00, next_desc: 
1352a1b0
Tx descriptor slot 11: tx_status: 80000000, addr: 13354200, next_desc: 
1352a1c0
Tx descriptor slot 12: tx_status: 80000000, addr: 13354800, next_desc: 
1352a1d0
Tx descriptor slot 13: tx_status: 80000000, addr: 13354e00, next_desc: 
1352a1e0
Tx descriptor slot 14: tx_status: 80000000, addr: 13355400, next_desc: 
1352a1f0
Tx descriptor slot 15: tx_status: 80000000, addr: 13355a00, next_desc: 
1352a100
Cur Tx points to slot:   0
Dirty Tx points to slot: 6
eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
wait for reset, chip_id: 2
eth0: reset finished after 5 microseconds.
eth0: Transmit frame #0 queued in slot 0.
Tx descriptor slot 0: tx_status: 00000000, addr: 13350000, next_desc: 1352a110
Tx descriptor slot 1: tx_status: 00000000, addr: badf00d0, next_desc: 1352a120


...and so on...

code used to generate logs: - see CHANGE tags for additions
this is in interrupt function, and I have more in the timeout function

      /*CHANGE*/
        int i;
        struct netdev_private *np=dev->priv;


        ioaddr = dev->base_addr;

        while ((intr_status = readw(ioaddr + IntrStatus))) {
                /* Acknowledge all of the current interrupt sources ASAP. */
                writew(intr_status & 0xffff, ioaddr + IntrStatus);

        /*CHANGE*/
        for (i = 0; i < TX_RING_SIZE; i++) {
                printk (KERN_INFO "Tx descriptor slot %i: tx_status: %8.8x, 
addr: %8.8x, next_desc: %8.8x\n",i,
np->tx_ring[i].tx_status, le32_to_cpu(np->tx_ring[i].addr), 
le32_to_cpu(np->tx_ring[i].next_desc));


