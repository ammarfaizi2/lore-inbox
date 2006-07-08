Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWGHVWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWGHVWp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWGHVWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:22:45 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:10681 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1030398AbWGHVWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:22:44 -0400
Date: Sat, 8 Jul 2006 17:22:30 -0400
Message-Id: <200607082122.k68LMUHo027526@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Quigley <dpquigl@tycho.nsa.gov>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, fistgen@filesystems.org
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set 
In-reply-to: Your message of "Sat, 08 Jul 2006 18:21:20 BST."
             <20060708172120.GB27058@infradead.org> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20060708172120.GB27058@infradead.org>, Christoph Hellwig writes:
> On Fri, Jul 07, 2006 at 01:22:09PM -0400, David Quigley wrote:

> Getting locking right if you want to allow access from above and below
> the stackable filesystems will be a pain.  

Agreed.  And, it's much worse: when you expose the lower f/s, users can much
w/ a lot more than locks -- all sorts of data and m-d, which is hard to deal
with in a stackable f/s.  It is fixable, but with non-trivial VFS changes
which would allow f/s modes on any layer to be immediately propagated
*upwards* in the stack.  I've been sketching out a design for such a thing
for years, but I honestly don't think it's worth considering at this point.
I'd prefer to see stackable f/s added to linux w/ minimal kernel changes
first.  Then, with user experience gathered, we can consider what VFS/kernel
changes may be in order for a future kernel release (2.7/2.8?)

> Note that I can't see any
> way to exclude direct access to the underlying filesystem in ecryptfs.

You can use overlay mounts: mount the stacked f/s on top of the lower f/s
dir directly.  It prevents _future_ access to the lower f/s through that
namespace (but not if through other paths, if they're available).

> I don't think there's too much of example for the behaviour I want.
> 
> But lets explain it a little better:
> 
>  - The idea is to avoid having the underlying filesystem mounted in any
>    public namespace.
> 
>  - Linux has the concept of mount points that only the kernel can use and
>    that aren't visible to any public namespace.  They can be created using
>    the *kern_mount family of APIs.
> 
>  - I suggest to use this API to mount the underlying filesystems from
>    ecryptfs.  It will have a reference to the vfsmount * and thus all
>    important data for the underlying filesystem.  Because it is the only
>    user of that filesystem locking and other operations get a lot simpler.

I like this idea very much: "hide" the mounted-on namespace while the
stackable f/s is sitting above.  Mike, have you looked at this?

Christoph, there is one problem with hiding the lower namespaces.  In
certain file systems, esp. crypto ones, you want to allow backup apps to
access the lower data directly: it's more efficient (not having to incure
expensive decryptions), and more secure (backup media contains ciphertext).

Do you know of a way in which you can hide the lower namespace from normal
users but not from superusers (or allow only one specific app to see the
lower namespace)?

Or, is there a way that the lower namespace can be exposed in read-only mode
(revusively, not just the top dir)?  Ideally, I'd like the lower namespace
to be hidden at all times, but exposed in readonly mode for specific apps
for a limited period of time.  That would helps us in unionfs as well.

Thanks,
Erez.
