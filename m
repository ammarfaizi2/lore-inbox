Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUFCOAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUFCOAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUFCOAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:00:00 -0400
Received: from [213.146.154.40] ([213.146.154.40]:22161 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263679AbUFCN7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:59:55 -0400
Date: Thu, 3 Jun 2004 14:59:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, axboe@suse.de,
       lmb@suse.de, kevcorry@us.ibm.com, arjanv@redhat.com,
       iro@parcelfarce.linux.theplanet.co.uk, trond.myklebust@fys.uio.no,
       anton@samba.org, lustre-devel@clusterfs.com
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
Message-ID: <20040603135952.GB16378@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de, lmb@suse.de,
	kevcorry@us.ibm.com, arjanv@redhat.com,
	iro@parcelfarce.linux.theplanet.co.uk, trond.myklebust@fys.uio.no,
	anton@samba.org, lustre-devel@clusterfs.com
References: <20040602231554.ADC7B3100AE@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602231554.ADC7B3100AE@moraine.clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 05:15:27PM -0600, Peter J. Braam wrote:
> People requested to see the code that uses the patch.  We have uploaded that
> to:
>  
> ftp://ftp.clusterfs.com:/pub/lustre/lkml/lustre-client_and_mds.tgz 
>  
> The client file system is the primary user of the kernel patch, in the
> llite directory. The MDS server is a sample user of do_kern_mount.  As
> requested I have removed many other things from the tar ball to make
> review simple (so this won't compile or run).

> We actually need do_kern_mount and truncate_complete_page.  Do kern
> mount is used because we use a file system namespace in servers in the
> kernel without exporting it to user space (mds/handler.c).  The server
> file systems are ext3 file systems but we replace VFS locking with DLM
> locks, and it would take considerable work to export that as a file
> system.

Yikes.  I'd rather not see something like this going in, and better work
on properly integrating the MDS code with the filesystem.  There's also
lots of duplication or almost duplication of VFS functionality in that
directory and the fsfilter horrors.  I'd suggest you get that cleaned up
and we'll try to merge it into 2.7, okay?

  
> Truncate_complete_page is used to remove pages in the middle of a file
> mapping, when lock revocations happen (llite/file.c
> ll_extent_lock_callback, calling ll_pgcache_remove_extent) .

Most of ll_pgcache_remove_extent probably wants to be a proper VFS
function.  Again, only interesting if the rest of lustre gets merged.
>  
> 2. lustre_version.patch concerns by Christoph Hellwig:
>  
> This one can easily be removed, but kernel version alone does not
> necessarily represent anything useful. There are tons of people
> patching their kernel with patches, even applying parts of newer
> kernel and still leaving kernel version at its old value
> (distributions immediately come to mind). So we still need something
> to identify version of necessary bits. E.g. version of intent API.

Well, bad luck for you.  It's not like there much interest to merge
any of these patches into the tree without the actual users anyway..

> 3. Introduction of lock-less version of d_rehash (__d_rehash) by
>    Christoph Hellwig:
>  
> In some places lustre needs to do several things to dentry's with
> dcache lock held already, e.g. traverse alias dentries in inode to
> find one with same name and parent as the one we have already.  Lustre
> can invalidate busy dentries, which we put on a list.  If these are
> looked up again, concurrently, we find them on this list and re-use
> them, to avoid having several identical aliases in an inode.  See
> llite/{dcache.c,namei.c} ll_revalidate and the lock callback function
> ll_mdc_blocking_ast which calls ll_unhash_aliases.  We use d_move to
> manipulate dentries associated with raw inodes and names in ext3.

I've only taken a short look at the dcache operations you're doing and
it looks a little fishy and very senistive for small changes in internal
dcache semantics.  You're also missing e.g. the LSM callbacks it seems.

Have you talked to Al about that code?

> 4. vfs intent API changes kernel exported concern API by Christoph
>    Hellwig:
>  
> With slight modification it is possible to reduce the changes to just
> changes in the name of intent structure itself and some of its
> fields. 
>  
> This renaming was requested by Linus, but we can change names back
> easily if needed, that would avoid any api change.  Are there other
> users, please let us know what to do?

Again, you're changing a filesystem API, we have a bunch of intree users
that can be modular so it's likely there are out of tree users, too.
The new semantics might be much nicer, but it's 2.7 material.

> 7. raw operations concerns by various people:
>  
> We have now implemented an alternative approach to this, that is
> taking place when parent lookup is done, using intents.  For setattr
> we managed to remove the raw operations alltogether, (praying that we
> haven't forgotten some awful problem we solved that led to the
> introduction of setattr_raw in the first place).
>  
> The correctly filled intent is recognised by filesystem's lookup or
> revalidate method.  After the parent is looked up, based on the intent
> the correct "raw" server call is executed, within the file
> system. Then a special flag is set in intent, the caller of parent
> lookup checks for the flag and if it is set, the functions returns
> immediately with supplied (in intent)exit code, without instantiating
> child dentries.
>  
> This needs some minor changes to VFS, though. There are at
> least two approaches.
>  
> One is to not introduce any new methods and just rely on fs' metohds
> to do everything, for this to work filesystem needs to know the
> remaining path to be traversed (we can fill nd->last with remaining
> path before calling into fs).  In the root directory of the mount, we
> need to call a revalidate (if supported by fs) on mountpoint to
> intercept the intent, after we crossed mountpoint. We have this
> approach implemented in that attached patch.  Does it look better than
> the raw operations?  

I'm not sure whether overloading ->d_revalidate or a new method for
that is prefferable.

> Much simpler for us is to add additional inode operation
> "process_intent" method that would be called when LOOKUP_PARENT sort
> of lookup was requested and we are about to leave link_path_walk()
> with nameidata structure filled and everything ready.  Then the same
> flag in intent will be set and everything else as in previous
> approach.  

Yupp, that sounds better.

> Well, how close are we now to this being acceptable?

As already mentioned above they're completely uninteresting without
actually getting the user in tree _and_ maintained there (unlike e.g.
intermezzo or coda that are creeping along).  I think based on those
patch we should be able to properly integrate intermezzo once 2.7 opens.

