Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280043AbRKVRHP>; Thu, 22 Nov 2001 12:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280047AbRKVRG6>; Thu, 22 Nov 2001 12:06:58 -0500
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:57102 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S280056AbRKVRGh>; Thu, 22 Nov 2001 12:06:37 -0500
To: linux-kernel@vger.kernel.org
Subject: Combining list_for_each and list_entry
From: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Date: 22 Nov 2001 18:06:29 +0100
Message-ID: <m38zcyrazu.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.6a |January
 17, 2001) at 22-11-2001 18:06:30,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.6 |December 14, 2000) at
 22-11-2001 18:06:29,
	Serialize complete at 22-11-2001 18:06:29
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Everywhere in the kernel where list_for_each is used, you typically
find a list_entry as the first statement in the loop body, e.g.:

	list_for_each(tmp, &runqueue_head) {
		p = list_entry(tmp, struct task_struct, run_list);
		if (can_schedule(p, this_cpu)) {
			int weight = goodness(p, this_cpu, prev->active_mm);
			if (weight > c)
				c = weight, next = p;
		}
	}

I came up with the following idea to combine the two:

#define list_iterate(lh, head, elm, link)				     \
	for (lh = (head)->next;						     \
	     lh != (head) &&						     \
	       (elm = list_entry(lh, typeof(*elm), link), lh = lh->next, 1);)

Now you can say

	list_iterate(tmp, &runqueue_head, p, run_list) {
		if (can_schedule(p, this_cpu)) {
			int weight = goodness(p, this_cpu, prev->active_mm);
			if (weight > c)
				c = weight, next = p;
		}
	}

and since lh is update at the beginning of the loop, list_iterate is
automatically safe, i.e. you can remove the current element while
looping.

How about it?

regards,
Kristian

