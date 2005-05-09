Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVEIO7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVEIO7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVEIO7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:59:24 -0400
Received: from godzilla.roxen.com ([212.247.28.43]:17128 "EHLO mail.roxen.com")
	by vger.kernel.org with ESMTP id S261387AbVEIO7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:59:19 -0400
Date: Mon, 9 May 2005 16:59:14 +0200 (MET DST)
From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, "akpm@osdl.org" <akpm@osdl.org>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Support for dx directories in ext3_get_parent (NFSD)
In-Reply-To: <1115647514.1984.71.camel@sisko.sctweedie.blueyonder.co.uk>
Message-ID: <Pine.GSO.4.21.0505091645430.22820-100000@jms.roxen.com>
Organization: Roxen Internet Software AB
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Stephen C. Tweedie wrote:

> On Mon, 2005-05-09 at 10:46, Henrik Grubbström wrote:
> 
> > > ext3_get_parent() is IMHO the wrong place to fix this bug as it introduces
> > > a lot of internals from htree into that function.  Instead, I think this
> > > should be fixed in ext3_find_entry() as in the below patch.  This has the
> > > added advantage that it works for any callers of ext3_find_entry() and not
> > > just ext3_lookup_parent().
> > 
> > The reason I didn't put it there is that handling of ".." is usually
> > performed by fs/namei.c:link_path_walk() and putting it in
> > ext3_find_entry() or one of the functions it calls would slow down the
> > common case.
> 
> True, but the extra cost is to evaluate
> 
> if (namelen > 2 || name[0] != '.'||(name[1] != '.' && name[1] != '\0')
> 
> as false.  That's not going to take long most of the time.  And this
> solution has two other big advantages: it fixes things for all lookups,
> not just NFS, and hence is safer against this bug cropping up again in
> the future in unexpected places; and it includes less dependency on
> htree internals, as Andreas said.

All true.

Since the htree stuff is implemented in the same file and the get_parent
operation is rather basic I didn't see much point. The advantages of my
patch are that it looks at a single directory block and that it doesn't
affect the i_dir_start_lookup state kept for non dx-directories.

> Cheers,
>  Stephen

--
Henrik Grubbström					grubba@roxen.com
Roxen Internet Software AB

