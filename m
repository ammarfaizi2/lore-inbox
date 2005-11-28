Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVK1XFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVK1XFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVK1XFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:05:41 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:15120 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932269AbVK1XFl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:05:41 -0500
Message-ID: <438B8BF8.4020604@vmware.com>
Date: Mon, 28 Nov 2005 15:00:08 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org> <438B600C.1050604@tmr.com> <438B827A.2090609@wolfmountaingroup.com>
In-Reply-To: <438B827A.2090609@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Nov 2005 23:00:08.0305 (UTC) FILETIME=[7A765610:01C5F46F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

>
> In 2-3 years we might actually see the hardware solution, maybee .... 
> I am skeptical Intel will move quickly on it. A software solution will 
> get out faster.



I'm not sure a hardware solution is even the right thing - consider a 
shared memory database process with a private heap.  You really want 
locks on the shared memory, and you really don't on the heap.

You need a way to type the lock semantics by memory region, and a 
working hardware solution can not perform as well as a careful software 
solution.  As was pointed out earlier, you can't use memory type 
attributes to infer lock semantics, you must assume them in the decoder 
or implement complex deadlock detection and recovery in silicon.

I would be willing to bet that library users know best.  Most cleanly 
written libraries already have wrapper functions that can be used to 
plug in needed libc functions like malloc, even file I/O.  Even if they 
don't, you can rewrap all of the imported functions.  Using this, you 
can isolate threaded libraries from single threaded applications, and 
make sure the performance critical libraries use non-threaded 
operations.  You can even afford to use a medium heavy hammer and switch 
from non-threaded to threaded dependent libraries every time you call a 
thread-using library function, because by assumption, the majority of 
performance critical code is going to be running single threaded.

Zach
