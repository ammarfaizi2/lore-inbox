Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270747AbUJUPW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270747AbUJUPW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270745AbUJUPV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:21:59 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:31874 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S270748AbUJUPTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:19:21 -0400
Message-ID: <4177D353.8090106@nortelnetworks.com>
Date: Thu, 21 Oct 2004 09:18:43 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com> <4176E001.1080104@zytor.com> <41772674.50403@metaparadigm.com> <417736C0.8040102@zytor.com> <417743EF.90604@nortelnetworks.com> <417744FD.1000008@zytor.com> <41774E20.8000309@nortelnetworks.com> <41774FEE.8020801@zytor.com>
In-Reply-To: <41774FEE.8020801@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> POSIX specifies:

<useful stuff snipped>

> The recvmsg( ) function may fail if:
> 
> [EIO] An I/O error occurred while reading from or writing to the file 
> system.

<snipped>

> Since you didn't code to Linux, and didn't code to POSIX... what did you 
> code to?

I didn't code it--my code generally uses nonblocking sockets or doesn't use 
select at all.  I'm just commenting on existing apps.

What do you mean by "didn't code to Linux"?  The Linux man pages for recvmsg() 
and ip do not mention EIO.  Hence, I suspect that not many people coding for 
Linux will have handled it.  Furthermore, the Linux man page for select() says 
that a socket that is returned as readable will not block on a subsequent read.

>> On the other hand, if you simply do the checksum verification at 
>> select() time for blocking sockets, then the existing binaries get 
>> exactly the behaviour they expect.

> ... unless the blocking changes.  In which case you either have to do 
> work twice, or it might *never* happen.  Not to mention the extra code 
> complexity.

If you verify the checksum at select time, you could just flag the packet as 
verified.  Then even if you do a recvmsg() with MSG_DONTWAIT, you wouldn't have 
to verify it again.  It means an extra pass over the data compared to a full-on 
O_NONBLOCK socket, but it's still correct.

If you change from nonblocking to blocking between select() and recvmsg(), then 
you have a problem, but you're still no worse off than the current situation.

The extra complexity is a valid point, but I suggest that the expectations of 
the installed base are more important.


> The performance overhead of checksumming is substantial; I have seen 
> some real horror examples of what happens when you do it badly.

Again, this is only a backwards compatibility thing.  All new apps should use 
nonblocking sockets anyways, right?  So this way, old apps don't suffer from 
single-packet-DOS attacks, at the cost of a performance penalty.

Chris
