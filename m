Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbVJKJJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbVJKJJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 05:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVJKJJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 05:09:30 -0400
Received: from nammatj.nsc.liu.se ([130.236.101.75]:46535 "EHLO
	nammatj.nsc.liu.se") by vger.kernel.org with ESMTP id S1751434AbVJKJJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 05:09:30 -0400
To: linux-kernel@vger.kernel.org
Subject: Cache invalidation bug in NFS v3 - trivially reproducible
From: Leif Nixon <nixon@nsc.liu.se>
Date: Tue, 11 Oct 2005 11:09:27 +0200
Message-ID: <m33bn8bet4.fsf@nammatj.nsc.liu.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have come across a bug where a NFS v3 client fails to invalidate
its data cache for a file even though it realizes that the file
attributes have changed. We have been able to recreate the bug on a
range of kernel versions and different underlying file systems.

Here's a minimal way to reproduce the error (there seems to be some
timing issues involved, but this has worked at least 90% of the time):

  NFS client n1                NFS client n2

  $ echo 1 > f
			       $ cat f
			       1
  $ touch .
  $ echo 2 > f
			       $ touch f
			       $ cat f
			       1

Now client n2 is stuck in a state where it uses its old cached data
forever (or at least for several hours):

  NFS client n1                NFS client n2

  $ cat f
  2
			       $ cat f
			       1

However, "stat f" gives the same output on both clients. "touch f" on
either machine corrects the situation; n2 invalidates its data cache.

Interestingly, the second write to the file ("echo 2 > f") must
not change the size of the file. If you do "echo foo > f" instead,
the erroneous behaviour isn't triggered.

We have seen this on a range of kernels between 2.6.9 and 2.6.13.2 on
Debian, CentOS, RHEL, Fedora and vanilla kernel.org, on both clients
and server. We have *not* been able to reproduce the bug with Linux
clients and a Solaris server, neither with Solaris clients and a Linux
server. Underlying file systems have been ext3 and xfs (and Solaris
ufs). We have tried varying mount options, but to no avail; the bug
persists, even with "noac".


Hypothesis:

When n2 does "touch f" and wants to do SETATTR, it first has to do a
LOOKUP (because n1 has updated the attributes on cwd with "touch .").
It seems that when n2 receives the updated attributes for f as a part
of the LOOKUP reply, it updates its attribute cache without
invalidating its data cache, leading to the anomalous situation.

If the "touch ." is omitted, n2 receives the updated file attributes
via an explicit GETATTR on f, and then everything works properly.

-- 
Leif Nixon                       -            Systems expert
------------------------------------------------------------
National Supercomputer Centre    -      Linkoping University
------------------------------------------------------------
