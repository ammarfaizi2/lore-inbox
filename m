Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWGYHW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWGYHW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 03:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWGYHW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 03:22:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14516 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751147AbWGYHWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 03:22:55 -0400
Date: Tue, 25 Jul 2006 00:22:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com, "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [RFC] ps command race fix
Message-Id: <20060725002244.af4d6e8d.pj@sgi.com>
In-Reply-To: <20060724193318.d57983c1.akpm@osdl.org>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724193318.d57983c1.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> We cannot do a single kmalloc() like cpuset does.

Ok ...

Well, since you're so impressed with the studliness of that idea
<grin>, how about this:

  Add a 'false link' to the .next task list.

Each diropen on /proc and each open on a cpuset 'tasks' file would
add one such 'false link' to the task list, representing that file
descriptors current seek offset in the task list.

A 'false link' would be a task_struct that was almost entirely unused,
except to mark the offset in the task list of a file descriptor open
on it (for /proc or cpuset 'tasks' files.)

The 'normal' do_each_thread/while_each_thread and related macros would
silently skip over these false links.

The /proc and cpuset 'tasks' code would use special macros that could
see the false link representing its current seek offset, and be able
to implement read and seek operations relative to that position.

Remove this 'false link' on the final close of the file descriptor
holding it.

This reduces the memory cost of an open on /proc or a 'tasks' file to
the size of a single 'false link' task_struct.

It -would- add another test and jump to the critical do_each_thread and
while_each_thread macros, to skip over 'false links'.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
