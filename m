Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUEWIbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUEWIbH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 04:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUEWIbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 04:31:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:22538 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262361AbUEWIbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 04:31:00 -0400
Date: Sun, 23 May 2004 10:29:12 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Christoph Hellwig <hch@alpha.home.local>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Cc: alan@redhat.com, vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: i486 emu in mainline?
Message-ID: <20040523082912.GA16071@alpha.home.local>
References: <20040522234059.GA3735@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522234059.GA3735@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Sun, May 23, 2004 at 01:40:59AM +0200, Christoph Hellwig wrote:
> These days gcc uses i486+ only instruction by default in libstdc++ so
> most modern distros wouldn't work on i386 cpus anymore.  To make it work
> again Debian merged Willy Tarreau's patch to trap those and emulate them
> on real i386 cpus.  The patch is extremely non-invasive and would
> certainly be usefull for mainline.  Any reason not to include it?

Well, I have mixed feelings about this because :

  - I don't know which version they based their port on. The version
    I published 2 years ago included CMOV emulation, and Denis Vlasenko
    found several bugs in it which I then fixed. Since the Debian port
    doesn't include CMOV, I wonder whether it includes those bugs or not
    (I'll have to diff the patches).

  - The code is ugly in some areas, and someone will kill me if this goes
    into mainline.

  - There are people (like Alan) who think that this should not go into
    mainline because this is a distro problem and nothing else. He says
    that only i386 packages should be installed on an i386 machine. He's
    perfectly right about this. I found it interesting for people like
    me who boot kernels on random machines, try to recover hard disk
    contents or other things using lots of dirty tools, and sometimes
    get hit by the "illegal instruction" trap. It also allowed me to
    run a pppd compiled with i586 glibc on my i386 firewall, but obviously
    this is just the easy way and not the right way to go.

  - I couldn't emulate locks, so this will break on SMP systems, and so
    will it if you need to access some memory share with an external
    microcontroller or something like that.

  - I've always wondered if this feature would not be exploitable to
    access unauthorized information. Eg: code an invalid opcode
    which would get emulated and references a memory area outside the
    user space. I put some verify_area() where I thought appropriate,
    but I might have left some caveats... Morten Welinder once insisted
    on the fact that each byte should be read once and only once so as
    to ensure that the user doesn't change the instruction while it is
    being emulated. I think it's already the case. He also said that I
    didn't take care of the segment selectors (such as SS) which some
    programs use perfectly legally (eg Wine). I don't know how to do
    that.

  - Denis Vlasenko suggested that we print some messages on the console
    when a program triggers the code, so as not to let the user think that
    his machine is slow as hell. But for this we would need not to flood the
    console (eg: once for each prog) but we don't want either to store
    anything in the task structure about the message having been displayed,
    so for now there's nothing. In fact, the only message which is displayed
    (in the most recent version) is about a warning about a LOCK prefix on
    an SMP kernel. But I didn't find it right here, so I suspect this is
    based on ancient code.

  - why not include the CMOV emulation while we're at it ? There are so
    many people using VIA EDEN chips who think it's i686 compatible that
    they may get hit too. IIRC, the chip only executes CMOV on registers,
    but very slowly (a few tens of cycles), while register to memory
    accesses generate a trap.

Other than that, I'm happy that someone found it useful, and happy too that
someone did the 2.6 port :-)

Regards,
Willy

