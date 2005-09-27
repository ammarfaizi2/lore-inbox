Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVI0QJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVI0QJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVI0QJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:09:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964999AbVI0QJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:09:52 -0400
Date: Tue, 27 Sep 2005 09:09:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sergey Vlasov <vsu@altlinux.ru>
cc: Harald Welte <laforge@gnumonks.org>, linux-usb-devel@lists.sourceforge.net,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org, greg@kroah.com,
       security@linux.kernel.org
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC]
 Oops while completing async USB via usbdevio
In-Reply-To: <20050927160029.GA20466@master.mivlgu.local>
Message-ID: <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Sep 2005, Sergey Vlasov wrote:
> 
> And then a process calls USBDEVFS_SUBMITURB and immediately exits; its
> pid gets reused by a completely different process (maybe even
> root-owned), then the urb completes, and kill_proc_info() sends the
> signal to the unsuspecting process.

Ehh.. pid's don't get re-used until they wrap.

Your _current_ code has that problem, though - "struct task_struct" _does_ 
get re-used.

Don't assume that the fixes are as bad.

Anyway, Christoph is certainly correct that what you _should_ be using is 
the SIGIO infrastructure, even if you don't actually use the fcntl() to 
register it. 

> Hmm, then probably send_sig_info() should check for non-NULL
> p->sighand after taking tasklist_lock?  Otherwise all uses of
> send_sig_info() for non-current tasks are unsafe.

I don't think so. 

Your oops is because you're using a STALE POINTER.

If you look it up by pid, it won't be stale, now will it?

Hint: the point where sighand is released is also the point where the 
process is unhashed.

			Linus
