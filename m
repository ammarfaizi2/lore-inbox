Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264670AbUFMAXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbUFMAXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 20:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264673AbUFMAXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 20:23:19 -0400
Received: from lakermmtao08.cox.net ([68.230.240.31]:12683 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S264670AbUFMAXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 20:23:17 -0400
In-Reply-To: <1087084736.4683.17.camel@lade.trondhjem.org>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Sat, 12 Jun 2004 20:23:16 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2004, at 19:58, Trond Myklebust wrote:
> So this would be more like an in-kernel keyring then?
Yeah, that seems about right.

> How does it cope with lifetime issues such as token renewal and
> invalidation?
My design is token-type independent, it merely implements a generic
token BLOB handling facility that maps a process to a set of tokens.
The usage of tokens should be a completely separate issue.  For
example, I auth to a Kerberos server and put the retrieved ticket into
the kernel token system.  When that token is later used, the user
(NFSv4, in this case) must verify if the token has expired or not. A
variety of actions may be taken after that point, one of which may be
to just delete the token.  If NFSv4 later tried to use the token handle
(Basically a filehandle), then it would get an error indicating that the
token was deleted, and could clean up.  If NFSv4 was the first one
that discovered the token was expired, then _it_ could delete the
token and clean up the state.

> Does it provide for notifiers in case of invalidation, renewal or token
> expiration?
That is a token-type specific matter, and should be handled by a
module targeting a specific token type.  All tokens have a type and a
service.  The "type" is an integer, representing the format of the 
token.
It could be TOKEN_RSA, or TOKEN_DSA, or TOKEN_KRB4, or
TOKEN_KRB5, or TOKEN_AES.  The "service" is a string that ids
a token uniquely within its type and token group.  A user program
could presumably create a token with any binary data and type arg
at all and just stick it into the kernel.  It would deduct from the 
user's
space and token limit, but it could be done and would work fine.  If
some token type needs special kernel handling then that could be
a module with some custom IOCTLs on the token filehandle.

Cheers,
Kyle Moffett


