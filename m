Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUIJWSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUIJWSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267984AbUIJWSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:18:54 -0400
Received: from ultra7.eskimo.com ([204.122.16.70]:8463 "EHLO ultra7.eskimo.com")
	by vger.kernel.org with ESMTP id S267979AbUIJWSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:18:39 -0400
Date: Fri, 10 Sep 2004 15:18:34 -0700
From: Elladan <elladan@eskimo.com>
To: Timothy Miller <miller@techsource.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040910221834.GC8698@eskimo.com>
References: <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <4141FF13.8030009@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4141FF13.8030009@techsource.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 03:22:59PM -0400, Timothy Miller wrote:
> 
> Linus Torvalds wrote:
> 
> >The same goes for something like a "container file". Whether you see it as
> >"dir-as-file" or "file-as-dir" (and I agree with Jan that the two are
> >totally equivalent), the point of having the capability in the kernel is
> >not that the operations cannot be done in user space - the point is that
> >they cannot be done in user space _safely_. The kernel is kind of the
> >thing that guarantees that everybody follows the rules.
> 
> Well, it CAN be done safely if every client has to go through the kernel 
> which does all the appropriate locks/semaphors and then passes the 
> request down to the daemon.  (Isn't NFS implemented this way?)
> 
> This is very micro-kernel-ish, but it's a reasonable idea to do it this 
> way in cases where things are non-critical.
> 
> Say there's a way to cd into a tgz file to look around.  If the access 
> methods through the kernel get routed back to a user-space process 
> (which probably does some amount of caching in memory and on disk of 
> uncompressed bits of the archive), it could be a bit slower than if it 
> were all in-kernel.  The thing is that the processing time in the daemon 
> is probably quite high compared to the overhead of the context switches, 
> so it doesn't cost much.  (And if it CAN be done in userspace without 
> being horribly convoluted or unsafe, then it SHOULD be done in 
> userspace.)  Besides, even if it were a LOT slower to access a tgz file 
> without extracting it first, I would STILL think it was wonderful AND 
> use it a LOT.

This is only safe for some limited definitions of safety.

Leaving aside the obvious complexities of making sure the user space
daemon doesn't just do something crazy, you have a number of problems:

* Which user does the daemon run as?  If it runs as root, it needs to
  enforce strict security requirements in terms of VFS operations coming
  in, and also, it has all the problems of a SUID application running on
  an arbitrary user file.  I don't know about you, but I don't trust
  joebob's tarfsd to be suid when running on some script kiddie tarball.

  If it runs as the user making the request, then what happens when two
  users try to open the same file at the same time.  Do they see two
  different views of the file?  Is one of them locked out?  How can they
  possibly synchronize if the views are writable?

* If the daemon runs as a user, then what happens if you try to run a
  suid program inside of the view?  What if root tries to walk into a
  tar file?  The conservative view is that the kernel would need to
  always return ENOENT for any process with elevated capabilities, but
  even this is not safe.

* Consider what happens if foo.tar/blah_blah is automatically bound to
  enter a tarfsd view of foo.tar.  What happens if I point the web
  server at foo.tar/blah?  The web server runs as httpd or something, so
  presumably httpd ends up running some sort of tarfsd view on the
  file.  But if the tarball was made by a malicious person, presumably
  it can obtain httpd user access now by exploiting a bug in tarfsd.

* Even if you assume the view is read-only and the kernel coerces all
  permissions and ownership and such, there's the possibility of tarfsd
  presenting unexpected syscall results - weird error codes, short
  reads, file data changing underneath mmap, etc. that user applications
  don't expect and may be susceptible to.

* Besides all these security issues, if this scheme is writable it has
  all the resource problems that loopback network filesystems suffer.
  What if the kernel is short on memory and tries to flush dirty buffers
  to reclaim it.  If those buffers are running against the user FS
  daemon, then that daemon must wake up to clear dirty buffers.  If it
  tries to allocate memory, deadlock in the kernel.


Probably the security problems can be solved to some degree by being
very paranoid in the kernel (at an associated loss in utility), and the
resource issues can be solved by restricting dirty buffers for loopback
mounts (at an associated loss in performance), but it's hardly simple.

-J

