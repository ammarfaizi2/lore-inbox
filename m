Return-Path: <linux-kernel-owner+w=401wt.eu-S932898AbWLSTJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbWLSTJQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932901AbWLSTJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:09:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55399 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932898AbWLSTJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:09:16 -0500
Date: Tue, 19 Dec 2006 10:59:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612191037291.3483@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins> <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
 <45876C65.7010301@yahoo.com.au> <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
 <45878BE8.8010700@yahoo.com.au> <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org> <4587B762.2030603@yahoo.com.au>
 <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Linus Torvalds wrote:
>
>  here's a totally new tangent on this: it's possible that user code is 
> simply BUGGY. 

Btw, here's a simpler test-program that actually shows the difference 
between 2.6.18 and 2.6.19 in action, and why it could explain why a 
program like rtorrent might show corruption behavious that it didn't show 
before.

	#include <sys/mman.h>
	#include <sys/fcntl.h>
	#include <unistd.h>
	#include <string.h>
	
	int main(int argc, char **argv)
	{
		char *mapping;
		int fd;
	
		fd = open("mapfile", O_RDWR | O_TRUNC | O_CREAT, 0666);
		if (fd < 0)
			return -1;
		if (ftruncate(fd, 10) < 0)
			return -1;
		mapping = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
		if (-1 == (int)(long)mapping)
			return -1;
		memset(mapping, 0xaa, 20);
		sync();
		if (ftruncate(fd, 40) < 0)
			return -1;
		memset(mapping + 20, 0x55, 20);
		write(1, mapping, 40);
		return 0;
	}

Notice the "sync()" in between the "memset()" and the "ftruncate()". In 
2.6.18, that would normally do absolutely _nothing_ to the shared memory 
mapping, becuase we simply couldn't track pages that were dirty in the 
page tables. 

So in 2.6.18, if you try this, with

	./a.out | od -x

you should see something like

	0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
	0000020 aaaa aaaa 5555 5555 5555 5555 5555 5555
	0000040 5555 5555 5555 5555
	0000050

which matches your memset() patterns: 20 bytes of 0xaa, and 20 bytes of 
0x55.

HOWEVER. 

In 2.6.19, because we actually track dirty data so much better, "sync()" 
will actually be smart enough to write out the dirty mmap'ed data too. But 
since the user program has only allocated ten bytes for it in the file, 
when it is written out, the rest of the page is cleared. When you then 
write the last 20 bytes (after _properly_ allocating memory for them), you 
should now see a pattern like

	0000000 aaaa aaaa aaaa aaaa aaaa 0000 0000 0000
	0000020 0000 0000 5555 5555 5555 5555 5555 5555
	0000040 5555 5555 5555 5555
	0000050

instead: with ten bytes of zero in between, because the data that couldn't 
be written out was cleared.

So 2.6.19 is strictly _better_, but exactly because it's tracking dirty 
status much more precisely, you'll see certain user-level bugs much more 
easily.

NOTE NOTE NOTE! The code really _was_ buggy in 2.6.18 too, and you _can_ 
get the zeroes in the middle of the file with an older kernel. But in 
older kernels, you need to be really really unlucky, and have the page 
cleaned by strong memory pressure. In 2.6.19, any "sync()" activity 
(includign from the outside) will clean the page, so a user program with 
this bug can just be made to trigger the bug much more easily.

			Linus
