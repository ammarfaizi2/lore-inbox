Return-Path: <linux-kernel-owner+w=401wt.eu-S1030200AbXAKPAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbXAKPAs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 10:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbXAKPAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 10:00:48 -0500
Received: from mail2.domainserver.de ([213.83.41.143]:2641 "EHLO
	smtp.domainserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030200AbXAKPAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 10:00:47 -0500
X-Greylist: delayed 1181 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 10:00:47 EST
Envelope-to: linux-kernel@vger.kernel.org
Delivery-date: Thu, 11 Jan 2007 16:00:47 +0100
From: Daniel Kabs <dkabs@mobotix.com>
Organization: MOBOTIX AG
To: linux-kernel@vger.kernel.org
Subject: unix(7) and MSG_TRUNC semantics
Date: Thu, 11 Jan 2007 15:41:03 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701111541.03667.dkabs@mobotix.com>
X-AUTH: - 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

For IPC, I use unix domain datagram sockets. I receive messages by calling 
recv(). The man page recv(2) tells me about the flags argument to a recv 
call, namely:
 MSG_TRUNC
      Return  the  real  length of the packet, even when it was longer
      than the passed buffer. Only valid for packet sockets.
Thus I used recv() with flags MSG_TRUNC|MSG_PEEK in order to detect 
message truncation due to insufficient buffer size.

Strangely enough, MSG_TRUNC seems to get ignored by the kernel: If the 
message received is larger than the receive buffer I supplied, the 
function returns the size of the buffer. I reckon, the function should 
return the real message size instead.

To work around this problem, I use the ioctl FIONREAD instead.

On the other hand, in this mailing list, I found an old bug report 
describing the same problem using UDP sockets:

http://groups.google.com/group/fa.linux.kernel/browse_frm/thread/fb6acbb527507e26/ad0b2ba33b6b66fa

UDP sockets seem to have been patched by now. From linux/net/ipv4/udp.c:
 udp_recvmsg()
  ...
        err = copied;
        if (flags & MSG_TRUNC)
                err = skb->len - sizeof(struct udphdr);
   ...

Why doesn't unix_dgram_recvmsg() in linux/net/unix/af_unix.c contain code 
to this effect? Is this a feature or a bug?


Cheers
Daniel Kabs
