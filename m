Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUJGW4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUJGW4h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269892AbUJGW4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:56:05 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:28655 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267923AbUJGWjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:39:49 -0400
Message-ID: <4165C58A.9030803@nortelnetworks.com>
Date: Thu, 07 Oct 2004 16:39:06 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: martijn@entmoot.nl, hzhong@cisco.com, jst1@email.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>	<41658C03.6000503@nortelnetworks.com>	<015f01c4acbe$cf70dae0$161b14ac@boromir>	<4165B9DD.7010603@nortelnetworks.com>	<20041007150035.6e9f0e09.davem@davemloft.net>	<4165C20D.8020808@nortelnetworks.com> <20041007152634.5374a774.davem@davemloft.net>
In-Reply-To: <20041007152634.5374a774.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Chris Friesen <cfriesen@nortelnetworks.com> wrote:

>>What I had in mind was that the non-blocking file descriptor have select() 
>>return without verifying the checksum, and if it was discovered to be bad at 
>>recvmsg() time, we return EAGAIN.
> 
> 
> That's what we do.  In net/ipv4/udp.c:udp_recvmsg()

Yes.  I realize this, and agree with that behaviour.

However, you chopped off what I consider the interesting part of my post.   I 
propose that if we call select() on a blocking file descriptor, we verify the 
checksum before saying that the socket is readable.  Then, at recvmsg() time, if 
it hasn't been checked already we would check it (to allow for the case of 
blocking socket without select()).

This allows for easy porting of apps that expect a blocking recvmsg() after 
select() to always succeed.

Thus, you end up with:

nonblocking socket -- exactly as current
blocking socket without select -- exactly as current
blocking socket with select -- checksum verified before select() returns


Chris
