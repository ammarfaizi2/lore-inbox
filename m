Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTLAR0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 12:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTLAR0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 12:26:24 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:52117 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263809AbTLAR0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 12:26:22 -0500
Date: Mon, 1 Dec 2003 18:26:20 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: 2.4.23 *_task_struct() observations ...
Message-ID: <20031201172620.GA312@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All!

just wanted to get an opinion on the following ...

include/asm-i386/processor.h  defines ...

  #define alloc_task_struct() ((struct task_struct *) \
				__get_free_pages(GFP_KERNEL,1))
  #define free_task_struct(p)  free_pages((unsigned long) (p), 1)
  #define get_task_struct(tsk) atomic_inc(&virt_to_page(tsk)->count)

now there seems to be no put_task_struct(), but
there are some examples where get/free is used 
where I would expect a put_* ...

fs/proc/base.c for example does:

        read_lock(&tasklist_lock);
        task = find_task_by_pid(pid);
        if (task)
                get_task_struct(task);
        read_unlock(&tasklist_lock);
        if (!task)
                goto out;

        inode = proc_pid_make_inode(dir->i_sb, task, PROC_PID_INO);

        free_task_struct(task);

which is a little suspicious ...

please could anybody explain the logic behind that?
(if it isn't a widespread bug(tm))

TIA,
Herbert


