Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbUKHKfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUKHKfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 05:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUKHKfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 05:35:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47589 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261503AbUKHKfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 05:35:46 -0500
Date: Mon, 8 Nov 2004 10:35:44 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unix_gc and file_count
Message-ID: <20041108103544.GA24336@parcelfarce.linux.theplanet.co.uk>
References: <20041108084825.GA8704@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108084825.GA8704@impedimenta.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 02:18:25PM +0530, Ravikiran G Thirumalai wrote:
> unix_gc then walks through all the unix sockets in the hashtable, and 
> processes sockets marked for gc (GC_ORPHAN).  unix_gc frees up the skbs in the 
> receive queue of these unix sockets which have a fd[] payload on that skb.  
> Other skbs are left as is.
 
> 1. Even if gc doesn't garbage collect the fd[] payload skbs, they'll be later
> freed by unix_release through __fput when the f_count for that socket goes to 0.
> Isn't a GC just for fd[] payloads which will anyway be freed wasteful?  I
> probably am missing something here........ 

You are.  Put descriptor of AF_UNIX socket into an SCM_RIGHTS datagram.
Send that datagram to that socket.  Close all descriptors you had opened.

We won't get the final fput() until all references to struct file are
gone.  We won't get all references gone until one in SCM_RIGHTS datagram
is gone.  I.e. that datagram has to die *before* we get to unix_release().
I.e. the only thing that can trigger the whole thing is GC.

That's why we need the damn thing in the first place.  And that's why
socket and non-socket cases are different.

Funnier case to look at:

fd1 and fd2 are AF_UNIX sockets.
get an SCM_RIGHTS datagram with fd1 in it into the queue of fd2.
get an SCM_RIGHTS datagram with fd2 in it into the queue of fd1.
close all opened descriptors (or just exit)

We have two struct file, each with ->f_count == 1.  Each has an AF_UNIX
socket associated with it (with inflight == 1).  And the only reference
to either struct file is sitting in skb in the receiving queue of another
one.

Current algorithm is obviously correct: GC_ORPHAN is set on the sockets
that will never have anything received from them.  Since we know that
we'll never receive pending SCM_RIGHTS datagrams in their queues, we can
pull all such datagrams out and kill them, which will release the references
to files held by them.  And that's all we can kill - a datagram in queue
of non-GC_ORPHAN socket could be eventually received, so we can't drop the
struct file references it carries.
