Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263642AbUEGPzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUEGPzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUEGPyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:54:40 -0400
Received: from outgoingmail.adic.com ([63.81.117.28]:29115 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263642AbUEGPxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:53:39 -0400
Message-ID: <409BAFAC.70601@xfs.org>
Date: Fri, 07 May 2004 10:47:56 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Arjan van de Ven <arjanv@redhat.com>, Paul Jakma <paul@clubi.ie>,
       Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org> <20040507065105.GA10600@devserv.devel.redhat.com> <20040507151317.GA15823@redhat.com>
In-Reply-To: <20040507151317.GA15823@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, May 07, 2004 at 08:51:05AM +0200, Arjan van de Ven wrote:
>  > 
>  > On Fri, May 07, 2004 at 01:37:54AM +0100, Paul Jakma wrote:
>  > > On Thu, 6 May 2004, Arjan van de Ven wrote:
>  > > 
>  > > > Ok I don't want to start a flamewar but... Do we want to hold linux
>  > > > back until all binary only module vendors have caught up ??
>  > > 
>  > > What about normal linux modules though? Eg, NFS (most likely):
>  > > 
>  > > 	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121804
>  > 
>  > NFSv4 has a > 1Kb stack user; Dave Jones has a fix pending for that...
> 
> Hmm, this one maybe?
>  
> 		Dave
> 

>  
> -	if (mlen > sizeof(buf))
> +	obj.data = kmalloc(1024, GFP_KERNEL);
> +	if (!obj.data)
> +		return -ENOMEM;
> +
> +	if (mlen > 1024) {

That's what I hate about all of this, just think how much stack that
kmalloc can take in low memory situations.... it might end up in
writepage on another nfs file.... Moving stuff off the stack and
into kmalloc just reduces the possibility of stack overflow, it
does not fix the problem. Having memory reclaim take place inside
the thread which is waiting for memory makes that a pretty hard
problem to fix.

Steve
