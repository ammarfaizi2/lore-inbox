Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbREOGT4>; Tue, 15 May 2001 02:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbREOGTg>; Tue, 15 May 2001 02:19:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35600 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262652AbREOGT0>; Tue, 15 May 2001 02:19:26 -0400
Date: Tue, 15 May 2001 01:41:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: [PATCH] remove page_launder() from bdflush
Message-ID: <Pine.LNX.4.21.0105150134190.32493-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, 

There is no reason why bdflush should call page_launder().

Its pretty obvious that bdflush's job is to only write out _buffers_. 

Under my tests this patch makes things faster.

Guess why? Because bdflush is writing out buffers when it should instead
blocking inside try_to_free_pages().

Please apply. 

--- fs/buffer.c.orig    Tue May 15 03:13:05 2001
+++ fs/buffer.c Tue May 15 03:13:22 2001
@@ -2703,8 +2703,6 @@
                CHECK_EMERGENCY_SYNC
 
                flushed = flush_dirty_buffers(0);
-               if (free_shortage())
-                       flushed += page_launder(GFP_KERNEL, 0);
 
                /*
                 * If there are still a lot of dirty buffers around,


