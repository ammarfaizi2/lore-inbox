Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbRBTOPg>; Tue, 20 Feb 2001 09:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRBTOP0>; Tue, 20 Feb 2001 09:15:26 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:14992 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129361AbRBTOPV>; Tue, 20 Feb 2001 09:15:21 -0500
Date: Tue, 20 Feb 2001 15:02:52 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Neil Brown <neilb@cse.unsw.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        dek_ml@konerding.com, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net, mason@suse.com
Subject: Re: [NFS] Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: <shslmr11yfs.fsf@charged.uio.no>
Message-ID: <Pine.GSO.4.10.10102201455390.13098-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20 Feb 2001, Trond Myklebust wrote:

> IIRC several NFS implementations (not Linux though) rely on being able
> to walk back up the directory tree in order to discover the path at
> any given moment.

If I read the source correctly, namespace operation are done with dir file
handle + file name. I'm playing with the idea if we could relax the rule,
that all dentries must be connected to the root. Inode to dentry lookups
are really evil, e.g. the current code ignores that there might be a fs
that supports links to dirs (besides that vfs doesn't support that very
well either).
What IMO knfsd needs is only a file handle <-> inode operation and as long
as the inode is not connected to a dcache entry (i_dentry is empty) it
gets a dummy dentry, which is used for further lookups. As soon as a real
dentry lookups that inode, we can flush the dummy dentry (small change to
d_instantiate()).
This would make it possible to support fs, that can't lookup ".." or it
would avoid extra checks for fs, that don't have real ".." dir entries.
All what a fs needs to do is to generate a 16(?) byte cookie, which can be
used to find the inode back (with the default to i_ino + i_generation).
This is nothing for 2.4, but IMO something that could be tried with 2.5.

bye, Roman

PS: /me is searching his fire proof underwear. :)

