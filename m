Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVEIOFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVEIOFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVEIOFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:05:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261374AbVEIOFi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:05:38 -0400
Subject: Re: [PATCH] Support for dx directories in ext3_get_parent (NFSD)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Henrik =?ISO-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, "akpm@osdl.org" <akpm@osdl.org>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0505091135290.22820-100000@jms.roxen.com>
References: <Pine.GSO.4.21.0505091135290.22820-100000@jms.roxen.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Message-Id: <1115647514.1984.71.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 09 May 2005 15:05:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-05-09 at 10:46, Henrik Grubbström wrote:

> > ext3_get_parent() is IMHO the wrong place to fix this bug as it introduces
> > a lot of internals from htree into that function.  Instead, I think this
> > should be fixed in ext3_find_entry() as in the below patch.  This has the
> > added advantage that it works for any callers of ext3_find_entry() and not
> > just ext3_lookup_parent().
> 
> The reason I didn't put it there is that handling of ".." is usually
> performed by fs/namei.c:link_path_walk() and putting it in
> ext3_find_entry() or one of the functions it calls would slow down the
> common case.

True, but the extra cost is to evaluate

if (namelen > 2 || name[0] != '.'||(name[1] != '.' && name[1] != '\0')

as false.  That's not going to take long most of the time.  And this
solution has two other big advantages: it fixes things for all lookups,
not just NFS, and hence is safer against this bug cropping up again in
the future in unexpected places; and it includes less dependency on
htree internals, as Andreas said.

I'll have a closer review of the patch, but for now I think I like
Andreas's version better.

Cheers,
 Stephen

