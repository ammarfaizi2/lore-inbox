Return-Path: <linux-kernel-owner+w=401wt.eu-S1760791AbWLHSD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760791AbWLHSD4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760793AbWLHSD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:03:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:52095 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760791AbWLHSDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:03:55 -0500
Message-ID: <4579A93C.7000609@us.ibm.com>
Date: Fri, 08 Dec 2006 12:04:44 -0600
From: Steve French <smfltc@us.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: simo <simo@samba.org>
Subject: Re: Upcall implementation in Linux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-11 am 12:13 +0800, ysgrifennodd Hsung-Pin Chang:
>>                 Recently, I need to use upcalls in Linux to actively and
<snip>
>>                 However, I have some questions about upcall implementation.
>>                 First, the user handler must be "pinned" into memory to
>>		   prevent paging out
> Linux intentionally and deliberately does not support kernel calls into
> user space. It leads to very difficult locking problems amongst other

> Instead we either send asynchronous events (signal/netlink/..) or we
> arrange that a system call returns when the event happens so the user
> process resumes.

Since we are not supposed to use captive ioctls as smbfs and others did in the
past, and having your own pseudo-filesystem (like RPC) just for upcalls is 
overkill.  What is the recommended way to address the following:

1) need to have userspace construct a ticket for kernel (kernel owns
the socket for this case: gssapi like kerberos session establishment
for cifs mounts)

2) the event is kernel initiated, requires a small amount of data
to be passed up to userspace (less than 4K) and a slightly larger amount
of data to be passed down (1K to 64K)

3) upcall repeats two to three times before userspace can be terminated
(gssapi/spnego standard can require multiple roundtrips to server), and
userspace has to keep (gssapi) state while these are going on, but can
terminate soon thereafter

4) this is not performance sensitive (typically only happens at mount time
and when reconnecting session after it is dropped due to glitches in network)
but could theoretically occur in low memory conditions (if tcp socket
connection was dropped under heavy stress, and we are in a path in kernel
reconnecting underneath balance_inode_pages/writepages)


I was leaning toward using the kernel key API to launch the userspace
daemon (/sbin/request-key) - perhaps passing it a unique pseudofile name
(in e.g. /proc/fs/cifs/upcall-xxxx) to use to read/write the data for
each stage but in some ways the kernel connector API seems to make more
sense.

The difficulties in these are the lack of examples that handle the
error cases - userspace crashes, userspace gets hung, connection
drops and the pseudofile needs to be removed, races between 
two copies of the app (mounts to two different servers overlapping),
how to minimize low memory conditions affecting the userspace app
etc.   

It almost would make it worthwhile to push more of it (even more
than sunrpc has done for something somewhat similar) into kernel.

Ideas on best ways to handle this kind of upcall?

Any pointers to reasonably terse examples, beyond the simple ones
(ecryptfs for kernel keyring, and the connector samples in kernel)

