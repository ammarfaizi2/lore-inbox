Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319183AbSHNDy7>; Tue, 13 Aug 2002 23:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319186AbSHNDy7>; Tue, 13 Aug 2002 23:54:59 -0400
Received: from dp.samba.org ([66.70.73.150]:33211 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319183AbSHNDyy>;
	Tue, 13 Aug 2002 23:54:54 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Designated initializers for i386 
In-reply-to: Your message of "Tue, 13 Aug 2002 23:16:21 +0200."
             <20020813231621.O13598@suse.de> 
Date: Wed, 14 Aug 2002 13:05:49 +1000
Message-Id: <20020813225913.9AFF42C274@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020813231621.O13598@suse.de> you write:
> On Tue, Aug 13, 2002 at 06:18:59PM +1000, Rusty Russell wrote:
>  > Sorry for batching these, but there are so damn many.
> 
> Do you have many more of these jumbo patchsets pending ?
> I've yet to find a word that sums up just how annoying it is
> to have a bunch of pending patches made totally useless due to
> these largely pointless (for now) patches.

Yes, it's a PITA.  I'm slowly working my way through the maintainers,
see my kernel.org web page.

Here is the copy of my sed script, which works pretty well (you still
have to check for screwed up bitfields, ie:
	unsigned long x:5,
	y:1,
	z:2;

The "y:1" line looks like an old-style designated initializer 8(.

Also, this script doesn't catch all of them, but it breaks the back of
the problem, leaving the rest for the janitors.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

#! /bin/sh
# Usage: fix-designated-initializers.sh <filenames>

for f; do
    # (1) Ignore default:
    # (2) Ignore lines containing two identifiers in a row but no C keywords,
    #     unless it contains /*, */ or ".
    # (3) Replace "foo: xxx, /* comment" with ".foo = xxx, /* comment"
    # (4) Replace "foo: xxx };" with ".foo = xxx };"
    # (5) Replace "{ foo: xxx" with "{ .foo = xxx"
    # (6) Lines which match "foo: xxx", grab next line, if it's foo:
    #     xxx\n};, replace.
    sed -e '/[	 ]default:/{p;d;}' \
	-e '/[a-zA-Z_][a-zA-Z0-9_]*[	 ]\+[a-zA-Z_][a-zA-Z0-9_]*/{/[^a-z]\(auto\|break\|case\|char\|const\|continue\|default\|do\|double\|else\|enum\|extern\|float\|for\|goto\|if\|inline\|int\|long\|register\|restrict\|return\|short\|signed\|sizeof\|static\|struct\|switch\|typedef\|union\|unsigned\|void\|volatile\|while\)[^a-z]/!{/\(\/\*\|\*\/\|"\)/!{p;d;};};}' \
	-e '/^\([	 ]\+\)\([a-z_]\+\):\([	 ]*\)\([^,]*,\)/{s//\1.\2\3= \4/p;d;}' \
	-e '/^\([	 ]\+\)\([a-z_]\+\):\([	 ]*\)\(.*[	 ]*};\)/{s//\1.\2\3= \4/p;d;}' \
	-e '/\({[	 ]\+\)\([a-z_]\+\):\([	 ]*\)/{s//\1.\2\3= /p;d;}' \
	-e '/^\([	 ]\+\)\([a-z_]\+\):\([	 ]\+\)\(.*\)/{N;/^\([	 ]\+\)\([a-z_]\+\):\([	 ]\+\)\([^\n]*\)\(\n[	 ]*};\)/{s//\1.\2\3= \4\5/;};}' < $f > $f.new
    diff -u $f $f.new
    rm -rf $f.new
done

