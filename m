Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUHPJg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUHPJg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 05:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUHPJfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 05:35:41 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:6831 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S267495AbUHPJdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 05:33:06 -0400
Message-ID: <019201c48374$09efc510$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Cc: "James Morris" <jmorris@redhat.com>
Subject: RCU issue with SELinux (Re: SELINUX performance issues)
Date: Mon, 16 Aug 2004 18:33:07 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone.

Sat, 7 Aug 2004 22:57:08 -0400 (EDT)
James Morris <jmorris@redhat.com> wrote:

> > The biggest problem is the global lock:
> > 
> > avc_has_perm_noaudit:
> >         spin_lock_irqsave(&avc_lock, flags);
> > 
> > Any chance we can get rid of it? Maybe with RCU?
> 
> Yes, known problem.  I plan on trying RCU soon, Rik was looking at a 
> seqlock approach.

I'm interested in the scalability of SELinux, and tried with
rwlock and RCU approaches.

I simply replaced spinlock_irq_save() by (read|write)_lock_irqsave() first,
but performance improvement was observed in the hackbench only,not in OSDL-REAIM.

Next, I tried with RCU approach. I came across the following problem.

Some AVC-Entries are referred directly by avc_entry_ref structure
in various resource objects (such as task_struct, inode and so on...). 
Thus, referring to invalidated AVC-Entries may happen after detaching
an entry from the AVC hash list.
Since only list scanning of forward direction is expected in RCU-model,
direct reference to AVC-Entry is not appropriate.

In my opinion, direct reference to AVC-Entry should be removed
to avoid the problem for scalability of SELinux.
The purpose of this direct reference is performance improvement
in consecutive access control check about each related object.
Performance degradation may happen by this.
But I think it is not so significant, because the number of the hash
slot is 512 in spite of that the number of AVC-Entry is 410 fixed.
We can reach the target AVC-Entry by one or two steps in average.

Is removing direct reference to AVC-Entry approach acceptable?

I'll try to consider this issue further.
--------
Kai Gai, Linux Promotion Center, NEC
E-mail: kaigai@ak.jp.nec.com

