Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbRLFOa3>; Thu, 6 Dec 2001 09:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285160AbRLFOaS>; Thu, 6 Dec 2001 09:30:18 -0500
Received: from pat.uio.no ([129.240.130.16]:9884 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S285154AbRLFO3z>;
	Thu, 6 Dec 2001 09:29:55 -0500
To: Xeno <xeno@overture.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: NFS client race causes data loss when appending
In-Reply-To: <3C0ED156.2F327B0F@overture.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 06 Dec 2001 15:29:47 +0100
In-Reply-To: <3C0ED156.2F327B0F@overture.com>
Message-ID: <shsher4776s.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == xeno  <xeno@overture.com> writes:

     > 1. getattr request goes out to get file size.  Value will be
     >    stale compared to inode->i_size, since writes are happening.
     > 2. All writebacks for the inode complete.
     > 3. getattr response returns with stale file size value.
     > 4. __nfs_refresh_inode checks writebacks, finds none,
     >    overwrites inode->i_size.
     > 5. generic_file_write resets file position (O_APPEND) with
     >    stale file size, overwriting previously written data.

<snip>
     > --- linux/fs/nfs/inode.c Fri Nov 9 14:28:15 2001
     > +++ linux-nfsappendrace/fs/nfs/inode.c Wed Dec 5 17:12:28 2001
     > @@ -868,8 +868,9 @@
     >  __nfs_revalidate_inode(struct nfs_server *server, struct inode
     >  *inode) {
     >  	int status = -ESTALE; struct nfs_fattr fattr;
     > + int writebacks;
 
     >  	dfprintk(PAGECACHE, "NFS: revalidating (%x/%Ld)\n",
    inode-> i_dev, (long long)NFS_FILEID(inode));
 
     > @@ -889,8 +890,9 @@
     >  		}
     >  	} NFS_FLAGS(inode) |= NFS_INO_REVALIDATING;
 
     > +	writebacks = nfs_have_writebacks(inode);
     >  	status = NFS_PROTO(inode)->getattr(inode, &fattr); if
     >  	(status) {
     >  		dfprintk(PAGECACHE, "nfs_revalidate_inode:
     >  		(%x/%Ld) getattr failed, error=%d\n",
    inode-> i_dev, (long long)NFS_FILEID(inode), status);
     > @@ -900,8 +902,11 @@
     >  				remove_inode_hash(inode);
     >  		} goto out;
     >  	}
     > +
     > + if ( writebacks && nfs_size_to_loff_t(fattr.size) <
     >  	inode->i_size )
     > + fattr.size = (__u64) inode->i_size;
 
     >  	status = nfs_refresh_inode(inode, &fattr); if (status)
     >  	{
     >  		dfprintk(PAGECACHE, "nfs_revalidate_inode:
     >  		(%x/%Ld) refresh failed, error=%d\n",

 The above is clearly insufficient to fix the race: you've only
addressed the problem of getattr. NFS is crawling with stuff that
returns fattrs (read/getattr/lookup/...). Each and every one of them
can race in the way you describe.
 It will also fail to prevent a race occurring if the writeback is
scheduled and written while we are in the getattr() call (rare but
possible)...

 What we really want is to prevent nfs_refresh_inode() from
overwriting newer attribute information with older information. How
therefore about something like the appended patch, that uses the ctime
field to determine which attribute information is obsolete?
I'm afraid it's not going to work too well for Linux servers because
of the shitty 1 second resolution we have on (a|m|c)time, but it will
help against most non-Linux servers.

Cheers,
  Trond

--- linux-2.4.17-pre4/fs/nfs/inode.c.orig	Thu Dec  6 02:27:46 2001
+++ linux-2.4.17-pre4/fs/nfs/inode.c	Thu Dec  6 15:26:07 2001
@@ -1007,6 +1007,10 @@
 	new_size = fattr->size;
  	new_isize = nfs_size_to_loff_t(fattr->size);
 
+	if (time_before(jiffies, NFS_READTIME(inode)+NFS_ATTRTIMEO(inode)) &&
+	    (s64)NFS_CACHE_CTIME(inode) - (s64)fattr->ctime < 0)
+		return 0;
+
 	/*
 	 * Update the read time so we don't revalidate too often.
 	 */
