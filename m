Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbTIOQTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbTIOQTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:19:21 -0400
Received: from extreme.heaven.net ([208.20.133.2]:4845 "EHLO
	extreme.heaven.net") by vger.kernel.org with ESMTP id S261535AbTIOQTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:19:19 -0400
Date: Mon, 15 Sep 2003 16:19:20 -0000
To: <linux-kernel@vger.kernel.org>
Subject: TAP interface on 2.4.22: Reduced MSS causes FTP stalls
From: "James Yonan" <jim@yonan.net>
X-Mailer: TWIG 2.7.7
Message-ID: <twig.1063642760.74284@yonan.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing a new version of OpenVPN which has the ability to lower the MSS on
TCP SYN packets as they pass through a tun or tap tunnel.  I am testing by
running FTP transfers over the tunnel.

I am finding that everything works perfectly over tun tunnels.  The MSS is
lowered and TCP properly uses the MSS as an upper bound on TCP payload size.

On tap tunnels however, an FTP put appears to progress to the end of the data
transfer then stall just prior to data channel close.  The stall can be broken
by pinging the remote tunnel endpoint from the ftp client machine.  The ping
causes the FTP client to instantly complete the stalled transfer.

I am testing by running the tunnel between two x86 systems running 2.4.22,
both locally connected to a 100mbps ethernet LAN.  I have also tested on
2.4.21 with the same results.

I have checked fairly carefully to make sure this isn't a bug in OpenVPN. When
the stall occurs, OpenVPN is blocking on a select() that is waiting for data
to become available on the tap character device.  Pinging the remote tunnel
endpoint unblocks the select call as it should with readable data appearing on
the tap device.  The ping completes, triggering the resumption of the nearly
complete but stalled FTP transfer.  I have been unable to reproduce this
stalling behavior using tun (i.e. point-to-point IPv4) tunnels.  Only tap
(i.e. virtual 802.3 ethernet) tunnels show this stalling behavior.

Somehow the ping seems to kick the stalled TCP session into completing.

The code I am using to tweak the MSS is drawn from the FreeBSD PPP code. 
Apparently, tweaking the TCP MSS in SYN packets is a fairly common approach to
solving MTU problems which arise from TCP protocol encapsulation.  The
tweaking happens in OpenVPN which runs in userspace.  OpenVPN constructs a tap
tunnel by opening the character device end of a tap interface and pushing bits
between the tap device and a UDP socket connected to a remote OpenVPN instance.

Any ideas of what might be wrong or where to look?

James Yonan
OpenVPN Developer

