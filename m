Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVCPGXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVCPGXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 01:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVCPGXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 01:23:06 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:60848 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262531AbVCPGXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 01:23:01 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.11-mm3: BUG: atomic counter underflow at: rpcauth_destroy
Date: Wed, 16 Mar 2005 07:23:08 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200503152321.52799.petkov@uni-muenster.de> <1110930779.22062.13.camel@lade.trondhjem.org>
In-Reply-To: <1110930779.22062.13.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503160723.08284.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 March 2005 00:52, Trond Myklebust wrote:
> ty den 15.03.2005 Klokka 23:21 (+0100) skreiv Borislav Petkov:
> > After some rookie debugging I think I've found the evildoer:
> >
> > rpcauth_create used to have a line that inits rpc_auth->au_count to one
> > atomically. This line is now missing so when you release the rpc
> > authentication handle, the au_count underflows. Here's a fix:
> >
> > Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> >
> > --- net/sunrpc/auth.c.orig 2005-03-15 22:34:58.000000000 +0100
> > +++ net/sunrpc/auth.c 2005-03-15 22:36:23.000000000 +0100
> > @@ -70,6 +70,7 @@ rpcauth_create(rpc_authflavor_t pseudofl
> >   auth = ops->create(clnt, pseudoflavor);
> >   if (!auth)
> >    return NULL;
> > + atomic_set(&auth->au_count, 1);
> >   if (clnt->cl_auth)
> >    rpcauth_destroy(clnt->cl_auth);
> >   clnt->cl_auth = auth;
>
> The correct fix for this has already been committed to Linus' bitkeeper
> repository. See
>
> http://linux.bkbits.net:8080/linux-2.6/cset@42332338Oz6uYqdnuwFBM5JHXlBCCQ?
>nav=index.html|ChangeSet@-4d
>
> Cheers,
>   Trond

Yeah, this is fixed, but, the atomic_dec_and_test(&auth->au_count) appears in 
net/sunrpc/auth.c too. And the respective create function which creates the 
authentication handles doesn't do atomic_set of this variable. So we should 
either remove the atomic_dec_and_test() there too or reintroduce the 
atomic_set() in the rpcauth_create function otherwise we are still going to 
experience the same underflow BUG messages. Or am I missing something :)?

Regards,
Boris.
