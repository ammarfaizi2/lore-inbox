Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSGHIv0>; Mon, 8 Jul 2002 04:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSGHIvZ>; Mon, 8 Jul 2002 04:51:25 -0400
Received: from copper.ftech.net ([212.32.16.118]:39116 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S314077AbSGHIvZ>;
	Mon, 8 Jul 2002 04:51:25 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF423@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Implementing a sockets address family
Date: Mon, 8 Jul 2002 09:50:39 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I am implementing a sockets interface to a existing driver that
exchanges a proprietary protocol with an intelligent sync card, the existing
driver is a char driver.  I have used the Kernel X.25 driver's sockets
interface as a template.  I have several issues at the moment, so here are
some questions:

1) It seems that the only way you can tell if the socket is blocking or
non-blocking is to looks at the flags or msghdr->flags on each function
call.  Is this the case?  When the socket is set to non-blocking and a call
to the system recv() function is made, my recvmsg() function is called but
neither the flags parameter nor the flags in the msghdr structure have any
indication that the socket is non-blocking.  What am I missing here?

2) My second question is also a non-blocking issue.  When I set the socket
to non-blocking and call the system accept() function, my accept() function
is called with O_NONBLOCK in the flags parameter.  If there isn't a call
pending, I return -EWOULDBLOCK.  However this causes my release() function
to be called immediately with  NULL in sock->sk.
Looking at socket.c, it looks as though a new socket structure is allocated
before the call to my accept(), and then when I return the error, release()
is called with the newly allocated socket structure that at this point is
not valid.  Is this a bug or should I be doing something else?

3) When releasing socket resources, sk_free() is called.  There is a pointer
to my structure in sk, is it correct that sk_free() will free my structure
and I therefore don't need to call kfree() myself?

4) I seem to have a resilience problem where some of my tests seems to cause
oops's in other seemingly non related processes (x for example).  I am
thinking that this could be a double deallocation or perhaps a stack
problem.  What is the best way for tracking down such problems?


Thanks in advance

Kevin
