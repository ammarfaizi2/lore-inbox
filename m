Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUKZWsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUKZWsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbUKZTtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:49:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262389AbUKZT3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:20 -0500
Date: Thu, 25 Nov 2004 13:02:06 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bgagnon@coradiant.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@novell.com>, davem@redhat.com
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-ID: <20041125150206.GF16633@logos.cnet>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com> <20041015182352.GA4937@logos.cnet> <1097980764.13226.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097980764.13226.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 03:39:26AM +0100, Alan Cox wrote:
> On Gwe, 2004-10-15 at 19:23, Marcelo Tosatti wrote:
> > I prefer doing the "if (PageReserved(page)) put_page_testzero(page)" as
> > you propose instead of changing get_user_pages(), as there are several
> > users which rely on its behaviour.
> > 
> > I have applied your fix to the 2.4 BK tree.
> 
> That isnt sufficient. Consider anything else taking a reference to the
> page and the refcount going negative. And yes 2.6.x has this problem and
> far worse in some ways, but it also has the mechanism to fix it.
> 
> 2.6.x uses VM_IO as a VMA flag which tells the kernel two things
> a) get_user_pages fails on it
> b) core dumping of it is forbidden
> 
> 2.6.x is missing a whole pile of these (fixed in the 2.6.9-ac tree I'm
> putting together). I *think* remap_page_range() in 2.6.x can just set
> VM_IO, but older kernels didn't pass the vma so all the users would need
> fixing (OSS audio, media/video, usb audio, usb video, frame buffer
> etc).

I dont see any practical problem with 2.4.x right now.

get_user_pages() wont be called on driver created VMA's with PageReserved 
pages because of the VM_IO bit which is set at remap_page_range(). 

Its not possible to have any vma mapped by a driver without VM_IO set.

But the network packet mmap was an isolated case, so I'll apply Andrea's 
fix just for safety, although I can't find any offender in the tree.


--- memory.c    2004-10-22 15:58:28.000000000 -0200
+++ memory.c  2004-10-28 14:32:26.585813200 -0200
@@ -499,7 +499,7 @@
                                /* FIXME: call the correct function,
                                 * depending on the type of the found page
                                 */
-                               if (!pages[i])
+                               if (!pages[i] || PageReserved(pages[i]))
                                        goto bad_page;
                                page_cache_get(pages[i]);
                        }


