Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281153AbRK3Wgi>; Fri, 30 Nov 2001 17:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281138AbRK3Wfg>; Fri, 30 Nov 2001 17:35:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29445 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281163AbRK3Wep>; Fri, 30 Nov 2001 17:34:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] smarter atime updates
Date: 30 Nov 2001 14:34:40 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9u91i0$vso$1@cesium.transmeta.com>
In-Reply-To: <3C072279.D346CD09@zip.com.au> <87n1144mo6.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <87n1144mo6.fsf@devron.myhome.or.jp>
By author:    OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> Andrew Morton <akpm@zip.com.au> writes:
> 
> > mark_inode_dirty() is quite expensive for journalling filesystems,
> > and we're calling it a lot more than we need to.
> > 
> > --- linux-2.4.17-pre1/fs/inode.c	Mon Nov 26 11:52:07 2001
> > +++ linux-akpm/fs/inode.c	Thu Nov 29 21:53:02 2001
> > @@ -1187,6 +1187,8 @@ void __init inode_init(unsigned long mem
> >   
> >  void update_atime (struct inode *inode)
> >  {
> > +	if (inode->i_atime == CURRENT_TIME)
> > +		return;
> >  	if ( IS_NOATIME (inode) ) return;
> >  	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
> >  	if ( IS_RDONLY (inode) ) return;
> 
> in include/linux/fs.h:
> 
> #define UPDATE_ATIME(inode)			\
> do {						\
> 	if ((inode)->i_atime != CURRENT_TIME)	\
> 		update_atime (inode);		\
> } while (0)
> 
> How about this macro? (add likely()?)
>

The only potential issue I can see (with either approach) is that it
seems to break filesystems for which atime has a granularity finer
than 1 s.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
