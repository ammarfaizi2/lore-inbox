Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262711AbTDASPp>; Tue, 1 Apr 2003 13:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262713AbTDASPp>; Tue, 1 Apr 2003 13:15:45 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:22988 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262711AbTDASPf>; Tue, 1 Apr 2003 13:15:35 -0500
Date: Tue, 1 Apr 2003 12:22:56 -0600
From: linas@austin.ibm.com
To: alan@lxorguk.ukuu.org.uk
Cc: linas@linas.org, ppc@suse.de, linux-kernel@vger.kernel.org
Subject: ptrace patch fails stress testing
Message-ID: <20030401122256.A34952@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a number of machines here that crash after installing
the recent ptrace fix.  The crash only occurrs when machines 
are highly stressed.

The problem appears to be that task->mm is dereferenced without 
looking to see if mm is NULL.  e.g. in the sched.h in the 
is_dumpable() macro, we have task->mm->dumpable .  I'm sitting
in front of a KDB session and I'm clearly looking at task->mm
which is NULL. 

In my particular case, the crash is *always* in kernel/ptrace.c
in access_process_vm(),  (which is called when something tries
to read /proc/pid/cmd_line).  There seem to be a few other places
in the kernel where task->mm is dererenced without checking mm,
but these are rare (?)  Most (?) places seem to make a point of
checking for NULL before using mm.

Why, how and under what conditions this race condition occurs, 
I don't know.  What the best fix is, I don't know.

I can try to just add a check for NULL, but I'd like someone 
to tell me that 'yes this is the right way to fix this.' 
(As opposed for trying to get some lock or trying to force 
the process to get paged in or whatever.)

BTW, this is an SMP machine, don't know if that matters.

Comments? Suggestions?

--linas

