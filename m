Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274861AbRIUWqg>; Fri, 21 Sep 2001 18:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274863AbRIUWq0>; Fri, 21 Sep 2001 18:46:26 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:26898 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S274861AbRIUWqR>;
	Fri, 21 Sep 2001 18:46:17 -0400
From: tpepper@vato.org
Date: Fri, 21 Sep 2001 15:46:42 -0700
To: linux-kernel@vger.kernel.org
Subject: possible race in end_buffer_io_async()
Message-ID: <20010921154642.A22662@cb.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a setup here that is triggering the BUG() in UnlockPage() in
end_buffer_io_async().  Looking at the code in that function we noticed that:

When the put_bh() macro calls got added to fs/buffer.c's
end_buffer_io_async() they look like they got in slightly inconsistently.
If the code branches to still_busy it does:

	put_bh(bh);
	spin_unlock_irqrestore(&page_uptodate_lock, flags);

If the branch is not taken it does:

	spin_unlock_irqrestore(&page_uptodate_lock, flags);
	put_bh(bh);

I don't know which is correct...There's either a possible race if the put_bh()
should be inside the lock (although since it's decrementing bh_count I doubt
it's what would be causing my attempt to unlock an unlocked page) or else
there are a few instructions that can be moved outside the lock.

I've been hunting around on the web and saw some discussion in July
about async I/O races between Andrea and Linus.  Are these resolved?
I'm running 2.4.9 on the machine in question (w/ and w/o kgdb) trying
to figure out what's going on.  I'm going to try the latest pre patches
this weekend since the 2.4.10-pre's include a big merge against Andrea.

Tim
