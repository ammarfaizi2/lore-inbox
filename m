Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUAISW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUAISW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:22:29 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:52241 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262925AbUAISWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:22:24 -0500
Date: Sat, 10 Jan 2004 02:20:03 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <3FFD79C9.1040404@sun.com>
Message-ID: <Pine.LNX.4.33.0401100143590.21972-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.8, required 8, AWL,
	BAYES_01, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jan 2004, Mike Waychison wrote:

> >
> >Mike can you enlighten me with a few words about how namespaces are useful
> >in the design. I have not seen or heard much about them so please be
> >gentle.
> >
> >
>

Think I have enough on namespaces to understand your proposal now. Thanks.

> >What is the form of the trigger talked about? Identifying the automount
> >points in the autofs filesystem has always been hard and error prone.
> >
> >
> >
> I don't understand what you mean by the identifying part.   However, the
> 'trigger' would the traditional method used in autofsv3/4 for indirect
> maps and probably based off what you already have for doing the browsing
> stuff.
>
> The direct map 'triggers' will be taken care of by another filesystem
> with a magic root directory that will catch traversals using some
> follow_link magic.   I wrote a prototype for this last summer, but
> haven't released it as the userspace stuff completely does not fit in
> with the existing daemon that was out at the time do the the mess of
> glue that was pgids, pipes and processes.   It worked in the simple
> case, but it didn't extend to being able to direct mount an indirect
> map, nor was it able to do the lazy mounting in multimounts as I had
> desired.

Is this the stuf that Al Viro is working on?

>
> >Please clearify what we are talking about WRT kernel support for
> >automount. Is the plan a new kernel module or are we talking about
> >unspecified 'in VFS' support or both?
> >
> >
> >
> This module will have its own new autofs module (hopefully named
> something other than autofs to avoid confusion/mishaps).  The VFS will
> have native support for expiry.  The VFS will also be slightly extended
> to allow the super_block cloning on namespace clone (although this can
> probably hold off a while, it's more a semantic issue than anything else).

Yep. Got that as well.

>
> >
> >Yes. In 4.1 NIS, LDAP and file maps are browsable for both direct and
> >indirect maps. The browsability, only, requires my kernel patch.
> >The daemon detects the updated modules' presence, and if the option is
> >specified 'ghosts' the directories, mounting them only when accessed.
> >
> >
> >
> What is the difference between Solaris's -browse and your ghosting then?

Well I don't know, nothing really. I was working to the requirement of
providing browsable mount trees. The 'doing it properly' was secondary to
satisfying my spec. Mind there are a number of things I haven't done.
Since I don't have a need for tree-mounts (closest would be multi-mount) I
haven't done anything there. As you say in v4 they are a mount/umount
everthing. Consequenty, only the top level leaves are browsable. Indeed, I
haven't solved my requirement of a transparent autofs filesystem aka.
Solaris automounter again. A difficult problem that will require
considerable effort.

>
> >>lstat('dir')
> >>chdir('dir')
> >>lstat('.')
> >>
> >>
> >
> >This suggestion has been made by others several times but doesn't seem
> >to be a problem in practice. In all my testing I have only been able to
> >find one case that does'nt work as needed when ghosted. This is the
> >situation where a home directory in a map exported from a server, is
> >actually not available (eg does not exist) and someone logs into the
> >account using wu-ftpd. In this case wu-ftpd thinks all is ok but of course
> >an error is returned when the directory access is attempted. In fact an
> >error should have been returned at login. Further, I believe this can be
> >solved with as little as an additional revalidate call in sys_stat (I
> >think the problem call was sys_stst ???).
> >
> >
> >
> The find(1) issue is fairly recent.   This check was added some time
> within the last two years (?) and only appears in the latest distros.
>
> Another problem were the ACL patches for ls(1) and friends.  I *really*
> think they should be lgetxattr ing instead of getxattr.  They even
> explicitly check via an lstat _before hand_ to verify if the file
> S_ISLNK, and only then will it getxattr if it isn't.  Why not extend
> it?   I duno.

Looks like I have more testing to do to get a better feel for the way this
behaves.

>
> >>This is the subtle difference between direct and indirect maps.   The
> >>direct map keys are absolute paths, not path components.  We are
> >>implementing direct mounts as individual filesystems that will trap on
> >>traversal into their base directory.  This filesystem has no idea where
> >>it is located as far as the user is concerned.  We need to tell the
> >>filesystem directly so that the usermode helper can look it up.
> >>Conversely, the indirect map uses the sub-directory name as a mapkey.
> >>
> >>
> >
> >I'm not sure what you are saying here. Does this mean there is a mount for
> >every direct mount (this might be what you call a trigger)?
> >
> >
> >
> Yes, it is its own filesystem (type autofs).  This is needed because we
> need to overlay direct triggers within NFS filesystems for multimounts.

Ahh. I see, you are talking about the cross filesystem problem. I haven't
solved that in what I have done either. Fortuneately I still get a good
hit rate in satisfying peoples' needs as in practice many people don't use
full automounter functionality.

>
> Browsing however obviously doesn't need that because we control the
> parent directory.
>
> >AIX implemented automounts by mounting everything in each map. This
> >made the mount listing very ugly.
> >
> >
> >
> ??  Really?  I find that hard to believe.  I thought Solaris shared it's
> automounter with HPUX and AIX.  I may be wrong though.

Old versions perhaps. AIX 4.x was the last I used. It was definately like
that then. 500+ automounts tends to cluter the mount display a bit.

> >Mmm. The vfsmount_lock is available to modules in 2.6. At least it was in
> >test11. I'm sure I compiled the module under 2.6 as well???
> >
> >I thought that, taking the dcache_lock was the correct thing to do when
> >traversing a dentry list?
> >
> >
> >
> Walking dentrys still takes the dcache_lock, however walking vfsmounts
> takes the vfsmount_lock.  dcache_lock is no longer used for fast path
> walking either (to the best of my understanding).
>
> find . -name '*.[ch]' -not -path '*SCCS*' | xargs grep vfsmount_lock |
> grep EXPORT

Strange. How does the module compile I wonder? How does it load without
unresolved symbols? Another little mystery to work on.

>
> shows no results for vfsmount_lock being exported to modules in 2.6.
>
> >
> >The autofs4 moudule blocks (auto) mounts during the umount callback.
> >Surely this is the sensible thing to do.
> >
> >
> >
> The raciness comes from the fact that we now support the lazy-mounting
> of multimount offsets using embedded direct mounts.  Autofs4 mounts all
> (or as much as it can) from the multimount all together, and unmounts it
> all on expiry.

But 4.1 does lazy mount for several maps. Mounts that are triggered
during the umount step of the expire are put on a wait queue along with
the task requesting the umount. I think autofs always worked that way.

> >
> >Hang on. From the discussion my impression of a lazy mount is that it is
> >not actually mounted!
> >
> >
> >
> Lazy _un_mounts as opposed to lazy mounts. Lazy unmounts are described
> in umount(8):

But will this leave the filesystem in a consistent state and allow further
mount activity on that mount point?

Ian


