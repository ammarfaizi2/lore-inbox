Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbSJJSZS>; Thu, 10 Oct 2002 14:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbSJJSZS>; Thu, 10 Oct 2002 14:25:18 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:59917 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261744AbSJJSZO>;
	Thu, 10 Oct 2002 14:25:14 -0400
Date: Thu, 10 Oct 2002 11:26:52 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [BK PATCH] i386 timer changes for 2.5.41
Message-ID: <20021010182652.GA25871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've taken the i386 timer.c patches that John Stultz has been working on
for a while, made some minor tweaks, added them to a bk tree, and tested
them on all the boxes that I have access too.  Here's the resulting
changesets:

Please pull from bk://lsm.bkbits.net/timer-2.5

These split up the time.c code to handle different interrupt time
sources, moving the code into a new arck/i386/kernel/timers directory.
This is going to get more important as new timer sources become
available (like IBM's Summit chipset), and removes a lot of #ifdefs from
the existing code.

The differences from John's last patches are:
	- use bk to show the history of the time.c file moves
	- added proper documentation for struct timer_opts
	- init() in timer_opts now returns 0 for success
	- timer array is now static, and NULL terminated to make
	  adding new sources an easier patch.

thanks,

greg k-h

 arch/i386/Makefile                  |    2 
 arch/i386/kernel/time.c             |  374 -----------------------------------
 arch/i386/kernel/timers/Makefile    |   10 
 arch/i386/kernel/timers/timer.c     |   39 +++
 arch/i386/kernel/timers/timer_pit.c |  132 ++++++++++++
 arch/i386/kernel/timers/timer_tsc.c |  382 +++++++++++++++++++++++++++++++-----
 include/asm-i386/timer.h            |   22 ++
 7 files changed, 538 insertions(+), 423 deletions(-)
-----

ChangeSet@1.751, 2002-10-10 01:10:45-07:00, johnstul@us.ibm.com
  i386 timer core: intergrate the new timer code to use the two different timer files.

 arch/i386/Makefile                  |    2 
 arch/i386/kernel/time.c             |   23 ++----
 arch/i386/kernel/timers/Makefile    |   10 +++
 arch/i386/kernel/timers/timer.c     |    8 +-
 arch/i386/kernel/timers/timer_pit.c |   35 +++++++++-
 arch/i386/kernel/timers/timer_tsc.c |  120 ++++++++++++++++++++----------------
 include/asm-i386/timer.h            |    2 
 7 files changed, 128 insertions(+), 72 deletions(-)
------

ChangeSet@1.750, 2002-10-10 00:08:03-07:00, johnstul@us.ibm.com
  i386 timer core: move code out of time.c into timers/timer_pit.c and timers/timer_tsc.c

 arch/i386/kernel/time.c             |  351 ------------------------------------
 arch/i386/kernel/timers/timer_pit.c |   97 +++++++++
 arch/i386/kernel/timers/timer_tsc.c |  262 ++++++++++++++++++++++++++
 3 files changed, 359 insertions(+), 351 deletions(-)
------

ChangeSet@1.749, 2002-10-09 23:57:56-07:00, johnstul@us.ibm.com
  i386 timer core: introduce struct timer_ops
  
  provides the infrastructure needed via the timer_ops structure, 
  as well as the select_timer() function for choosing the best 
  available timer

 arch/i386/kernel/timers/timer.c |   31 +++++++++++++++++++++++++++++++
 include/asm-i386/timer.h        |   20 ++++++++++++++++++++
 2 files changed, 51 insertions(+)
------

