Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVJFTHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVJFTHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVJFTHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:07:24 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:62142 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751311AbVJFTHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:07:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=cf5KCG1BBGLFIuByDYGSjZ86JIiKvrly99Gcee1pg9EjG+GnYWp4oLye5p0aGS12hx/CgkNVpO5XQfQDzCMhRBjjGn1nQ3FlbxD6OqABwWSIiqeCZl/9zpuCg95JtG1WetNcH390bIXef7O6QrqTfezlA6hSvl3jgmcwiTosYok=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 11/12] HPPFS: add dentry_ops->d_revalidate
Date: Thu, 6 Oct 2005 20:07:31 +0200
User-Agent: KMail/1.8.2
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>
References: <20050918141006.31461.23599.stgit@zion.home.lan> <20050921034416.GW7992@ftp.linux.org.uk>
In-Reply-To: <20050921034416.GW7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200510062007.32365.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 05:44, Al Viro wrote:
> On Sun, Sep 18, 2005 at 04:10:07PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > +static int hppfs_d_revalidate(struct dentry * dentry, struct nameidata *
> > nd) +{
> > +	int (*d_revalidate)(struct dentry *, struct nameidata *);
> > +	struct dentry *proc_dentry;
> > +
> > +	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
> > +	if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate)
> > +		d_revalidate = proc_dentry->d_op->d_revalidate;
> > +	else
> > +		return 1; /* "Still valid" code */
> > +
> > +	return (*d_revalidate)(proc_dentry, nd);
> > +}
>
> Ahem...  Guess what that will do with negative dentry?
Was missing the very first line (dentry->d_inode). I just saw you already 
suggested returning 0 for them, which I'm gonna do anyway.

But, actually, procfs returns ENOENT (or EINVAL) rather than creating negative 
dentries (at least, I've examined most of procfs lookup funcs, hope I haven't 
missed any)...

And actually, after realizing the procfs trick, I see that we, too should miss 
negative dentries, because on the "uncached" path when we get an error like 
that we propagate that, and on the "cached" one obviously we can't find them 
in dcache.
Right?

I'll do the check for negative dentries anyway because depending on procfs 
details is not on my TODO list.

Yes, we could, but given the unmaintainance level of HPPFS, nobody would ever 
fix it when needed, and that's not recommended.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
