Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268179AbUHFRGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268179AbUHFRGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268190AbUHFRDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:03:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:61650 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268200AbUHFQ6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:58:39 -0400
Date: Fri, 6 Aug 2004 09:58:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de,
       Chris Shoemaker <c.shoemaker@cox.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Possible dcache BUG
In-Reply-To: <200408060751.07605.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <20040806073739.GA6617@elte.hu> <20040806004231.143c8bd2.akpm@osdl.org>
 <200408060751.07605.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Aug 2004, Gene Heskett wrote:
> 
> Linus, Andrew, should I apply this patch too at the next remake?

Might be worth it, but it's more important to see any oops at all, or lack 
of oopses..

> FWIW, I'm still up (20:38) this morning, and showing plenty (127+ 
> megs) of free memory.  No crash, no odd log (other than samba 
> squawking about some option thats been changed & I haven't fixed the 
> smb.conf) so far.
> 
> I'm beginning to like this test patch, Linus, thanks :)

If the only thing you have done is add the list_del_init() debugging 
patch, then the only thing that has changed is really the access patterns 
to uncached memory.

The original list_del_init() tries to only do a few single _writes_ to the 
dentries around it. The added debugging will do _reads_ (and thus bring it 
into the cache) of the dentry pointers of the dentries around it.

If that change makes a real difference, I really only see two 
possibilities:
 - there really is a prefetch bug (or possibly, there's a bug in our 
   prefetch fixup code, and the known prefetch bug just triggers the 
   problem indirectly)
 - it just changes the timing enough that whatever bug you hit went away.

Now, Chris Shoemaker reported dentry problems on a intel CPU and said that 
wli had seen something too, but I'm wondering whether Chris and wli might 
have been seeing the knfsd/xfs-related dentry bug that I found yesterday.  
So I think the prefetch theory is still alive, but we should check with 
Chris. Chris?

		Linus
