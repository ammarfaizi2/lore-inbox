Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLJKiu>; Sun, 10 Dec 2000 05:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129521AbQLJKik>; Sun, 10 Dec 2000 05:38:40 -0500
Received: from turnover.lancs.ac.uk ([148.88.17.220]:40696 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S129348AbQLJKiW>; Sun, 10 Dec 2000 05:38:22 -0500
Message-Id: <l0313030bb658f80c3180@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 10 Dec 2000 10:07:42 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <j.d.morton@lancaster.ac.uk>
Subject: Traffic storm interaction with MacOS 8.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been noticing a problem associated with certain pairings of
applications on my home LAN, specifically when attempting to send large
amounts of data through some types of forwarder.  I have just been able to
isolate the exact symptoms and a possible cause of the problem, which I
describe below:

Setup:
	Client A is a PowerMac 8100/80 with a G3 CPU upgrade, MacOS 8.6
	Link between CLient A and Gateway is 10baseT Ethernet
	Gateway is either:
		a 486DX/25 running Linux 2.2.16; or
		a P166/MMX running Linux 2.4.0-test10
	Link between Gateway and Client B is variable, but can include a
		standard 56k modem and is certainly slower than 10baseT.
	Client B is somewhere on the Internet, with a slowish connection

Applications affected:
	Client A running Ircle 3.1a10 and performing a DCC SEND to Client B
through tircproxy running on Gateway.
	Client A running TridiaVNC Server 3.4.0 alpha <whatever> and
sending data to a VNC client running on Client B, through tcpxd running on
Gateway.

Symptoms:
	Shortly after beginning a transfer exceeding approximately 32Kb in
size, utilisation on the LAN between CLient A and Gateway exceeds 60%.  CPU
utilisation on both hosts sticks at 100%; in the case of the 486, the
entire machine locks up and is unusable for the duration of the storm,
which lasts until the connection is closed on CLient A or the link is
physically severed.  When the P166 is in use, the effect is much less
severe and the machine is able to continue processing and forwarding data
to CLient B, and the traffic storm is intermittent with pulses occurring
approximately 20-60 seconds apart on a typical connection.  The machine
also remains generally usable, allowing me to examine the data involved.

	Examining the storm in progress using tcpdump reveals that the
storm occurs when the Receive window of the Gateway end of the connection
is zero.  The storm itself consists of repeated exchanges of TCP packets
containing no data and still advertising the zero-sized receive window.  On
the P166, the storm abates when the receive window becomes non-zero (ie.
when some data has been sent to Client B) and resumes when the original
condition of (receive window zero AND Client A has data to send) is present.

Analysis:
	This is probably a bug in the MacOS, as well as in Linux, and the
presence of both is necessary to cause the effect.  I believe it can be
worked around in the Linux kernel without affecting correctly-operating
systems, in the following manner.  The workaround involves NOT sending more
than one TCP responses in a row which advertise a zero receive window,
unless some other relevant aspect of the connection has changed (eg. data
is flowing in the opposite direction).  This would break the cycle,
eliminating the storm.  When the receive window becomes available again, a
single, empty TCP packet would be generated advertising the new window
size; this I believe is already present.

NB: I am not a kernel hacker, thus I don't feel confident to introduce a
patch myself.  I hope someone will pick this up, review it, and take the
necessary action...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a19 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
