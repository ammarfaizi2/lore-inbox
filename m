Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUG2F6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUG2F6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 01:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUG2F6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 01:58:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33197 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262329AbUG2F6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 01:58:11 -0400
Date: Thu, 29 Jul 2004 01:58:06 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: lkml List <linux-kernel@vger.kernel.org>
Subject: Re: Preliminary Linux Key Infrastructure 0.01-alpha1
In-Reply-To: <65EFF013-DEAA-11D8-9612-000393ACC76E@mac.com>
Message-ID: <Xine.LNX.4.44.0407290116340.13892-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004, Kyle Moffett wrote:

> Preliminary Linux Key Infrastructure 0.01-alpha1:
> 
> I'm writing a key/keyring infrastructure for the Linux kernel. I've got
> some of the basic infrastructure done, and I'd like any comments on it
> that you may have.

Firstly, it might be useful for other developers if you could write up a
brief rationale about this feature, why it's needed and why this is a good
solution.  I do know of a few projects which could make use of keyrings:

 - cryptfs (Michael Halcrow)
 - afs
 - module signing (David Howells/ Arjan)

Are there others (with running code, merged or potentially mergable) ?

Does your design cater for all needs?

I think I heard that Greg-KH had some keyring code already, so there may
be some existing code floating around.

To get more people to look at the code, I'd suggest that you get it 
running and prepared as a patch to the mainline kernel.  It will also help 
if you follow Documentation/CodingStyle and use more idiomatic kernel 
development practices.

For example, typedefs are generally frowned upon (but perhaps acceptable
to improve readability of complex function pointer stuff).

You don't need to cast the result of kmalloc:

	key = (lki_key_t *)kmalloc(sizeof(lki_key_t),GFP_KERNEL);

should be:

	key = kmalloc(sizeof(lki_key_t),GFP_KERNEL);

Avoid using sizeof(some_type) for things like the above, use the actual 
object itself:

	key = kmalloc(sizeof(*key), GFP_KERNEL);

(in case the type of *key changes some day).

Use wrapper functions like wait_event_interruptible() instead of rolling 
your own.

It's better (IMHO) to have one exit path in a function, to clarify error
handling, locking, and make it easier to audit the code.  e.g. in
lki_key_used_list_allocate(), you grab a lock then have several return
points with no unlock.

Having some real code which uses the framework will also be good.


> TODO:
> 	keyctl:
> 		The syscall that makes it all possible

Why would you need a syscall?

> 	keyfs:
> 		keys by number: On hold while I learn more about filesystems :-D

What does this mean?

I would imagine that the entire userspace API would be filesystem based.  
e.g.  you could load the keys for module signature checking during boot by
writing them to a node like:

cat keyring.txt > /keyrings/modsign/keys

Disable further changes:

echo "0" > /keyrings/modsign/write

You could manage per process credentials via /proc/self/something


- James
-- 
James Morris
<jmorris@redhat.com>


