Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268658AbUJUGCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268658AbUJUGCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUJUF7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:59:02 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:15260 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S269881AbUJUF6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:58:13 -0400
Message-ID: <41774FEE.8020801@zytor.com>
Date: Wed, 20 Oct 2004 22:58:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com> <4176E001.1080104@zytor.com> <41772674.50403@metaparadigm.com> <417736C0.8040102@zytor.com> <417743EF.90604@nortelnetworks.com> <417744FD.1000008@zytor.com> <41774E20.8000309@nortelnetworks.com>
In-Reply-To: <41774E20.8000309@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> H. Peter Anvin wrote:
> 
>>> H. Peter Anvin wrote:
>>>
>>>> The whole point is that it doesn't break the *documented* interface.
> 
> 
>> I'm talking about returning -1, EIO.
> 
> 
> 
> Ah.  By "it", I thought you meant the current performance optimizations, 
> not the EIO.  My apologies.
> 
> I think returning EIO is suboptimal, as it is not an expected error 
> value for recvmsg().  (It's not listed in the man pages for recvmsg() or 
> ip.)  It would certainly work for new apps, but probably not for many 
> existing binaries.

POSIX specifies:

The recvmsg( ) function shall fail if:

[EAGAIN] or [EWOULDBLOCK] The socket's file descriptor is marked 
O_NONBLOCK and no data is waiting to be received; or MSG_OOB is set and 
no out-of-band data is available and either the socket s file descriptor 
is marked O_NONBLOCK or the socket does not support blocking to await 
out-of-band data.

[EBADF] The socket argument is not a valid open file descriptor.

[ECONNRESET] A connection was forcibly closed by a peer.

[EINTR] This function was interrupted by a signal before any data was 
available.

[EINVAL] The sum of the iov_len values overflows a ssize_t, or the 
MSG_OOB flag is set 37371 and no out-of-band data is available.

[EMSGSIZE] The msg_iovlen member of the msghdr structure pointed to by 
message is less 37373 than or equal to 0, or is greater than {IOV_MAX}.

[ENOTCONN] A receive is attempted on a connection-mode socket that is 
not connected.

[ENOTSOCK] The socket argument does not refer to a socket.

[EOPNOTSUPP] The specified flags are not supported for this socket type.

[ETIMEDOUT] The connection timed out during connection establishment, or 
due to a transmission timeout on active connection.

The recvmsg( ) function may fail if:

[EIO] An I/O error occurred while reading from or writing to the file 
system.

[ENOBUFS] Insufficient resources were available in the system to perform 
the operation.

[ENOMEM] Insufficient memory was available to fulfill the request.

Since you didn't code to Linux, and didn't code to POSIX... what did you 
code to?

> On the other hand, if you simply do the checksum verification at 
> select() time for blocking sockets, then the existing binaries get 
> exactly the behaviour they expect.
> 

... unless the blocking changes.  In which case you either have to do 
work twice, or it might *never* happen.  Not to mention the extra code 
complexity.

The performance overhead of checksumming is substantial; I have seen 
some real horror examples of what happens when you do it badly.

	-hpa
