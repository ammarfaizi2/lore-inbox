Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275391AbRJASqq>; Mon, 1 Oct 2001 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275389AbRJASqh>; Mon, 1 Oct 2001 14:46:37 -0400
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:25303 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S275388AbRJASq2>; Mon, 1 Oct 2001 14:46:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: Makefile gcc -o /dev/null: the dissapearing of /dev/null
Date: Mon, 1 Oct 2001 10:46:18 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010929114304.A21440@lug-owl.de> <Pine.LNX.4.33.0109290535390.25966-100000@cerberus.stardot-tech.com> <20010929202148.D26521@lug-owl.de>
In-Reply-To: <20010929202148.D26521@lug-owl.de>
MIME-Version: 1.0
Message-Id: <01100110461905.08995@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 September 2001 14:21, Jan-Benedict Glaw wrote:

> No-go. It's perfectly okay to remove an opened file. Test it yourself.
> You may even replace a running (!) executable...

Which isn't actually too frightening since the filehandle of an open file 
counts as a link to the inode, so the inode won't actually be removed until 
that file handle is closed.  The associated disk space won't be freed until 
then either, etc.  And if you create a new file with the same name, it 
doesn't change which inode your executable is currently bound to.  It's like 
renaming your existing file to something else and renaming some other file to 
have that original name.  Who cares?  That's not the inode our file handle 
points to.  Deleting the last directory link just prevents new filehandles 
from being opened against it (except maybe by dup(2), or forking a child that 
inherits the parent's file handles...)

Slightly oversimplifying, running an executable opens the file and mmaps the 
sucker in to your process space and jumps to the code, page faulting stuff in 
as needed.  If the directory entry that was used to open it is then renamed 
or removed, the process doesn't care.  It already has the file open, it's 
happy.

This is also part of the magic (in linux/fs/exec.c) that makes shared 
libraries work.  mmaping in the same file twice can share physical pages 
without having to do anything special.  One cheap and easy (and ugly) way of 
doing writable shared memory is to create a writable temp file, mmap it in 
twice (once in each process), and then unlink it from the directory while 
keeping it open and mapped in in both processes.  It's ugly.  It's easy.  
It's portable.  It's really ugly.  It creates unnecessary disk access on a 
lot of systems, but then so does swapping...

Now opening an executable and WRITING to the file while it was running would 
be fairly unpleasant.  I believe changing its contents would change stuff in 
memory, because of the mmap.  (Correct me if I'm wrong.)  But I seriously 
doubt that's allowed.

The situation is slightly confused since so much stuff does an 
open/truncate/write instead of an unlink/create/write.  But if it didn't, 
stuff like "cp bootnet.img /dev/fd0" wouldn't work as expected, and "echo 
blah > /dev/null" would delete /dev/null and replace it with a short text 
file.  Not good.  Since truncate on block devices is ignored, the above two 
examples work as expected.  (It also automatically maintains ownership and 
permissions and such when editing other people's files that are world 
writable or being twiddled by root.  And there's no race condition between 
deleting the old file and creating the new one...)

Rob
