Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSGQX6I>; Wed, 17 Jul 2002 19:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSGQX6I>; Wed, 17 Jul 2002 19:58:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47071 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S315222AbSGQX6H>; Wed, 17 Jul 2002 19:58:07 -0400
Date: Wed, 17 Jul 2002 20:01:05 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207180001.g6I015f02681@devserv.devel.redhat.com>
To: torvalds@transmeta.com (Linus Torvalds)
cc: linux-kernel@vger.kernel.org
Subject: Re: close return value
In-Reply-To: <mailman.1026868201.10433.linux-kernel2news@redhat.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020716.165241.123987278.davem@redhat.com> <1026869741.2119.112.camel@irongate.swansea.linux.org.uk> <20020716.172026.55847426.davem@redhat.com> <mailman.1026868201.10433.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>From: David S. Miller <davem@redhat.com>

>>   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>>   Date: 17 Jul 2002 02:35:41 +0100
>>
>>   Our NFS can return errors from close().
>>
>>Better tell Linus.
> 
> Oh, Linus knows.  In fact, Linus wrote some of the code in question. 
> 
> But the thing is, Linus doesn't want to have people have the same issues
> with local filesystems.  I _know_ there are broken applications that do
> not test the error return from close(), and I think it is a politeness
> issue to return error codes that you can know about as soon as humanly
> possible. 

> For NFS, you simply cannot do any reasonable performance without doing
> deferred error reporting.  The same isn't true of other filesystems. 
> Even in the presense of delayed block allocation, a local filesystem can
> _reserve_ the blocks early, and has no excuse for giving errors late
> (except, of course, for actual IO errors). 

I really hate to disagree with the chief penguin here, but
it's extremely dumb to return errors from close(). The last
time we trashed this issue on this list was when a newbie used
an error return from release() to communicate with his driver.

The problem with errors from close() is that NOTHING SMART can be
done by the application when it receives it. And application can:

 a) print a message "Your data are lost, have a nice day\n".
 b) loop retrying close() until it works.
 c) do (a) then (b).

The thing about (b) is that the kernel can do it much better.
Another thing proponents of errors from close() better ask themselves
is if the file descriptor stays open or closed if close() abends.
If it remains open, your exit() is bust. If it closes, you
cannot retry the error (b).

-- Pete
