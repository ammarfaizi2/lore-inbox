Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTFQSGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTFQSGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:06:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50959 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264460AbTFQSGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:06:09 -0400
Message-ID: <3EEF5BA6.9030505@zytor.com>
Date: Tue, 17 Jun 2003 11:19:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: David Howells <dhowells@warthog.cambridge.redhat.com>
CC: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] VFS autmounter support
References: <16634.1055873257@warthog.warthog>
In-Reply-To: <16634.1055873257@warthog.warthog>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> One of the problems I have to deal with is namespaces. This means I can't just
> have an automounter running in userspace that's passed requests to mount
> things as it might not be able to access the target namespace.

> Doing it this way means that I don't need to care which namespace the
> automount needs to take effect in. I can just return a vfsmount to the VFS (as
> acquired from do_kern_mount()) and let that paste it into the right place.
> 
> Furthermore, for AFS at least, it's a lot less excessive than, say, calling
> back into userspace.
>

Namespaces have all kinds of problems anyway when mixed with
automounting (it's not at all clear what the semantics should be, and
I'm pretty sure that the semantics the current namespaces give are
overall undersirable), but when I discussed this issue with Al Viro he
indicated that you can always access all namespaces via procfs; if not,
you *should* be able to...

> 
>>At least #2 can be done with existing means using follow_link.
> 
> How? I want to be able to mount on the location in question (so it has to be a
> directory), but I don't want "ls -l" to cause it to mount (otherwise
> accidentally doing that or tab expansion if /afs, say, will take ages).
> 
> Maybe you mean construct a symlink that points to somewhere I can actually
> mount the filesystem? If so, that too can suffer from namespace problems.
> 
> Whatever happens, stat() must _not_ cause the automount point to mount.
> 

That's actually not true.  It's lstat() that mustn't cause the automount
point to mount -- stat() only comes into play if lstat() resolves to a
symlink.  However, lstat() never invokes follow_link, so creating a
dentry with a follow_link method resolving to itself, and an associated
dummy directory inode, does what's required.

> 
>>I think using a revalidation pointer like dentries might be a better
>>way to do #4/#5, although using the existing one in the dentries is
>>probably better.
> 
> Do you mean dispose of the expired mount point when it's next revalidated? If
> so, surely you _don't_ want to do it then, as that's normally a prelude to
> reusing it.
> 
> Or do you mean do it actually inside dentry->d_op->d_revalidate()? But you
> can't do it there because you don't know what vfsmount you are dealing with.
> 

I mean inside d_revalidate().

> 
>>#1 isn't really clear to me what you're going for, but it seems to be
>>to duplicate bookkeeping.
>
> Duplicate of what bookkeeping?
> 
> The fact that the operation is provided indicates that a dentry is an
> automount point, and as such should be handled specially by path-walk. All the
> logic to link the new vfsmount into the filesystem topology can be handled
> easily by the VFS at that point because all the details are to hand.
> 

I don't see that it should be handed specially.

> 
>>I also don't see how this solves the biggest problems with complex
>>automounts, which are:
>>
>>a) how to guarantee that a large mount tree can be safely destroyed;
> 
> What do you mean by safely? I check that the usage count on vfsmount
> structures is 1 under lock just before unlinking it - thereby making sure that
> no one has a file open on it, no process has it as its root or cwd, and that
> nothing is mounted upon it.

Not good enough.  You need to be able to tell that atomically for a full
*tree*, that can contain multiple mounts, some of which have other
mounts on top of them, not just for a single superblock.

> Also, I do the actual unmounting from process context by walking the
> namespace's extant mount list, rather than directly nominating a vfsmount for
> removal.
> 
> One drawback is that - taking AFS as an example - doing a umount of /afs won't
> work until all the subtrees have either been manually unmounted or have
> expired (though I can make umount capable of handling this).

See above.

>>b) how to detect partial unmounts. 
> 
> What do you mean by a partial unmount?

/foo/bar is an automounted filesystem, which has /foo/bar/baz mounted on
top of it.  Now the user manually umounts /foo/bar/baz (because of
staleness, or whatever.)  Now the automount system needs to detect
accesses to /foo/bar/baz and remount... effectively, /foo/bar/baz needs
to atomically turn into an automounter point.

	-hpa


