Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751731AbWAKUz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWAKUz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWAKUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:55:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21146 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751731AbWAKUz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:55:26 -0500
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, sct@redhat.com,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060111124617.5e7e1eaa.akpm@osdl.org>
References: <200601112126.59796.ak@suse.de>
	 <20060111124617.5e7e1eaa.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 21:55:17 +0100
Message-Id: <1137012917.2929.78.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 12:46 -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > 
> > Running LTP with the default runfile on a 4 virtual CPU x86-64 
> > system gives
> > 
> > To reproduce: run ltp 20040908 (newer one will probably work
> > too) with runltp -p -q -l `uname -r` on a ext3 file system
> > 
> > config is x86-64 defconfig.
> > 
> 
> mutex_trylock() is returning the wrong value.  fs/super.c:write_super()
> clearly took the lock.


the conversion is buggy.

mutex_trylock has the same convention as spin_try_lock (which is the
opposite of down_trylock). THe conversion forgot to add a !

--- linux-2.6.15/fs/ext3/super.c~	2006-01-11 21:54:13.000000000 +0100
+++ linux-2.6.15/fs/ext3/super.c	2006-01-11 21:54:13.000000000 +0100
@@ -2150,7 +2150,7 @@
 
 static void ext3_write_super (struct super_block * sb)
 {
-	if (mutex_trylock(&sb->s_lock) != 0)
+	if (!mutex_trylock(&sb->s_lock) != 0)
 		BUG();
 	sb->s_dirt = 0;
 }


