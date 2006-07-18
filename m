Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWGRWz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWGRWz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGRWz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:55:58 -0400
Received: from gw.goop.org ([64.81.55.164]:54711 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932397AbWGRWz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:55:57 -0400
Message-ID: <44BD478C.9040509@goop.org>
Date: Tue, 18 Jul 2006 13:41:48 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Arjan van de Ven <arjan@infradead.org>, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, ak@suse.de, rusty@rustcorp.com.au,
       zach@vmware.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 05/33] Makefile support to build Xen subarch
References: <20060718091807.467468000@sous-sol.org>	<20060718091949.842251000@sous-sol.org>	<1153216813.3038.22.camel@laptopd505.fenrus.org> <20060718044007.74324d93.akpm@osdl.org>
In-Reply-To: <20060718044007.74324d93.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> @@ -99,6 +103,7 @@ drivers-$(CONFIG_PM)			+= arch/i386/powe
>  
>  CFLAGS += $(mflags-y)
>  AFLAGS += $(mflags-y)
> +CPPFLAGS += $(mflags-y)
>
> This change affects _all_ subarchitectures (by potentially altering their
> CPPFLAGS) and it's rather a mystery why one subarch needs the -Ifoo in its
> CPPFLAGS whereas all the others do not.
>   

The reason is that arch-i386/kernel/vmlinux.lds.S is run through CPP, 
and it includes asm/thread_info.h and asm/page.h, which end up including 
"mach_page.h" (which this patch series introduces).  There is a version 
in both mach-default/mach_page.h and mach-xen/mach_page.h, so the -I is 
necessary for non-Xen sub-arches as well. 

I guess the conservative approach would be to only add this -I for the 
vmlinux.lds target, assuming there are no later compile problems.  On 
the flip-side, would you want C and Asm code getting a different set of 
includes from "manually" preprocessed-files?  I would think you'd want 
either defines/includes at all, or to have them identical.

The CPPFLAGS assignment also appears to make the previous two lines 
redundant, since a_flags and c_flags (which is what actually gets used 
for compilation) end up having CPPFLAGS incorporated into them.

    J

