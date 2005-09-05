Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVIETM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVIETM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 15:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVIETM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 15:12:26 -0400
Received: from shill.XCF.Berkeley.EDU ([128.32.112.247]:26821 "EHLO
	wilber.gimp.org") by vger.kernel.org with ESMTP id S932406AbVIETM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 15:12:26 -0400
Date: Mon, 5 Sep 2005 12:11:59 -0700
From: kurt.hackel@oracle.com
To: David Teigland <teigland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Joel.Becker@oracle.com, ak@suse.de,
       linux-cluster@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050905191159.GA21169@gimp.org>
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org> <20050904045821.GT8684@ca-server1.us.oracle.com> <20050903224140.0442fac4.akpm@osdl.org> <20050905043033.GB11337@redhat.com> <20050905015408.21455e56.akpm@osdl.org> <20050905092433.GE17607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905092433.GE17607@redhat.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 05:24:33PM +0800, David Teigland wrote:
> On Mon, Sep 05, 2005 at 01:54:08AM -0700, Andrew Morton wrote:
> > David Teigland <teigland@redhat.com> wrote:
> > >
> > >  We export our full dlm API through read/write/poll on a misc device.
> > >
> > 
> > inotify did that for a while, but we ended up going with a straight syscall
> > interface.
> > 
> > How fat is the dlm interface?   ie: how many syscalls would it take?
> 
> Four functions:
>   create_lockspace()
>   release_lockspace()
>   lock()
>   unlock()

FWIW, it looks like we can agree on the core interface.  ocfs2_dlm
exports essentially the same functions:
    dlm_register_domain()
    dlm_unregister_domain()
    dlmlock()
    dlmunlock()

I also implemented dlm_migrate_lockres() to explicitly remaster a lock
on another node, but this isn't used by any callers today (except for
debugging purposes).  There is also some wiring between the fs and the
dlm (eviction callbacks) to deal with some ordering issues between the
two layers, but these could go if we get stronger membership.

There are quite a few other functions in the "full" spec(1) that we
didn't even attempt, either because we didn't require direct 
user<->kernel access or we just didn't need the function.  As for the
rather thick set of parameters expected in dlm calls, we managed to get
dlmlock down to *ahem* eight, and the rest are fairly slim.

Looking at the misc device that gfs uses, it seems like there is pretty
much complete interface to the same calls you have in kernel, validated
on the write() calls to the misc device.  With dlmfs, we were seeking to
lock down and simplify user access by using standard ast/bast/unlockast
calls, using a file descriptor as an opaque token for a single lock,
letting the vfs lifetime on this fd help with abnormal termination, etc.
I think both the misc device and dlmfs are helpful and not necessarily
mutually exclusive, and probably both are better approaches than
exporting everything via loads of syscalls (which seems to be the 
VMS/opendlm model).

-kurt

1. http://opendlm.sourceforge.net/cvsmirror/opendlm/docs/dlmbook_final.pdf


Kurt C. Hackel
Oracle
kurt.hackel@oracle.com
