Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTEMNyW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTEMNyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:54:22 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:52494 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261241AbTEMNyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:54:10 -0400
Message-ID: <3EC0FB9E.8030305@aitel.hist.no>
Date: Tue, 13 May 2003 16:05:18 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, alexh@ihatent.com
Subject: [PATCH] Re: 2.5.69-mm4 undefined active_load_balance
References: <20030512225504.4baca409.akpm@digeo.com>	<87vfwf8h2n.fsf@lapper.ihatent.com>	<20030513001135.2395860a.akpm@digeo.com>	<87n0hr8edh.fsf@lapper.ihatent.com>	<20030513085525.GA7730@hh.idb.hist.no> <20030513020414.5ca41817.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> 
>>>: undefined reference to `active_load_balance'
>>
>> I got this one too
> 
> 
> I don't think so.  Please do a `make clean' and try again.
> 
You don't think so?  How come?
Note that this was a clean install, I unpacked
the 2.5.69 tarball, applied 2.5.69-mm3, copied a
.config file, and ran "make oldconfig; make bzImage"

I tried make clean, and still get
kernel/built-in.o(.text+0x102a): In function `schedule':
: undefined reference to `active_load_balance'
drivers/built-in.o(.text+0x7d534): In function `fb_prepare_logo':
: undefined reference to `find_logo'
make: *** [.tmp_vmlinux1] Error 1

During compile, I got a warning that active_load_balance
was implicitly declared or some such.

Looking at sched.c I see that
active_load_balance is declared if  CONFIG_SHARE_RUNQUEUE
is not set.

Later, if we have CONFIG_SMP _and_ CONFIG_SHARE_RUNQUEUE
we get a longer version of active_load_balance

So, active_load_balance doesn't exist if
CONFIG_SHARE_RUNQUEUE is set on a non-smp machine.

but schedule() later do a call to active_load_balance
that isn't masked by any #ifdef.  This machine isn't SMP,
and CONFIG_SHARE_RUNQUEUE gets set - so it goes wrong.

The problem seems to be in sched.h, which says:
/*
  * Is there a way to do this via Kconfig?
  */
#ifdef CONFIG_NR_SIBLINGS_2
# define CONFIG_NR_SIBLINGS 2
#elif defined(CONFIG_NR_SIBLINGS_4)
# define CONFIG_NR_SIBLINGS 4
#else
# define CONFIG_NR_SIBLINGS 0
#endif

#ifdef CONFIG_NR_SIBLINGS
# define CONFIG_SHARE_RUNQUEUE 1
#else
# define CONFIG_SHARE_RUNQUEUE 0
#endif

I get
# define CONFIG_NR_SIBLINGS 0
and the #ifdef CONFIG_NR_SIBLINGS
test triggers because something #defined
to 0 is #defined.  I guess this is the problem,
and if so, changing the #ifdef CONFIG_NR_SIBLINGS
to #if CONFIG_NR_SIBLINGS should do the trick.

A patch for this is at the end of the message.

> 
>>, as well as:
>> drivers/built-in.o(.text+0x7d534): In function `fb_prepare_logo':
>> : undefined reference to `find_logo'
> 
> 
> Is that thing _still_ there?
> 
> Does this fix?
[...]
Yes, thanks!

Patch for the active_load_balance problem.
It is not yet tested, it is compiling right now
and that takes time.

Helge Hafting

--- sched.h.orig        2003-05-13 15:45:17.000000000 +0200
+++ sched.h     2003-05-13 15:45:43.000000000 +0200
@@ -158,7 +158,7 @@
  # define CONFIG_NR_SIBLINGS 0
  #endif

-#ifdef CONFIG_NR_SIBLINGS
+#if CONFIG_NR_SIBLINGS
  # define CONFIG_SHARE_RUNQUEUE 1
  #else
  # define CONFIG_SHARE_RUNQUEUE 0


