Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030610AbWKOPwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610AbWKOPwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbWKOPwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:52:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18622 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030610AbWKOPwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:52:22 -0500
Date: Wed, 15 Nov 2006 15:52:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 19/19] CacheFiles: Permit daemon to probe inuseness of a cache file
Message-ID: <20061115155205.GA3911@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, sds@tycho.nsa.gov, trond.myklebust@fys.uio.no,
	selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
	aviro@redhat.com, steved@redhat.com
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200702.12943.39624.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114200702.12943.39624.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 08:07:02PM +0000, David Howells wrote:
> Permit the daemon to probe to see whether a cache file is in use by a netfs or
> not.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/cachefiles/cf-daemon.c |   73 +++++++++++++++++++
>  fs/cachefiles/cf-namei.c  |  170 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/cachefiles/internal.h  |    3 +
>  3 files changed, 246 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/cachefiles/cf-daemon.c b/fs/cachefiles/cf-daemon.c
> index ae82685..ee07865 100644
> --- a/fs/cachefiles/cf-daemon.c
> +++ b/fs/cachefiles/cf-daemon.c
> @@ -38,6 +38,7 @@ static int cachefiles_daemon_cull(struct
>  static int cachefiles_daemon_debug(struct cachefiles_cache *cache, char *args);
>  static int cachefiles_daemon_dir(struct cachefiles_cache *cache, char *args);
>  static int cachefiles_daemon_tag(struct cachefiles_cache *cache, char *args);
> +static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args);
>  
>  static unsigned long cachefiles_open;
>  
> @@ -66,6 +67,7 @@ static const struct cachefiles_daemon_cm
>  	{ "frun",	cachefiles_daemon_frun	},
>  	{ "fcull",	cachefiles_daemon_fcull	},
>  	{ "fstop",	cachefiles_daemon_fstop	},
> +	{ "inuse",	cachefiles_daemon_inuse	},
>  	{ "tag",	cachefiles_daemon_tag	},
>  	{ "",		NULL			}
>  };
> @@ -602,3 +604,74 @@ inval:
>  	kerror("debug command requires mask");
>  	return -EINVAL;
>  }
> +
> +/*
> + * find out whether an object is in use or not
> + * - command: "inuse <dirfd> <name>"
> + */
> +static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
> +{
> +	struct dentry *dir;
> +	struct file *dirfile;
> +	uid_t fsuid;
> +	gid_t fsgid;
> +	u32 fscreatesid;
> +	int dirfd, fput_needed, ret;
> +
> +	_enter(",%s", args);
> +
> +	dirfd = simple_strtoul(args, &args, 0);
> +
> +	if (!isspace(*args))
> +		goto inval;
> +
> +	while (isspace(*args))
> +		args++;
> +
> +	if (!*args)
> +		goto inval;
> +
> +	if (strchr(args, '/'))
> +		goto inval;
> +
> +	if (!test_bit(CACHEFILES_READY, &cache->flags)) {
> +		kerror("inuse applied to unready cache");
> +		return -EIO;
> +	}
> +
> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
> +		kerror("inuse applied to dead cache");
> +		return -EIO;
> +	}
> +
> +	/* extract the directory dentry from the fd */
> +	dirfile = fget_light(dirfd, &fput_needed);

Once again a very strong NACK for anything that gets a fd argument as
text from userspace.  Also a very strong NACK for use of fget/fget_light
from non-core code and exports for either of them.

