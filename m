Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUJGV4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUJGV4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268357AbUJGVvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:51:40 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:37118 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268293AbUJGVtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:49:31 -0400
Message-ID: <4165B9DD.7010603@nortelnetworks.com>
Date: Thu, 07 Oct 2004 15:49:17 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martijn Sipkema <martijn@entmoot.nl>
CC: hzhong@cisco.com, "'Jean-Sebastien Trottier'" <jst1@email.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'David S. Miller'" <davem@redhat.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com> <41658C03.6000503@nortelnetworks.com> <015f01c4acbe$cf70dae0$161b14ac@boromir>
In-Reply-To: <015f01c4acbe$cf70dae0$161b14ac@boromir>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martijn Sipkema wrote:
> From: "Chris Friesen" <cfriesen@nortelnetworks.com>

>>Since we wouldn't be posix compliant anyway in the nonblocking case, we may as 
>>well return EAGAIN--it's the most appropriate.
> 
> 
> No, I don't think so, since POSIX says to return EAGAIN when:
> 
>   The socket's file descriptor is marked O_NONBLOCK and no data is waiting to
>   be received; or MSG_OOB is set and no out-of-band data is available and either
>   the socket's file descriptor is marked O_NONBLOCK or the socket does not
>   support blocking to await out-of-band data

We are discussing the case where the socket is nonblocking and the udp checksum 
is corrupt, right?  (Because in the blocking case select() would verify the 
checksum.)

In this case, select() returns with the socket readable, we call recvmsg() and 
discover the message is corrupt.  At this point we throw away the corrupt 
message, so we now have no data waiting to be received.  We return EAGAIN, and 
userspace goes merrily on its way, handling anything else in its loop, then 
going back to select().

Seems perfectly suitable.

Chris
