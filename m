Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278508AbRJPDZa>; Mon, 15 Oct 2001 23:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278076AbRJPDZK>; Mon, 15 Oct 2001 23:25:10 -0400
Received: from cti06.citenet.net ([206.123.38.70]:42253 "EHLO
	cti06.citenet.net") by vger.kernel.org with ESMTP
	id <S278074AbRJPDZC>; Mon, 15 Oct 2001 23:25:02 -0400
From: Jacques Gelinas <jack@solucorp.qc.ca>
Date: Mon, 15 Oct 2001 21:43:31 -0500
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announce: many virtual servers on a single box (scheduling)
X-mailer: tlmpmail 0.1
Message-ID: <20011015214331.6cf66bb2bd01@remtk.solucorp.qc.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 17:22:43 -0500, James Sutherland wrote

> Hmmm - does this work with devfs?

Not tried. Sorry. Note that vserver can't mount.

> Have you looked at the "fairsched" patch for this? It seems to be
> unmaintained since 2.4.0-testXX, but look close to your needs...

So far I am toying with a very simple solution. The current schedular (SCHED_OTHER)
is using each process p->counter (time quantum used so far) as one data to
compute the priority.

Security context are sharing a common struct context_info and it contains
a counter too (atomic_t counter). When the process p->counter is decremented
the context_info->counter is also decremented. This context_info counter is
used along with the p->counter to compute the process priority. So if a vserver
is running many processe, then their total cpu usage is accounted in their
common context_info->counter, so they have lover priority (together) than
a single process in another vserver.

Note that this idea is broad. A PAM module could be use to setup a per-user
context_info, without switching the security ID and you end up with
per-user fair schedular (well, per whatever).

Note also that this per context_info scheduling is a flag (you can only turn it on).
By default, there is no special scheduling in a vserver.

---------------------------------------------------------
Jacques Gelinas <jack@solucorp.qc.ca>
vserver: run general purpose virtual servers on one box, full speed!
http://www.solucorp.qc.ca/miscprj/s_context.hc
