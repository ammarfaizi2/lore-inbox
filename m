Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbSJ2BlJ>; Mon, 28 Oct 2002 20:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261439AbSJ2BlJ>; Mon, 28 Oct 2002 20:41:09 -0500
Received: from mtao-m02.ehs.aol.com ([64.12.52.8]:17025 "EHLO
	mtao-m02.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S261438AbSJ2BlI>; Mon, 28 Oct 2002 20:41:08 -0500
Date: Mon, 28 Oct 2002 17:47:27 -0800
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Security critical race condition in epoll code
In-reply-to: <20021028220809.GB27798@outpost.ds9a.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Message-id: <3DBDE8AF.6090102@netscape.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b)
 Gecko/20021016
References: <20021028220809.GB27798@outpost.ds9a.nl>
 <Pine.LNX.4.44.0210281420540.966-100000@blue1.dev.mcafeelabs.com>
 <20021028225821.GA29868@outpost.ds9a.nl> <3DBDCC02.6060100@netscape.com>
 <20021029001843.GB31212@outpost.ds9a.nl>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a race condition in the epoll patch which permits 
user space to scribble in the kernel's free memory.

First a user space program creates an epoll fd and adds a socket to it 
using sys_epoll_ctl(...EP_CTL_ADD...)

Then the program creates two threads, A and B.  Simultaneously, A calls 
sys_epoll_ctl(...EP_CTL_MOD...) and B calls 
sys_epoll_ctl(...EP_CTL_DEL...) on the socket that was previously added.

Thread A runs up through the point where ep_find() returns the (struct 
epitem *) for the socket.

Thread B then runs and ep_remove() frees the (struct epitem *).

Thread A then runs some more and stores the value of events into the now 
freed block of memory pointed to by dpi.


