Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUKHIxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUKHIxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUKHIxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:53:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:2977 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261786AbUKHIv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:51:59 -0500
Date: Mon, 8 Nov 2004 14:18:25 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: unix_gc and file_count
Message-ID: <20041108084825.GA8704@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to clean up uses of file_count in 2.6 as suggested by Viro
earlier.  Biggest hurdle is unix_gc.  I am trying to get rid of file_count in
unix_gc.  But I am not sure if I understand unix_gc very well.
I thought I'd put out questions I've been having...
Appreciate if someone can clarify.

Here goes:

unix_gc pushes a root set onto a stack.  This root set is not to be garbage
collected.  Root set is determined by the condition:
	if (open_count > atomic_read(&unix_sk(s)->inflight))
>From my understanding, for a unix socket, opencount cannot be less than 
inflight, simply because unix_*_sendmsg bumps up the f_count of each struct
file of the passed fd array through scm_send. inflight is later bumped up at
unix_attach_fds for unix sockets in the fd[] payload.  unix_*_recvmsg bumps 
down inflight for unix sockets of the payload fd[] and later does a fput for
all fds of the payload fd array.  Hence, the condition for sockets to
be GC'ed is open_count == inflight.  If open_count is +'ve for a GC able socket,
it means  the open_count is only because the socket is part of a fd payload
waiting to be received.  Some of the sockets with open_count == inflight 
may not be GC'ed if they happen to be in the receive queue as a fd payload 
of a inuse unix socket (on the stack).  All sockets which can be GC'ed will 
be in the hash list with unix_sk(s)->gc_tree == GC_ORPHAN;
unix_gc then walks through all the unix sockets in the hashtable, and 
processes sockets marked for gc (GC_ORPHAN).  unix_gc frees up the skbs in the 
receive queue of these unix sockets which have a fd[] payload on that skb.  
Other skbs are left as is.

1. Even if gc doesn't garbage collect the fd[] payload skbs, they'll be later
freed by unix_release through __fput when the f_count for that socket goes to 0.
Isn't a GC just for fd[] payloads which will anyway be freed wasteful?  I
probably am missing something here........ 
2. Now, other skbs are left as is, what is the need for just the fd[] payload 
to be freed? Either free all skbs or free none at all no?
3. If a process does a sendmsg with SCM_RIGHTS payload and the process which
is supposed to do do recvmsg dies, will the payload fd[] f_count not hang 
around for ever? Only the fds which are unix sockets will have their skbs having
fd[] load cleaned up.  All struct (file)s of the payload remain....  

Appreciate if someone can answer the above/point out gaps in my understanding.

Thanks,
Kiran

