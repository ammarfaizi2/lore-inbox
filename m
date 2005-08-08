Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVHHKSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVHHKSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVHHKSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:18:47 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:15747 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750804AbVHHKSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:18:47 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080223445375c907@mail.gmail.com>
            <20050808095747.GD13951@redhat.com>
In-Reply-To: <20050808095747.GD13951@redhat.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Mon, 08 Aug 2005 13:18:45 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F73185.00006260@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland writes:
> > > +#define RETRY_MALLOC(do_this, until_this) \
> > > +for (;;) { \
> > > +     { do_this; } \
> > > +     if (until_this) \
> > > +             break; \
> > > +     if (time_after_eq(jiffies, gfs2_malloc_warning + 5 * HZ)) { \
> > > +             printk("GFS2: out of memory: %s, %u\n", __FILE__, __LINE__); \
> > > +             gfs2_malloc_warning = jiffies; \
> > > +     } \
> > > +     yield(); \
> > > +}
> > 
> > Please drop this. 
> 
> Done in the spot that could deal with an error, but there are three other
> places that still need it.

Which places are those? I only see these: 

gfs2-02.patch:+ RETRY_MALLOC(ip = kmem_cache_alloc(gfs2_inode_cachep, 
GFP_KERNEL), ip);
gfs2-02.patch-+ gfs2_memory_add(ip);
gfs2-02.patch-+ memset(ip, 0, sizeof(struct gfs2_inode));
gfs2-02.patch-+
gfs2-02.patch-+ ip->i_num = *inum;
gfs2-02.patch-+ 

 -> GFP_NOFAIL. 

gfs2-02.patch:+         RETRY_MALLOC(page = 
grab_cache_page(aspace->i_mapping, index),
gfs2-02.patch-+                      page);
gfs2-02.patch-+ } else {
gfs2-02.patch-+         page = find_lock_page(aspace->i_mapping, index);
gfs2-02.patch-+         if (!page)
gfs2-02.patch-+                 return NULL; 

I think you can set aspace->flags to GFP_NOFAIL but why can't you return 
NULL here on failure like you do for find_lock_page()? 

gfs2-02.patch:+ RETRY_MALLOC(bd = kmem_cache_alloc(gfs2_bufdata_cachep, 
GFP_KERNEL),
gfs2-02.patch-+              bd);
gfs2-02.patch-+ gfs2_memory_add(bd);
gfs2-02.patch-+ atomic_inc(&gl->gl_sbd->sd_bufdata_count);
gfs2-02.patch-+
gfs2-02.patch-+ memset(bd, 0, sizeof(struct gfs2_bufdata)); 

 -> GFP_NOFAIL 

gfs2-08.patch:+ RETRY_MALLOC(gm = kmalloc(sizeof(struct gfs2_memory), 
GFP_KERNEL), gm);
gfs2-08.patch-+ gm->gm_data = data;
gfs2-08.patch-+ gm->gm_file = file;
gfs2-08.patch-+ gm->gm_line = line;
gfs2-08.patch-+
gfs2-08.patch-+ spin_lock(&memory_lock); 

 -> GFP_NOFAIL 

gfs2-10.patch:+         RETRY_MALLOC(new_gh = gfs2_holder_get(gl, state,
gfs2-10.patch-+                                               LM_FLAG_TRY |
gfs2-10.patch-+                                               
GL_NEVER_RECURSE),
gfs2-10.patch-+                      new_gh);
gfs2-10.patch-+         set_bit(HIF_DEMOTE, &new_gh->gh_iflags);
gfs2-10.patch-+         set_bit(HIF_DEALLOC, &new_gh->gh_iflags); 

gfs2_holder_get uses kmalloc which can use GFP_NOFAIL. 

                Pekka 

