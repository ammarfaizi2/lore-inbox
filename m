Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVDIXNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVDIXNW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVDIXLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:11:49 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:45985
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261404AbVDIXKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:10:48 -0400
Date: Sat, 9 Apr 2005 15:58:10 -0700
From: "David S. Miller" <davem@davemloft.net>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, mingo@elte.hu, tony.luck@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
Message-Id: <20050409155810.593d8f7b.davem@davemloft.net>
In-Reply-To: <16983.33049.962002.335198@napali.hpl.hp.com>
References: <3R6Ir-89Y-23@gated-at.bofh.it>
	<ugoecowjci.fsf@panda.mostang.com>
	<20050409070738.GA5444@elte.hu>
	<16983.33049.962002.335198@napali.hpl.hp.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2005 00:15:37 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> Yes, of course.  The deadlock was due to context-switching, not
> switch_mm() per se.  Hopefully someone else beats me to remembering
> the details before Monday.

Sparc64 has a deadlock because we hold mm->page_table_lock during
switch_mm().  I bet IA64 did something similar, as I remember it
had a very similar locking issue in this area.

So the deadlock was, we held the runqueue locks over switch_mm(),
switch_mm() spins on mm->page_table_lock, the cpu which does have
mm->page_table_lock tries to do a wakeup on the first cpu's runqueue.
Classic AB-BA deadlock.
