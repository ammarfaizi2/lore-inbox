Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUC2FYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 00:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUC2FYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 00:24:36 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:26892 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262661AbUC2FYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 00:24:32 -0500
Date: Mon, 29 Mar 2004 07:22:38 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Len Brown <len.brown@intel.com>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Message-ID: <20040329052238.GD1276@alpha.home.local>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <1080535754.16221.188.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080535754.16221.188.camel@dhcppc4>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

On Sun, Mar 28, 2004 at 11:49:15PM -0500, Len Brown wrote:
 
> ACPI unconditionally used cmpxchg before this change also -- from asm().
> The asm() was broken, so we replaced it with C,
> which invokes the cmpxchg macro, which isn't defined for
> an 80386 build.
> 
> I guess it is a build bug that the assembler allowed us
> to invoke cmpxchg in an asm() for an 80386 build in earlier releases.
> 
> I'm open to suggestions on the right way to fix this.
> 
> 1. recommend CONFIG_ACPI=n for 80386 build.
> 
> 2. force CONFIG_ACPI=n for 80386 build.
> 
> 3. invoke cmpxchg from acpi even for 80386 build.
> 
> 4. re-implement locks for the 80386 case.

I like this one, but a simpler way : don't support SMP in this case, so that
we won't have to play with locks. This would lead to something like this :

#ifndef CONFIG_X86_CMPXCHG
#ifndef CONFIG_SMP
#define cmpxchg(lock,old,new) ((*lock == old) ? ((*lock = new), old) : (*lock))
#else
#define cmpxchg(lock,old,new) This_System_Is_Not_Supported
#endif
#endif

This code (if valid) might be added to asm-i386/system.h so that we don't
touch ACPI code.

Any comments ?

Willy

