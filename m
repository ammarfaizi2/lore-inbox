Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWBIWJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWBIWJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 17:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWBIWJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 17:09:17 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:19102 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750807AbWBIWJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 17:09:17 -0500
Message-ID: <43EBBD7C.5@vilain.net>
Date: Fri, 10 Feb 2006 11:09:00 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxh5qhb.fsf@ebiederm.dsl.xmission.com> <20060209021828.GC9456@ccure.user-mode-linux.org> <43EB7007.5040208@watson.ibm.com> <20060209174812.GA6945@ccure.user-mode-linux.org>
In-Reply-To: <20060209174812.GA6945@ccure.user-mode-linux.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> On Thu, Feb 09, 2006 at 11:38:31AM -0500, Hubertus Franke wrote:
>>Jeff, interesting, but won't that post some serious scalability issue?
>>Imaging 100s of container/namespace ?
> In terms of memory?  
> Running size on sched.o gives me this on x86_64:
>    text    data     bss     dec     hex filename
>   35685    6880   28800   71365   116c5 sched.o
> 
> and on i386 (actually UML/i386)
> 
>    text    data     bss     dec     hex filename
>   10010      36    2504   12550    3106 obj/kernel/sched.o
> 
> I'm not sure why there's such a big difference, but 100 instances adds
> a meg or two (or three) to the kernel.  This overstates things a bit
> because there are things in sched.c which wouldn't be duplicated, like
> the system calls.
> 
> How big a deal is that on a system which you plan to have 100s of
> containers on anyway?

Quite a big deal.  You might have 2Gigs of main memory, but your CPU is
unlikely to be more than a Megabyte in close reach.  A meg or two of
scheduler data and code means that your L1 and L2 cache will be cycling
every scheduler round; which is OK if you have very short runqueues but
as you get more and more processes it will really start to hurt.

Remember, systems today are memory bound and anything you can do to
reduce the amount of time the system sits around waiting for memory to
fetch, the better.

Compare that to the Token Bucket Scheduler of Linux-VServer; a tiny
struct for each process umbrella, that will generally fit in one or two
cachelines, to which the scheduling support adds four ints and a
spinlock.  With this it achieves fair CPU scheduling between vservers.

Sam.
