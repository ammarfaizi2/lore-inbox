Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVJMXRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVJMXRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVJMXRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:17:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932537AbVJMXRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:17:41 -0400
Date: Thu, 13 Oct 2005 16:16:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, vsu@altlinux.ru, laforge@gnumonks.org,
       linux-usb-devel@lists.sourceforge.net, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, greg@kroah.com, security@linux.kernel.org
Subject: Re: [Security] [vendor-sec] [BUG/PATCH/RFC] Oops while completing
 async USB via usbdevio
In-Reply-To: <20051013160010.7cc532ae.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.64.0510131611060.23590@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <1127840281.10674.5.camel@localhost.localdomain>
 <20051013160010.7cc532ae.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Oct 2005, Pete Zaitcev wrote:
> 
> The whole application cannot exit and leave URBs running behind,
> because usbdevio_release() blocks until they are terminated.

Wrong.

You just do a fork(), and a close in the parent.

"release()" won't be called until the _last_ close, and the task that 
opened the fd can certainly exit before that.

If you want to have something that is called on each close, you can 
trigger on the "flush()" VFS call, but then you have to realize that that 
can happen an infinite number of times, and while the original one is open 
(ie on a fork, if the _child_ calls close(), then you'll get a flush, even 
though the original fd is still open and still in use).

So you really don't want to terminate the URB's in "flush()". Which means 
that the original process can very much be long gone when release happens.

It's a fundamental mistake to think that file descriptors stay with the 
process that opened them. 

		Linus
