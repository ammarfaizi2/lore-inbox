Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWDZVAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWDZVAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWDZVAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:00:16 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:7114 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964842AbWDZVAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:00:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: kswapd oops reproduced with 2.6.17-rc2 (was Oops with 2.6.15.3 on amd64)
Date: Wed, 26 Apr 2006 22:59:39 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060422221232.GA6269@uio.no> <200604261740.47107.Rafal.Wysocki@fuw.edu.pl> <20060426161214.GA13689@uio.no>
In-Reply-To: <20060426161214.GA13689@uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604262259.39691.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry, I sent the previous message with a wrong address by mistake]

On Wednesday 26 April 2006 18:12, Steinar H. Gunderson wrote:
> On Wed, Apr 26, 2006 at 05:40:46PM +0200, R. J. Wysocki wrote:
> >> I reproduced this with 2.6.17-rc2 on the same machine:
> >> 
> >> [261604.531829] Unable to handle kernel paging request at ffff8000020369d8 RIP: 
> >> [261604.536538] <ffffffff802509e6>{isolate_lru_pages+74}
> > If your kernel is compiled with the debug info, could you please do
> > "gdb vmlinux"  in the kernel sorces directory and then (in gdb)
> > "l *(isolate_lru_pages+74)" to see which source line it corresponds to?
> 
> It isn't, but I hadn't changed the sources, .config or build environment
> since I built it, so I did a straight recompile with CONFIG_DEBUG_INFO set,
> and got:
> 
>   (gdb) l *(isolate_lru_pages+74)
>   0xffffffff80250c2a is in isolate_lru_pages (list.h:154).
> 
> (I had to run gdb on a machine with 64-bit userspace, but I guess just
> copying the vmlinux file should suffice.)

This kind of agrees with my result ie. list_del() in isolate_lru_pages():

0xffffffff80265b7a is in isolate_lru_pages (list.h:160).
155      * Note: list_empty on entry does not return true after this, the entry is
156      * in an undefined state.
157      */
158     static inline void list_del(struct list_head *entry)
159     {
160             BUG_ON(entry->prev->next != entry);
161             BUG_ON(entry->next->prev != entry);
162             __list_del(entry->prev, entry->next);
163             entry->next = LIST_POISON1;
164             entry->prev = LIST_POISON2;

It looks like we have passed an empty list or a NULL to list_del().  Strange.

Greetings,
Rafael
