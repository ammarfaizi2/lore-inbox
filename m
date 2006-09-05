Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWIECzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWIECzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 22:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWIECzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 22:55:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43949 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965091AbWIECzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 22:55:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       saito.tadashi@soft.fujitsu.com, ak@suse.de, oleg@tv-sign.ru,
       jdelvare@suse.de
Subject: Re: [PATCH] proc: readdir race fix.
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
	<20060905112621.b663bc7d.kamezawa.hiroyu@jp.fujitsu.com>
Date: Mon, 04 Sep 2006 20:54:30 -0600
In-Reply-To: <20060905112621.b663bc7d.kamezawa.hiroyu@jp.fujitsu.com>
	(KAMEZAWA Hiroyuki's message of "Tue, 5 Sep 2006 11:26:21 +0900")
Message-ID: <m1d5ab3tw9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> On Mon, 04 Sep 2006 17:13:10 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> Hi, Hit OOM-Killer, because of memory leak of task struct.
>
> patch is attached.
> -Kame
>
> task struct should be put always.

Good catch. I actually have a pending cleanup that works better if the
task struct is held across the filldir so the incremental patch should look like:

I also noticed a benign typo in TGID_OFFSET (1 subtract one that I shouldn't)

Complete patch in just a moment.

Eric

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b7650b9..03f6680 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2186,7 +2186,7 @@ int proc_pid_readdir(struct file * filp,
        tgid = filp->f_pos - TGID_OFFSET;
        for (task = next_tgid(tgid);
             task;
-            task = next_tgid(tgid + 1)) {
+            put_task_struct(task), task = next_tgid(tgid + 1)) {
                int len;
                ino_t ino;
                tgid = task->pid;

