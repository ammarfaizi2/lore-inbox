Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUAJRBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUAJRBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:01:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:31882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265256AbUAJRBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:01:39 -0500
Date: Sat, 10 Jan 2004 08:35:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Klaus Ripke <paul@malete.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mm/filemap.c: atomic file read(2)/write(2) ?
In-Reply-To: <200401091308.45802.paul@malete.org>
Message-ID: <Pine.LNX.4.58.0401092144330.1877@evo.osdl.org>
References: <200401091308.45802.paul@malete.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jan 2004, Klaus Ripke wrote:
> 
> judging from mm/filemap.c it seems like
> ordinary reads/writes should be atomic to each other
> (read sees write completely or not at all,
> not only where it "can be proven to be after the write"),
> if

Nope. There are file descriptors that have atomicity guarantees (pipes(, 
but regular files do not. In particular, even on UP you'll see nonatomic 
reads with PREEMPT enabled.

Even without preempt you could see interesting partial updates if you take 
a page fault. That's true even if your user space only ever reads or 
writes within a whole page, since what you can get on the read() path is:

 - read one word from the page cache
 - try to write it to user space
 - take a page fault - sleep

 - writer now comes in and updates the region

 - the reader comes back after the page fault
 - the reader completes the copy_to_user(), but the _first_ word was read 
   from the old page cache contents and not re-read.

(This will depend on which particular version of copy_to_user() you use: a
"rep movs" will re-read the page cache and give an "atomic" read, while
all other forms of memory copies will only re-try the destination write
instruction, with the old value read from the source).

		Linus
