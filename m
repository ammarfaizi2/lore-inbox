Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbTGEFKM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 01:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266276AbTGEFKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 01:10:12 -0400
Received: from dp.samba.org ([66.70.73.150]:142 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266275AbTGEFKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 01:10:08 -0400
Date: Sat, 5 Jul 2003 15:21:02 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030705052102.GB13308@krispykreme>
References: <20030703023714.55d13934.akpm@osdl.org> <20030704210737.GI955@holomorphy.com> <20030704181539.2be0762a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704181539.2be0762a.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Look at select_bad_process(), and the ->mm test in badness().  pdflush
> can never be chosen.
> 
> Nevertheless, there have been several report where kernel threads _are_ 
> being hit my the oom killer.  Any idea why that is?

Milton and I were just looking at this and it seems there is no locking
to prevent p->mm ending up NULL due to exit. And if p->mm does end up
NULL, you go off and kill all your kernel threads :)

Anton

	read_lock(&tasklist_lock);
	p = select_bad_process();

...

        oom_kill_task(p);
        /*
         * kill all processes that share the ->mm (i.e. all threads),
         * but are in a different thread group
         */
        do_each_thread(g, q)
                if (q->mm == p->mm && q->tgid != p->tgid)
                        oom_kill_task(q);
        while_each_thread(g, q);
