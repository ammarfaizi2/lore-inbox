Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWHBJBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWHBJBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 05:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWHBJBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 05:01:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55721 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750723AbWHBJBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 05:01:23 -0400
Date: Wed, 2 Aug 2006 11:01:22 +0200
From: Jan Blunck <jblunck@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] fix vmstat per cpu usage
Message-ID: <20060802090122.GN4995@hasse.suse.de>
References: <20060801173620.GM4995@hasse.suse.de> <20060801140707.a55a0513.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801140707.a55a0513.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, Andrew Morton wrote:

> >  
> >  static inline void __count_vm_event(enum vm_event_item item)
> >  {
> > -	__get_cpu_var(vm_event_states.event[item])++;
> > +	__get_cpu_var(vm_event_states).event[item]++;
> >  }
> 
> How odd.  Are there any negative consequences to the existing code?

In asm-s390/percpu.h we use

 #define __get_cpu_var(var) __reloc_hide(var,S390_lowcore.percpu_offset)

and for modules on s390x __reloc_hide() is defined as

 #define __reloc_hide(var,offset) \
   (*({ unsigned long *__ptr; \
        asm ( "larl %0,per_cpu__"#var"@GOTENT" \
              : "=a" (__ptr) : "X" (per_cpu__##var) ); \
        (typeof(&per_cpu__##var))((*__ptr) + (offset)); }))

which leads in this case to

 larl %0, per_cpu__vm_event_states.event[item]@GOTENT

which is invalid asm.
