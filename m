Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270048AbUJUDFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270048AbUJUDFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUJUDE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:04:29 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:24961 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S270527AbUJUDAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:00:19 -0400
Message-ID: <41772674.50403@metaparadigm.com>
Date: Thu, 21 Oct 2004 11:01:08 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com> <4176E001.1080104@zytor.com>
In-Reply-To: <4176E001.1080104@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/04 06:00, H. Peter Anvin wrote:
> Chris Friesen wrote:
> 
>> H. Peter Anvin wrote:
>>
>>> EIO seems to be The Right Thing[TM]... it pretty much says "yes, we
>>> received something, but it was bad."  What isn't clear to me is how
>>> applications react to EIO.  It could easily be considered a fatal
>>> error... :-/
>>
>>
>>
>>  From an application point of view, The Right Thing would be to do the 
>> checksum validation at select() time if the socket is blocking.
>>
>> If it's nonblocking, then just do as we do now and return EAGAIN at 
>> recvmsg() time.
>>
>> This would ensure that all existing apps get the expected semantics, 
>> but the ones based on blocking sockets would see a performance 
>> degredation.
>>
> 
> Doing work twice can hardly be considered The Right Thing.

Optimisations that break documented interfaces and age old assumptions
can hardly be considered The Right Thing :)

And you only do the checksum once (just earlier), and the copy_to_user
should be cache hot as most of these UDP apps will call recvmesg right
after the select.

That said, an app with many connected sockets will have a high chance
of losing the cache. Although a handful of unconnected UDP sockets
(one per interface) are more common in the use case of a large number
of clients, so in general the performance difference should be minor.

Doing the same amount work (with chance of lower performance because of
cache loss) is good IMHO if it means the choice of a reliable vs an
unreliable interface. You can only take the performance optimisation
argument so far and when these optimisations start breaking interfaces,
i think that's too far ie. what to give up efficiency vs. correctness?

Just my 2c in favour of !O_NONBLOCK early UDP checksum test in select.

~mc
