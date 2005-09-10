Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVIJV73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVIJV73 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVIJV73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:59:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16856 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932267AbVIJV71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:59:27 -0400
Date: Sat, 10 Sep 2005 14:58:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: Re: [PATCH 0/6] jbd cleanup
Message-Id: <20050910145848.51881e61.akpm@osdl.org>
In-Reply-To: <20050910145525.GB7593@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com>
	<20050909021522.1a271e4b.akpm@osdl.org>
	<20050910145525.GB7593@miraclelinux.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> wrote:
>
> On Fri, Sep 09, 2005 at 02:15:22AM -0700, Andrew Morton wrote:
> > Akinobu Mita <mita@miraclelinux.com> wrote:
> > >
> > > The following 6 patches cleanup the jbd code and kill about 200 lines. 
> > >
> > 
> > Thanks, but I'm not inclined to apply them.
> > 
> > a) Maybe 70-80% of the Linux world uses this filesystem.  We need to be
> >    very cautious in making changes to it.
> 
> And we need many eyeballs.

True.  And the only way to really learn code is to make changes to it.

> (I've tried to understand how the jbd works several times.
>  But I always failed.)

It's very hard to reverse engineer the high-level design concepts from the
implementation.  And the design concepts in JBD are really complex, which
is a problem fo us.

When I first had to learn the thing 4-5 years back I sat down for a solid
week and wrote a 40-odd page how-it-works document for myself, just to
force it into my head.  It was probably about 50% accurate, but it was a
useful exercise.

> About the debuggability of list_heads, how about adding the kind of
> the following gdb macros in .gdbinit?
> 
> ---
> 
> define list_entry
> 	set $ptr=$arg0
> 	p ($arg1 *)((char *)$ptr - (size_t) &(($arg1 *)0)->$arg2)
> end
> 
> define list_entry_s
> 	set $ptr=$arg0
> 	p (struct $arg1 *)((char *)$ptr - (size_t) &((struct $arg1 *)0)->$arg2)
> end
> 
> define to_journal_head
> 	list_entry_s $arg0 journal_head b_list
> end

Here's mine ;)

# list_entry list type member
define list_entry
	set $off = (int)&(((struct $arg1 *)0)->$arg2)
	set $addr = (int)$arg0
	set $res = $addr - $off
	printf "0x%x\n", (struct $arg1 *)$res
end

