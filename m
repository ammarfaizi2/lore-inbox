Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUE0AIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUE0AIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 20:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUE0AIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 20:08:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:3503 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261405AbUE0AIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 20:08:36 -0400
Date: Wed, 26 May 2004 17:08:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       Stephane LOEUILLET <bug-kernel@leroutier.net>
Subject: Re: [Bug 2773] New: kernel panic under medium load
In-Reply-To: <20040526163029.10b5c88c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405261656370.1648@ppc970.osdl.org>
References: <390810000.1085582148@[10.10.2.4]> <Pine.LNX.4.58.0405260918161.1770@ppc970.osdl.org>
 <20040526163029.10b5c88c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 May 2004, Andrew Morton wrote:
>
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > What happens for you before? Can you do a "make mm/page_alloc.s" and post 
> > the result (well, just __alloc_pages, not the rest).
> > 
> 
> Stephane had added page_alloc.s to
> 
> 	http://bugme.osdl.org/show_bug.cgi?id=2773

Interesting. The load is right before the instruction:

**	        movl    -36(%ebp), %eax		***
	        cmpl    $99, 24(%eax)
	        jg      .L241

and the only difference here is that it says "-36(%ebp)" instead of 
"20(%esp)" because it's compiled with frame pointers.

(Well, there must be something else different on the stack frame too, 
according to the earlier dump it really _should_ be 20%(%esp), but the 
difference between %esp and %ebp here runs to 52, not 56, which makes me 
suspect the thing is compiled with some different options. Anyway, that 
bogus 0x00004000 value is not on the stack at either offset in the dump, 
so it shouldn't matter).

Oh, I just notice that Stephane actually _says_ that he changed the config 
options.

Anyway, the interesting part seems to be that %eax is corrupt, and it
really shouldn't be. It appears to be ok in memory, and was loaded from
there just before, so I'm wondering whether there is soem _serious_
problem with this machine?

		Linus
