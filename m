Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTIYJqp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 05:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbTIYJqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 05:46:45 -0400
Received: from mail2.uu.nl ([131.211.16.76]:60045 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S261777AbTIYJqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 05:46:42 -0400
Subject: linux/time.h annoyance
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064483200.6405.442.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 11:48:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm annoyed by something in linux/time.h. The issue is as follows:

-
#include <sys/time.h>
#include <linux/time.h>
int main () { return 0; }
-

... compile with -Wall -Werror, and you'll get ...

-
In file included from test.c:2:
/usr/include/linux/time.h:9: redefinition of `struct timespec'
/usr/include/linux/time.h:88: redefinition of `struct timeval'
/usr/include/linux/time.h:93: redefinition of `struct timezone'
/usr/include/linux/time.h:124: redefinition of `struct itimerval'
-

... and the compile fails. In 2.6.x, there'll be some additional
warnings ...

-
In file included from test.c:2:
/usr/src/linux-2.6.0-test4/include/linux/time.h:9: redefinition of
`struct timespec'
/usr/src/linux-2.6.0-test4/include/linux/time.h:15: redefinition of
`struct timeval'
/usr/src/linux-2.6.0-test4/include/linux/time.h:20: redefinition of
`struct timezone'
In file included from test.c:2:
/usr/src/linux-2.6.0-test4/include/linux/time.h:341:1: "FD_SET"
redefined
In file included from /usr/include/sys/time.h:31,
                 from test.c:1:
/usr/include/sys/select.h:93:1: this is the location of the previous
definition
In file included from test.c:2:
/usr/src/linux-2.6.0-test4/include/linux/time.h:342:1: "FD_CLR"
redefined
In file included from /usr/include/sys/time.h:31,
                 from test.c:1:
/usr/include/sys/select.h:94:1: this is the location of the previous
definition
In file included from test.c:2:
/usr/src/linux-2.6.0-test4/include/linux/time.h:343:1: "FD_ISSET"
redefined
In file included from /usr/include/sys/time.h:31,
                 from test.c:1:
/usr/include/sys/select.h:95:1: this is the location of the previous
definition
In file included from test.c:2:
/usr/src/linux-2.6.0-test4/include/linux/time.h:344:1: "FD_ZERO"
redefined
In file included from /usr/include/sys/time.h:31,
                 from test.c:1:
/usr/include/sys/select.h:96:1: this is the location of the previous
definition
In file included from test.c:2:
/usr/src/linux-2.6.0-test4/include/linux/time.h:350:1: "ITIMER_REAL"
redefined
In file included from test.c:1:
/usr/include/sys/time.h:96:1: this is the location of the previous
definition
In file included from test.c:2:
/usr/src/linux-2.6.0-test4/include/linux/time.h:351:1: "ITIMER_VIRTUAL"
redefined
In file included from test.c:1:
/usr/include/sys/time.h:99:1: this is the location of the previous
definition
In file included from test.c:2:
/usr/src/linux-2.6.0-test4/include/linux/time.h:352:1: "ITIMER_PROF"
redefined
In file included from test.c:1:
/usr/include/sys/time.h:103:1: this is the location of the previous
definition
/usr/src/linux-2.6.0-test4/include/linux/time.h:359: redefinition of
`struct itimerval'
-

... and it still fails.

This is an issue in various ways. Most importantly, several linux kernel
headers that are not found in sys/ or for which sys/ is simply a
boilerplate-code-include (such as sys/soundcard.h) include linux/time.h
themselves (example: linux/videodev2.h). Also, many userspace tools
include sys/time.h automatically (example: glib2). Consequently, without
using ugly hacks, such as #define _LINUX_TIME_H 1 before including
glib.h and linux/videodev2.h, I cannot make a gnome2 video application
that will compile properly with -Wall -Werror. And that sucks.

sys/time.h & related headers seems to have a few macros to check for
struct definitions for each of the above-mentioned. I'm not sure how
official any of this is, but the fix for the first two of the warnings
seems very simple: add the same macro checks to linux/time.h. For struct
timespec, this is __timespec_defined. For struct timeval, this is
_STRUCT_TIMEVAL. Amusingly, linux/time.h uses _STRUCT_TIMESPEC for the
first. Code would look like:

#ifndef macro
#define macro
struct foo {
  int bar;
}
#endif /* macro */

The third and fourth warning (timezone/itimerval) are harder, because
sys/time.h & co don't have macros to check for redifinitions here. Does
anyone have suggestions on how to fix those two? Perhaps a check to see
whether time.h or sys/time.h was already included before defining the
structs (although that would still break if you reverse the order of
including those files, i.e. first #include linux/time.h and then
sys/time.h)?
For the 2.6.x-only warnings (FD_CLR etc.), these are all macro's and
could thus simply be checked by doing a "#ifndef ... #define ... #endif
/* ... */" for each of the ones that give a warning.

If wanted, I can provide a patch to fix parts of this, but this is so
simple that it shouldn't be needed for me to send one. Besides, I'm not
sure whether my proposed fixes are the right ones.

Thanks,

Ronald
(please CC me, I'm not subscribed)

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

