Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271926AbRIDKFP>; Tue, 4 Sep 2001 06:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271927AbRIDKFG>; Tue, 4 Sep 2001 06:05:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47753 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271926AbRIDKEv>;
	Tue, 4 Sep 2001 06:04:51 -0400
Date: Tue, 04 Sep 2001 03:04:54 -0700 (PDT)
Message-Id: <20010904.030454.85412225.davem@redhat.com>
To: ak@suse.de
Cc: jeffm@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs
 on parisc architecture
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <oupoforxpc1.fsf@pigdrop.muc.suse.de>
In-Reply-To: <20010903003437.A385@linux-m68k.org.suse.lists.linux.kernel>
	<20010903213835.A13887@fury.csh.rit.edu.suse.lists.linux.kernel>
	<oupoforxpc1.fsf@pigdrop.muc.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 04 Sep 2001 11:44:30 +0200

   Jeff Mahoney <jeffm@suse.com> writes:
   
   >     I did kick around the idea of making those macros the default accessors for
   >     the deh_state member (which is the only place they're used), but it unfairly
   >     penalizes arches that don't need them.
   
   On archs that don't need them {get,put}_unaligned should be just normal
   assignments. They are certainly on i386.

I can also almost guarentee you that the x86 will sometimes not
execute these bitops atomically on SMP.

We had some obscure bug on SMP/x86 years ago, and Linus discovered
that removing an unaligned spinlock or bitop made the problem go away.

Reiserfs is broken and needs to be fixed.

If you make the unaligned accessors there the default for everyone,
you solve the problem _AND_ there is no penalization.  Look at what
the compiler makes of the code generated, it is going to be almost
entirely identical.  The compiler should be able to compute it all
via constants.  If not, oh you get 1 or 2 instructions here or
there, and that is MINISCULE compared to the cost of the atomic
operation itself.

What's more, you will have less QA'ing to do, since this code will
always be in use and thus tested.

FACT: Doing bitops on something not "long" aligned is a bug and
      will always be a bug.  You must fix it.

Later,
David S. Miller
davem@redhat.com

