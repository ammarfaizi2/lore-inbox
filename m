Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266024AbUAUSk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266015AbUAUSk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:40:57 -0500
Received: from waste.org ([209.173.204.2]:37345 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265998AbUAUSjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:39:54 -0500
Date: Wed, 21 Jan 2004 12:39:38 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: More cleanups for swsusp
Message-ID: <20040121183938.GE14797@waste.org>
References: <20040120225219.GA19190@elf.ucw.cz> <20040121051855.B0C282C0A7@lists.samba.org> <20040120213037.66c9d5a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120213037.66c9d5a0.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 09:30:37PM -0800, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > In message <20040120225219.GA19190@elf.ucw.cz> you write:
> >  > -	if (fill_suspend_header(&cur->sh))
> >  > -		panic("\nOut of memory while writing header");
> >  > +	BUG_ON (fill_suspend_header(&cur->sh));
> > 
> > ...
> >  3) BUG_ON(complex condition expression) is much less clear than:
> > 
> >  	if (complex condition expression)
> >  		BUG();

Disagree. All BUG_ON() stuff should read like:

/* check that impossible stuff didn't happen, move along, nothing to see */
BUG_ON(...);

Which is fine and good until the condition is actually doing more than
just sanity checking.

> Worse.  If some smarty goes and makes BUG_ON a no-op (for space reasons),
> it will break software suspend.  We should ensure that the expression which
> is supplied to BUG_ON() never has side-effects for this reason.

While I generally agree that "assertions" shouldn't have side-effects,
a slightly smarter smarty would make sure that BUG_ON evaluated its
condition. I have this in -tiny:

+#ifndef CONFIG_BUG
+#define BUG()
+#define WARN_ON(condition) do { if (condition) ; } while(0)
+#define BUG_ON(condition) do { if (condition) ; } while(0)
+#define PAGE_BUG(page)
+#else

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
