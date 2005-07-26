Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVGZPNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVGZPNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVGZPND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:13:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:28432 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261844AbVGZPLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:11:48 -0400
Message-ID: <42E653B0.1000900@tmr.com>
Date: Tue, 26 Jul 2005 11:16:00 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>
Subject: Re: topology api confusion
References: <20050722213316.GE17865@otto> <42E55C7E.50301@us.ibm.com>
In-Reply-To: <42E55C7E.50301@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> Nathan Lynch wrote:
> 
>>We need some clarity on how asm-generic/topology.h is intended to be
>>used.  I suspect that it's supposed to be unconditionally included at
>>the end of the architecture's topology.h so that any elements which
>>are undefined by the arch have sensible default definitions.  Looking
>>at 2.6.13-rc3, this is what ppc64, ia64, and x86_64 currently do,
>>however i386 does not (i386 pulls in the generic version only when
>>!CONFIG_NUMA).
>>
>>The #ifndef guards around each element of the topology api
>>cannot serve their apparent intended purpose when the architecture
>>implements a given bit as a function instead of a macro
>>(e.g. cpu_to_node in ppc64):
> 
> 
> When I originally wrote this all up, I had planned it to be used the way
> i386 does: offer a full implementation of topology if appropriate, else
> include the generic "sane" default.  It has since changed to work more like
> you described: implement some (or all) of the topology functions, then
> include the generic one to define any you missed.
> 
> 
> 
>>Since ppc64 unconditionally includes asm-generic/topology.h, all uses
>>of cpu_to_node are preprocessed to (0).  Similar damage occurs with
>>every other topology function which happens to be a real function
>>instead of a macro.  I'm surprised my ppc64 numa systems even boot ;)
>>
>>If the intent is that the architecture is free to define only a subset
>>of the api and include the generic header for fallback definitions,
>>then we need to do the #ifndef __HAVE_ARCH_FOO thing, no?  That is,
>>the code above would look like:
> 
> 
> You are correct in noticing that things should (though apparently don't?)
> go wonky when arches define their topology functions as *functions*, rather
> than macros.  It hasn't really seemed to bite anyone yet, so I've left it
> alone, though to be honest, it is as surprising to me that it works as it
> is to you.  I've resisted creating #ifdef ARCH_HAVE_XXX all over the place,
> though maybe it is finally time?

If I understand the problem, is it amenable to just defining the macros 
and using another name for a function? In other words, if most arch 
define xx_generic_add as a function, can you just
  #define xx_generic_add xx_local_arch_add
which would satisfy the #ifndef, allow use of a function, etc? Then 
xx_local_arch_add can be the function. Then the common include would not 
generate macros for things which exist as function.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
