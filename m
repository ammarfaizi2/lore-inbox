Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSIIGQb>; Mon, 9 Sep 2002 02:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSIIGQb>; Mon, 9 Sep 2002 02:16:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8860 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316535AbSIIGQa>;
	Mon, 9 Sep 2002 02:16:30 -0400
Date: Sun, 08 Sep 2002 23:13:04 -0700 (PDT)
Message-Id: <20020908.231304.30400540.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: pavel@suse.cz, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020909054106.19E762C0C4@lists.samba.org>
References: <20020906095743.A35@toy.ucw.cz>
	<20020909054106.19E762C0C4@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 09 Sep 2002 13:45:02 +1000

   	/* FIXME: Initializer required so gcc 2.96 doesn't put in BSS */
   	DEFINE_PER_CPU(int, xxx) = 0;
   
   everywhere, which can be deleted later

Why everywhere?  If you do it in the macro, then when you want
to delete the initializer remove the macro arg.  Then you cover
both in-kernel and cases in external sources because the build
will break for them so they'll know to fixup their macro invocation.

I hate when things change silently, and if you don't put it in
the macro, someone will get it wrong and we'll find out only
when someone with an older compiler uses that feature on an SMP
machine.

Read as: This is bad programming practice Rusty, regardless of
         your personal views about this particular GCC bug or
	 what you think is a legitimate initializer.

See spinlock_t's declaration for older GCC versions, that is how we
traditionally deal with compiler bugs like this, explicitly so that it
is impossible to "miss" something and get it wrong.

Everytime I asked Linus to rearrange some piece of code that used
spinlock_t initializers to workaround the "empty initializer at
end of struct" GCC bug he always told me "someone will get it
wrong if we do it that way"  And I think he's right.
