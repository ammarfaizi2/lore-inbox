Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269276AbRGaMWt>; Tue, 31 Jul 2001 08:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269275AbRGaMWj>; Tue, 31 Jul 2001 08:22:39 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:51979 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269272AbRGaMW0>; Tue, 31 Jul 2001 08:22:26 -0400
Message-ID: <3B66A305.E1A17E3A@namesys.com>
Date: Tue, 31 Jul 2001 16:22:29 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Rik van Riel <riel@conectiva.com.br>, Christoph Hellwig <hch@caldera.de>,
        linux-kernel@vger.kernel.org, Vitaly Fertman <vitaly@namesys.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption (patch to cause redhat to unmount 
 reiserfs on halt included)
In-Reply-To: <Pine.LNX.4.33L.0107301858350.5582-100000@duckman.distro.conectiva> <3B65E0FE.CC84FF98@namesys.com> <20010731133443.N9244@khan.acc.umu.se>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

David Weinehall wrote:

> > Every major kernel component should have a #define which if on checks
> > every imaginable thing the developer can think of to check regardless
> > of how slow it makes the code go to check it.  Then, when users (or at
> > least as usefully, developers adding a new feature) have bugs in that
> > component, they can turn it on.
> 
> Ugh! I think you need to have a little chat with Linus about this
> opinion of yours on how to use #ifdef / #endif in code... I'm not all
> that sure he'll agree with you.

I didn't say he would agree with me, in fact I am sure he doesn't alike
assertions in the code.  I merely said it should be done.:-)  As a final little
quibble, let me mention that nikita has created macros that neatly hide the
#ifdefs, and sent them out for testing.

We will consider pulling all but the essential assertions out of ReiserFS. 
Sigh.  This is the difference between engineering, and marketing.  As an
engineer, I said overengineer the checks so that our testing process will catch
more things, and then #define them out so that there is no performance cost. 
Perfectly logical.  Then along come the distros, and they turn on debugging,
they don't tell the users that debugging is on, and users think we are slower
than other filesystems when we are just configured exactly as we tell the users
not to configure us, sigh.

I'll try simply ensuring that users are warned that debugging is on first.  Of
course, with the way syslog is usually misconfigured on most distros we'll have
to be careful to ensure that they ever see the messages....  Should I ask
whether, with ReiserFS debugging on, and the default syslog.conf, the assertions
being checked for on these particular distros ever reach the users?  Better I
not ask....?

If Chris wants to run ReiserFS with the checks on, fine, he is a user, and he at
least knows he is doing it, but when a distro does it without warning users the
FS is crippled it is really foul.

Well, if any of you users out there are interested in knowing practical details
of how to overcome the shovelware, even more important than recompiling your
kernel, these patches will help.  Note the cute patch that causes reiserfs to
get unmounted rather than unpowered by these folks so concerned about corruption
of data.:-O  I am merely passing these patches onwards, I have not verified that
they are correct (because I lack a redhat machine to test on).  If RedHat could
confirm that the patch is correct it would be nice, and mindboggling as well.

Vitaly, make sure these are on our website.

>From Dustin Byford:

--- rc.sysinit.orig     Mon Jul 30 22:58:45 2001
+++ rc.sysinit  Mon Jul 30 22:57:16 2001
@@ -211,7 +211,8 @@

  _RUN_QUOTACHECK=0
  ROOTFSTYPE=`grep " / " /proc/mounts | awk '{ print $3 }'`
-if [ -z "$fastboot" -a "$ROOTFSTYPE" != "nfs" ]; then
+if [ -z "$fastboot" -a "$ROOTFSTYPE" != "nfs" \
+                    -a "$ROOTFSTYPE" != "reiserfs" ]; then

          STRING=$"Checking root filesystem"
         echo $STRING

>From David Rees:

--- halt.orig   Mon Jul 30 17:26:24 2001
+++ halt        Mon Jul 30 17:26:36 2001
@@ -165,7 +165,7 @@
 
 # Remount read only anything that's left mounted.
 #echo $"Remounting remaining filesystems (if any) readonly"
-mount | awk '/ext2/ { print $3 }' | while read line; do
+mount | awk '/ext2|reiserfs/ { print $3 }' | while read line; do
     mount -n -o ro,remount $line
 done
