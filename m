Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269871AbUJGW1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269871AbUJGW1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269869AbUJGW0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:26:33 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:36332 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268340AbUJGWY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:24:56 -0400
Message-ID: <4165C20D.8020808@nortelnetworks.com>
Date: Thu, 07 Oct 2004 16:24:13 -0600
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
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>	<41658C03.6000503@nortelnetworks.com>	<015f01c4acbe$cf70dae0$161b14ac@boromir>	<4165B9DD.7010603@nortelnetworks.com> <20041007150035.6e9f0e09.davem@davemloft.net>
In-Reply-To: <20041007150035.6e9f0e09.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Chris Friesen <cfriesen@nortelnetworks.com> wrote:

>>In this case, select() returns with the socket readable, we call recvmsg() and 
>>discover the message is corrupt.  At this point we throw away the corrupt 
>>message, so we now have no data waiting to be received.  We return EAGAIN, and 
>>userspace goes merrily on its way, handling anything else in its loop, then 
>>going back to select().

> Incorrect.  When the user specifies blocking on the file descriptor
> we must give it what it asked for.  -EAGAIN on a blocking file descriptor
> is always a bug, in all situations, that's what this code used to do and we
> fixed it because it's a bug.

I believe you misread what I said.  Just before the above quote, I said "We are 
discussing the case where the socket is nonblocking and the udp checksum is 
corrupt, right? "

What I had in mind was that the non-blocking file descriptor have select() 
return without verifying the checksum, and if it was discovered to be bad at 
recvmsg() time, we return EAGAIN.  For a blocking file descriptor, we would 
verify the checksum before returning from select().

That way, the blocking case gets the semantics it expects (although worse 
performance), while the nonblocking case gets full performance as well as 
semantics that it will handle properly.

Chris
