Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270076AbUJHSYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270076AbUJHSYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270080AbUJHSWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:22:31 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:42881 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270076AbUJHSTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:19:33 -0400
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
From: Albert Cahalan <albert@users.sf.net>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Catalin Marinas <Catalin.Marinas@arm.com>,
       Richard Earnshaw <Richard.Earnshaw@arm.com>,
       Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <4166C216.2080305@grupopie.com>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
	 <20041008160456.H17999@flint.arm.linux.org.uk>
	 <4166C216.2080305@grupopie.com>
Content-Type: text/plain
Organization: 
Message-Id: <1097259244.2673.2646.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Oct 2004 14:14:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 12:36, Paulo Marques wrote:
> Russell King wrote:
> > On Mon, Sep 27, 2004 at 09:03:05PM +0100, Russell King wrote:
> > 
> >>The ARM binutils seems to be in a problematical state at the moment.
> >>It has recently had a "bug" fixed where ARM specific "mapping symbols"
> >>were not generated in ELF objects.  These "mapping symbols" have names
> >>such as "$a" and "$d".
> > 
> > 
> > Ok, another tool which is affected by this is procps:
> > 
> > $ ps alx
> > Warning: /boot/System.map-2.6.9-rc3 not parseable as a System.map
> > Warning: /boot/System.map not parseable as a System.map
> > Warning: /usr/src/linux/System.map has an incorrect kernel version.
> > F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
> > 4     0     1     0  16   0  1244  508 do_sel S    ?          0:01 init [3]

The "$" is considered a garbage character by the sanity check.
(same as "\v", "\033", "\xff", and so on)

> ps is reading System.map probably because reading /proc/<pid>/wchan 
> directly was very slow. It used to take an average of 1.3ms (on a P4 
> 2.8GHz) and now it takes less than 0.5us (that is miliseconds and 
> microseconds!)

No, the /proc/*/wchan file is supposed to be used.
For some reason, stat() is failing. Here is the code:

  // next try the Linux 2.5.xx method
  if(!stat("/proc/self/wchan", &sbuf)){
    use_wchan_file = 1; // hack
    return 0;
  }

See what these commands tell you:

strace -o data -e trace=stat ps alx >> /dev/null ; grep self data
stat /proc/self/wchan
stat /proc/$$/wchan
stat /proc/self/
stat /proc/self

> If this is the case, then after the changes to kallsyms go in, procps 
> could start using wchan directly and avoid reading the System.map 
> altogether.

Here's an idea: if both name and number were provided
at the same time and I could get notified when a module
is loaded or unloaded, then I could cache the
number-to-name translation.


