Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273203AbRIYTkw>; Tue, 25 Sep 2001 15:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRIYTkn>; Tue, 25 Sep 2001 15:40:43 -0400
Received: from [194.213.32.137] ([194.213.32.137]:4356 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273203AbRIYTkc>;
	Tue, 25 Sep 2001 15:40:32 -0400
Message-ID: <20010925003416.A151@bug.ucw.cz>
Date: Tue, 25 Sep 2001 00:34:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: riel@conectiva.com.br, kernel list <linux-kernel@vger.kernel.org>
Subject: Out of memory handling broken
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I need to allocate as much memory as possible (but not more). Okay, so
I use out_of_memory, right?

Does this code look sane?

static void eat_memory(void)
{
        int i = 0;
        void **c= eaten_memory, *m;

        printk("Eating pages ");
        while ((m = (void *) get_free_page(GFP_USER))) {
                memset(m, 0, PAGE_SIZE);
                eaten_memory = m;
                if (!(i%5000))
                        printk( "." );
                *eaten_memory = c;
                c = eaten_memory;
                i++;
                if (out_of_memory())
                        break;
        }
        printk("(%dK)\n", i*4);
}

[if not, how should I code it?]

But, when I looked into out_of_memory... Of course its
wrong. out_of_memory() contains

        if (nr_swap_pages > 0)
                return 0;

...which is obviously wrong. It is well possible to have free swap
_and_ be out of memory -- eat_memory() loop gets system to this state
easily.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
