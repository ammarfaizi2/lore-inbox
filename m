Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265739AbTIJV2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265741AbTIJV2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:28:18 -0400
Received: from gprs147-211.eurotel.cz ([160.218.147.211]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265739AbTIJV2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:28:16 -0400
Date: Wed, 10 Sep 2003 23:27:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jamie Lokier <jamie@shareable.org>, Dave Jones <davej@redhat.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030910212757.GA257@elf.ucw.cz>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com> <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com> <20030910152902.GA2764@elf.ucw.cz> <Pine.LNX.4.53.0309101147040.14762@chaos> <20030910183138.GA23783@mail.jlokier.co.uk> <Pine.LNX.4.53.0309101439390.18459@chaos> <20030910201240.GB24424@mail.jlokier.co.uk> <Pine.LNX.4.53.0309101619020.18924@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309101619020.18924@chaos>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 		cmpl	$1, %eax
> > > 		jz	1f
> > > 		jc	2f
> > > 		call	do_default
> > > 		jmp	more_code
> > > 	1:	call	do_something_if_equal
> > > 		jmp	more_code
> > > 	2:	call	do_something_if_less
> > > 	more_code:
> > >
> > > In every case, one has to jump around code for other execution paths
> > > except the last, where you have to jump on condition anyway. There
> > > is no free liunch, and the straight-through route, do_default
> > > uas just as many jumps as the last.
> >
> > Here is your code optimised for no jumps in the "do_default" case:
> >
> > 		cmpl	$1,%eax
> > 		jbe	1f
> > 		call	do_default
> > 	more_code:
> > 		.subsection 1
> > 	1:	jnz	2f
> > 		call	do_something_if_equal
> > 		jmp	more_code
> > 	2:	call	do_something_if_less
> > 		jmp	more_code
> > 		.previous
> >
> 
> You are a magician! Putting in a .subsection to hide the jump
> is absolute bullshit. The built-in macros, ".subsection", and
> ".previous" just made the damn linker do the fixup. You just
> did a long jump, out of the current code-stream, into some

He's right. Even without subsections you can move code somewhere
outside the function. And gcc should be smart enough to do that.

							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
