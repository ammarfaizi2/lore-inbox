Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUHHFOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUHHFOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 01:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUHHFOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 01:14:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43468 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265134AbUHHFOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 01:14:34 -0400
Date: Sun, 8 Aug 2004 01:14:14 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: David Howells <dhowells@redhat.com>
cc: torvalds@osdl.org, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <arjanv@redhat.com>, <dwmw2@infradead.org>, <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, <sfrench@samba.org>, <mike@halcrow.us>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] implement in-kernel keys & keyring management
In-Reply-To: <6453.1091838705@redhat.com>
Message-ID: <Xine.LNX.4.44.0408080046130.27710-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004, David Howells wrote:

> I've made available a patch that does a better job of key and keyring
> management for authentication, cryptography, etc.. I've added a good bit of
> documentation and I've commented the code more thoroughly.

Here's some more feedback:

 typedef int32_t key_serial_t;

Why is this signed?  And does this really need to be a typedef? (Do you 
forsee it ever changing from 32-bit?).


For consistency, request_key(), validate_key() and lookup_key() should 
probably be of the form key_request() etc.  There are other similar 
cases throughout the code.


I would suggest that the /sbin/request-key interface be done via Netlink
messaging instead.  The kernel would generate key create and key update
messages, to which userpace daemons can respond (similar to e.g. pfkey
acquire).  I think these messages need to be tagged with the key 'type',
so that the userspace code knows what to generate keys for.


  #define sys_keyctl(o,b,c,d,e)          (-EINVAL)

This should probably be -ENOSYS.


-                   capable(CAP_SETGID))
+                   capable(CAP_SETGID)) {
                        new_egid = egid;
+               }

This looks superfluous.


We need to look at the implications for LSM, e.g. keys have Unix style
access control information attached, and LSM apps may want to extend this
to other security models.  Some of the user interface calls may also need
to be mediated via LSM.


- James
-- 
James Morris
<jmorris@redhat.com>



