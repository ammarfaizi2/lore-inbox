Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVCOX5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVCOX5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVCOXyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:54:24 -0500
Received: from pat.uio.no ([129.240.130.16]:6531 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262127AbVCOXxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:53:19 -0500
Subject: Re: 2.6.11-mm3: BUG: atomic counter underflow at: rpcauth_destroy
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503152321.52799.petkov@uni-muenster.de>
References: <200503152321.52799.petkov@uni-muenster.de>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 18:52:58 -0500
Message-Id: <1110930779.22062.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.367, required 12,
	autolearn=disabled, AWL 1.58, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 15.03.2005 Klokka 23:21 (+0100) skreiv Borislav Petkov:

> After some rookie debugging I think I've found the evildoer:
> 
> rpcauth_create used to have a line that inits rpc_auth->au_count to one
> atomically. This line is now missing so when you release the rpc
> authentication handle, the au_count underflows. Here's a fix:
> 
> Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> 
> --- net/sunrpc/auth.c.orig 2005-03-15 22:34:58.000000000 +0100
> +++ net/sunrpc/auth.c 2005-03-15 22:36:23.000000000 +0100
> @@ -70,6 +70,7 @@ rpcauth_create(rpc_authflavor_t pseudofl
>   auth = ops->create(clnt, pseudoflavor);
>   if (!auth)
>    return NULL;
> + atomic_set(&auth->au_count, 1);
>   if (clnt->cl_auth)
>    rpcauth_destroy(clnt->cl_auth);
>   clnt->cl_auth = auth;

The correct fix for this has already been committed to Linus' bitkeeper
repository. See

http://linux.bkbits.net:8080/linux-2.6/cset@42332338Oz6uYqdnuwFBM5JHXlBCCQ?nav=index.html|ChangeSet@-4d

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

