Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVDIQYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVDIQYi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 12:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVDIQYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 12:24:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:8849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261352AbVDIQYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 12:24:16 -0400
Date: Sat, 9 Apr 2005 09:26:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@engr.sgi.com>
cc: ross@jose.lug.udel.edu, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050409085017.7edf2c9a.pj@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0504090916550.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071720.GA23128@jose.lug.udel.edu> <Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
 <20050409085017.7edf2c9a.pj@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005, Paul Jackson wrote:
>
> > in order to avoid having to worry about special characters
> > they are NUL-terminated)
> 
> Would this be a possible alternative - newline terminated (convert any
> newlines embedded in filenames to the 3 chars '%0A', and leave it as an
> exercise to the reader to de-convert them.)

Sure, you could obviously do escaping (you need to remember to escape '%' 
too when you do that ;).

However, whenever you do escaping, that means that you're already going to 
have to use a tool to unpack the dang thing. So you didn't actually win 
anything. I pretty much guarantee that my existing format is easier to 
unpack than your escaped format.

ASCII isn't magical.

This is "fsck_tree()", which walks the unpacked tree representation and 
checks that it looks sane and marks the sha1's it finds as being 
needed (so that you can do reachability analysis in a second pass). It's 
not exactly complicated:

	static int fsck_tree(unsigned char *sha1, void *data, unsigned long size)
	{
	        while (size) {
	                int len = 1+strlen(data);
	                unsigned char *file_sha1 = data + len;
	                char *path = strchr(data, ' ');
	                if (size < len + 20 || !path)
	                        return -1;
	                data += len + 20;
	                size -= len + 20;
	                mark_needs_sha1(sha1, "blob", file_sha1);
	        }
	        return 0;
	}

and there's one HUGE advantage to _not_ having escaping: sorting and
comparing.

If you escape things, you now have to decide how you sort filenames. Do
you sort them by the escaped representation, or by the "raw"  
representation? Do you always have to escape or unescape the name in order 
to sort it.

So I like ASCII as much as the next guy, but it's not a religion. If there 
isn't any point to it, there isn't any point to it.

The biggest irritation I have with the "tree" format I chose is actually
not the name (which is trivial), it's the <sha1> part. Almost everything
else keeps the <sha1> in the ASCII hexadecimal representation, and I
should have done that here too. Why? Not because it's a <sha1> - hey, the 
binary representation is certainly denser and equivalent - but because an 
ASCII representation there would have allowed me to much more easily 
change the key format if I ever wanted to. Now it's very SHA1-specific.

Which I guess is fine - I don't really see any reason to change, and if I 
do change, I could always just re-generate the whole tree. But I think it 
would have been cleaner to have _that_ part in ASCII.

			Linus
