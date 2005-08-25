Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVHYUlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVHYUlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 16:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVHYUlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 16:41:46 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:14262 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S932562AbVHYUlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 16:41:45 -0400
Date: Thu, 25 Aug 2005 17:43:35 -0300
From: Glauber de Oliveira Costa <gocosta@br.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Glauber de Oliveira Costa <gocosta@br.ibm.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       ext2resize-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] Ext3 online resizing locking issue
Message-ID: <20050825204335.GA1674@br.ibm.com>
References: <20050824210325.GK23782@br.ibm.com> <1124996561.1884.212.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124996561.1884.212.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> NAK, this is wrong:
> 
> > +		lock_super(sb);
> >  		err = ext3_group_extend(sb, EXT3_SB(sb)->s_es, n_blocks_count);
> > +		unlock_super(sb);
> 
> This basically reverses the order of locking between lock_super() and
> journal_start() (the latter acts like a lock because it can block on a
> resource if the journal is too full for the new transaction.)  That's
> the opposite order to normal, and will result in a potential deadlock.
> 
Ooops! Missed that. But I agree with the point. 

 
> But the _right_ fix, if you really want to keep that code, is probably
> to move all the resize locking to a separate lock that ranks outside the
> journal_start.  The easy workaround is to drop the superblock lock and
> reaquire it around the journal_start(); it would be pretty easy to make
> that work robustly as far as ext3 is concerned, but I suspect there may
> be VFS-layer problems if we start dropping the superblock lock in the
> middle of the s_ops->remount() call --- Al?
> 

Just a question here. With s_lock held by the remount code, we're
altering the struct super_block, and believing we're safe. We try to
acquire it inside the resize functions, because we're trying to modify 
this same data. Thus, if we rely on another lock, aren't we probably 
messing  up something ? (for example, both group_extend and remount code 
potentially modify s_flags field. If we ioctl and remount at the same time, 
each one with a different lock, something could go wrong). Am I missing
something here ? 

glauber
