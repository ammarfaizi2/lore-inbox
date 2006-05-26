Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWEZVuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWEZVuD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWEZVuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:50:03 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:25027 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750958AbWEZVuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:50:02 -0400
Message-ID: <44777805.2060600@gmail.com>
Date: Fri, 26 May 2006 22:49:57 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <20060513160541.8848.2113.stgit@localhost.localdomain> <p73u07t5x6f.fsf@bragg.suse.de> <20060526085916.GA14388@elte.hu> <b0943d9e0605260937j5a86d4dr4adcae6fc35c73fa@mail.gmail.com> <20060526174723.GD30208@elte.hu>
In-Reply-To: <20060526174723.GD30208@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Ingo Molnar wrote:
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
>>A problem I'm facing (also because I'm not familiar with the other 
>>architectures) is detecting the effective stack boundaries of the 
>>threads running or waiting in kernel mode. Scanning the whole stack 
>>(8K) hides some possible leaks (because of no longer used local 
>>variables) and not scanning the list at all can lead to false 
>>positives. I would need to investigate this a bit more.
> 
> i was thinking about this too, and i wanted to suggest a different 
> solution here: you could build a list of "temporary" objects that only 
> get registered with the memleak proper once a thread exits a system call 
> (or once a kernel thread goes back to its main loop). This means a 
> (lightweight) callback in the syscall exit (or irq exit) path. This way 
> you'd not have to scan kernel stacks at all, only .data and the objects 
> themselves.

That's an interesting approach. I'll first look at the level of false
positives without scanning the stacks at all.

> avoiding the scanning of the kernel stacks gets rid of some of the 
> biggest source of natural entropy. (they contain strings and all sorts 
> of other binary data that could accidentally match up with a kernel 
> pointer)

Indeed, there is a quite high rate of false negatives (undetected leaks)
in my tests, especially on SMP, when scanning the stacks. However, I
haven't got any false positive when not scanning them (on an embedded
platform). I think even the false positives in this case would be mainly
temporary (until a moment of relative calm, i.e. most tasks sleeping).

On SMP there can be another issue - pointers kept in registers only -
leading to false positives. Anyway, I think it's more important to have
a few (temporary) false positives rather than missing real memory leaks.

Catalin
