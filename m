Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUHIE1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUHIE1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 00:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUHIE1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 00:27:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:18876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265930AbUHIE1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 00:27:33 -0400
Date: Sun, 8 Aug 2004 21:27:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Morris <jmorris@redhat.com>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjanv@redhat.com, dwmw2@infradead.org,
       greg@kroah.com, Chris Wright <chrisw@osdl.org>, sfrench@samba.org,
       mike@halcrow.us, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] implement in-kernel keys & keyring management
In-Reply-To: <Xine.LNX.4.44.0408082041010.1123-100000@dhcp83-76.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0408082114230.1832@ppc970.osdl.org>
References: <Xine.LNX.4.44.0408082041010.1123-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Aug 2004, James Morris wrote:
> 
> I'm not disagreeing with the above, but what about performance?  Part of
> the reason I suggested Netlink is that it's likely to be more efficient
> to send messages over a socket than to exec a program for each key
> request from the kernel.

Yes. However, I don't see that the kernel really would ask for new keys 
very often.  Any normal operation is that you have the key already.

> It's difficult to know if performance will actually be an issue without
> understanding the potential workload more.  What if many thousands of
> clients are connected to a fileserver?  Would calling /sbin/request-key
> for each key request be likely to cause performance problems?

The fileserver generally is the one that _asks_ for keys, not the other 
way around.

So the "I don't have a key" case is more of an issue where somebody tries 
to mount an encrypted filesystem, and the filesystem says "you don't have 
a key".

It's not a thing like "you tried to open a file" that happens thousands of
times a second - that one would get an EACCES if you don't have a key. 

It would be more like "the mount binary needs a key to mount this volume, 
so let's request that key first".

David, have you actually coded up something that uses the user callback, 
maybe you can describe a realistic schenario...

But at least to me, the /sbin/request-key thing is more like loading a 
module. You might do it to mount a filesystem or read an encrypted volume, 
but you wouldn't do it in the "normal" workload. It's a major event.

		Linus
