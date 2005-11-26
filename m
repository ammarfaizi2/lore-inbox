Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbVKZDBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbVKZDBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 22:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbVKZDBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 22:01:09 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:33995 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932643AbVKZDBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 22:01:08 -0500
Date: Sat, 26 Nov 2005 11:09:38 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 10/19] readahead: state based method
Message-ID: <20051126030938.GA6237@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20051125151210.993109000@localhost.localdomain> <20051125151550.440541000@localhost.localdomain> <43872BF2.3030407@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43872BF2.3030407@cosmosbay.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2005 at 04:21:22PM +0100, Eric Dumazet wrote:
> Wu Fengguang a ¨¦crit :
> 
> > include/linux/fs.h |    8 +
> >
> >--- linux-2.6.15-rc2-mm1.orig/include/linux/fs.h
> >+++ linux-2.6.15-rc2-mm1/include/linux/fs.h
> >@@ -604,13 +604,19 @@ struct file_ra_state {
> > 	unsigned long start;		/* Current window */
> > 	unsigned long size;
> > 	unsigned long flags;		/* ra flags RA_FLAG_xxx*/
> >-	unsigned long cache_hit;	/* cache hit count*/
> >+	uint64_t      cache_hit;	/* cache hit count*/
> > 	unsigned long prev_page;	/* Cache last read() position */
> > 	unsigned long ahead_start;	/* Ahead window */
> > 	unsigned long ahead_size;
> > 	unsigned long ra_pages;		/* Maximum readahead window */
> > 	unsigned long mmap_hit;		/* Cache hit stat for mmap accesses 
> > 	*/
> > 	unsigned long mmap_miss;	/* Cache miss stat for mmap accesses 
> > 	*/
> >+
> >+	unsigned long age;
> >+	pgoff_t la_index;
> >+	pgoff_t ra_index;
> >+	pgoff_t lookahead_index;
> >+	pgoff_t readahead_index;
> > };
> 
> Hum... This sizeof(struct file) increase seems quite large...

Thanks.
I'm not sure if the two read-ahead logics should coexist in long term.
If so, the file_ra_state can be changed as follows to save memory:

struct file_ra_state {
        union { 
                struct {
                        unsigned long start;            /* Current window */
                        unsigned long size;
                        unsigned long ahead_start;      /* Ahead window */
                        unsigned long ahead_size;
                };
                struct {
                        unsigned long mmap_hit;         /* Cache hit stat for mmap accesses */
                        unsigned long mmap_miss;        /* Cache miss stat for mmap accesses */
                };      
                struct {
                        unsigned long age;
                        pgoff_t la_index;
                        pgoff_t ra_index;
                        pgoff_t lookahead_index;
                        pgoff_t readahead_index;
                };
        };
        uint64_t      cache_hit;        /* cache hit count*/
        unsigned long flags;            /* ra flags RA_FLAG_xxx*/
        unsigned long prev_page;        /* Cache last read() position */
        unsigned long ra_pages;         /* Maximum readahead window */
};

The mmap_hit/mmap_miss should be only used in mmap read-around logic.

> Have you ever considered to change struct file so that file_ra_state is not 
> embedded, but dynamically allocated (or other strategy) for regular files ?
> 
> I mean, sockets, pipes cannot readahead... And some machines use far more 
> sockets than regular files.
> 
> I wrote such a patch in the past I could resend...

Yes, I noticed it, and think it generally a good idea. The only problem is that
I'm afraid the patch might make the file_ra_state tightly coupled with file. See
this comment:

 * Note that @filp is purely used for passing on to the ->readpage[s]()
 * handler: it may refer to a different file from @mapping (so we may not use
 * @filp->f_mapping or @filp->f_dentry->d_inode here).
 * Also, @ra may not be equal to &@filp->f_ra.

And this patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/broken-out/ext3_readdir-use-generic-readahead.patch
  Linus points out that ext3_readdir's readahead only cuts in when
  ext3_readdir() is operating at the very start of the directory.  So for large
  directories we end up performing no readahead at all and we suck.
  
  So take it all out and use the core VM's page_cache_readahead().  This means
  that ext3 directory reads will use all of readahead's dynamic sizing goop.
  
  Note that we're using the diretory's filp->f_ra to hold the readahead state,
  but readahead is actually being performed against the underlying blockdev's
  address_space.  Fortunately the readahead code is all set up to handle this.

Regards,
Wu
