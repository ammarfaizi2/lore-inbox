Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbUBZTjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbUBZTjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:39:40 -0500
Received: from palrel13.hp.com ([156.153.255.238]:39614 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262955AbUBZTjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:39:25 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16446.19305.637880.99704@napali.hpl.hp.com>
Date: Thu, 26 Feb 2004 11:39:21 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, kingsley@aurema.com,
       linux-kernel@vger.kernel.org
Subject: Re: /proc visibility patch breaks GDB, etc.
In-Reply-To: <20040225224410.3eb21312.akpm@osdl.org>
References: <16445.37304.155370.819929@wombat.chubb.wattle.id.au>
	<20040225224410.3eb21312.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 25 Feb 2004 22:44:10 -0800, Andrew Morton <akpm@osdl.org> said:

  Andrew> Peter Chubb <peter@chubb.wattle.id.au> wrote:
  >> 
  >> 
  >> In fs/proc/base.c:proc_pid_lookup(), the patch
  >> 
  >> read_unlock(&tasklist_lock); if (!task) goto out; + if
  >> (!thread_group_leader(task)) + goto out_drop_task;
  >> 
  >> inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO);
  >> 
  >> means that threads other than the thread group leader don't
  >> appear in the /proc top-level directory.  Programs that are
  >> informed via pid of events can no longer find the appropriate
  >> process -- for example, using gdb on a multi-threaded process, or
  >> profiling using perfmon.
  >> 
  >> The immediate symptom is GDB saying: Could not open
  >> /proc/757/status when 757 is a TID not a PID.

  Andrew> What does `ls /proc/757' say?  Presumably no such file or
  Andrew> directory?  It's fairly bizare behaviour to be able to open
  Andrew> files which don't exist according to readdir, which is why
  Andrew> we made that change.

Excuse, but this seems seriously FOOBAR.  I understand that it's
interesting to see the thread-leader/thread relationship, but surely
that's no reason to break backwards compatibility and the ability to
look up _any_ task's info via /proc/PID/.  A program that only wants
to show "processes" (thread-group leaders) can simply read
/proc/PID/status and ignore the entries for which Tgid != PPid.

Perhaps you could put relative symlinks in task/?  Something like
this:

 $ ls -l /proc/self/task
 dr-xr-xr-x    3 davidm   users           0 Feb 26 11:37 13494 -> ..
 dr-xr-xr-x    3 davidm   users           0 Feb 26 11:37 13495 -> ../../13495

perhaps?

	--david
