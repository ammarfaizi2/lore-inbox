Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSCVNUK>; Fri, 22 Mar 2002 08:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSCVNUB>; Fri, 22 Mar 2002 08:20:01 -0500
Received: from ns.ithnet.com ([217.64.64.10]:39944 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S310258AbSCVNTt>;
	Fri, 22 Mar 2002 08:19:49 -0500
Date: Fri, 22 Mar 2002 14:19:42 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: trond.myklebust@fys.uio.no
Cc: green@namesys.com, sneakums@zork.net, linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020322141942.14518fc6.skraw@ithnet.com>
In-Reply-To: <15515.4235.679887.998891@charged.uio.no>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002 12:07:55 +0100
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> >>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:
>      > The files are obviously not deleted from the server. Can you
>      > give me a short hint in where to look after this specific case
>      > (source location). I will try to do some debugging around the
>      > place to see what is going on.
> 
> Those decisions are supposed to be made in the fh_to_dentry()
> 'struct super_operations' method. For ReiserFS, that would be in
> fs/reiserfs/inode.c:reiserfs_fh_to_dentry().
> 
> It would indeed be a good idea to try sticking some debugging
> 'printk's in there in order to see what is failing...

Well, I seem to be really stupid, watch this:

struct dentry *reiserfs_fh_to_dentry(struct super_block *sb, __u32 *data,
				     int len, int fhtype, int parent) {
    struct cpu_key key ;
    struct inode *inode = NULL ;
    struct list_head *lp;
    struct dentry *result;

    /* fhtype happens to reflect the number of u32s encoded.
     * due to a bug in earlier code, fhtype might indicate there
     * are more u32s then actually fitted.
     * so if fhtype seems to be more than len, reduce fhtype.
     * Valid types are:
     *   2 - objectid + dir_id - legacy support
     *   3 - objectid + dir_id + generation
     *   4 - objectid + dir_id + objectid and dirid of parent - legacy
     *   5 - objectid + dir_id + generation + objectid and dirid of parent
     *   6 - as above plus generation of directory
     * 6 does not fit in NFSv2 handles
     */
    if (fhtype > len) {
	    if (fhtype != 6 || len != 5)
		    printk(KERN_WARNING "nfsd/reiserfs, fhtype=%d, len=%d - odd\n",
			   fhtype, len);
	    fhtype = 5;
    }
    if (fhtype < 2 || (parent && fhtype < 4)) {
	printk(KERN_WARNING "fh: 1\n");
	goto out ;
	}

    if (! parent) {
	    /* this works for handles from old kernels because the default
	    ** reiserfs generation number is the packing locality.
	    */
	    key.on_disk_key.k_objectid = data[0] ;
	    key.on_disk_key.k_dir_id = data[1] ;
	    inode = reiserfs_iget(sb, &key) ;
	    if (!inode)
		    printk(KERN_WARNING "fh: 2a\n");
	    	
	    if (inode && !IS_ERR(inode) && (fhtype == 3 || fhtype >= 5) &&
		data[2] != inode->i_generation) {
		    iput(inode) ;
		    printk(KERN_WARNING "fh: 2\n");
		    inode = NULL ;
	    }
    } else {
	    key.on_disk_key.k_objectid = data[fhtype>=5?3:2] ;
	    key.on_disk_key.k_dir_id = data[fhtype>=5?4:3] ;
	    inode = reiserfs_iget(sb, &key) ;
	    if (!inode)
		    printk(KERN_WARNING "fh: 3a\n");
	    
	    if (inode && !IS_ERR(inode) && fhtype == 6 &&
		data[5] != inode->i_generation) {
		    iput(inode) ;
		    printk(KERN_WARNING "fh: 3\n");
		    inode = NULL ;
	    }
    }
out:
    if (IS_ERR(inode))
	return ERR_PTR(PTR_ERR(inode));
    if (!inode)
        return ERR_PTR(-ESTALE) ;

    /* now to find a dentry.
     * If possible, get a well-connected one
     */
    spin_lock(&dcache_lock);
    for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
	    result = list_entry(lp,struct dentry, d_alias);
	    
	    if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
		    dget_locked(result);
		    result->d_vfs_flags |= DCACHE_REFERENCED;
		    spin_unlock(&dcache_lock);
		    iput(inode);
		    return result;
	    }
    }
    spin_unlock(&dcache_lock);
    result = d_alloc_root(inode);
    if (result == NULL) {
	    iput(inode);
	    printk(KERN_WARNING "fh: 4\n");
	    
	    return ERR_PTR(-ENOMEM);
    }
    result->d_flags |= DCACHE_NFSD_DISCONNECTED;
    return result;

}

As you can see I put printks just around everywhere, where a false exit seems possible. Only I get _no_ output from it in my testcase.

Is this really the correct spot to look at?

What else can I do?

Regards,
Stephan

