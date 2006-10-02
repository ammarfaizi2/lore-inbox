Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWJBSXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWJBSXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbWJBSXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:23:37 -0400
Received: from mail.fieldses.org ([66.93.2.214]:13550 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S965231AbWJBSXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:23:35 -0400
Date: Mon, 2 Oct 2006 14:23:27 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: NeilBrown <neilb@suse.de>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 006 of 8] knfsd: nfsd4: fslocations data structures
Message-ID: <20061002182327.GB8084@fieldses.org>
References: <20060929130518.23919.patches@notabene> <1060929030913.24108@suse.de> <20060928234540.fd74f1e1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928234540.fd74f1e1.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 11:45:40PM -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 13:09:13 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> > 
> > From: Manoj Naik <manoj@almaden.ibm.com>
> > 
> > Define FS locations structures, some functions to manipulate them, and add
> > code to parse FS locations in downcall and add to the exports structure.
...
> > +	if (fsloc->locations_count < 0)
> 
> this is unsigned.

Yes, thanks.

> > +	fsloc->locations = kzalloc(fsloc->locations_count
> > +			* sizeof(struct nfsd4_fs_location), GFP_KERNEL);
> 
> This is subject to multiplication overflow.  If it's a privileged operation
> and isn't dependent on stuff coming in over the wire then ok..

This is data provided locally by root.  But there's no reason to allow
this to be arbitrarily large, and I'd still prefer to have some
sanity-checking, so I'll replace the bogus "<0" check above by a
check for something "too large".

> > +out_free_all:
> > +	nfsd4_fslocs_free(fsloc);
> 
> This call to nfsd4_fslocs_free() can end up kfreeing members of
> fsloc->locations[] which haven't been initialised here.  Are we sure the
> caller set them all to zero?

Yes.  There will only ever be one caller, and it has to initialize
these to zero.  I agree that this could be more obvious....

> > +	return err;
> > +}
> > +
> > +#else /* CONFIG_NFSD_V4 */
> > +static int fsloc_parse(char **, char *, struct svc_export *) { return 0; }
> 
> static inline
> 
> This has a different prototype from the other version of fsloc_parse()
> 
> This ain't C++ - function arguments need identifiers as well as types.
> 
> Someone needs to read Documentation/SubmitChecklist..

That would be me, sorry, yes.

Bryce Harrington is also setting up automatic compile-testing for us
with the obvious config options turned on and off, so hopefully that
will help save me from myself....

Patches addressing the above follow.

--b.
