Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269202AbTGJLA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269203AbTGJLA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:00:26 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:42506 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S269202AbTGJLAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:00:20 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: 2.5.74-mm3 OOM killer fubared ?
Date: Thu, 10 Jul 2003 11:14:59 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bejhrj$dgg$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1057835699 13840 62.216.29.200 (10 Jul 2003 11:14:59 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running 2.5.74 on our newsfeeder box for a day without
problems (and 2.5.72-mm2 for weeks before that).

Now with 2.5.74-mm3 (booted 11 hours ago) it keeps killing processes
for no apparent reason:

Jul 10 11:59:01 quantum kernel: Out of Memory: Killed process 9952 (innfeed).
Jul 10 12:25:48 quantum kernel: Out of Memory: Killed process 10498 (innfeed).
Jul 10 12:25:48 quantum kernel: Fixed up OOM kill of mm-less task
Jul 10 12:45:41 quantum kernel: Out of Memory: Killed process 11894 (innfeed).
Jul 10 12:47:14 quantum kernel: Out of Memory: Killed process 13128 (innfeed).
Jul 10 12:53:09 quantum kernel: Out of Memory: Killed process 13221 (innfeed).
Jul 10 12:55:12 quantum kernel: Out of Memory: Killed process 13649 (innfeed).

I check seconds before the last kill:

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
news     13649  0.2  0.1 60368 1108 ?        SN   12:53   0:00 innfeed -y

# free
             total       used       free     shared    buffers     cached
Mem:       1035212    1030104       5108          0     548208     307148
-/+ buffers/cache:     174748     860464
Swap:       996020      41708     954312

Enough memory free, no problems at all .. yet every few minutes
the OOM killer kills one of my innfeed processes.

I notice that in -mm3 this was deleted relative to -vanilla:

-
-       /*
-        * Enough swap space left?  Not OOM.
-        */
-       if (nr_swap_pages > 0)
-               return;
  
.. is that what causes this ? In any case, that should't vene matter -
there's plenty of memory in this box, all buffers and cached, but that
should be easily freed ..

Related mm question - this box is a news server, which does a lot
of streaming I/O, and also keeps a history database open. I have the
idea that the streaming I/O evicts the history database hash and
index file caches from memory, which I do not want. Any chance of
a control on a filedescriptor that tells it how persistant to be
in caching file data ? E.g. a sort of "nice" for the cache, so that
I could say that streaming data may be flushed from buffers/cache
earlier than other data (where the other data would be the
database files) ?

Mike.

