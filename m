Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266067AbRGCXpA>; Tue, 3 Jul 2001 19:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266068AbRGCXov>; Tue, 3 Jul 2001 19:44:51 -0400
Received: from pedigree.cs.ubc.ca ([142.103.6.50]:14077 "EHLO
	pedigree.cs.ubc.ca") by vger.kernel.org with ESMTP
	id <S266067AbRGCXok>; Tue, 3 Jul 2001 19:44:40 -0400
Date: Tue, 3 Jul 2001 16:44:36 -0700
From: Dima Brodsky <dima@cs.ubc.ca>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Dima Brodsky <dima@cs.ubc.ca>
Subject: RPC: rpciod waiting on sync task!
Message-ID: <20010703164436.A20309@cascade.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I modified the linux NFS client, kernel 2.4.5 and 2.4.6-pre7, to send
an extra SETATTR, with special values, within nfs_open and nfs_release
so that I would be able to track file open and close.  For the server I
am using a slightly modified linux user level nfs server.

What I noticed is that after this change I get:

RPC: rpciod waiting on sync task!

coming from the kernel under heavy read load, especially with
larger chunks of data 8k, 16, and 64k.

The code introduced into nfs_open and nfs_release is:

        memset( &fattr, 0, sizeof(struct nfs_fattr) );
        memset( &attr, 0, sizeof(struct iattr) );

        attr.ia_valid = ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_SIZE;
        attr.ia_mode = inode->i_mode;
        attr.ia_uid = -10;
        attr.ia_gid = -10;
        attr.ia_size = -10;
        attr.ia_atime = -1;
        attr.ia_mtime = -1;
        attr.ia_ctime = -1;
        attr.ia_attr_flags = -1;

        error = NFS_PROTO(inode)->setattr(inode, &fattr, &attr);
        if ( error ) {
                printk( "nfs_network_openclose: error=%d\n", error );
        }

Does anybody see any problems with this code?  The unmodified nfs client
works fine with the unmodified nfs server.

Thanks
ttyl
Dima

-- 
Dima Brodsky                                   dima@cs.ubc.ca
                                               http://www.cs.ubc.ca/~dima
201-2366 Main Mall                             (604) 822-6179 (Office)
Department of Computer Science                 (604) 822-2895 (DSG Lab)
University of British Columbia, Canada         (604) 822-5485 (FAX)

Computers are like Old Testament gods; lots of rules and no mercy.
							  (Joseph Campbell)

