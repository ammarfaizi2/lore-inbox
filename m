Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160069-27302>; Sun, 31 Jan 1999 14:14:50 -0500
Received: by vger.rutgers.edu id <157467-27302>; Sun, 31 Jan 1999 14:14:25 -0500
Received: from [207.181.251.162] ([207.181.251.162]:6767 "EHLO bitmover.com" ident: "root") by vger.rutgers.edu with ESMTP id <160069-27302>; Sun, 31 Jan 1999 14:12:23 -0500
Message-Id: <199901311924.LAA04620@bitmover.com>
To: linux-kernel@vger.rutgers.edu
From: lm@bitmover.com (Larry McVoy)
Subject: Re: Page coloring HOWTO [ans] 
Date: Sun, 31 Jan 1999 11:24:39 -0800
Sender: owner-linux-kernel@vger.rutgers.edu

davem@redhat.com (Hey, look where Dave is :-) says:

:    Page coloring, in the sense that we are talking about here,
:    is %99 dealing with physically indexed secondary/third-level
:    etc. caches.  Virtually indexed secondary/third-level caches
:    are dinosaurs 

Are you sure about that? We should come to agreement on terminology.
I thought that the HyperSparc was virtually indexed and virtually tagged,
with just about everything else being virtually indexed but physically
tagged.

: The following is a distribution scheme which I found to work extremely
: well in practice and testing:
: 
:     Add to task_struct a member "int cur_color;"
: 
:     Add to inode a member "int cur_color"
: 
:     When giving a new address space to a process (via exec() or some
:     other means, but not during fork/clone for example) set
:     tsk->cur_color to zero.
: 
:     When allocating a new inode structure in the vfs, set
:     inode->cur_color to zero.
: 
:     Now track page cache, page table allocation, and anonymous page
:     faulting in the following way:
: 
:        a) At each anonymous page write fault, allocate a free page
:           with color current->cur_color, and then increment this.
: 
:        b) At each page table page allocation, do the same as in #a
: 
:        c) At each addition of a new page into the page cache, allocate
:           this page using the vfs object's inode->cur_color, and then
:           increment.

This has some nice attributes in that it will work well if a process
chooses to touch memory at a stride of exactly cache size.  However,
it's a little harder to tune for if you are an application writer because
different inputs to the program will give you different page colors.

You could argue it either way but I'm curious as to why not just use the
(pageno + pid) % cachesize alg.  Did you try this and find that it gave
consistently worse results?  I'd find that sort of hard to believe but 
your oblique reference to mmaped shared libraries gave me a hint that you
might be onto something.  Can you explain the results please?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
