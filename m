Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVFZXIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVFZXIB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVFZXIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:08:00 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:57353 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261648AbVFZXHb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:07:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NCYvEo6pvrvFERNuzPQpwyVSrjnpSNx8TNJFTW5lsaiv5ro4XuD9MGCkLlKVcXljp4Ipztig5Rw2uxaTeVhc/UVyt29CHnngaqYejpvXqp+h37ntDQujE5YFopkpZj+Rrsk7yq8e1vbBquI6UqvrehI6hbRVSO6CZAIL2KlWKP0=
Message-ID: <21d7e997050626160729afdff2@mail.gmail.com>
Date: Mon, 27 Jun 2005 09:07:28 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: SiS drm broken during 2.6.9-rc1-bk1
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050215103207.GA19866@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0502131124090.16528@skynet>
	 <21d7e99705021400266bcbc0f2@mail.gmail.com>
	 <20050215103207.GA19866@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > layout is the most likely patch to have broken things... I haven't
> > > confirmed it is this particular patch yet, tomorrow I'll get some time to
> > > do it ..
> > >
> >
> > okay running client applications using
> >
> > setarch -L i386 glxgears
> >
> > makes them work.. I'll start looking for a bug in the the SIS client
> > side library..
> 
> yeah. Look for 2GB assumptions - e.g. assumptions that pointers cast to
> integer will be positive values, such as:
> 
>         int i;
> 
>         i = malloc(somesize);
>         if (i <= 0)
>                 handle_alloc_failure();
> 
> here with the topdown layout you'd get a malloc 'failure'.

Just for completeness, Thomas Winischoffer tracked this down over the
weekend, I had stared at it previously to no great avail,

The issue was with the user space SiS Mesa driver having an
uninitialised structure on the stack for the copy command sent to the
DRM, with the old layout it would end up with zero'ed reserved fields
by luck most of the time, with the new one it went the other way..

the fix is now in Mesa CVS....

Dave.
