Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRFGPon>; Thu, 7 Jun 2001 11:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbRFGPoc>; Thu, 7 Jun 2001 11:44:32 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:51852 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261651AbRFGPoX>; Thu, 7 Jun 2001 11:44:23 -0400
Date: Thu, 7 Jun 2001 11:44:19 -0400
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org, xgajda@fi.muni.cz, kron@fi.muni.cz
Subject: Re: CacheFS
Message-ID: <20010607114419.A23962@cs.cmu.edu>
Mail-Followup-To: Jan Kasprzak <kas@informatics.muni.cz>,
	linux-kernel@vger.kernel.org, xgajda@fi.muni.cz, kron@fi.muni.cz
In-Reply-To: <20010607133750.I1193@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010607133750.I1193@informatics.muni.cz>
User-Agent: Mutt/1.3.18i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 01:37:50PM +0200, Jan Kasprzak wrote:
> 	The goal is to speed-up reading of potentially slow filesystems
> (NFS, maybe even CD-based ones) by the local on-disk cache in the same way
> IRIX or Solaris CacheFS works. I would expect this to be used on clusters
> of computers or university computer labs with NFS-mounted /usr or some
> other read-only filesystems. Another goal is to use the Linux filesystem
> as a backing store (as opposed to the block device or single large file
> used by CODA).

Coda definitely doesn't use a block device or single large file, but a
regular filesystem as backing store. Currently ext2, reiserfs and ramfs
are known to work, and at least tmpfs is know to be broken. I can easily
fix tmpfs, but it isn't urgent so I'm delaying working on it until 2.5
unless there is sufficient interest.

> 	Every file on the front filesystem (NFS or so) volume will be cached
> in two local files by cachefsd: The first one would contain the (parts of)
> real file content, and the second one would contain file's metadata and the
> bitmap of valid blocks (or pages) of the first file. All files in cachefsd's
> backing store would be in a per-volume directory, and will be numbered by the
> inode number from the front filesystem.

- Intermezzo uses 'holes' in files to indicate that content isn't
  available.
- You might want to have a more hierarchical backing store, directory
  operations in large directories are not very efficient.
- I believe you are switching the meaning of front and backend
  filesystems around a lot in your description. Who exactly assigns the
  inode numbers?

> 	Now here are some questions:
> 
> * Should the cachefsd be in user space (as it is in the prototype
> implementation) or should it be moved to the kernel space? The former
> allows probably better configuration (maybe a deeper directory
> structure in the backing store), but the later is faster as it avoids
> copying data between the user and kernel spaces.

If you only allow whole-file accesses, the Coda solution will minimize
data copying between user and kernel space. The file is fetched into the
cache when opened, and every subsequent access is transparently
redirected to the container-file without contacting userspace until the
file is closed.

I am not considering to ever add a bitmap based 'these parts are ok and
those aren't' file access implementation to the Coda kernel module.
However, I do consider a 'data is valid up to this point' offset field a
possible future extension. Basically the open would return early when
the first N pages have been streamed in from the server. Whenever the
client wants to write or read a page beyond this point the kernel makes
a request to userspace to extend the limit. This way quota's can be
enforced, access to large files that are read sequentially is faster,
but the kernel-userspace interactions are minimized.

> * Can the kernel part of CODA can be used for this?

Not if you want to intercept and redirect every single read and write
call. That's a whole other can of worms, and I'd advise you to let the
userspace cachemanager to act as an NFS daemon. In my opinion, the Coda
kernel module fills a specific niche, and should not become yet another
kernel NFS client implementation that happens to bounce requests to
userspace using read/write on a character device instead of RPC/UDP
packets to a socket.

If you are willing to work within the confines of the Coda semantics,
sure. I'd even be willing to push a bit more on the support of more
underlying filesystems and adding the 'valid data offset' logic.

Some references,

UserFS,
    AFAIK one of the first userfs implementations for Linux,

    http://www.goop.org/~jeremy/userfs/
    http://www.penguin.cz/~jim/userfs/ 		     (same one ported to 2.2?)


PodFuk,
    Went from an NFS daemon implementation to using the Coda kernel
    module,

    http://atrey.karlin.mff.cuni.cz/~pavel/podfuk/podfuk.html
    http://sourceforge.net/projects/uservfs/ 			(aka UserVFS?)


AVFS,
    Another userfs implementation that when from a shared library hack
    to using the Coda kernel module,

    http://sourceforge.net/projects/avfs


Jan

