Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTJQCVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 22:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTJQCVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 22:21:19 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:50172 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263279AbTJQCVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 22:21:16 -0400
Subject: /proc reliability & performance
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1066356438.15931.125.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Oct 2003 22:07:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I created a process with 360 thousand threads,
went into the /proc/*/task directory, and did
a simple /bin/ls. It took over 9 minutes on a
nice fast Opteron. (it's the same at top-level
with processes, but I wasn't about to mess up
my system that much)

OK, that's a bit extreme, but it does show a
scalability problem. There is an O(n*n)
algorithm in there. Here is a proposed fix:

Tie directory readers to a task_struct (or to
some of the PID tracking structs), so that
a directory reader is on a list. When a task
exits, move the list of directory readers on
to a neighboring task.

That is O(1) on task exit, and generally O(n)
for the whole /proc or /proc/42/task read.
It's O(1) per step of the read, excepting
where multiple directory readers wind up at
the same location.

Another benefit is that it is reliable as
long as tasks don't move around on the lists.
Each task will appear at most once, and will
appear exactly once if it doesn't start or
exit during the directory scan.


