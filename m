Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVA3JQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVA3JQH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 04:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVA3JQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 04:16:07 -0500
Received: from 80.178.38.121.forward.012.net.il ([80.178.38.121]:56034 "EHLO
	linux15") by vger.kernel.org with ESMTP id S261642AbVA3JQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 04:16:01 -0500
From: Oded Shimon <ods15@ods15.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Pipes and fd question. Large amounts of data.
Date: Sun, 30 Jan 2005 11:15:59 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501301115.59532.ods15@ods15.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Unix C programming question. Has to do mostly with pipes, so I am hoping I 
am asking in the right place.

I have a rather unique situation. I have 2 programs, neither of which   have 
control over.
Program A writes into TWO fifo's.
Program B reads from two fifo's.

My program is the middle step.

The problem - neither programs are aware of each other, and write into any of 
the fifo's at their own free will. They will also block until whatever data 
moving they did is complete.

Meaning, if I were to use the direct approach and have no middle step, the 
programs would be thrown into a deadlock instantly. as one program will write 
info fifo 1, and the other will be reading from fifo 2.

The amounts of data is very large, GB's of data in total, and at least 10mb a 
second or possibly as much as 300mb a second. So efficiency in context 
switching is very important.

programs A & B both write and read using large chunks, usually 300k.

So far, my solution is using select() and non blocking pipes. I also used 
large buffers (20mb). In my measurements, at worst case the programs 
write/read 6mb before switching to the other fifo. so 20mb is safe enough.

I have implemented this, but it has a major disadvantage - every 'write()' 
only write 4k at a time, never more, because of how non-blocking pipes are 
done. at 20,000 context switches a second, this method reaches barely 10mb a 
second, if not less.

Blocking pipes have an advantage - they can write large chunks at a time. They 
have a more serious disadvantage though - the amount of data you ask to be 
written/read, IS the amount of data that will be written or read, and will 
block until that much data is moved. I cannot know beforehand exactly how 
much data the programs want, so this could easily fall into a dead lock.

Ideally, I could do this:
my program:  write(20mb);
program B:     read(300k);
my program:  write() returns with return value '300,000'

I was unable to find anything like this solution or similar.
No combination of blocking/non blocking fd's will give this, or any system 
call.
I am looking for alternative/better suggestions.

- ods15.
