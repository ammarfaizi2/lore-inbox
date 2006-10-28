Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWJ1REX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWJ1REX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWJ1REW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 13:04:22 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:43954 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1751153AbWJ1REW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 13:04:22 -0400
X-Originating-Ip: 72.57.81.197
Date: Sat, 28 Oct 2006 13:02:35 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: why "probe_kernel_address()", not "probe_user_address()"?
In-Reply-To: <20061028092906.6c1562e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610281258060.2652@localhost.localdomain>
References: <Pine.LNX.4.64.0610281153180.2091@localhost.localdomain>
 <20061028092906.6c1562e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006, Andrew Morton wrote:

> On Sat, 28 Oct 2006 11:56:24 -0400 (EDT)
> "Robert P. J. Day" <rpjday@mindspring.com> wrote:
>
> >
> >   it seems odd that the purpose of the "probe_kernel_address()" macro
> > is, in fact, to probe a *user* address (from linux/uaccess.h):
> >
> > #define probe_kernel_address(addr, retval)              \
> >         ({                                              \
> >                 long ret;                               \
> >                                                         \
> >                 inc_preempt_count();                    \
> >                 ret = __get_user(retval, addr);         \
> >                 dec_preempt_count();                    \
> >                 ret;                                    \
> >         })
> >
> >   given that that routine is referenced only 5 places in the entire
> > source tree, wouldn't it be more meaningful to use a more appropriate
> > name?
> >
>
> You'll notice that all callers are indeed probing kernel addresses.
> The function _could_ be used for user addresses and could perhaps be
> called probe_address().
>
> One of the reasons this wrapper exists is to communicate that the
> __get_user() it is in fact not being used to access user memory.

one quick addition to this.  in arch/i386/kernel/traps.c, we have the
code snippet:

        if (eip < PAGE_OFFSET)
                return;
        if (probe_kernel_address((unsigned short __user *)eip, ud2))
                return;
        if (ud2 != 0x0b0f)
                return;

        printk(KERN_EMERG "------------[ cut here ]------------\n");

#ifdef CONFIG_DEBUG_BUGVERBOSE
        do {
                unsigned short line;
                char *file;
                char c;

                if (probe_kernel_address((unsigned short __user *)(eip + 2),
                                        line))
... etc etc ...

  if those pointers qualified by "__user" *aren't* actually addresses
into user space, that would seem to violate what i read in the book
"linux device drivers (3rd ed)", p. 50:

"This [__user] annotation is a form of documentation, noting that a
pointer is a user-space address that cannot be directly dereferenced.
For normal compilation, __user has no effect, but it can be used by
external checking software to find misuse of user-space addresses."

  under the circumstances, wouldn't this show up as one of those
misuses?

rday
