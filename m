Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281623AbRKUG3x>; Wed, 21 Nov 2001 01:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281624AbRKUG3n>; Wed, 21 Nov 2001 01:29:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61327 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281623AbRKUG3d>;
	Wed, 21 Nov 2001 01:29:33 -0500
Date: Tue, 20 Nov 2001 22:29:20 -0800 (PST)
Message-Id: <20011120.222920.51691672.davem@redhat.com>
To: ebiederm@xmission.com
Cc: torvalds@transmeta.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 + Bug in swap_out.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <m1vgg41x3x.fsf@frodo.biederman.org>
In-Reply-To: <m1vgg41x3x.fsf@frodo.biederman.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: ebiederm@xmission.com (Eric W. Biederman)
   Date: 20 Nov 2001 23:01:06 -0700

   And looking in fork.c mmput under with right circumstances becomes.
   kmem_cache_free(mm_cachep, (mm)))
   
   So it appears that there is nothing that keeps the mm_struct that
   swap_mm points to as being valid. 

I do not agree with your analysis.

If we hold the mmlist lock and we find the mm on the swap mm list, by
definition it must have a non-zero user count already.  (put an assert
there if you don't believe me :-)

Only when the user count drops to zero will mmput() free up the mm.
It simultaneously grabs the mmlist lock when it drops the user count
to zero, this is how it synchronizes with the rest of the world.
Perhaps you aren't noticing that it is using "atomic_dec_and_lock()"
or you don't understand how that primitive works?

We increment the mm user count before dropping the mmlist lock in the
swapper, so even if the user does a mmput() we still hold a reference.
ie. mmput won't put the user count to zero.
