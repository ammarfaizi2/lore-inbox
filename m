Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbTF2OL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 10:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbTF2OL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 10:11:56 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:19587 "EHLO
	rwcrmhc13.attbi.com") by vger.kernel.org with ESMTP id S265697AbTF2OLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 10:11:48 -0400
Message-ID: <3EFEF753.50100@mvista.com>
Date: Sun, 29 Jun 2003 09:27:31 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Race condition in fs/proc/array.c with task->comm
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I searched for something about this, and I couldn't find anything.

I was having a problem with "top" crashing occasionally, so I looked,
and top was getting nil characters in the process name in
/proc/<pid>/stat.  It turns out that there is a race condition when
generating the output for task->comm.  If the task "execs" during this
time, it copies a new name into task->comm.  When generating
/proc/<pid>/stat, it uses sprintf to copy the string.  However, if the
data is changing in task->comm during this time, the results can be
corrupted, including putting nil characters into the string.

This seems to be a problem in all version of the kernel I looked at
(various 2.4 and 2.5 releases).  I have only tested the problem in 2.4.20.

I can think it two main ways to fix this.  You can:

* Make a local copy of task->comm.  The results might still be wrong,
but it will not contain nil characters.

 * Use locks so the data is consistent.

I can fix this and supply a patch, but I'd like suggestions on which
path to take.  If suggesting a lock, should I create a new lock, or is
there an existing lock I can use?

Thanks,

-Corey

