Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315185AbSEFWMO>; Mon, 6 May 2002 18:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSEFWMN>; Mon, 6 May 2002 18:12:13 -0400
Received: from [195.39.17.254] ([195.39.17.254]:54420 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315185AbSEFWMM>;
	Mon, 6 May 2002 18:12:12 -0400
Date: Tue, 7 May 2002 00:11:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Writing to the swap space
Message-ID: <20020506221125.GA25298@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For swsusp, I need to write to the swap space.

I used technique similar to this:

static void mark_swapfiles(swp_entry_t prev, int mode)
{
        swp_entry_t entry;
        union diskpage *cur;

        cur = (union diskpage *)get_free_page(GFP_ATOMIC);
        if (!cur)
                panic("Out of memory in mark_swapfiles");
        /* XXX: this is dirty hack to get first page of swap file */
        entry = SWP_ENTRY(root_swap, 0);
        lock_page(virt_to_page((unsigned long)cur));
        rw_swap_page_nolock(READ, entry, (char *) cur);


... modify cur->fields...

        lock_page(virt_to_page((unsigned long)cur));
        rw_swap_page_nolock(WRITE, entry, (char *)cur);

        free_page((unsigned long)cur);
}

It seems not to work any more. Some io is done, but it is not
synchronous any more, and it does not seem to hit the disk.

What am I doing wrong, or is there something wrong in 2.5.12/2.5.13?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
