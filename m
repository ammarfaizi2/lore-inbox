Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTJZLFX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTJZLFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:05:23 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:56198 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262971AbTJZLFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:05:19 -0500
Message-ID: <3F9BAA1B.6080203@colorfullife.com>
Date: Sun, 26 Oct 2003 12:03:55 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: viro@parcelfarce.linux.theplanet.co.uk, arekm@pld-linux.org,
       linux-kernel@vger.kernel.org, jmorris@redhat.com, sds@epoch.ncsc.mil,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: 2.6.0-test9 and sleeping function called from invalid context
References: <200310260045.52094.arekm@pld-linux.org>	<20031025185055.4d9273ae.akpm@osdl.org>	<20031025224950.001b4055.akpm@osdl.org>	<20031026082610.GU7665@parcelfarce.linux.theplanet.co.uk> <20031026014153.0fdbd50a.akpm@osdl.org>
In-Reply-To: <20031026014153.0fdbd50a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>What protects against concurrent execution of proc_pid_lookup() and
>proc_task_lookup()?  I think nothing, because one is at /proc/42 and the
>other is at /proc/41/42; the parent dir inodes are different.  hmm.
>  
>
Ugs.
/proc/1 and /proc/1/task/1 are two different dentrys.
proc_task_lookup happily overwrites task->proc_dentry. Which means the 
task patch broke tsk->proc_dentry.
I think the cure is simple: proc_task_lookup should not write 
proc_dentry, only proc_pid_lookup should do that.
tsk->proc_dentry is only used by proc_pid_flush: If a task exits, all 
entries below /proc/<pid> are stale, and a shrink_dcache_parent on the 
/proc/<pid> dentry recovers the memory.
There is a race between in proc_pid_lookup between checking that the 
task is still running and setting tsk->proc_dentry, but AFAICS the race 
is not critical: In the worst case, the stale dentries remain around. 
They are never returned to user space, d_revalidate prevents that.

--
    Manfred


