Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWHUDeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWHUDeP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 23:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWHUDeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 23:34:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45204 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932118AbWHUDeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 23:34:12 -0400
From: Neil Brown <neilb@suse.de>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Date: Mon, 21 Aug 2006 13:34:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17641.10665.116168.867041@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] 2.6.17.8 - do_vfs_lock: VFS is out of sync with lock
	manager!
In-Reply-To: message from Jesper Juhl on Thursday August 17
References: <9a8748490608080739w2e14e5ceg44a7bf0a3b475704@mail.gmail.com>
	<17636.4462.975774.528003@cse.unsw.edu.au>
	<9a8748490608170258s32df0272r60c8c540e5871485@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 17, jesper.juhl@gmail.com wrote:
> On 17/08/06, Neil Brown <neilb@suse.de> wrote:
> > On Tuesday August 8, jesper.juhl@gmail.com wrote:
> > > I have some webservers that have recently started reporting the
> > > following message in their logs :
> > >
> > >   do_vfs_lock: VFS is out of sync with lock manager!
> >
> >
> > I can imagine that happening if you mount with '-o nolocks'.
> > Then a non-blocking lock could cause that message (I think).
> > Can you conform that you aren't using 'nolocks'.
> >
> Confirmed.

Thanks.  I suspected as much but don't like to assume.

I've look more thoroughly at this code and I think the message is
meaningless and can be ignored.

Looking in fs/nfs/file.c (at 2.6.18-rc4-mm1 if it matters, but 2.6.17
is much the same)

 - do_vfs_lock is only called when the filesystem was mounted with
    -o nolock  EXCEPT
 - If a lock request to the server in interrupted (when mounted with
     -o intr) then do_vfs_lock is called to try to get the lock
    locally.  Normally equivalent code will be called inside
    fs/lockd/clntproc.c when the server replies that the lock has been
    gained.  In the case of an interrupt though this doesn't happen
    but the lock may still have happened on the server.  So we record
    locally that the lock was gained, to ensure that it gets unlocked
    when the process exits.

As you don't have '-o nolocks' you must be hitting the second case.
The lock call to the server returns -EINTR or -ERESTARTSYS and
do_vfs_lock is called just-in-case.  
As this is a just-in-case call, it is quite possible that the lock is
held by some other process, so getting an error is entirely possible.
So printing the message in this case seems wrong.

On the other hand, printing the message in any other case seems wrong
too, as server locking is not being used, so there is nothing to get
out of sync with.

As a further complication, I don't think that in the just-in-case
situation that it should risk waiting for the lock.
Now maybe we can be sure there is a pending signal which will break
out of any wait (though I'm worried about -ERESTARTSYS - that doesn't
imply a signal does it?), but I would feel more comfortable if
FL_SLEEP were turned off in that path.

So: Trond:  Any obvious errors in the above?
Is the following patch ok?

NeilBrown


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfs/file.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff .prev/fs/nfs/file.c ./fs/nfs/file.c
--- .prev/fs/nfs/file.c	2006-08-21 13:28:25.000000000 +1000
+++ ./fs/nfs/file.c	2006-08-21 13:30:27.000000000 +1000
@@ -452,9 +452,6 @@ static int do_vfs_lock(struct file *file
 		default:
 			BUG();
 	}
-	if (res < 0)
-		printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n",
-				__FUNCTION__);
 	return res;
 }
 
@@ -504,10 +501,13 @@ static int do_setlk(struct file *filp, i
 		 * we clean up any state on the server. We therefore
 		 * record the lock call as having succeeded in order to
 		 * ensure that locks_remove_posix() cleans it out when
-		 * the process exits.
+		 * the process exits.  Make sure not to sleep if
+		 * someone else holds the lock.
 		 */
-		if (status == -EINTR || status == -ERESTARTSYS)
+		if (status == -EINTR || status == -ERESTARTSYS) {
+			fl->fl_flags &= ~FL_SLEEP;
 			do_vfs_lock(filp, fl);
+		}
 	} else
 		status = do_vfs_lock(filp, fl);
 	unlock_kernel();

 
  
