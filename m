Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWJMSAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWJMSAq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWJMSAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:00:46 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:25386 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751772AbWJMSAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:00:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EL6tROmO46SBD1FbbZXNEPoO5Gf3FmFiMwm1lKSK3nf87DFEVXFcluGNqLQ5ScyVl+UxcfAZDgXNP40UAcJXuVPxiL747pDM0feHVlxdENBYsaJnIhvjcCcIZ3XDJo6Dw95NfKJnvKVIowgdilWw+7CViH39H+QgpkPgrUxtRnA=
Date: Sat, 14 Oct 2006 03:00:39 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch 7/7] stacktrace filtering for fault-injection capabilities
Message-ID: <20061013180039.GD29079@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ak@suse.de, Don Mullis <dwm@meer.net>, Valdis.Kletnieks@vt.edu
References: <20061012074305.047696736@gmail.com> <452df23e.44ca1e09.1a7f.780f@mx.google.com> <20061012142004.a111ca6a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012142004.a111ca6a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:20:04PM -0700, Andrew Morton wrote:

> I read the documentation but I still don't understand this feature.  What
> does the stacktrace actually do?  It gets stored somewhere and displayed
> later?  What's it all for?

For example someone may want to inject kmalloc()/kmem_cache_alloc()
failures into only e100 module. they want to inject not only direct
kmalloc() call, but also indirect allocation, too.

- e100_poll --> netif_receive_skb --> packet_rcv_spkt --> skb_clone
  --> kmem_cache_alloc

This patch enables to detect function calls like this by stacktrace
and inject failures. The script
Documentaion/fault-injection/failmodule.sh
helps it.

The range of text section of loaded e100 is expected to be
[/sys/module/e100/sections/.text, /sys/module/e100/sections/.exit.text)

So failmodule.sh stores these values into /debug/failslab/address-start
and /debug/failslab/address-end.

> > --- work-fault-inject.orig/lib/Kconfig.debug
> > +++ work-fault-inject/lib/Kconfig.debug
> > @@ -472,6 +472,8 @@ config LKDTM
> >  
> >  config FAULT_INJECTION
> >  	bool
> > +	select STACKTRACE
> > +	select FRAME_POINTER
> >  
> >  config FAILSLAB
> >  	bool "fault-injection capabilitiy for kmalloc"
> > 
> 
> Is the selection of FRAME_POINTER really needed?  The fancy new unwinder
> is supposed to be able to handle frame-pointerless unwinding?

As I wrote in another reply, There are two type of implementation of
this stacktrace filter.

- using STACKTRACE + FRAME_POINTER
- using new unwinder (STACK_UNWIND)

The stacktrace with using new unwinder without FRAME_POINTER is much
slower than STACKTRACE + FRAME_POINTER.

