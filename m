Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWIFJAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWIFJAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 05:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWIFJAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 05:00:40 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:55740
	"EHLO gwia-smtp.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750714AbWIFJAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:00:39 -0400
From: Jean Delvare <jdelvare@suse.de>
Organization: SUSE
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] proc: readdir race fix (take 3)
Date: Wed, 6 Sep 2006 11:01:11 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de,
       Albert Cahalan <acahalan@gmail.com>, Paul Jackson <pj@sgi.com>
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com> <20060905101050.GA128@oleg> <m1ac5e2woe.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac5e2woe.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609061101.11544.jdelvare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 5 September 2006 16:52, Eric W. Biederman wrote:
> The problem: An opendir, readdir, closedir sequence can fail to report
> process ids that are continually in use throughout the sequence of
> system calls.  For this race to trigger the process that
> proc_pid_readdir stops at must exit before readdir is called again.
>
> This can cause ps to fail to report processes, and  it is in violation
> of posix guarantees and normal application expectations with respect
> to readdir.
>
> Currently there is no way to work around this problem in user space
> short of providing a gargantuan buffer to user space so the directory
> read all happens in on system call.
>
> This patch implements the normal directory semantics for proc,
> that guarantee that a directory entry that is neither created nor
> destroyed while reading the directory entry will be returned.  For
> directory that are either created or destroyed during the readdir you
> may or may not see them.  Furthermore you may seek to a directory
> offset you have previously seen.
>
> These are the guarantee that ext[23] provides and that posix requires,
> and more importantly that user space expects. Plus it is a simple
> semantic to implement reliable service.  It is just a matter of
> calling readdir a second time if you are wondering if something new
> has show up.
>
> These better semantics are implemented by scanning through the
> pids in numerical order and by making the file offset a pid
> plus a fixed offset.
>
> The pid scan happens on the pid bitmap, which when you look at it is
> remarkably efficient for a brute force algorithm.  Given that a typical
> cache line is 64 bytes and thus covers space for 64*8 == 200 pids. 
> There are only 40 cache lines for the entire 32K pid space.  A typical
> system will have 100 pids or more so this is actually fewer cache lines
> we have to look at to scan a linked list, and the worst case of having
> to scan the entire pid bitmap is pretty reasonable.
>
> If we need something more efficient we can go to a more efficient data
> structure for indexing the pids, but for now what we have should be
> sufficient.
>
> In addition this takes no additional locks and is actually less
> code than what we are doing now.
>
> Also another very subtle bug in this area has been fixed.  It is
> possible to catch a task in the middle of de_thread where a thread is
> assuming the thread of it's thread group leader.  This patch carefully
> handles that case so if we hit it we don't fail to return the pid, that
> is undergoing the de_thread dance.
>
> This patch is against 2.6.18-rc6 and it should be relatively straight
> forward to backport to older kernels as well.
>
> Thanks to KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> for
> providing the first fix, pointing this out and working on it.

Eric, Kame, thanks a lot for working on this. I'll be giving some good 
testing to this patch today, and will return back to you when I'm done.

-- 
Jean Delvare
