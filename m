Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264423AbTK0B4C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 20:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTK0B4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 20:56:02 -0500
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([67.60.40.239]:51589
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S264423AbTK0Bz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 20:55:59 -0500
Message-ID: <3FC559AB.7000806@sh0n.net>
Date: Wed, 26 Nov 2003 20:55:55 -0500
From: Shawn Starr <spstarr@sh0n.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031119 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@osdl.org>
Subject: Random SIGSEGVs and 2.6.0-test10
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's funny you mention random userland SIGSEGV's.

I don't know if this some of the fallout wrt CONFIG_PREEMPT being 
enabled or not but using vmware and running my ncurses mp3 player seems 
to trigger an oddity:

Apon using vmware, it may sometimes crap out with a internal bug # and 
in doing so, sometimes my mp3 player will segfault for no reason. This 
randomly happens. I do have preempt enabled. Even more odd is the fact 
that even if I have only say 4500K left out of 576MB, there is 0 swap 
usage. The kernel malloc fails if there is no physical memory? If I have 
a huge swap file/disk wouldn't it malloc some of that virtual memory? 
There is no OOM kill either happening since there's no log of that from 
the kernel saying it did an OOM kill.

I would certainly like to debug any weird oddities. My systems seem to 
be good test grounds for such things :-)

Thanks,

> List:     linux-kernel
> Subject:  Re: What exactly are the issues with 2.6.0-test10 preempt?
> From:     Linus Torvalds <torvalds () osdl ! org>
> Date:     2003-11-24 23:00:40
> [Download message RAW]
>
> On Mon, 24 Nov 2003, Bradley Chapman wrote:
> >
> > Indeed. Do the same subsystems usually show the memory corruption 
> issue with
> > preempt active, or does it just pop up all over the place, 
> unpredictably?
>
> There are a few reports of "predictable" memory corruption, in the sense
> that the same people tend to see the same kinds of oopses _without_ any
> other signs of memory corruption (ie no random SIGSEGV's in user space
> etc).
>
> There's the magic slab corruption thing, there's a strange thread data
> corruption (one person), and there's the sunrpc timer bug. All are
> "impossible" bugs that would indicate a small amount of data corruption in
> some core data structure.
>
> They are hard to trigger, which makes me personally suspect some
> user-after-free thing, where the bug happens only when somebody else
> allocates (and uses) the entry immediately afterwards (so that the old
> user overwrites stuff that just got initialized for the new user).
>
> It's not likely to be a wild pointer: those tend to corrupt random memory,
> and that in turn is a lot more likely to result in _user_ corruptions
> (causing SIGSEGV's, corrupted files that magically become ok again when
> re-read, etc), since 99% of all memory tends to be non-kernel data
> structures.
>
> The PAGEFREE debug option works well for page allocations, but the slab
> cache is not very amenable to it. For slab debugging, it would be
> wonderful if somebody made a _truly_ debugging slab allocator that didn't
> use the slab cache at all, but used the page allocator (and screw the fact
> that you use too much memory ;) instead.
>
> (Sadly, some slab users actually use that stupid "initialize" crap. We
> should rip it out: it's a disaster from a data cache standpoint too, since
> it tends to do all the wrong things there, even though it's literally
> meant to help).
>
>         Linus

