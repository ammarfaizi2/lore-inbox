Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTGHQvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbTGHQvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:51:50 -0400
Received: from www.13thfloor.at ([212.16.59.250]:56198 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S264917AbTGHQvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:51:47 -0400
Date: Tue, 8 Jul 2003 19:06:28 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, hannal@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Fastwalk: reduce cacheline bouncing of d_count (Changelog@1.1024.1.11)
Message-ID: <20030708170628.GA13593@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, hannal@us.ibm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux FSdevel <linux-fsdevel@vger.kernel.org>
References: <16138.53118.777914.828030@charged.uio.no> <1057673804.4357.27.camel@dhcp22.swansea.linux.org.uk> <16138.56467.342593.715679@charged.uio.no> <1057677613.4358.33.camel@dhcp22.swansea.linux.org.uk> <20030708164426.GB10004@www.13thfloor.at> <1057683213.5228.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1057683213.5228.3.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 05:53:34PM +0100, Alan Cox wrote:
> On Maw, 2003-07-08 at 17:44, Herbert Poetzl wrote:
> > > Its no big problem to me since I can just back it out of -ac
> > 
> > just curious, because I use this patch since early 2.4.20,
> > are there any reasons to 'back it out of -ac' for you?
> > 
> > anyway I totally agree that the NFS issue pointed out by 
> > Trond should be addressed ...
> 
> Its high risk, its got bugs as Trond already showed and it only
> helps performance on giant SMP boxes. Its all risk and no
> reward. Quota updates get you working 32bit uid quota and
> the interactivity stuff helps all even tho its got some
> risk.

every change (if it's not a bugfix, and even those) bear
a risk, what I like about the fastwalk patch is not the
performance gain on giant SMP boxes, because I do not have
any (unfortunately ;) but the code change from ...

        if (path_init(pathname,  LOOKUP_PARENT, &nd))
                error = path_walk(pathname, &nd);

to
        error = path_lookup(pathname,  LOOKUP_PARENT, &nd);


and

        dentry = cached_lookup(nd->dentry, &this, 0);
        if (!dentry) {
                dentry = real_lookup(nd->dentry, &this, 0);
                err = PTR_ERR(dentry);
                if (IS_ERR(dentry))
                         break;
        }

to
	err = do_lookup(nd, &this, &next, &pinned, 0);


which (at least for me) is more read-/understandable ...

anyway, thanks for you answer,
Herbert

