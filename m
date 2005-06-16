Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVFPGFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVFPGFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 02:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVFPGFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 02:05:31 -0400
Received: from [159.226.5.94] ([159.226.5.94]:9999 "EHLO ercist.iscas.ac.cn")
	by vger.kernel.org with ESMTP id S261741AbVFPGFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 02:05:19 -0400
Subject: Re: [PATCH] ReiserFS _get_block_create_0 wrong behavior when I/O
	fails
From: fs <fs@ercist.iscas.ac.cn>
To: Vladimir Saveliev <vs@namesys.com>
Cc: reiserfs-list@namesys.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Hans Reiser <reiser@namesys.com>
In-Reply-To: <1118850101.17622.579.camel@tribesman.namesys.com>
References: <1118865954.4231.4.camel@CoolQ>
	 <1118850101.17622.579.camel@tribesman.namesys.com>
Content-Type: text/plain
Organization: iscas
Message-Id: <1118941347.2886.2.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Jun 2005 13:04:59 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Vladimir Saveliev,
On Wed, 2005-06-15 at 11:41, Vladimir Saveliev wrote:

> > Patch:
> > diff -uNp /tmp/linux-2.6.12-rc6/fs/reiserfs/inode.c /tmp/linux-2.6.12-rc6.new/fs/reiserfs/inode.c
> > --- /tmp/linux-2.6.12-rc6/fs/reiserfs/inode.c	2005-06-06 11:22:29.000000000 -0400
> > +++ /tmp/linux-2.6.12-rc6.new/fs/reiserfs/inode.c	2005-06-15 13:56:45.552564512 -0400
> > @@ -254,6 +254,7 @@ static int _get_block_create_0 (struct i
> >      char * p = NULL;
> >      int chars;
> >      int ret ;
> > +    int result ;
> >      int done = 0 ;
> >      unsigned long offset ;
> >  
> > @@ -262,7 +263,8 @@ static int _get_block_create_0 (struct i
> >  		  (loff_t)block * inode->i_sb->s_blocksize + 1, TYPE_ANY, 3);
> >  
> >  research:
> > -    if (search_for_position_by_key (inode->i_sb, &key, &path) != POSITION_FOUND) {
> > +    result = search_for_position_by_key (inode->i_sb, &key, &path) ;
> > +    if (result != POSITION_FOUND) {
> >  	pathrelse (&path);
> >          if (p)
> >              kunmap(bh_result->b_page) ;
> > @@ -270,7 +272,8 @@ research:
> >  	// That there is some MMAPED data associated with it that is yet to be written to disk.
> >  	if ((args & GET_BLOCK_NO_HOLE) && !PageUptodate(bh_result->b_page) ) {
> >  	    return -ENOENT ;
> > -	}
> > +	}else if (result == IO_ERROR)
> > +		return -EIO ;
> >          return 0 ;
> >      }
> >      
> 
> Your patch is incomplete. There is one more search_for_position_by_key
> at the end of this function. You probably want to check its return value
> also.
I notice there's a comment
	if (search_for_position_by_key (inode->i_sb, &key, &path) !=
POSITION_FOUND)
	    // we read something from tail, even if now we got IO_ERROR <-
Here, can you explain more ?
	    break;



