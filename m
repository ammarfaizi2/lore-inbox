Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVL2Oni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVL2Oni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVL2Oni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:43:38 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:61334 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1750736AbVL2Oni convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:43:38 -0500
Date: Thu, 29 Dec 2005 15:43:36 +0100
Message-Id: <395333712@web.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?Burkhard=20Sch=F6lpen?= <bschoelpen@web.de>
To: linux-kernel@vger.kernel.org
Subject: PCI DMA burst delay
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working on a linux driver for a custom pci card (containing a Xilinx FPGA) which is bus master capable and has to transfer large amounts of data with high bandwidth. I finally succeeded in mmaping the dma buffer residing in ram to user space to avoid unnecessary copying. So actually it seems to work quite well, but sometimes I get some trouble (which seems to occur randomly) concerning dma transfers from ram to the device. When this problem occurs, it leads to the fact, that data arrives too late at the input fifo on the pci card (16kBit).

Looking at some signals with an oscilloscope shows the following behaviour:
1. After preparing the dma buffer in ram and telling the pci card that the dma transfer should begin, the first dma burst is transmitted in a normal way.
2. After the first burst, the pci bus grant signal is disabled, so the access to the bus seems to be denied.
3. About 400 nanoseconds later, the pci device tries to initiate the next burst, but does not succeed (pci bus access is not granted)
  => this process is repeated 3 times
4. In most cases the next burst starts here after the third trial (and all other following bursts are following well). But in the (rarely) faulty case, the 2nd burst only starts after another delay of about 600ns, which is too late, because meanwhile I get a buffer underrun in the FPGA. After some delayed bursts the transfer continues normally.

Does anybody have an idea, why the dma bursts could be delayed, although I deactivated all other pci devices that could disturb the transfers? Maybe it is a quite simple issue, because I'm not yet very experienced with dma stuff. Could it be a problem with my driver implementation, because if the problem occurs, it is always after the first burst? The dma buffer in ram I allocated with pci_alloc_consistent() as described in Rubini's book and the DMA-mapping.txt documentation file.

Here is some information about my environment:
- Gigabyte GA-8I945GMF mainboard with Pentium D processor
- custom pci board with Xilinx FPGA Spartan 2 (XC2S150-6) with PCI 32 LogiCore
- Debian Linux with 2.6.13.4 SMP kernel

Another thing I should mention is that I tried to configure the length of the dma bursts with the pci core, but that didn't work. The oscilloscope showed, that the actual burst length never was higher than 512 Bits and I think this is much too less to be efficient! 

Any hint would be very appreciated.

Kind regards,
Burkhard Schölpen

__________________________________________________________________________
Erweitern Sie FreeMail zu einem noch leistungsstarkeren E-Mail-Postfach!		
Mehr Infos unter http://freemail.web.de/home/landingpad/?mc=021131

