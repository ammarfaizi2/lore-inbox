Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTJ2EJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 23:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTJ2EJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 23:09:35 -0500
Received: from relay1.softcomca.com ([168.144.1.67]:61960 "EHLO
	relay1.softcomca.com") by vger.kernel.org with ESMTP
	id S261733AbTJ2EJP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 23:09:15 -0500
Message-ID: <176730-2200310329491330@M2W026.mail2web.com>
X-Priority: 3
Reply-To: odain2@mindspring.com
X-Originating-IP: 66.167.185.215
X-URL: http://mail2web.com/
From: "odain2@mindspring.com" <odain2@mindspring.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_PACKET_MMAP revisited
Date: Tue, 28 Oct 2003 23:09:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 29 Oct 2003 04:09:13.0027 (UTC) FILETIME=[6934D930:01C39DD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking into faster ways to do packet captures and I stumbled on
the following discussion on the Linux Kernel mailing list:

http://www.ussg.iu.edu/hypermail/linux/kernel/0202.2/1173.html

In that discussion Jamie Lokier suggested having a memory buffer that's
shared between user and kernel space and having the NIC do DMA transfers
directly to that buffer as an alternative to using Alexy's shared ring
buffer stuff.  The argument was that this would avoid the memory copy that
the kernel does from the DMA buffer to the memory mapped ring buffer. 
However, Alan Cox pointed out that the main cost of the memory copy is
getting the data from system memory (where the NIC put it via DMA) into the
L1 cache (DMA doesn't do any cache coherence so it can't go there
directly).  The memory copy (presumably from L1 cache to L1 cache) is
insignificant compared to this cost and since you'll need to get the data
into L1 cache to use it anyway, the memory copy is virtually free.

I'm wondering if this takes all of the costs into account.  If I understand
how this works the user space application can't get at the packet without a
context switch so that the kernel can first copy the packet to the shared
buffer.  The cost of the context switch is pretty high and this seems to me
to be the main bottleneck.  I believe that in normal operation each packet
(or with NICs that do interrupt coalescing, every n packets) causes an
interrupt which causes a context switch, the kernel then copies the data
from the DMA buffer to the shared buffer and does a RETI.  That's fairly
expensive.  If, on the other hand, data could be copied directly to
user-space accessible memory the NIC wouldn't need to generate any
interrupts and the kernel wouldn't need to get involved at all (this
assumes a NIC that can be configured not to generate any interrupts).  The
user space application could then poll the shared buffer and process
packets as fast as possible (some synchronization mechanism is clearly
needed here, but I think some of the high-end programmable NICs could do
this).  Would this not be significantly more efficient then the current
implementation?

Thank,
Oliver

PS: I'm not a mailing list subscriber so CCs on responses would be
appreciated.



--------------------------------------------------------------------
mail2web - Check your email from the web at
http://mail2web.com/ .


