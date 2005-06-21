Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVFUF5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVFUF5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVFUFy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 01:54:27 -0400
Received: from imf23aec.mail.bellsouth.net ([205.152.59.71]:50911 "EHLO
	imf23aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261948AbVFUFte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 01:49:34 -0400
Message-ID: <000d01c5762c$5e399dc0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC] do_execve() perf improvement opportunity?
Date: Tue, 21 Jun 2005 02:42:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_execve() on EVERY entry/exit allocates and frees a structure pointed to
by the 'bprm' variable.

I'm thinking it may be possible to very cheaply cache a pointer to the last
allocation here rather than freeing it and just recycle it for the next exec
saving a trip through the slab machanism.

On x86 I'm pretty sure this could be done very racy and lockless (other than
XCHG's implied locks).  Other architectures that don't have an implied
locking instruction might need a hard lock of some sort.

Something along the lines of (pseudocode):

static volatile struct blahblah *p = NULL;

/* ...before the exec... */
bprm = NULL
xchg(bprm, p)
if (bprm == NULL) kmalloc like it is now

/*
  blah, blah, blah...exec triage blob as it exists today
*/

/* ...after the exec...*/
xchg(bprm, p) /* cache what we just used */
if (bprm)     /* Maybe free someone else's if it was still available */
    kfree(bprm);

For things that proceed mostly sequentially like a lot of shell scripts,
Linux builds, etc this simple minded high-speed low-drag, single structure
racy implementation might provide a nice gain for minimal cost.


