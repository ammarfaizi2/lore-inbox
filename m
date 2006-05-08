Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWEHSSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWEHSSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 14:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWEHSSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 14:18:09 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:21687 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750741AbWEHSSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 14:18:08 -0400
Subject: Re: [PATCH] selinux: check for failed kmalloc in
	security_sid_to_context
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@namei.org>, serue@us.ibm.com,
       linux-kernel@vger.kernel.org, jmorris@redhat.com
In-Reply-To: <20060508104659.7f17f38d.akpm@osdl.org>
References: <20060427020740.GA23112@sergelap.austin.ibm.com>
	 <Pine.LNX.4.64.0604262325090.5735@d.namei>
	 <20060508104659.7f17f38d.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 08 May 2006 14:21:33 -0400
Message-Id: <1147112493.23640.134.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 10:46 -0700, Andrew Morton wrote:
> James Morris <jmorris@namei.org> wrote:
> >
> > On Wed, 26 Apr 2006, Serge E. Hallyn wrote:
> > 
> > > Check for NULL kmalloc return value before writing to it.
> > > 
> > > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> > 
> > Acked-by: James Morris <jmorris@namei.org>
> > 
> > 
> > > ---
> > > 
> > >  security/selinux/ss/services.c |    4 ++++
> > >  1 files changed, 4 insertions(+), 0 deletions(-)
> > > 
> > > 3d9cf05c7fa2578f87648dd0862e70cf7959ad7a
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > index 6149248..20b1065 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -593,6 +593,10 @@ int security_sid_to_context(u32 sid, cha
> > >  
> > >  			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
> > >  			scontextp = kmalloc(*scontext_len,GFP_ATOMIC);
> > > +			if (!scontextp) {
> > > +				rc = -ENOMEM;
> > > +				goto out;
> > > +			}
> > >  			strcpy(scontextp, initial_sid_to_string[sid]);
> > >  			*scontext = scontextp;
> > >  			goto out;
> > > 
> > 
> 
> Given that GFP_ATOMIC can fail and it'll cause an oops I'll queue this for
> 2.6.17 and shall send it in the direction of the -stable guys too, thanks.

Note however that this can only occur prior to initial policy load
by /sbin/init; after that, we don't follow that branch.

> What will happen when one of the GFP_ATOMIC allocations in there fails? 
> Will the computer become insecure?

No, it doesn't affect the access control enforcement.  The caller just
can't get the context string in that case, so in the case of the AVC or
audit, it falls back to only logging the SID for later analysis.  The
audit people are interested in having a way to dump the kernel's SID
table in that case, so we may end up exporting that via selinuxfs.  In
some other cases where we are returning the context to userspace, the
program would get the ENOMEM error ultimately and have to retry when
memory was available.

-- 
Stephen Smalley
National Security Agency

