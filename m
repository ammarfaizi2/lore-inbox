Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTDUSwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTDUSwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:52:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19729 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261968AbTDUSvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:51:41 -0400
Date: Mon, 21 Apr 2003 12:04:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Roman Zippel <zippel@linux-m68k.org>, "David S. Miller" <davem@redhat.com>,
       <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <20030421194749.A10963@infradead.org>
Message-ID: <Pine.LNX.4.44.0304211153270.9109-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003, Christoph Hellwig wrote:
>
> Why do we need to do a mapping?  Old applications just won't see the
> high bits (they're mapped to whatever overflow value) - values that
> fit into the old 16bit range should never be remapped.

Ehh.. Old and new drivers alike will use the MAJOR() macro, and that macro
had better work with old and new kernels. Agreed? (And if you don't agree,
don't even bother to answer, I'm not really interested in even discussing
something so fundamental).

And regardless of whether a person uses an old or a new library, they had
better see the same MAJOR() and MINOR() values for a legacy device, like
/dev/hda1. In other words, the library version of MAJOR(),MINOR() _has_ to
return the value 3,1, or it can break perfectly valid programs.

Again, if you don't agree, don't even bother sending me email any more
about this issue. This is not negotiable. We _will_ have backwards and
forwards compatibility, and that's final.

This means that MAJOR() has to look at bits 8..15 if the value is small. 
No ifs, buts and maybes about it.

HOWEVER, clearly MAJOR() has to look at other bits too, otherwise it 
wouldn't make any sense to make a bigger dev_t in the first place. The 
current MAJOR() is the logical extension.

But that _will_ force aliasing, unless you start doing some really funky 
things (make the dev_t look more like a UTF-8 unicode-like extension, 
which is obviously possible). In other words, there will be OTHER values 
for "dev_t" that will _also_ look like the tuple <3,1>.

And my requirements are that

 - other values of dev_t that also look like <3,1> had better act 
   _identically_ to the legacy values. It _has_ to work this way, since 
   otherwise you'd have a total maintenance nightmare, with "ls -l"  
   showing two device files as being identical, yet having different
   behaviour.

 - Device drivers that ask for "major 3, minors 0-0xfff" _have_ to do the 
   sane thing. In particular, in the presense of aliases (see above), it 
   has to match _both_ aliases (see above).

These are not things open for discussion. We know what the behaviour MUST 
BE. Aliases _have_ to behave identically, anything else is _indisputably_ 
crap.

And I claim that this means that you have to have a mapping somewhere. 
You're free to come up with new ideas, but I don't think it will work. 
Keep the above rules in mind: backwards compatibility and aliases that 
work identically. That's all it really boils down to.

		Linus

