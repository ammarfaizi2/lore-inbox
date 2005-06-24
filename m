Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbVFXRxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbVFXRxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 13:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbVFXRxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 13:53:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:65253 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263375AbVFXRwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 13:52:45 -0400
Subject: kernel setsocketoptions API - can not set options to avoid very
	slow TCP ACK
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: jra@samba.org, linux-cifs-client@lists.samba.org
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1119635364.14908.51.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Jun 2005 12:49:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at some network traces today that indicated the need to
set TCP_NODELAY, and possibly turn on/off TCP_QUICKACK in a few places -
but I don't see a reasonable way to call set socketoptions for TCP
sockets from kernel - they seem to require a user space pointer.

The details, sequential network file copy from server:
	mounted over loopback interface using most current cifs 
	to most current samba 3

	dd if=/mnt/bigfile of=/dev/null BS=1M

	The file read requests are for 16K (the negotiated buffer size)
	over the network to Samba

	The read responses are being sent quickly enough by
	samba (less than 1ms).  The responses are a bit over 16K due to 
	protocol headers - perhaps 16K+100.

	TCP/IP fragments the response into two pieces.  One almost
	16K and and the remaining 100 bytes or so in a second frame.

	The second small frame is held up for a few hundred 
	milliseconds (!) waiting on the client TCP stack to 
	do a TCP ACK.

	This results in terrible network utilization as the second 
	read request will not be issued until the first response is 
	completely received.  This particular case is probably about
	50 times slower than it should be due to waiting on the slow
	ACK.

There are various other things that would help of course - running other
processes on the client accessing the network filesystem would cause the
ack to sometimes happen faster, and async dispatching of more read
requests at one time, or of even larger read requests, but this case
does indicate that turning on quickack on the client for the case of
waiting for large read responses, and probably readdir (which responses
are also similar in size) is worth trying.   In addition, smbfs (in user
space) sets TCP_NODELAY for its sockets when it mounts and that is
probably appropriate here as well for cifs client.  Is there a
recommended way to set this in kernel - NFS/SunRPC seems to set its
socket options directly in sock->sk and that is fine with me but it
would look a little strange to do
	tp->nonagle |= TCP_NAGLE_OFF | TCP_NAGLE_PUSH 
and
	ip_push_pending _frames
in filesystem code (since calling net/ipv4/tcp.c setsocketoption is not
possible).

