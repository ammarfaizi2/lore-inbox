Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVJRRXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVJRRXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 13:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVJRRXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 13:23:20 -0400
Received: from unknown-1-11.wrs.com ([147.11.1.11]:13514 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S1751087AbVJRRXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 13:23:20 -0400
Subject: OOM killer code in 2.6 kernel
From: "Petrovic, Boban" <Boban.Petrovic@windriver.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Oct 2005 13:22:53 -0400
Message-Id: <1129656173.10335.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I have stumbled upon very interesting and in other hand very hard
problem. I am trying to integrate code which introduces process
protection from OOM killer action in cases when there is not enough RAM
in the system. The code works fine on architectures like ppc32, ppc64
and arm XScale. On Intel Xeon and Pentium M architectures with disabled
SMP and HighMem support in the kernel the code also works fine. Problem
begins if I turn on SMP and HighMem. I am using a test case which work
following way:  when child is forked both parent and child malloc amount
of memory which when summed together exceed amount of memory available
on system; parent is than protected. On the Intel architectures with SMP
and HighMem on I experience that OOM kills many processes in addition to
child process like sshd, portmap, bash, xinetd, etc.  Number of killed
processes vary from one test execution to other. As, I pointed out
earlier, the code works fine only when SMP and HighMem are off. Any
other combination of these options still causes the problem. I am using
heavily patched Linux 2.6.10 kernel, with Kernel preempt turned off (the
problem occurs with vanilla 2.6.14rc2 kernel also). The targets I have
tested so far don't use swap device, and they have RAM in amounts
starting from 1Gb.
  What I discovered so far is that when OOM sends SIGKILL to process,
memory owned by process is not released as quickly as system would like.
Processes running on other processors jump into OOM and eventually more
processes get killed. I introduced changes to mm/page_alloc.c ->
__alloc_pages() function which suppress more than one processor to enter
the OOM code, and also I reduced number of OOM calls to one call per
second for allowed processor. The idea is to give enough time to process
marked to be killed to release pages. The change works fine for one of
the targets but isn't working for other Intel boards.
  I need more insight on what might cause slow releasing of pages, when
this release occurs and which part of kernel is in charge of that.
Please CC me with your replies.

  Thanks,
  Boban
