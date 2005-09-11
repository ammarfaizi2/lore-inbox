Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbVIKVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVIKVsv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVIKVsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:48:51 -0400
Received: from fmr14.intel.com ([192.55.52.68]:27301 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750943AbVIKVsu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:48:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: new asm-offsets.h patch problems
Date: Sun, 11 Sep 2005 14:48:44 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E7E@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new asm-offsets.h patch problems
Thread-Index: AcW3GI11C1q0kNzFQCi7jX+pu4LXHAAAIMcQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Sep 2005 21:48:45.0195 (UTC) FILETIME=[954F1DB0:01C5B71A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>  $ cp arch/ia64/configs/bigsur_defconfig .config
>>  $ yes '' | make oldconfig
>
>You can just do:
>make bigsur_defconfig

I only recently found out about that ... but in some cases I still
want to do something like this as I want to make a small tweak from
some of the standard config files (e.g. delete CONFIG_SMP to do a UP
build based on some of the standard configs).

>
>>  $ make prepare
>> 
>> leaves me with an include/asm-ia64/asm-offsets.h that only has the
>> definition of IA64_TASK_SIZE at 0.
>
>I could reproduce this as well.
>Did you actually look at the output of the compile?

Uh, no.  I guess that would have helped me figure out what was happening.

>It looks like the more comprehensive dependency checking hits you now.
>What happens is that the compilation of asm-offsets.c fails due to
>consistency checks in a few places.
>
>First we have in page.h:
>#error Unsupported page size!
>Because CONFIG_IA64_PAGE_SIZE_4KB (8KB, 16KB, 32KB) is not defined.

Ugh.

>Then next we have in same file:
>include/asm/page.h:162: error: `PAGE_SHIFT' undeclared
>That's because CONFIG__HUGETLB_PAGE is set

Presumably more follow-on from not defining any of the PAGE_SIZE
configs.

>etc etc.
>
>The only real fix is to fix the dependencies or provide
>enough defines in your hack.

More ugh.

>I wonder why so many errors occurs with ia64 but not others.
>Do you have a much different .h files layout?

Apparently we do.

>To give you an indication that this is not mission impossible
>I played a bit with the invloved .h files.
  ...
>And since the header files did compile in my case I would say that
>most if not all of the includes are wrong.

Agreed.

>A .h file shall be selfcontained, but not a convinient placeholder
>for including a lot of .h files.
>
>It still leaves of with the original offending IA64_TASK_SIZE,
>but grep did no tell me where task_struct was defined??

It is in include/linux/sched.h

>So I could not try to give that one  spin.
>
>PS. the include of sigframe.h in asm-offsets.c is bad. Please do:
>#include "sigframe.h"

Will fix ... while I'm trying to unravel all the rest of this.

Thanks for all the pointers.

-Tony
