Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWEYSqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWEYSqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWEYSqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:46:30 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:60058 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030326AbWEYSq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:46:29 -0400
Subject: Re: [Ext2-devel] Re: [UPDATE][1/24]ext3 block
	allocation/reservation fixes to support 2^32 blocks
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Limin Wang <lance.lmwang@gmail.com>
Cc: sho@tnes.nec.co.jp, adilger@clusterfs.com, jitendra@linsyssoft.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060525132914.GA9943@laptop.exavio.cn>
References: <20060525214011sho@rifu.tnes.nec.co.jp>
	 <20060525132914.GA9943@laptop.exavio.cn>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 25 May 2006 11:46:21 -0700
Message-Id: <1148582781.3715.19.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 21:29 +0800, Limin Wang wrote:
> See my comments in the lines.
> 
> Regards,
> lmwang
> 
> * sho@tnes.nec.co.jp <sho@tnes.nec.co.jp> [2006-05-25 21:40:11 +0900]:
> 
> > Summary of this patch:
> >   [1/24]  modify around the block allocation code(ext3)
> >           - Modify around the ext3 block allocation code to replace
> >             "int" type filesystem block number with "unsigned long".
> > 
> > Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
> > ---
> > diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/balloc.c linux-2.6.17-rc4.tmp/fs/ext3/balloc.c
> > --- linux-2.6.17-rc4/fs/ext3/balloc.c	2006-05-25 16:18:35.848388909 +0900
> > +++ linux-2.6.17-rc4.tmp/fs/ext3/balloc.c	2006-05-25 16:27:50.071038370 +0900
> > @@ -223,7 +223,7 @@ void ext3_rsv_window_add(struct super_bl
> >  {
> >  	struct rb_root *root = &EXT3_SB(sb)->s_rsv_window_root;
> >  	struct rb_node *node = &rsv->rsv_node;
> > -	unsigned int start = rsv->rsv_start;
> > +	unsigned long start = rsv->rsv_start;
> >  
> >  	struct rb_node ** p = &root->rb_node;
> >  	struct rb_node * parent = NULL;
> > @@ -656,7 +656,8 @@ ext3_try_to_allocate(struct super_block 
> >  			struct buffer_head *bitmap_bh, int goal,
> >  			unsigned long *count, struct ext3_reserve_window *my_rsv)
> >  {
> > -	int group_first_block, start, end;
> > +	unsigned long group_first_block;
> > +	int start, end; 
> unsigned long start, end;
> 
> start and end will get data from my_rcv, so it need use u32 also.
> 
No, start and end are group relative blocks:
start = my_rsv->_rsv_start - group_first_block


> >  	unsigned long num = 0;
> >  
> >  	/* we do allocation within the reservation window if we have a window */
> > @@ -766,12 +767,13 @@ fail_access:
> >  static int find_next_reservable_window(
> >  				struct ext3_reserve_window_node *search_head,
> >  				struct ext3_reserve_window_node *my_rsv,
> > -				struct super_block * sb, int start_block,
> > -				int last_block)
> > +				struct super_block * sb,
> > +				unsigned long start_block,
> > +				unsigned long last_block)
> >  {
> >  	struct rb_node *next;
> >  	struct ext3_reserve_window_node *rsv, *prev;
> > -	int cur;
> > +	unsigned long cur;
> >  	int size = my_rsv->rsv_goal_size;
> unsigned long size = my_rsv->rsv_goal_size;
>  
> 

I doubt we need a reservation window size larger than 2^31 blocks....


Mingming

