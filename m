Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265614AbTFSNui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 09:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265618AbTFSNui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 09:50:38 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:13968 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S265614AbTFSNuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 09:50:37 -0400
Message-ID: <3EF1C208.1080404@sun.com>
Date: Thu, 19 Jun 2003 10:00:40 -0400
From: Mike Waychison <michael.waychison@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@warthog.cambridge.redhat.com>
CC: viro@parcelfarce.linux.theplanet.co.uk,
       David Howells <dhowells@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS autmounter support v2
References: <fa.nerig52.1j7u3qk@ifi.uio.no> <fa.fq0dsjb.1a06mop@ifi.uio.no>
In-Reply-To: <fa.fq0dsjb.1a06mop@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> I think this can make use of my suggested change... If you make a trigger fs
> that has its root directory simply an automount point (though this leads me to
> think that perhaps (u)mount should follow the example of stat and use
> LOOKUP_NOAUTOMOUNT).
> 
> Perhaps:
> 
> 	[namespace X]
> 	mount /dev/hda8 /usr/include
> 	mount -t trap "mount-fs-B" /usr/include/foo1
> 	mount -t trap "mount-fs-C" /usr/include/foo2
> 
> 	[namespace Y]
> 	mount /dev/hda8 /usr/local/include
> 	mount -t trap "mount-fs-D" /usr/local/include/foo1
> 
> Then have a daemon that can take a request to mount and then reply with the
> mount parameters, allowing the trap fs to obtain a vfsmount via
> do_kern_mount(). I would make the trap fs supply the daemon with an fd
> attached to the trap rootdir to act as a token representing the request (and
> controlling its lifetime).
> 

You would have to go this route.  I think Al's opinion in this is that 
your original proposal allows arbitrary dentry's in the tree to act as 
traps.  As such, there is no way for a derived namespace to manipulate 
that trap at all.  By implying that the trap is installed via mount says 
you are now proposing that every trap is represented by its own superblock.

You're new proposal is exactly what I have been working on, autofs 
direct mountpoints using the less intrusive follow_link magic Anvin has 
mentioned on a previous thread both here and on autofs@vger.

The one problem with this solution is the following breaks:

# installtrap /foo host:/export/foo
<userspace daemon listens for requests to mount>
# newnssh
newnssh # cd /foo

Oops, the daemon started from the initial namespace doesn't have access 
to the namespace in my second shell.

The most reasonable way I can see to cope with this is to allow 
CAP_SYS_ADMIN processes the ability to change namespaces.  Eg, the 
daemon can be told which pid triggered the trap on /foo, 
open(/proc/<pid>/mounts) and perform a ioctl(IOC_USENAMESPACE) on it.

What do you guys think?

Mike Waychison

