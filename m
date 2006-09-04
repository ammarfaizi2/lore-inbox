Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWIDUIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWIDUIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWIDUIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 16:08:04 -0400
Received: from smtp-out.google.com ([216.239.45.12]:10920 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964983AbWIDUIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 16:08:02 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=G8Q7qUlaZr1okA0ip2imERPY/Carl4apYBd2XV5ESHC0kU+zg1nLKHzLolL76mZ2W
	UVWeoMUqBWtvsCrQOPUwQ==
Message-ID: <44FC8787.70305@google.com>
Date: Mon, 04 Sep 2006 13:07:35 -0700
From: Markus Gutschke <markus@google.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andreas Hobein <ah2@delair.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: Trouble with ptrace self-attach rule since kernel > 2.6.14
References: <200608312305.47515.ah2@delair.de> <Pine.LNX.4.64.0609011117440.27779@g5.osdl.org> <20060902170323.GA369@oleg> <200609041416.03945.ah2@delair.de> <20060904152307.GA98@oleg>
In-Reply-To: <20060904152307.GA98@oleg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> It's a pity to disappoint you, but you may be the 3rd :) Found this
> unanswered message:
> 
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=114073955827139
> 
> (the author cc'ed)


I think, I would be the second one rather than the third one. Linus 
replied to me personally, and that is probably the reason why the 
archive shows the question as unanswered.

For the record (i.e. the mailing list archives), yes, I was able to 
change my application to use clone(CLONE_VM) followed by ptrace(), 
instead of ptrace()'ing from one of the threads in my application.

There were a few minor obstacles that I had to overcome, though. E.g. 
some versions of glibc find the location of "errno" by looking at the 
current stack pointer and masking off some bits. Since my code should be 
portable across a large range of different glibc and kernel versions, I 
had to accommodate this behavior by either 1) allocating the new 
thread's stack within the old thread's stack, effectively sharing 
"errno", or 2) making direct system calls and avoiding all functions 
that access "errno".

The former approach is preferable when using CLONE_VFORK, but if that is 
not an option than the second approach will work OK.

Overall, it turned out to be a few weeks worth of work making these 
changes, but (as usual) most of the time was spent validating that the 
new code works on all platforms and in all usage scenarios. As a result, 
the new code is actually better than the old one. There definitely 
seemed to be problems with the old approach and some older kernels, too.

Using clone(), makes the code slightly less portable, but all of this 
code is already pretty Linux-specific anyway.

I'd be happy to answer any questions about working around various bugs 
in historic kernel and glibc versions.


Markus
