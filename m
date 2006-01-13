Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422985AbWAMV1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWAMV1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422987AbWAMV1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:27:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422985AbWAMV1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:27:34 -0500
Date: Fri, 13 Jan 2006 13:27:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Singleton <daviado@gmail.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, drepper@gmail.com,
       robustmutexes@lists.osdl.org
Subject: Re: Robust futex patch for Linux 2.6.15
Message-Id: <20060113132704.207336d7.akpm@osdl.org>
In-Reply-To: <b324b5ad0601131316m721f959eu37b741f9e5557a2e@mail.gmail.com>
References: <b324b5ad0601131316m721f959eu37b741f9e5557a2e@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Singleton <daviado@gmail.com> wrote:
>
> Andrew and Ingo,
> 
>      here is a patchthat I'd like to see tested in the mm kernel.  The patch
>  supports robust futexes for Linux without any RT support.
> Ulrich Drepper has been asking me for a while for a patch that just has
> robustness
> in it, no RT or PI or PQ.   He'd like to see it in Linux and said he'd
> support
> it in glibc if/when it gets in.
> 
>      This patch was originally done by Todd Kneisel for the robust-mutex SIG
> at
> OSDL.  I've fixed a few bugs and added slab support.
> 
>      The patch is at
> 
>       http://source.mvista.com/~dsingleton/patch-2.6.15-robust-futex-1
> 
>      There are also some simple tests for robustness in the same directory
>       in robust-tests.tar.gz.  These simple tests test register, deregister,
> waiting,
>       timed waiting,  waiting for robustness from a dieing thread to wake,
> etc.
> 

Please send the patch to this mailing list with a full description, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt.  And by "full" I
mean something which tells us what a "robust futex" actually is (it's been
a year since I thought about them) and why we would want such a thing.

This code looks racy:

+static int futex_deadlock(struct rt_mutex *lock)
+{
+	DEFINE_WAIT(wait);
+
+	_raw_spin_unlock(&lock->wait_lock);
+	_raw_spin_unlock(&current->pi_lock);
+
+	prepare_to_wait(&deadlocked_futex, &wait, TASK_INTERRUPTIBLE);
+	schedule();
+	finish_wait(&deadlocked_futex, &wait);
+
+	return -EDEADLK;
+}

If the spin_unlocks happened after the prepare_to_wait then it would be
more idoimatic, but without having analysed the wakeup path, I wonder if a
wakeup which occurs after the spin_unlocks and before the prepare_to_wait()
will get lost.
