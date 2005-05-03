Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVECTEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVECTEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 15:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVECTEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 15:04:49 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:44748 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261601AbVECTE0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 15:04:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=agYa/LS9AF6WYLKWrt87QG9TMMZyR4prMYELoYrccrCGaXnMh3PsxdZqmj3LvVtx/FNkmO8Uzr7bD8eB6YTTTvkqmkskXe9RW7OKsT0uaG1k4a8EFKDDEx317CBPuNvSctyx8mN5t9GsUfLsEjOWLL/bLOvd7GwQMuLum60iT5Q=
Message-ID: <469958e0050503120463eaca73@mail.gmail.com>
Date: Tue, 3 May 2005 12:04:26 -0700
From: Caitlin Bestler <caitlin.bestler@gmail.com>
Reply-To: Caitlin Bestler <caitlin.bestler@gmail.com>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Cc: Libor Michalek <libor@topspin.com>, Bill Jordan <woodennickel@gmail.com>,
       Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       Timur Tabi <timur.tabi@ammasso.com>
In-Reply-To: <20050503184325.GA19351@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <469958e00504291731eb8287c@mail.gmail.com>
	 <20050503184325.GA19351@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/05, Andy Isaacson <adi@hexapodia.org> wrote:

> 
> A consistent statement would be
> 
>     After fork(2), any regions which were registered are UNDEFINED.
>     Region boundaries are byte-accurate; a registration can cover just
>     part of a page, in which case the non-registered part of the page
>     has normal fork COW semantics.
> 

That is a reasonable approach.

> 
> Obviously, calling *any* RDMA-userland-stuff in the child is completely
> undefined [1].  One place where I can see a potential problem is in
> atexit()-type handlers registered by the RDMA library.  Since those
> aren't performance-critical they can and should do sanity checks with
> getpid() and/or checking with the kernel driver.
> 

That is also reasonable. None of the RDMA libraries I have worked on
bothered to use an atexit()-type hook because the user was theoretically
*required* to close the rnic, and driver code was already reuqired to clean
up in case of a total process failure. Adding an intermediate safety-net
for applications that exited cleanly but forget to close just didn't seem
worthwhile. If the application wants the cleanup performed optimally
then it can close the rnic, otherwise it can't complain about forcing
the RNIC vendor to clean up in the driver code.

> [1] You might want to allow the child to start a completely new RDMA
>     context, but I don't see that as necessary.
> 

That should be allowed. It is actually more normal to use the parent
as a dispatcher and to actually manage the connection in a child
process.
