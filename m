Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311144AbSCHVaS>; Fri, 8 Mar 2002 16:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311141AbSCHV37>; Fri, 8 Mar 2002 16:29:59 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:30469 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S311136AbSCHV3o>; Fri, 8 Mar 2002 16:29:44 -0500
Date: Fri, 8 Mar 2002 22:29:42 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Danek Duvall <duvall@emufarm.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020308222942.A7163@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Danek Duvall <duvall@emufarm.org>, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu> <20020308100632.GA192@lorien.emufarm.org> <20020308195939.A6295@devcon.net> <20020308203157.GA457@lorien.emufarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020308203157.GA457@lorien.emufarm.org>; from duvall@emufarm.org on Fri, Mar 08, 2002 at 12:31:57PM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 12:31:57PM -0800, Danek Duvall wrote:
> 
> So it also turns out that either by changing that argument to 0 or just
> reverting that hunk of the patch, xmms starts skipping whenever mozilla
> loads a page, even a really simple one.

ie. always when mozilla tries to do a socket(PF_INET6, ...), which
ends up requesting the ipv6 module. 

As a side note, IMHO it would be sensible to have some way of
disabling module autoloading of protocol modules in the network stack.
As more and more apps start supporting IPv6, those ipv6 module
requests are getting more frequent on machines without IPv6 support
(the vast majority for now), which might turn into a real performance
penalty (fork+exec+wait for modprobe finish...)

> Disk activity and other network
> activity don't seem to cause the skipping, and the skipping disappears
> when I go back to an unaltered ac kernel, so there seems to be something
> wrong with set_user(0, 0) as well, just a different problem.

Uhm, this one seems rather strange. AFAICT, the dumpable flag is used
purely for access control to the processes in-memory data, ie.
/proc/<pid>/*, coredump generation etc., it doesn't affect scheduler,
memory management or the like.

Maybe it's related to the wmb() done by set_user() if dumpclear is
set? (although it's actually a nop on most x86 (which arch are you
using?))

Just for testing, can you try moving the wmb() in set_user()
(kernel/sys.c, line 512 in 2.4.19-pre2-ac3) out of the if statement?
(ie. put it right after the closing brace)

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
