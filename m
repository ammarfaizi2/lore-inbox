Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268641AbUILJlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268641AbUILJlM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268646AbUILJjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:39:24 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3270 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268592AbUILJim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:38:42 -0400
Date: Sun, 12 Sep 2004 11:39:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       wli@holomorphy.com
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912093943.GA10356@elte.hu>
References: <20040912085609.GK32755@krispykreme>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <20040912085609.GK32755@krispykreme>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Anton Blanchard <anton@samba.org> wrote:

> I tried creating 100,000 threads just for the hell of it. I was
> surprised that it appears to have worked even with pid_max set at 32k.
> 
> It seems if we are above pid_max we wrap back to RESERVED_PIDS at the
> start of alloc_pidmap but do not enforce this upper limit. I guess
> every call of alloc_pidmap above 32k was wrapping back to
> RESERVED_PIDS, walking the allocated space then allocating off the
> end.

yeah. Does the attached patch fix it?

> Just as an aside, does it make sense to remove the pidmap allocator
> and use the IDR allocator now its there?

might make sense - needs benchmarking. In particular the performance of
kill(pid, 0) [PID lookup] should be benchmarked on the cycle level, and
the combined performance of pthread_create()+pthread_exit().

> Now once I had managed to allocate those 100,000 threads, I noticed
> this:
> 
> 18446744071725383682 dr-xr-xr-x   3 root root   0 Sep 12 08:10 100796
> 
> Strange huh. Turns out we allocate inodes in proc via:
> 
> #define fake_ino(pid,ino) (((pid)<<16)|(ino))
> 
> With 32bit inodes we are screwed once pids go over 64k arent we?

indeed.

i'm wondering, dont we have a similar problem with PROC_TID_FD_DIR
already? Running some simple code that opens 1 million files gives:

 [root@saturn root]# ulimit -n 1000000
 [root@saturn root]# ./open-fds 1000000
 999997 fds opened
 [root@saturn root]# cd /proc/2333/fd/
 [root@saturn fd]# ls -li | grep 153028253
 153028253 lrwx------  1 root root 64 Sep 12 11:18 165533 -> /dev/pts/0
 153028253 lrwx------  1 root root 64 Sep 12 11:18 362141 -> /dev/pts/0
 153028253 lrwx------  1 root root 64 Sep 12 11:18 427677 -> /dev/pts/0
 153028253 lrwx------  1 root root 64 Sep 12 11:18 624285 -> /dev/pts/0
 153028253 lrwx------  1 root root 64 Sep 12 11:19 689821 -> /dev/pts/0
 153028253 lrwx------  1 root root 64 Sep 12 11:18 99997 -> /dev/pts/0
 [...]

plenty of overlap in the #ino space.

	Ingo

--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pid-max-fix.patch"

--- linux/kernel/pid.c.orig	
+++ linux/kernel/pid.c	
@@ -103,7 +103,7 @@ int alloc_pidmap(void)
 	pidmap_t *map;
 
 	pid = last_pid + 1;
-	if (pid >= pid_max)
+	if (unlikely(pid >= pid_max))
 		pid = RESERVED_PIDS;
 
 	offset = pid & BITS_PER_PAGE_MASK;
@@ -116,6 +116,10 @@ int alloc_pidmap(void)
 		 * slowpath and that fixes things up.
 		 */
 return_pid:
+		if (unlikely(pid >= pid_max)) {
+			clear_bit(offset, map->page);
+			goto failure;
+		}
 		atomic_dec(&map->nr_free);
 		last_pid = pid;
 		return pid;

--32u276st3Jlj2kUU--
