Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261946AbSIYIg2>; Wed, 25 Sep 2002 04:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbSIYIg2>; Wed, 25 Sep 2002 04:36:28 -0400
Received: from closet.leakybucket.com ([208.177.155.94]:26240 "HELO
	closet.leakybucket.org") by vger.kernel.org with SMTP
	id <S261946AbSIYIg0>; Wed, 25 Sep 2002 04:36:26 -0400
Date: Tue, 24 Sep 2002 18:14:01 -0700
From: alfred@leakybucket.org
To: linux-kernel@vger.kernel.org
Subject: [patch] Re: 2 futex questions
Message-ID: <20020925011401.GA15543@closet.leakybucket.org>
Reply-To: alfred@leakybucket.org
References: <20020925003353.GA15418@closet.leakybucket.org> <Pine.LNX.4.44.0209251015320.4690-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209251015320.4690-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 10:23:16AM +0200, Ingo Molnar wrote:
> 
> what it says: 'uaddr must be naturally aligned, and the word must be on a
> single page'. In theory it's possible that __alignof__(int) !=
> sizeof(int).
> 

Ok, would the following actually save some cycles then?

diff -u a/kernel/futex.c b/kernel/futex.c 
--- a/kernel/futex.c    Tue Sep 24 15:25:01 2002
+++ b/kernel/futex.c    Tue Sep 24 18:09:09 2002
@@ -321,9 +321,10 @@
 
        pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
 
-       /* Must be "naturally" aligned, and not on page boundary. */
+       /* Must be "naturally" aligned, and must not cross a page boundary. */
        if ((pos_in_page % __alignof__(int)) != 0
-           || pos_in_page + sizeof(int) > PAGE_SIZE)
+           || ((sizeof(int) != __alignof__(int))
+                && (pos_in_page + sizeof(int) > PAGE_SIZE)))
                return -EINVAL;
 
        /* Simpler if it doesn't vanish underneath us. */


Alfred Landrum
