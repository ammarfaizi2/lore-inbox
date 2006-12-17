Return-Path: <linux-kernel-owner+w=401wt.eu-S1752437AbWLQLJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWLQLJs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 06:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbWLQLJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 06:09:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:32877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752437AbWLQLJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 06:09:47 -0500
X-Authenticated: #14349625
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061217085859.GB2938@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu>
Content-Type: text/plain
Date: Sun, 17 Dec 2006 12:09:42 +0100
Message-Id: <1166353782.21740.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-17 at 09:58 +0100, Ingo Molnar wrote:
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
> 
> > Hi Ingo,
> > 
> > On 16/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> > >FYI, i'm working on integrating kmemleak into -rt. Firstly, i needed the
> > >fixes below when applying it ontop of 2.6.19-rt15.
> > 
> > Do you need these fixes to avoid a compiler error? If yes, this is 
> > caused by a bug in gcc-4.x. The kmemleak container_of macro has 
> > protection for non-constant offsets passed to container_of but the 
> > faulty gcc always returns true for builtin_contant_p, even when this 
> > is not the case. Previous versions (3.4) or one of the latest 4.x gcc 
> > don't have this bug.
> > 
> > I wouldn't extend kmemleak to work around a gcc bug which was already 
> > fixed.
> 
> correct, i needed it for gcc 4.0.2. If you want this feature upstream, 
> this has to be solved - no way are we going to phase out portions of 
> gcc4. It's not hard as you can see it from my patch, non-static 
> container_of is very rare. We do alot of other hackery to keep older 
> compilers alive, and we only drop compiler support if some important 
> feature really, really needs new gcc and a sane workaround is not 
> possible.

If that's because of things like the dinky testcase below,

   int main (int argc, char *argv[])
   {
     static int a[] = { __builtin_constant_p (argc) ? 1 : 0 };
     return a[0];
   }

AFAIK, no SuSE compiler can handle it.  I just build/tested their latest
version,

   gcc version 4.1.2 20061129 (prerelease) (SUSE Linux)

and it still can't deal with that without gcc41-rh198849.patch being
applied.

	-Mike

