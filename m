Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTKHRqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTKHRqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:46:40 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:54534 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261901AbTKHRqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:46:38 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Denis <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: 2.6-test6: nanosleep+SIGCONT weirdness
Date: Sat, 8 Nov 2003 19:46:28 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200311081946.28808.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I observe some strange behaviour in 2.6-test6 with this small program:

n.c
===
#include <sys/time.h>
#include <errno.h>
int main(int argc, char* argv[]) {
    struct timespec t = { 5000,0};
    while(nanosleep(&t,&t)<0) {
        puts("Yeah");
        if(errno!=EINTR) break;
    }
    return 0;
}

In 2.4 stracing it while doing killall -CONT ./n works fine:

# strace ./n
execve("./n", ["./n", "5000"], [/* 23 vars */]) = 0
nanosleep({5000, 0}, 0xbffffd54)        = -1 EINTR (Interrupted system 
call)
--- SIGCONT (Continued) ---
write(1, "Yeah", 4Yeah)                     = 4
write(1, "\n", 1
)                       = 1
nanosleep({4994, 730000000}, 0xbffffd54) = -1 EINTR (Interrupted system 
call)
--- SIGCONT (Continued) ---
write(1, "Yeah", 4Yeah)                     = 4
write(1, "\n", 1
)                       = 1
nanosleep({4994, 280000000}, 0xbffffd54) = -1 EINTR (Interrupted system 
call)
--- SIGCONT (Continued) ---
write(1, "Yeah", 4Yeah)                     = 4
write(1, "\n", 1
)                       = 1
nanosleep({4993, 930000000}, 

But in 2.6 it does this:

# strace ./n
execve("./n", ["./n", "400"], [/* 26 vars */]) = 0
nanosleep({5000, 0}, 0xbffffc44)        = -1 ERRNO_516 (errno 516)
--- SIGCONT (Continued) ---
setup()                                 = -1 EFAULT (Bad address)
--- SIGCONT (Continued) ---
write(1, "Yeah", 4Yeah)                     = 4
write(1, "\n", 1
)                       = 1
_exit(0)                                = ?
-- 
vda
