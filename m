Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUKVVeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUKVVeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbUKVVaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:30:46 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:28650 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262431AbUKVV1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:27:18 -0500
Message-Id: <200411222127.iAMLRtN7020062@owlet.beaverton.ibm.com>
To: Ray Bryant <raybry@sgi.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: [Lse-tech] scalability of signal delivery for Posix Threads 
In-reply-to: Your message of "Mon, 22 Nov 2004 09:51:15 CST."
             <41A20AF3.9030408@sgi.com> 
Date: Mon, 22 Nov 2004 13:27:55 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So with CLONE_SIGHAND, we share the handler assignments and which signals
are blocked, but retain the ability for individual threads to receive
a signal.  And when all of them receive signals in quick succession,
we see lock contention because they're sharing the same (effectively)
global lock to receive all of their (effectively) individual signals
.. is that correct?

Are you contending on tasklist_lock, or on siglock?

    It seems to me that scalability would be improved if we moved the
    siglock from the sighand structure to the task_struct.

Only if you want to keep its current semantics of it being a lock for
all things signal.  Finer granularity would, it seems at first look,
afford you the benefits you're looking for.  (But not without the cost of
a fair amount of work to make sure the new locks are utilized correctly.)
For the problem you're describing, it sounds like the contention is occuring
at delivery, so a new lock for pending, blocked, and real_blocked might be
in order.

Rick
