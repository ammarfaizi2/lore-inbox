Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVGVUA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVGVUA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVGVUA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:00:29 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:23768 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261320AbVGVUA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:00:27 -0400
Subject: slow tcp acks on loopback device
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: samba-technical@lists.samba.org
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1122062219.29258.12.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Jul 2005 14:56:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing odd tcp characteristics on the loopback device.

In analyzing cifs read performance to samba, I see a fairly consistent
pattern.

TCP frame containing SMBRead request (asking for size 16K)
1st 16K of SMB Read Response  (1 ms later or less) sent from samba
	Samba's response is just over 16K (due to protocol header)
wait 40ms doing nothing AFAIK
tcp ack from client to server
TCP frame with last few bytes of the SMB ReadResponse
TCP frame containing next SMB Read Request (asking for size 16K) etc.

I added a setsockopt call to cifs's ipv4_connect to set TCP_NODELAY to 1
(done once just after the connect) which did not seem to help.

Noticing that the loopback device (at least on RHEL4) has an unfortunate
mtu size 16384 (which is about 50 bytes too small for SMB read
responses), I did try increasing the MTU slightly.  Changing that to
18000 did avoid the fragmentation and the 40ms delay - but what puzzled
me was why setting TCP_NODELAY after the socket was created did not
eliminate the delay on the ack and if there is a way to avoid the huge
tcp ack delay by either doing something else to force client acking
immediately or to do something on the client side of the stack to get
the server to send the whole 16K+ frame - it looks like the tcp windows
is 32K if the value in the tcp acks in the network trace is to be
trusted.

