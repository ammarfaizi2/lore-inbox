Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSFQPyR>; Mon, 17 Jun 2002 11:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSFQPyQ>; Mon, 17 Jun 2002 11:54:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16901 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314500AbSFQPyP>;
	Mon, 17 Jun 2002 11:54:15 -0400
Date: Mon, 17 Jun 2002 16:54:17 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Using tq_immediate
Message-ID: <20020617165417.Y9435@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you want to use tq_immediate, here's the current way to do it:

        queue_task(&bcs->tqueue, &tq_immediate);
        mark_bh(IMMEDIATE_BH);

There's about 80 drivers in the tree which do this, FYI.  This sucks,
because it sets up a linkage between task queues and bottom halves.
If you, like I, wish for bottom halves to go away, we're going to have
to change this.  Some people want to eradicate task queues too -- and
while I think this is a fine idea, I can't see it happening in the next
week or so.

My proposal is:

	queue_task(&bcs->tqueue, &tq_immediate);
	wake_immediate_queue();

While this is a little magic (there's no obvious connection between the
two), and it's special-purpose (no equivalent for other task queues),
I think it's an acceptable compromise that doesn't require taking out
all 80 drivers and shooting them.

-- 
Revolutions do not require corporate support.
