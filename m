Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVIKVeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVIKVeM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVIKVeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:34:12 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:12059 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750925AbVIKVeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:34:10 -0400
Date: Sun, 11 Sep 2005 23:36:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new asm-offsets.h patch problems
Message-ID: <20050911213603.GA31190@mars.ravnborg.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E70@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E70@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 01:39:07PM -0700, Luck, Tony wrote:
> 
> >I'll try it.  Hunk#2 of the change to Makefile didn't apply with
> >patch ... I had to apply it by hand.
> 
> Either I goofed on the hand application of this patch, or it isn't
> working.  Curious thing is that it works with some config files, but
> not with others.  When I first reported this problem, all my builds
> had worked except for the sn2_defconfig one.  With this patch applied
> I'm seeing bigsur_defconfig fail quite regularly.
> 
> E.g. this sequence (starting from a clean tree):
> 
>  $ cp arch/ia64/configs/bigsur_defconfig .config
>  $ yes '' | make oldconfig

You can just do:
make bigsur_defconfig

>  $ make prepare
> 
> leaves me with an include/asm-ia64/asm-offsets.h that only has the
> definition of IA64_TASK_SIZE at 0.

I could reproduce this as well.
Did you actually look at the output of the compile?

It looks like the more comprehensive dependency checking hits you now.
What happens is that the compilation of asm-offsets.c fails due to
consistency checks in a few places.

First we have in page.h:
#error Unsupported page size!
Because CONFIG_IA64_PAGE_SIZE_4KB (8KB, 16KB, 32KB) is not defined.

Then next we have in same file:
include/asm/page.h:162: error: `PAGE_SHIFT' undeclared
That's because CONFIG__HUGETLB_PAGE is set

etc etc.

The only real fix is to fix the dependencies or provide
enough defines in your hack.

I wonder why so many errors occurs with ia64 but not others.
Do you have a much different .h files layout?

To give you an indication that this is not mission impossible
I played a bit with the invloved .h files.

Following patch (cut'n'pasted) let bigsur + defconfig succeed
a make prepare.

diff --git a/arch/ia64/kernel/asm-offsets.c
b/arch/ia64/kernel/asm-offsets.c
--- a/arch/ia64/kernel/asm-offsets.c
+++ b/arch/ia64/kernel/asm-offsets.c
@@ -8,10 +8,6 @@

 #include <linux/sched.h>

-#include <asm-ia64/processor.h>
-#include <asm-ia64/ptrace.h>
-#include <asm-ia64/siginfo.h>
-#include <asm-ia64/sigcontext.h>
 #include <asm-ia64/mca.h>

 #include "../kernel/sigframe.h"
 diff --git a/include/asm-ia64/mca.h b/include/asm-ia64/mca.h
 --- a/include/asm-ia64/mca.h
 +++ b/include/asm-ia64/mca.h
 @@ -15,12 +15,6 @@

 #if !defined(__ASSEMBLY__)

-#include <linux/interrupt.h>
-#include <linux/types.h>
-
-#include <asm/param.h>
-#include <asm/sal.h>
-#include <asm/processor.h>
 #include <asm/mca_asm.h>

     
And since the header files did compile in my case I would say that
most if not all of the includes are wrong.
A .h file shall be selfcontained, but not a convinient placeholder
for including a lot of .h files.

It still leaves of with the original offending IA64_TASK_SIZE,
but grep did no tell me where task_struct was defined??
So I could not try to give that one  spin.

PS. the include of sigframe.h in asm-offsets.c is bad. Please do:
#include "sigframe.h"

	Sam
