Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWEHRtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWEHRtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWEHRtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:49:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932427AbWEHRtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:49:49 -0400
Date: Mon, 8 May 2006 10:46:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@namei.org>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com
Subject: Re: [PATCH] selinux: check for failed kmalloc in
 security_sid_to_context
Message-Id: <20060508104659.7f17f38d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604262325090.5735@d.namei>
References: <20060427020740.GA23112@sergelap.austin.ibm.com>
	<Pine.LNX.4.64.0604262325090.5735@d.namei>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:
>
> On Wed, 26 Apr 2006, Serge E. Hallyn wrote:
> 
> > Check for NULL kmalloc return value before writing to it.
> > 
> > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> 
> Acked-by: James Morris <jmorris@namei.org>
> 
> 
> > ---
> > 
> >  security/selinux/ss/services.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > 3d9cf05c7fa2578f87648dd0862e70cf7959ad7a
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 6149248..20b1065 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -593,6 +593,10 @@ int security_sid_to_context(u32 sid, cha
> >  
> >  			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
> >  			scontextp = kmalloc(*scontext_len,GFP_ATOMIC);
> > +			if (!scontextp) {
> > +				rc = -ENOMEM;
> > +				goto out;
> > +			}
> >  			strcpy(scontextp, initial_sid_to_string[sid]);
> >  			*scontext = scontextp;
> >  			goto out;
> > 
> 

Given that GFP_ATOMIC can fail and it'll cause an oops I'll queue this for
2.6.17 and shall send it in the direction of the -stable guys too, thanks.

What will happen when one of the GFP_ATOMIC allocations in there fails? 
Will the computer become insecure?

