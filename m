Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTKZWn1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTKZWn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:43:27 -0500
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:55813 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S264358AbTKZWnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:43:22 -0500
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16325.11418.646482.223946@pc7.dolda2000.com>
Date: Wed, 26 Nov 2003 23:43:38 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6 nfsd troubles - stale filehandles
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm running my NFSv3 server at home on a 2.6 kernel, and it seems to
have some issues, to say the least. The clients sporadically get stale
handle errors, and I don't really know how to debug it.

The server is currently running 2.6.0-test10, but it has been running
test9, test6 and test4 as well, and they have all had the same
problems. The clients run different kernels, 2.4.22, 2.4.20, RH9
standard kernel and 2.6.0-test8-mm1. The filesystem on the kernel is
ReiserFS, but I had it on XFS before, and it had the same problems, so
it doesn't seem to be related to that.

In essence, I have no idea whatsoever what causes it, and the major
problem is that I don't really know how to find out. The NFS code is
really large, and I haven't had the time to get really into it.

I'll describe the symptoms. Everything works as it should normally,
but every now and then (the frequency, too, is very irregular -
sometimes it doesn't happen for days while sometimes it happens all
the time), some filehandles become stale. For example, a client's
working directory can become stale, and nothing except leaving the
directory and going back seems to fix it. Note that when it happens,
the directory can still be listed through an absolute path to it,
although sometimes that fails too. A "staled" cwd never recovers.

I have noted especially strange behavior when reading files that
suddenly go stale. This happens a lot to my mailboxes, so I have been
able to gather pretty thorough symptoms of it. When a mailbox
(ordinary UNIX style spool file) goes stale, I run 'wc' repeatedly on
it to fix it ("while ! wc $file; do :; done"), and when I do, I see
that the number of lines that wc can count "grows" for each iteration,
until the entire file can be counted and the problem is solved,
temporarily. Sometimes (rarely) during this process the line count
resets. In that manner, it almost seems as if the file is being
"transferred" from the server, but I guess that conclusion is too
weird to be correct.

Another strange thing is that some directories _never_ are affected by
this. I use this NFS export to share my home directories, and /home
and the home directories themselves have never once become stale. It
almost seems as if files are more easily "staled" the lower down in
the directory hierarchy they are, but that too seems too weird to be
possible, and not all files are like that.

Sometimes the "staling frequency" can be lowered by rebooting the
clients, and sometimes it can be lowered by rebooting the server.

Sometimes, files and directories can be staled even though no process
is using them. I don't know if maybe the client forgets to release a
filehandle to it for any reason. It happens all too often to my
mozilla pref directory (/home/fredrik/.mozilla/default/58nhp2e8.slt).
When it happens, it is extremely hard to access, be it by cwd or
absolute path. Stupid as I am, I haven't tried if any other client can
access it when it happens, but rebooting the client tends to help
temporarily. While it is that way, commands do work sporadically on
the directory and the files therein, but the majority of the requests
on that directory fail with ESTALE.

When a cwd recently became staled, I enabled debug output on the
client and server, and although there doesn't seem to be anything
special about it, I'll include it just to be sure. To generate the
output, I ran ls once in the staled cwd.

Server:
nfsd_dispatch: vers 3 proc 1 
nfsd: GETATTR(3)  36: 06000001 0000fe00 00000002 00023957 00000002 00000000 
nfsd: fh_verify(36: 06000001 0000fe00 00000002 00023957 00000002 00000000) 

Client:
NFS: 56712 flushd starting 
NFS: 56712 flushd back to sleep 
NFS: revalidating (7/145751) 
NFS call  getattr 
NFS reply getattr 
NFS: refresh_inode(7/145751 ct=1 info=0x6) 
NFS: (7/145751) revalidation complete 
NFS: revalidating (7/146244) 

145751 (0x23957) is the i-number of the home directory
(/home/hannes). fe00 is the device number of the LVM2 volume the
filesystem resides on. 146244 is the i-number of the staled directory
(/home/hannes/dc). This client is running 2.4.22.

During this debug test, only two packets were transferred between the
client and server. One was the GETATTR request from the client on
/home/hannes, and the other was a successful response from the server.

I staled the directory essentially by being inside it and running
"while:; do ls; done". It worked a hundred times or so and then became
staled. There was only one request that failed with ERR_STALE, and it
was a GETATTR request on /home/hannes/dc, just like any other (ie. the
request didn't differ from any of the preceding hundred requests).
Note that this method doesn't always work; sometimes the command goes
on forever, as it should.

That is all the info that I can think of right now. If you're still
reading, I thank you for your endurance. If you need anything more,
tell me and I'll find it out.

Lastly, is this error known? Have I been reporting this unnecessarily?
I would have imagined that this problem hadn't gone unnoticed, but I
didn't find anything in the archives. Could it be that NFS bugs are
handled elsewhere? In that case, please tell me where.

Thank you for your time!

Fredrik Tolf

