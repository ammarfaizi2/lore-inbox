Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269039AbUJQDmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269039AbUJQDmj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269046AbUJQDmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:42:39 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:43986 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269039AbUJQDmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:42:24 -0400
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: bgagnon@coradiant.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041015182352.GA4937@logos.cnet>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com>
	 <20041015182352.GA4937@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097980764.13226.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 17 Oct 2004 03:39:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-15 at 19:23, Marcelo Tosatti wrote:
> I prefer doing the "if (PageReserved(page)) put_page_testzero(page)" as
> you propose instead of changing get_user_pages(), as there are several
> users which rely on its behaviour.
> 
> I have applied your fix to the 2.4 BK tree.

That isnt sufficient. Consider anything else taking a reference to the
page and the refcount going negative. And yes 2.6.x has this problem and
far worse in some ways, but it also has the mechanism to fix it.

2.6.x uses VM_IO as a VMA flag which tells the kernel two things
a) get_user_pages fails on it
b) core dumping of it is forbidden

2.6.x is missing a whole pile of these (fixed in the 2.6.9-ac tree I'm
putting together). I *think* remap_page_range() in 2.6.x can just set
VM_IO, but older kernels didn't pass the vma so all the users would need
fixing (OSS audio, media/video, usb audio, usb video, frame buffer
etc).

Alan

