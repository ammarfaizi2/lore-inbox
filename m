Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266410AbTGES1l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 14:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266412AbTGES1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 14:27:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:56777 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266410AbTGES1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 14:27:40 -0400
Date: Sat, 5 Jul 2003 11:43:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-Id: <20030705114308.6dacb5a2.akpm@osdl.org>
In-Reply-To: <20030705104433.GK955@holomorphy.com>
References: <20030703023714.55d13934.akpm@osdl.org>
	<20030704210737.GI955@holomorphy.com>
	<20030704181539.2be0762a.akpm@osdl.org>
	<20030705104433.GK955@holomorphy.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> The badness() check isn't good enough. If badness() returns 0 for all
>  processes with pid's > 0 and the first one seen is a kernel thread the
>  kernel thread will be chosen.

Are we looking at the same code? 

static struct task_struct * select_bad_process(void)
{
	int maxpoints = 0;
	struct task_struct *g, *p;
	struct task_struct *chosen = NULL;

	do_each_thread(g, p)
		if (p->pid) {
			int points = badness(p);
			if (points > maxpoints) {
				chosen = p;
				maxpoints = points;
			}
			if (p->flags & PF_SWAPOFF)
				return p;
		}
	while_each_thread(g, p);
	return chosen;
}

if badness() returns zero for everything, this returns NULL and
the kernel panics.


