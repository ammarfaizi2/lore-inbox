Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161312AbWHENy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWHENy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 09:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWHENy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 09:54:28 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:16098 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S932613AbWHENy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 09:54:28 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpucontroller
Date: Sat, 05 Aug 2006 17:41:47 GMT
Message-ID: <06B5D5N12@briare1.heliogroup.fr>
X-Mailer: Pliant 96
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem you have here is more fondamental:
Linux is for the first time getting seriouly behond Unix semantic.
Historically, you had only small behond Unix semantic issues at the corners,
I mean /proc or /sys, but with proper ressources management, they get central
for the first time.
The reason is that Unix semantic just fall short as far as ressources
management is concerned.

Basically, when you request some ressources, let's start with memory and
disk space, there are two possible scenario:
. either you want what you request to be reliably allocated over time or
  the request to fail immediately,
. or you want to maximize the ability to satisfy the request immediately
  with potencial imperative instruction from the operating system to shrink
  usage at a later point (or even direct takeback with no forwarn from the
  operating system)
The current disk quotas apply the first rule,
the current OOM killer applies the second rule.
None is good in facts because only the application can decide what kind
of failure (immediate or futur) it wants.
There is a third kind of ressources management (CPU, IO and network bandwith)
where the solution is easier because a two stages queue does it.

So, my preposed general picture to introduce proper ressources management is:
everthing in the system is connected to a service ID (including inodes);
then the kernel can be instructed with rules dispatching ressources amoung
services ID (as an example, 30% cpu and 50% disk space for the database)
Now, we can implement two stage queues for the CPU, IO, etc on one side,
and proper ressources recovery on the other for memory or disk space.
The allocation rule beeing that if the ressource is requested with immediat
failure it will fail as soon as the ressource quota for the given service
ID is exhausted,
and if a given ressource is exhausted at overall system stage, then the
process which most over consumed thanks to allocating with potencial futur
failure instead of immediat one is warned then killed if it does not shrink
fast enough (or some files are deleted in case of disk storage with a potencial
demon beeing called first to give it a change to make smarter decision)

