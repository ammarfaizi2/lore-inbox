Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268800AbUILTIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268800AbUILTIe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268803AbUILTIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:08:34 -0400
Received: from the-village.bc.nu ([81.2.110.252]:29621 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268817AbUILTIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:08:22 -0400
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local and
	REMOTE(verified)Denial of Service Attack
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wolfpaw - Dale Corse <admin@wolfpaw.net>
Cc: kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <002701c498f9$a7203140$0200a8c0@wolf>
References: <002701c498f9$a7203140$0200a8c0@wolf>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095012366.11736.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Sep 2004 19:06:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-12 at 19:52, Wolfpaw - Dale Corse wrote:
> > > A) Why are the timeouts so long?
> > 
> > So you don't get random corruption
> 
> Hmm. I'll take your word for it, I'm not quite grasping it,
> but you know quite a bit more about it then I do :) I would
> have thought once a close is sent, the data has all been received
> and/or sent anyway, so what would corrupt?

It has all arrived at least once. However you don't know if a
retransmitted packet took a long trip round the world and popped out
later. When that happens you need to be sure you can tell old and new
apart. The TIME_WAIT state is basically "don't use this identical set of
port/address data for long enough to be sure any prior use has exited
the internet in its entirety.

> It _appears_ that when we close a socket (ie with mysql_close) on
> the client side, the client side closes the FD properly (though Mysql

socket != fd. If you close an fd and open you may get the same fd but
its a different socket. If its getting stuck closing could you have
another copy of the fd left open somewhere or have passed it to a
process you forked (thats a classic nasty to track down error) ?

> doesn't), and then if we call connect (which it does a lot, being a proxy
> server) it will reuse that FD. At this point, the Mysql side still hasn't
> closed it, and it is sitting in CLOSE_WAIT, where it remains forever, since
> it is in use by the client side elsewhere already. Should connect be
> checking the "list of not connected, but state other then CLOSED" list
> before it decides to use a particular FD? Or is this behavior intentional?

Sockets are two way at the TCP layer. "close" really means "have
finished sending". When both ends have finished sending the connection
is complete but not before. Thus if Mysql daemon says "I am done" but
you have open references to the handle then it will stay open one way
still.

