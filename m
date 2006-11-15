Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966089AbWKOMjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966089AbWKOMjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 07:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966807AbWKOMjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 07:39:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5033 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966089AbWKOMjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 07:39:03 -0500
Message-ID: <455B0A58.9080303@RedHat.com>
Date: Wed, 15 Nov 2006 07:38:48 -0500
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060911 Red Hat/1.0.5-0.1.el4 SeaMonkey/1.0.5
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH 05/19] NFS: Use local caching
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200632.12943.72086.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200632.12943.72086.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> The attached patch makes it possible for the NFS filesystem to make use of the
> network filesystem local caching service (FS-Cache).
> 
> To be able to use this, an updated mount program is required.  This can be
> obtained from:
> 
> 	http://people.redhat.com/steved/cachefs/util-linux/
> 
> To mount an NFS filesystem to use caching, add an "fsc" option to the mount:
> 
> 	mount warthog:/ /a -o fsc
Note: the nfs mounting code has recently moved from util-linux
into nfs-utils but the functionality is off by default (hopefully that
will change soon). In Fedora Core 6 we've decided to go ahead and
turn on the mount code which in turned allowed us to added
the '-o fsc' mounting flag. So with FC6, there is no need
to download a modified util-linux.

> +static inline void nfs_fscache_get_fh_cookie(struct inode *inode, int aycache) {}
> +static inline void nfs_fscache_release_fh_cookie(struct inode *inode) {}
> +static inline void nfs_fscache_zap_fh_cookie(struct inode *inode) {}
> +static inline void nfs_fscache_renew_fh_cookie(struct inode *inode) {}
> +static inline void nfs_fscache_disable_fh_cookie(struct inode *inode) {}

To create a cleaner and more scalable "cookie" interface into NFS,
I suggest that we remove the type of cookie from the name of the
cookie routines (meaning remove the _fh_ from the names) and bury
that type of information in the actual cookie routines. The last
thing the NFS code should care about is the type of cookie it needs
to use.. those decisions should exist in the cookie routines, not
in the mainline code... imho...

So resulting in routines would like:

static inline void nfs_fscache_get_cookie(struct inode *inode) {}
static inline void nfs_fscache_release_cookie(struct inode *inode) {}
static inline void nfs_fscache_zap_cookie(struct inode *inode) {}
static inline void nfs_fscache_renew_cookie(struct inode *inode) {}
static inline void nfs_fscache_disable_cookie(struct inode *inode) {}

Then instead of just having a fscache_cookie hang off the NFS inode,
have a pointer to a nfs_fscache_cookie structure:

struct nfs_fscache_cookie {
     int   type;   /* the type cookie: FILE, READDIR, XATTR, etc */
     ulong flags;  /* Doesn't all interfaces need flags :-) */
     void *cookie; /* the actual cookie */
};

Using an interface like this, would allow all the ugly cookie processing
to stay far away from the mainline NFS code, also makes the interface
into NFS much cleaner, simpler and scalable. Finally all changes (i.e. 
adding another cookie type) would be isolated away from the mainline
code and confined to a couple files.

Comments?

steved.

