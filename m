Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbTJABT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 21:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTJABT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 21:19:57 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:51849 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261828AbTJABTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 21:19:55 -0400
Subject: Re: Kernel includefile bug not fixed after a year :-(
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       schilling@fokus.fraunhofer.de
Content-Type: text/plain
Organization: 
Message-Id: <1064970349.736.14.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Sep 2003 21:05:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling writes:

>> Also Joerg, now that I have your attention: There is a bug
>> somewhere so that if I set the kernel HZ to 400, recompile
>> everything including `cdrecord`, I can no longer record a CD.
>> I think that somewhere, somebody is using a raw jiffie-count
>> instead of multiplying by HZ in the time-out code. I've check
>> through all the SCSI stuff, and I use SCSI disks exclusively.
>> I think something in your code needs fixing. This is for kernel
>> version 2.4.22
>
> Cdrecord and pther programs too includes <sys/param.h>

If that's a kernel header, you have a bug.

> If you change HZ in the kernel include files and recompile
> your problems suffer from the same sort of inconsistencies
> that have been the reason for my initial mail.
>
> If Linux likes to support changes to HZ, then it needs to
> support POSIX interfaces. On Solaris, sys/param.h looks this way:
>
> #define        HZ              ((clock_t)_sysconf(_SC_CLK_TCK))

On a Linux 2.4.xx system and above, you do this:

/////////////////////////////////////////////////////
#ifndef AT_CLKTCK
#define AT_CLKTCK       17    // frequency of times()
#endif

#define NOTE_NOT_FOUND 42

//extern char** environ;  // if _GNU_SOURCE not defined

// for ELF executables, notes are pushed before environment and args
// (Portable too! This even works on PA_RISC for some reason.)
static unsigned long find_elf_note(unsigned long findme){
  unsigned long *ep = (unsigned long *)environ;
  while(*ep++);
  while(*ep){
    if(ep[0]==findme) return ep[1];
    ep+=2;
  }
  return NOTE_NOT_FOUND;
}

// ...

Hertz = find_elf_note(AT_CLKTCK);

/////////////////////////////////////////////////////

Don't trust any _sysconf() junk. It's broken.

> You may even change HZ on a running Solaris system.... the
> only programs that are affected may be the ones that have
> timeouts while the change has been done.

Cute. It's bloat though, because it turns constant
expressions into variable ones.

> The problem is that the timeouts in the SCSI interface are
> based on HZ rather than being abstract from kernel internals.

That's a bug. They should be in terms of USER_HZ,
milliseconds, centiseconds, microseconds, or nanoseconds.
Pick something good and make a patch.


