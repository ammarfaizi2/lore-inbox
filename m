Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUDBMGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 07:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUDBMGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 07:06:18 -0500
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:65173 "EHLO
	zigzag.lvk.cs.msu.su") by vger.kernel.org with ESMTP
	id S263003AbUDBMGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 07:06:16 -0500
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: Exploring sigqueue leak (was: Strange 'zombie' problem both in 2.4 and 2.6)
Date: Fri, 2 Apr 2004 16:05:15 +0400
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404021605.15909@zigzag.lvk.cs.msu.su>
X-Scanner: exiscan *1B9NQC-0000dc-00*VqARkqiIoA6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Yesterday I posted to linux-kernel describind a problem that caused both 
2.4 and 2.6 kernels to leave lots of zombies.
I analysed the problem and found it is caused by overflow of 'sigqueue' 
slab cache (I may be wrong in terminology here). Details are in my 
previous post.

Now I'm looking for advice from somebody who understands how stuff in 
linux/signal.c works.

[the following ins about unpatched 2.6.4 kernel]

Seems that 'sigqueue' objects are allocated exactly in 2 places: in 
__sigqueue_alloc() and in send_signal().

__sigqueue_alloc() seems to be used only by sigqueue_alloc();
sigqueue_alloc() seems only to be used by alloc_posix_timer() from 
kernel/posix-timers.c;
alloc_posix_timer() is a static function used only by sys_timer_create() 
syscall handler.
This syscall is not one widely used; I'm not sure it it is actually used by 
anything running here.

So the leak seems to happen through allocation of 'sigqueue' objects in 
send_signal().
However, if I understand correctly, object allocated here keeps information 
about signal being transferred, and lives as long as this tranfer is in 
progress.
Signal transfer is somewhat very fast.
So, if everything is working ok, usually zero 'sigqueue' objects should be 
allocated.

Seems that it is possible to find out how many 'sigqueue' objects are 
currently allocated by running
   grep sigqueue /proc/slabinfo
and looking at the first number of output.
So seems that almost always the first number in the output of the above 
command should be zero.
And that's exactly what happens on all hosts here expect the server.

Just after reboot and starting all services, the number on the server was 
135. Later it changes, sometimes getting down to about 40, sometimes 
rising to something about 200. It is never becoming zero.

And after some time, when happens what I've described in the previous 
postings, it gets up to 1024 and stays there forever, causing some 
user-space visible misbehaves. The zombie keeping is not the only one. 
Other is strange and definitly incorrect failures inside threaded 
programs.

I thought that some 'sigqueue' objects could correspond to pending signals 
that are blocked by their reciever processes. However, I can't see any 
pending signals running
   grep SigPnd /proc/*/status
- all displayed masks are zeroes, while there are more than 100 allocated 
'sigqueue' objects.

So that's what I found.
Please correct me if I'm wrong, and/or advice where to look for the leak.

Nikita

