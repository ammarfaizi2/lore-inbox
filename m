Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbTCVLeL>; Sat, 22 Mar 2003 06:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbTCVLeL>; Sat, 22 Mar 2003 06:34:11 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:56000 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S262128AbTCVLeK>;
	Sat, 22 Mar 2003 06:34:10 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303221145.h2MBjAW09391@csl.stanford.edu>
Subject: [CHECKER] races in 2.5.65/mm/swapfile.c?
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Sat, 22 Mar 2003 03:45:10 -0800 (PST)
Cc: engler@csl.stanford.edu (Dawson Engler)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

mm/swapfile.c seems to have three potential races.

The first two are in 
        linux-2.5.62/mm/swap_state.c:87:add_to_swap_cache

which seems reachable without a lock from the callchain:

        mm/swapfile.c:sys_swapoff:998->
              sys_swapoff:1026->
                try_to_unuse:591->
                        mm/swap_state.c:read_swap_cache_async:377->
                            add_to_swap_cache

add_to_swap_cache increments two global variables without a lock:
        INC_CACHE_INFO(add_total);
and
        INC_CACHE_INFO(exist_race);


The final one is in
        linux-2.5.62/mm/swapfile.c:213:swap_entry_free
which seems to increment
        nr_swap_pages++;
without a lock.

Are these real races?  Or are these just stats variables?  (Or is
there some implicit locking that protects these?)

Regards,
Dawson
