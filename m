Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUHVErL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUHVErL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 00:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUHVErL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 00:47:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266124AbUHVErH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 00:47:07 -0400
Date: Sat, 21 Aug 2004 21:46:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rlrevell@joe-job.com
Subject: Re: [patch] context-switching overhead in X, ioport(), 2.6.8.1
Message-Id: <20040821214632.62d58e40.davem@redhat.com>
In-Reply-To: <20040821135516.GA3872@elte.hu>
References: <20040821135516.GA3872@elte.hu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW, I would recommend a sparse bitmap implementation for the
ioport stuff.  Something simple like:

struct set_ent {
	u32 pos;
	u32 bits;
	struct set_ent *next;
};

static inline int is_set(struct set_ent *head, int pos)
{
	while (head != NULL) {
		if (pos >= head->pos) {
			if (pos < head->pos + 32) {
				if (head->bits &
				    (1 << (pos - head->pos)))
					return 1;
			}
			break;
		}

		head = head->next;
	}
	return 0;
}

You get the idea.
