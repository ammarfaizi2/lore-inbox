Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVIMXKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVIMXKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVIMXKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:10:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45487 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750823AbVIMXKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:10:48 -0400
Date: Tue, 13 Sep 2005 16:10:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sripathi Kodi <sripathik@in.ibm.com>
cc: Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
In-Reply-To: <43274503.7090303@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org>
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org>
 <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org>
 <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org>
 <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Sripathi Kodi wrote:
> 
> Coming back to the problem of being able to see the threads of a process 
> whose main thread has done pthread_exit, it appears to me that the only 
> hurdle is getting the ->fs pointer from task struct. Since all threads of 
> the process point to the same fs structure, would it be okay if we try to 
> get it from some other thread? Below is the patch I tried for this:

I don't think this is wrong per se, but you shouldn't take the tasklist 
lock normally. You're better off just doing

	static struct fs_struct *get_fs(struct task_struct *tsk)
	{
		struct fs_struct *fs;

		task_lock(tsk);
		fs = task->fs;
		if (fs) {
			atomic_inc(&fs->count);
			task_unlock(tsk);
			return fs;
		}
		task_unlock(tsk);

		read_lock(&tasklist_lock);
		if (pid_alive(tsk)) {
			struct task_struct *tmp = tsk;
			while ((tmp = next_thread(tmp)) != tsk) {
				task_lock(tmp);
				fs = tmp->fs;
				if (fs) {
					atomic_inc(fs->count)
					task_unlock(tmp);
					break;
				}
				task_unlock(tmp);
			}
		}
		read_unlock(&tasklist_lock);
		return fs;
	}

or something like that. You get the idea (totally untested, use at your 
own risk, if your hair falls off and you get boils, it wasn't my fault).

		Linus
