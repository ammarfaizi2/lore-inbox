Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTIDCoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTIDCo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:44:29 -0400
Received: from dp.samba.org ([66.70.73.150]:43709 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264498AbTIDCnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:43:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix 
In-reply-to: Your message of "Wed, 03 Sep 2003 12:05:36 MST."
             <Pine.LNX.4.44.0309031201170.31853-100000@home.osdl.org> 
Date: Thu, 04 Sep 2003 12:43:04 +1000
Message-Id: <20030904024345.CC3E02C018@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309031201170.31853-100000@home.osdl.org> you write:
> Private mappings that haven't been broken by COW (and a read-only mapping
> never will be) will see updates as they happen on the file that backs it.
> That's the fundamental difference between "mmap(MAP_PRIVATE)" and
> "read()".

Right, so it would be consistent for someone doing a FUTEX_WAIT on an
"intact" (not broken by COW) private mapping to see a FUTEX_WAKE done
on that file.

However, Jamie's futex code will see !VM_SHARED on the mapping, and
compare futexes by mm + uaddr (rather than inode + file offset), so
this is NOT the case.  Using VM_MAYSHARE instead would make the
MAP_SHARED readonly case work as above, though.

The way futexes are used now, they're both "don't care".  If you have
a private mapping or read-only mapping, you'll never get woken by
others with the same file mapped writable shared, but WTF were you
waiting for a futex if the mapping is private anyway: the lock
acquisition won't work (and sleeping forever is easier to debug than
two tasks getting the lock).

Oh no, I think I'm starting to understand the VM a little.

Ick.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
