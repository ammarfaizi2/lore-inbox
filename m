Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315384AbSEGI3L>; Tue, 7 May 2002 04:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315385AbSEGI3K>; Tue, 7 May 2002 04:29:10 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:40674 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S315384AbSEGI3K>;
	Tue, 7 May 2002 04:29:10 -0400
Message-Id: <3.0.6.32.20020507103320.0090d610@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 07 May 2002 10:33:20 +0200
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: [Q] find matching unix socket pairs?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody!


I have a process tree which talks using (unix) socket pairs. Now I wrote a
perl script which read /proc/*/fd/* and displays the communications channels.

I have one problem left: the association of socket pairs.

Sometimes it happens that the pair has an even and an odd inode (say, 50
and 51), but sometimes they are more than 1 from each other.

Looking in the sources I think I found out why. The sys_socketpair call calls 
->create() two times; the create-call uses kalloc, which can block.
So if there are some processes trying to get pairs it can happen that the 
->create calls are interleaving.

The unix sockets are paired by unix_peer(), which is a #define to ->pair.
But as this is a pointer to another skb it doesn't make much sense to
export that as-is to userspace.

In /proc/net/unix there is a "num"-field exported, which is just a pointer
to the "struct sock"-structure (?).
Maybe this num-field could be substituted (if adding another field then
this should be done before path, as for socketpairs the path is empty and
adding behind that would make parsing more difficult) by some ->pair->
identifier?
I'd suggest the ->i_ino value, as this is already visible in user space,
but I'm lost how to get the dentry from the ->pair pointer.


Any suggestions?
Help?
Finished patches :-) ???


Regards,

Phil




