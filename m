Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280799AbRKOJzi>; Thu, 15 Nov 2001 04:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280805AbRKOJzU>; Thu, 15 Nov 2001 04:55:20 -0500
Received: from mons.uio.no ([129.240.130.14]:17080 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S280801AbRKOJzR>;
	Thu, 15 Nov 2001 04:55:17 -0500
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: generic_file_llseek() broken?
In-Reply-To: <UTC200111150055.AAA93544.aeb@cwi.nl>
	<20011115020259.C5739@lynx.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 15 Nov 2001 10:55:07 +0100
In-Reply-To: <20011115020259.C5739@lynx.no>
Message-ID: <shsd72kcq9w.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andreas Dilger <adilger@turbolabs.com> writes:

     > --- linux.orig/fs/read_write.c Tue Aug 14 12:09:09 2001
     > +++ linux/fs/read_write.c Thu Nov 15 01:54:35 2001
     > @@ -36,15 +36,24 @@
     >  		case 1:
     >  			offset += file->f_pos;
     >  	}
     > +
     > + /* LFS 2.1.1.6: can't seek to a position that doesn't fit in
     >  	off_t */
     > + retval = -EOVERFLOW;
     > + if ((!(file->f_flags & O_LARGEFILE) && offset > MAX_NON_LFS)
     >  	||
     > + offset > file->f_dentry->d_inode->i_sb->s_maxbytes)
     > + goto out;
     > +
     >  	retval = -EINVAL;
     > - if (offset>=0 &&
     >  	offset<=file->f_dentry->d_inode->i_sb->s_maxbytes) {
     > - if (offset != file->f_pos) {
     > - file->f_pos = offset;
     > - file->f_reada = 0;
     > - file->f_version = ++event;
     > - }
     > - retval = offset;
     > + if (offset < 0)
     > + goto out;
     > +
     > + if (offset != file->f_pos) {
     > + file->f_pos = offset;
     > + file->f_reada = 0;
     > + file->f_version = ++event;
     >  	}
     > + retval = offset;
     > +out:
     >  	return retval;
     >  }
 
     > @@ -64,6 +73,12 @@
     >  		case 1:
     >  			offset += file->f_pos;
     >  	}
     > +
     > + /* LFS 2.1.1.6: can't seek to a position that doesn't fit in
     >  	off_t */
     > + retval = -EOVERFLOW;
     > + if (!(file->f_flags & O_LARGEFILE) && offset > MAX_NON_LFS)
     > + goto out;
     > +
     >  	retval = -EINVAL; if (offset >= 0) {
     >  		if (offset != file->f_pos) {
     > @@ -73,6 +88,7 @@
     >  		} retval = offset;
     >  	}
     > +out:
     >  	return retval;
     >  }
 
     > @@ -103,8 +119,6 @@
     >  	if (origin <= 2) {
     >  		loff_t res = llseek(file, offset, origin);
     >  		retval = res;
     > - if (res != (loff_t)retval)
     > - retval = -EOVERFLOW; /* LFS: should only happen on 32 bit
     >  			platforms */
     >  	} fput(file);
     >  bad:

This breaks NFS badly for which a directory seek position is *not* a
file offset, but is an unsigned cookie. Please ensure that the above
checks are only made on regular files.

Cheers,
   Trond
