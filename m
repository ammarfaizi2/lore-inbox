Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277392AbRJJUBf>; Wed, 10 Oct 2001 16:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277390AbRJJUB1>; Wed, 10 Oct 2001 16:01:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50954 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277389AbRJJUBP>; Wed, 10 Oct 2001 16:01:15 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 10 Oct 2001 13:00:29 -0700
Message-Id: <200110102000.f9AK0SU02765@penguin.transmeta.com>
To: eduard.epi@t-online.de
Subject: Re: Invalid operand with 2.4.11
Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.33.0110102109460.1363-100000@eduard.t-online.de>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110102109460.1363-100000@eduard.t-online.de> you write:
>
>I am using a SuSE 7.2 distro. When I'm starting their yast2, it crashes
>reliably and leaves this message in the log (run through ksymoops):

I'd absolutely _love_ it if you can pinpoint this to a particular
pre-release.  Something like "it doesn't happen with pre5, but it does
happen with pre6".  Or "pre6 was fine, but the final 2.4.11 breaks". 

Mind doing that? Together with a full config file, and I'll have a much
better idea of what broke..

The oops itself _seems_ to because the slab debugging (which you had
enabled: good for you!) catches on CHECK_PAGE() when freeing the name
slab at the end of open_namei():

    # define CHECK_PAGE(page)                                       \
        do {                                                    \
                CHECK_NR(page);                                 \
                if (!PageSlab(page)) {                          \
                        printk(KERN_ERR "kfree: bad ptr %lxh.\n", \  
                                (unsigned long)objp);           \
                        BUG();                                  \
                }                                               \
        } while (0)

but it's a bit hard sometimes to debug these things remotely. Did you
see that "kfree: bad ptr" message?

Anyway, I do have one (possibly bad) suspicion: one thing you can try
with plain 2.4.11 is to remove the "FASTCALL()" macro in <linux/fs.h>
around the __user_walk/path_init/path_walk/link_path_walk declarations.
Those FASTCALL's are new, and I wonder if gcc has register pressure
problems with them, which could cause corruption, which in turn would
explain how "open_namei()" would to try to free a bad pointer.

[ Yeah, that's it, blame it on the compiler.. ]

		Linus
