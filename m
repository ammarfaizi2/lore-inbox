Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132684AbRC2IO3>; Thu, 29 Mar 2001 03:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132689AbRC2IOT>; Thu, 29 Mar 2001 03:14:19 -0500
Received: from bart.one-2-one.net ([195.94.80.12]:40712 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S132684AbRC2IOE>; Thu, 29 Mar 2001 03:14:04 -0500
Date: Thu, 29 Mar 2001 10:14:53 +0200 (CEST)
From: Martin Diehl <home@mdiehl.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac27
In-Reply-To: <E14iKvx-0006Eq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0103291013140.7191-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Linus cc'ed - related thread: 243-pre[78]: mmap changes (breaks) /proc)

On Wed, 28 Mar 2001, Alan Cox wrote:

> 2.4.2-ac27
> o	Revert mmap change that broke assumptions (and	(Martin Diehl)
> 	it seems SuS) 

the reason to suggest keeping the test was not due to len=0 behaviour of
mmap in general as is suggested by your comment. The breakage that I've
seen was due to mmap not returning -ENODEV for files from /proc despite
the lack of valid f_op->mmap (because the test was moved behind the len==0
check). The point is sed(1) first tries to mmap(2) the file and falls back
to read(2) in case of -ENODEV (and probably other errors too). This is
important for /proc since most files there are stat'ed size=0 but return
stuff when reading. Not getting error for mmap len=0 file makes sed assume
EOF. Anyway, reverting it was not addressed to cases where f_op->mmap is
valid but request is to mmap len=0 - we still return the startaddr 
parameter in that case:

$ touch nullfile
$ strace sed 's/./X/' nullfile
open("nullfile", O_RDONLY|O_LARGEFILE)  = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 0, PROT_READ, MAP_PRIVATE, 4, 0) = 0

This is consistent throughout all 2.4.x at least. From your comment I've
learnt SuS v2 requires -ENODEV for the len=0 case. While this would
resolve the /proc issue as well there might be some chance to brake code
which expects mmap(len=0) to succeed.
BTW, man-pages (1.31) say, mmap(2) returns -EINVAL if called with bad
start/length/offset values - but makes no claims whether len=0 would be
valid or not.

In case we want to follow what you've said about SuS, the right thing
might simply go along

--- linux-243-pre8/mm/mmap.c	Wed Mar 28 13:14:19 2001
+++ linux-243p8-md/mm/mmap.c	Thu Mar 29 09:49:34 2001
@@ -204,8 +204,12 @@
 	int correct_wcount = 0;
 	int error;
 
+	/* We need to error mmaps of 0 length. The apps rely on this and
+	   SuS v2 says that we return -ENODEV in this case without mentioning
+	   returning 0 for 0 length mmap */
+
 	if ((len = PAGE_ALIGN(len)) == 0)
-		return addr;
+		return -ENODEV;
 
 	if (len > TASK_SIZE || addr > TASK_SIZE-len)
 		return -EINVAL;

I really have no idea about what, if any, code might rely on old
beahviour. Some commonly used tools may get confused with stuff from
/var/lock/subsys tree for example. So probably it's better not to field
this change before 2.5 to be able to identify such things in time.
In this case we could add some clarification to your comment, saying that
returning error on len=0 is a future thing, leave the current len=0
semantics untouched, keep the f_op->mmap test at the very beginning (and
drop the moved one a few lines below).

Regards
Martin

