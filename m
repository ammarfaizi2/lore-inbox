Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbUBZK53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 05:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUBZK4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 05:56:53 -0500
Received: from mail503.nifty.com ([202.248.37.211]:65021 "EHLO
	mail503.nifty.com") by vger.kernel.org with ESMTP id S262768AbUBZK4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 05:56:48 -0500
To: linux-kernel@vger.kernel.org
Subject: How to emulate 'chroot /jail/ su httpd -c' ?
From: Tetsuo Handa <a5497108@anet.ne.jp>
Message-Id: <200402261956.BEF40183.2B918856@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43 (on Trial)]
X-Accept-Language: ja,en
Date: Thu, 26 Feb 2004 19:56:40 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for querying userland program in this list.

I have the following line in /etc/rc.d/init.d/httpd

daemon chroot /jail/ su httpd -c $httpd $OPTIONS

This needs /bin/su after /usr/sbin/chroot, but I don't
want to place /bin/su (and related files) in the jail.
So, I want to do this with one program.

But, the problem is... there are so many 'set*id()'
system calls and their behavior are slightly differ.
I'm not sure how to emulate 'chroot /jail/ su httpd -c'.
The following is the code I wrote, but is this equivalent?
(I want Apache never re-gain root privilege unless
executing setuid-root program.)

--- Is this a correct code to 'chroot /jail/ su httpd -c' ?---

#include <stdio.h>
#include <pwd.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    struct passwd *pw = getpwnam("httpd");
    if (!pw) return 1;
    if (chroot("/jail/") || chdir("/") || setuid(pw->pw_uid) || setgid(pw->pw_gid)) return 1;
    printf("OK\n"); // Now call execvl() to run Apache.
    return 0;
}

---

Kernel version is 2.4.25.
No need to worry for listening port 80,
I'm using iptables to redirect port 80 to 8000
and Apache doesn't need root privilege from the beginning.


Regards...

                  PANDA   (a5497108 at anet.ne.jp)
