Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265011AbUE1XWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265011AbUE1XWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 19:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265017AbUE1XWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 19:22:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30923 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265011AbUE1XWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 19:22:14 -0400
Date: Fri, 28 May 2004 18:18:08 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040528231808.GA13711@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524114009.96CE13100E2@moraine.clusterfs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I have some questions about the revalidate_special.

In case of "." we do revalidate_special() which calls real_lookup(), 
which can create a negative dentry, if "." is unhashed, and return 
no error. After that we don;t have any check for negative dentry
in link_path_walk. The result could be we return success
from link_path_walk() with a negative dentry. And I think it is
bad.

Maneesh





On Mon, May 24, 2004 at 07:39:50PM +0800, Peter J. Braam wrote:
> Hi Linus, Andrew & others,
> 
> Many people have asked me to have this patched reviewed, and
> considered for inclusion in 2.6 after some reworking.  At the kernel
> summit last summer we discussed these issues.
> 
> This patch is not the Lustre file system, with client file system,
> Lustre RPC, server code etc.  This patch would enable people to run
> Lustre with modules loading into unmodified kernels and this appears
> to be something vendors really would like to see.  FYI, at the moment
> Lustre is a just a little bit larger than NFS, comparing clients,
> servers, and rpc code for each (60K vs 80K lines of code).
> 
> This patch was written quite defensively: file systems not using 
> intents should really be completely unaffected.
> 
> I attach a little tar ball with patches and a series file which
> describes the order of the patches.  Below is a short description of
> each of the patches.  I also want to tell you a few things we have 
> worked on that are not present in this patch:
>  
>  - deal with "pinning" directories that are CWD or mount points.  They
>    should not be removable/unlinkable by remote nodes, and the FS needs
>    some indication of that.
> 
>  - in Lustre d_parent is not necessarily valid, so sys_getcwd needs to
>    be careful.  In Ottawa we discussed adding an optional hook.
> 
>  - changes to NFSD to allow it to run on top of Lustre
> 
>  - per file system locking operations (refinining i_sem) to allow 
>    parallel updates in one directory. 
> 
> It goes without saying that many people in CFS have made contributions
> to this patch and that the ideas were heavily influenced by discussions
> with the kernel community.
> 
> Please give me your thoughts about how we can move forward with this.
>  
> Regards,
> 
> - Peter -
>  
>  
> dev_read_only-vanilla-2.6.patch
>  
>   This introduces an ioctl on block devices to stop doing I/O. The
>   only purpose of the patch is automated recovery regression testing,
>   it is very convenient to have this available.
> 
> export-vanilla-2.6.patch
>  
>   Export symbols used by Lustre.
> 
> header_guards-vanilla-2.6.patch
>  
>   Small bug fix to avoid double inclusion of headers
> 
> lustre_version.patch
>  
>   A tiny header to check that the kernel patch and Lustre modules are
>   compatible.
>   
> vfs-dcache_locking-vanilla-2.6.patch
> 
>   A trivial patch to make functions available to lustre that do
>   d_move, d_rehash, without taking/dropping the dcache lock.
>  
> vfs-dcache_lustre_invalid-vanilla-2.6.patch
>  
>   This allows dentries to be d_invalidate'd if a bit is set in the
>   FLAGS.  This is required when dentries that are busy on the local
>   node are invalidated on another client system.
> 
> vfs-intent_api-vanilla-2.6.patch
>  
>   Introduce intents for other operations.  Add a file system hook to
>   release intent data.  Make a few "intent versions" of functions such
>   as "lookup_one_len_it" and "user_walk_it" available through headers.
>   Arrange that the open intent is visible in the open methods. Add a
>   few missing intent_init calls.
> 
> vfs-intent_exec-vanilla-2.6.patch
>  
>   Add intents for open in the context of execution.
>  
> vfs-intent_init-vanilla-2.6.patch
>  
>   Add intent_init for all operations, not just for open.
> 
> vfs-intent_lustre-vanilla-2.6.patch
>  
>   Add a pointer to per fs intent_data structure to the struct lookup_intent.
>  
> vfs-raw_ops-vanilla-2.6.patch
> 
>   This adds raw operations for setattr, mkdir, rmdir, mknod, unlink,
>   symlink, link and rename.  The raw operations look up the parent
>   directories (but not leaf nodes) involved in the operation and then
>   ask the file system to execute the operation.  These methods allow
>   us to delegate the execution of these functions to the server, and
>   instantiate no dentries for leaf nodes, leaf nodes will only enter
>   the dcache on subsequent lookups.  This patch dramatically
>   simplifies the client/server lock management, particularly for
>   rename.
>  
>   In Ottawa Linus suggested that we could maybe do this with intents
>   instead.  I feel that both are ugly, both are possible but intents
>   looked akward.
>  
> vfs-revalidate_counter-vanilla-2.6.patch
>  
>   We found that dentries could be invalidated multiple times through
>   activity on remote nodes, but this shoudl not lead to failure in
>   Lustre.  The revalidation path real_lookup was adapted to take a few
>   more iterations through the revalidation before giving up.  This
>   revalidation takes the form of first revalidating, then looking up
>   if it fails, and possibly revalidating a few more times (see above)
>   until there is success.
>  
> vfs-revalidate_special-vanilla-2.6.patch
> 
>  
>   We add nameidata flags to indicate that a link sits in the middle of
>   the path and a flag that inidicates we are looking at the last
>   component of a path.  [If someone knows if the existing flags could
>   detect this, that would be welcome.]  To pass intents when the last
>   pathname component is a "." we insert a "special" revalidation
>   function that calls revalidate dentry when such a pathname is
>   traversed.
>  
> vfs_intent-flags_rename-vanilla-2.6.patch
>  
>   As Linus requested in Ottawa last summer, rename intent.open.flags
>   to intent.  it_flags and intent.open.create_mode to
>   intent.it_create_mode.  Remove the union of "intents", which only
>   contained an open_intent, and replace it with a single struct
>   lookup_intent included in the nameidata.
>  
> vfs-do_truncate.patch
>   
>   We added a parameter to do_truncate so that the FS can now if it is
>   being called from open or not.
> 



-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
