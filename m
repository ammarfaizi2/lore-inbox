Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWHHMwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWHHMwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWHHMwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:52:05 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:54179 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S964875AbWHHMwA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:52:00 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Kirill Korotaev <dev@sw.ru>
Subject: Re: [PATCH] unserialized task->files changing (v2)
Date: Tue, 8 Aug 2006 14:51:57 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xemul@sw.ru,
       hch@infradead.org
References: <44D87611.7070705@sw.ru>
In-Reply-To: <44D87611.7070705@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608081451.58305.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 13:31, Kirill Korotaev wrote:
> Fixed race on put_files_struct on exec with proc.
> Restoring files on current on error path may lead
> to proc having a pointer to already kfree-d files_struct.
>
> ->files changing at exit.c and khtread.c are safe as
> exit_files() makes all things under lock.
>
> v2 patch changes:
> - introduced reset_files_struct() as Christoph Hellwig suggested
>
> Found during OpenVZ stress testing.

Sorry but there is something I dont understand. You ignored my point.

+void reset_files_struct(struct task_struct *tsk, struct files_struct *files)
+{
+       struct files_struct *old;
+
+       old = tsk->files;
+       task_lock(tsk);
+       tsk->files = files;
+       task_unlock(tsk);
+       put_files_struct(old);
+}

Its seems very strange to protect tsk->files = files with a 
task_lock()/task_unlock(). What is it supposed to guard against ???

If this patch corrects the 'bug', then a simpler fix would  be to use a memory 
barrier between "tsk->files = files" and "put_files_struct(old);" 

No need to perform 2 atomics ops on the task lock.

old = tsk->files;
tsk->files = files;
smp_mb();
put_files_struct(old);

That would be enough to guard against proc code (because this code only needs 
to read tsk->files of course)

The same remark can be said for __exit_files() from kernel/exit.c

If this task_lock()/task_unlock() patch is really needed, then a comment in 
the source would be very fair.

Eric

