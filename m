Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTKMHxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 02:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTKMHxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 02:53:09 -0500
Received: from mail.webmaster.com ([216.152.64.131]:63462 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262052AbTKMHxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 02:53:06 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "kirk bae" <justformoonie@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: RE: So, Poll is not scalable... what to do?
Date: Wed, 12 Nov 2003 23:52:55 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEMEHOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <LAW12-F60bw5TYIo9WF0002bec8@hotmail.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If poll is not scalable, which method should I use when writing
> multithreaded socket server?

	'poll' is quite scalable. It's only not scalable if you make stupid
assumptions about how people use it.

> What is the most efficient model to use?
>
> Is there a "standard" model to use when writing a scalable multithreaded
> socket serve such as "io completion ports" on windows?

	If all your sockets are equally active, having a bunch of threads each
'poll'ing 1,024 descriptors is perfectly scalable. 64,000 is not a problem,
and that's about the kernel limit if memory serves me.

	If you have active and inactive sockets, sort them. Have some threads that
'poll' on large numbers of inactive sockets and some that 'poll' on small
numbers of active sockets. This will scale quite well as the expensive
'poll' calls are infrequent compared to the cheap ones.

> From the "Microbenchmark comparing poll, kqueue, and /dev/poll",
> kqueue is
> the way to go. Am I correct?

	Yes, if you're using a kernel that supports it. It will pretty much always
be more efficient than 'poll'.

> Also, why is it that poll doesn not return with "close signal" when a
> thread-1 calls poll and thread-2 calls close on a sockfd1? It seems that
> poll only handles close signal when a client disconnects from the server.
> I've seen this mentioned here before, has it been fixed?

	You can never ever make this work. There will always be a race condition no
matter what you do. (How can you ever be sure thread-2 doesn't all 'close'
jsut before thread-1 calls 'poll'?) So do not ever do this. Do not ever
release a shared resource while a thread is or might be using it because it
might also be about to use it!

	DS


