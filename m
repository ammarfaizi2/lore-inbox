Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317437AbSF2Anf>; Fri, 28 Jun 2002 20:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317485AbSF2Ane>; Fri, 28 Jun 2002 20:43:34 -0400
Received: from mpdr0.chicago.il.ameritech.net ([67.38.100.19]:14313 "EHLO
	mpdr0.chicago.il.ameritech.net") by vger.kernel.org with ESMTP
	id <S317437AbSF2And>; Fri, 28 Jun 2002 20:43:33 -0400
Date: Fri, 28 Jun 2002 19:46:39 -0500
From: Mark J Roberts <mjr@znex.org>
To: linux-kernel@vger.kernel.org
Subject: list.h merge sort implementation.
Message-ID: <20020629004639.GA2311@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Key: 0x025D0C28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few months ago I adapted a merge sort implementation from
http://www.chiark.greenend.org.uk/~sgtatham/algorithms/listsort.html
to work with Linux's list.h. I figure I should get it into the
archives just in case anyone might want such a thing. So here it is.

void list_sort(struct list_head *head, int (*cmp)(struct list_head *a, struct list_head *b))
{
	struct list_head *p, *q, *e, *list, *tail, *oldhead;
	int insize, nmerges, psize, qsize, i;

	list = head->next;
	list_del(head);
	insize = 1;
	for (;;) {
		p = oldhead = list;
		list = tail = NULL;
		nmerges = 0;

		while (p) {
			nmerges++;
			q = p;
			psize = 0;
			for (i = 0; i < insize; i++) {
				psize++;
				q = q->next == oldhead ? NULL : q->next;
				if (!q)
					break;
			}

			qsize = insize;
			while (psize > 0 || (qsize > 0 && q)) {
				if (!psize) {
					e = q;
					q = q->next;
					qsize--;
					if (q == oldhead)
						q = NULL;
				} else if (!qsize || !q) {
					e = p;
					p = p->next;
					psize--;
					if (p == oldhead)
						p = NULL;
				} else if (cmp(p, q) <= 0) {
					e = p;
					p = p->next;
					psize--;
					if (p == oldhead)
						p = NULL;
				} else {
					e = q;
					q = q->next;
					qsize--;
					if (q == oldhead)
						q = NULL;
				}
				if (tail)
					tail->next = e;
				else
					list = e;
				e->prev = tail;
				tail = e;
			}
			p = q;
		}

		tail->next = list;
		list->prev = tail;

		if (nmerges <= 1)
			break;

		insize *= 2;
	}

	head->next = list;
	head->prev = list->prev;
	list->prev->next = head;
	list->prev = head;
}
