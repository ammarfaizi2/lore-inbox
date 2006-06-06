Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWFFU1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWFFU1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 16:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWFFU1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 16:27:45 -0400
Received: from khc.piap.pl ([195.187.100.11]:49925 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751074AbWFFU1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 16:27:44 -0400
To: Paul Fulghum <paulkf@microgate.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 06 Jun 2006 22:27:40 +0200
In-Reply-To: <1149622813.11929.3.camel@amdx2.microgate.com> (Paul Fulghum's message of "Tue, 06 Jun 2006 14:40:13 -0500")
Message-ID: <m3u06yc9mr.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> writes:

> +++ b/drivers/net/wan/Makefile	2006-06-06 14:08:53.000000000 -0500
> @@ -9,14 +9,18 @@ cyclomx-y                       := cycx_
>  cyclomx-$(CONFIG_CYCLOMX_X25)	+= cycx_x25.o
>  cyclomx-objs			:= $(cyclomx-y)  
>  
> -hdlc-y				:= hdlc_generic.o
> +hdlc-$(CONFIG_HDLC)		:= hdlc_generic.o
>  hdlc-$(CONFIG_HDLC_RAW)		+= hdlc_raw.o
>  hdlc-$(CONFIG_HDLC_RAW_ETH)	+= hdlc_raw_eth.o
>  hdlc-$(CONFIG_HDLC_CISCO)	+= hdlc_cisco.o
>  hdlc-$(CONFIG_HDLC_FR)		+= hdlc_fr.o
>  hdlc-$(CONFIG_HDLC_PPP)		+= hdlc_ppp.o
>  hdlc-$(CONFIG_HDLC_X25)		+= hdlc_x25.o
> -hdlc-objs			:= $(hdlc-y)
> +ifeq ($(CONFIG_HDLC),y)
> +  hdlc-objs			:= $(hdlc-y)
> +else
> +  hdlc-objs			:= $(hdlc-m)
> +endif

How could that work? If CONFIG_HDLC=m and CONFIG_HDLC_*=y it would read:

hdlc-m := hdlc_generic.o
hdlc-y := hdlc_{raw,raw_eth,cisco,fr,ppp,x25}.o
hdlc-objs := $(hdlc-m)

CONFIG_HDLC is 3-state and CONFIG_HDLC_* are simple bools, everything
makes a single module.

Not sure what missing symbols do you experience (never had synclink
adapter) but almost certainly it's when generic HDLC is not selected
(or is 'm' while synclink is 'y') and it's not related to the Makefile
(i.e., while I don't exactly like the rest of the patch as I think
enabling gHDLC should enable hw drivers - like with other drivers -
it would probably work).
-- 
Krzysztof Halasa
