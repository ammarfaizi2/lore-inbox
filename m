Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbUANS2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUANS2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:28:40 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:53407 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263356AbUANS2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:28:33 -0500
Subject: Re: 2.4.24 SMP lockups
From: David Woodhouse <dwmw2@infradead.org>
To: Simon Kirby <sim@netnation.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       viro@ftp.uk.linux.org
In-Reply-To: <20040114170753.GB8467@netnation.com>
References: <20040109210450.GA31404@netnation.com>
	 <Pine.LNX.4.58L.0401101719400.1310@logos.cnet>
	 <20040114170753.GB8467@netnation.com>
Content-Type: text/plain
Message-Id: <1074104903.7098.18.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Wed, 14 Jan 2004 18:28:23 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-14 at 09:07 -0800, Simon Kirby wrote:
> I also have an entire sysrq-T, but it is for over 500 processes, so I
> posted the entire serial capture log as well, as a few other things
> here:
> 
> 	http://blue.netnation.com/sim/ref/2.4.24_stuck_cpu/

Perfect report; thanks.

It deadlocked in attempting to get a spinlock, in remove_wait_queue().

(Look at the address it wanted to jump to when it got the lock, from 
0xc011c7cf to 0xc011c7cf+0xffffe996 == 0xc011b165).

This is almost probably because the remove_wait_queue() in
__wait_on_freeing_inode() is removing us from a waitqueue in an inode
which has already been freed. The memory which used to hold a spinlock
has been reused, and it now looks locked, so we wait. For ever.

This differs from the working 2.6 version, where the waitqueue is in a
hsah table and doesn't go away.

I _think_ it's true that the _only_ way we can get woken from
__wait_on_freeing_inode() is the inode has actually been destroyed, in
which case it's fine just to _not_ remove ourselves from the (defunct)
wait queue, and to return. But I need to stare hard at it some more,
have another cup of tea, and ask Al :)

If I'm right in the above, then this should work....

===== fs/inode.c 1.47 vs edited =====
*** /tmp/inode.c-1.47-18008	Thu Jan  8 12:23:51 2004
--- fs/inode.c	Wed Jan 14 18:25:33 2004
*************** static void __wait_on_freeing_inode(stru
*** 264,270 ****
--- 264,274 ----
          set_current_state(TASK_UNINTERRUPTIBLE);
          spin_unlock(&inode_lock);
          schedule();
+ /* Inode is dead or dying. The wait queue is obsolete and we don't need to
+    remove ourselves from it. More to the point we _mustn't_ remove ourselves
+    since it may already have been freed
          remove_wait_queue(&inode->i_wait, &wait);
+  */
          spin_lock(&inode_lock);
  }
  


-- 
dwmw2

