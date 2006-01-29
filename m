Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWA2HVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWA2HVO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWA2HVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:21:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8415 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750881AbWA2HVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:21:14 -0500
To: <linux-kernel@vger.kernel.org>
CC: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: [RFC][PATCH 0/5] Task references..
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 00:19:56 -0700
Message-ID: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the pid virtualization thread it was noticed that currently in
the kernel we have a variables that hold pids of processes or
process groups that we later intend to send signals to.

It was suggest that we instead use pointers to struct task_struct
and reference count them to get around this problem.

The problem was that each file descriptor in the system has one of
these variables in f_owner an instance of struct fown_struct it would
allow user to bypass the limits on the number of processes and
type of megabytes of memory with invisible zombie processes.

For kernel threads where things are tightly coordinated this is not an
issue hand holding a reference to the task struct of a kernel thread
seems the sane thing to do.

The other problem was that pointers to struct task_struct don't map
well to process groups.

I believe the solution to these problems is to introduce a small data
structure that can be reference counted and holds a pointer to a
struct task_struct.   The struct task_struct holds a pointer to this
small data structure that will be used to remove the pointer to itself
when the struct task_struct is freed.

The following series of patches implement the data structure and
the routines for manipulating it.  As well as implementing this
data structure in two common cases in the kernel, that demonstrate
it's usefulness.

Eric
