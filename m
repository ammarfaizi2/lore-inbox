Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265700AbUAQJ3j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 04:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUAQJ3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 04:29:39 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:45481 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265700AbUAQJ3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 04:29:38 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Date: Sat, 17 Jan 2004 14:59:01 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org
References: <200401161759.59098.amitkale@emsyssoft.com> <20040116215144.GA208@elf.ucw.cz> <40088E9D.1010908@mvista.com>
In-Reply-To: <40088E9D.1010908@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171459.01794.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 Jan 2004 6:53 am, George Anzinger wrote:
> Pavel Machek wrote:
> > Hi!
> >
> >>KGDB 2.0.3 is available at
> >>http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> >>
> >>Ethernet interface still doesn't work. It responds to gdb for a couple of
> >>packets and then panics. gdb log for ethernet interface is pasted below.
> >>
> >>It panics and enter kgdb_handle_exception recursively and silently. To
> >> see the panic on screen make kgdb_handle_exception return immediately if
> >> kgdb_connected is non-zero.
> >>
> >>Panic trace is pasted below. It panics in skb_release_data. Looks like
> >> skb handling will have to changed to be have kgdb specific buffers.
> >
> > This seems to be needed (if I unselect CONFIG_KGDB_THREAD, I get
> > compile error on x86-64).
>
> Amit, could you explain why this is an option?  It seems very useful and
> not really too much code...

It saves all registers before switch_to. It does that two times at present. 
Once (implicit) register save by gcc and an explicit register save in 
arch/<proc>/kernel/entry.S Second register save in kern_schedule generates a 
pt_regs structure which gdb can get all registers at once from. If it's 
omited, gdb has to figure out where gcc has saved registers from the 
non-standards code in switch_to, which it can't do correctly all the time.

We can have a check for (a new variable) debugger_enabled before calling 
kern_schedule. That'll be add negligible overhead and will allow extra thread 
info to be saved only when a debugger is enabled. There will not be any need 
for CONFIG_KGDB_THREAD also.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

