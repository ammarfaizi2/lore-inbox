Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267593AbSKQUa3>; Sun, 17 Nov 2002 15:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbSKQUa2>; Sun, 17 Nov 2002 15:30:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:7517 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267595AbSKQUaX>; Sun, 17 Nov 2002 15:30:23 -0500
Date: Sun, 17 Nov 2002 15:38:23 -0500
From: Doug Ledford <dledford@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Several Misc SCSI updates...
Message-ID: <20021117203823.GF3280@redhat.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
References: <20021117202826.GE3280@redhat.com> <Pine.LNX.4.44.0211171228350.1370-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211171228350.1370-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 12:29:25PM -0800, Linus Torvalds wrote:
> 
> On Sun, 17 Nov 2002, Doug Ledford wrote:
> >
> > These bring the scsi subsys up to the new module loader semantics.  There 
> > is more work to be done on inter-module locking here, but we need to solve 
> > the whole module->live is 0 during init problem first or else it's a waste 
> > of time.
> 
> Hey, just remove the "live" test, I think it's over-eager and likely to 
> just cause extra code to work around it rather than fix anything.

Won't work.  module->live is what Rusty uses to indicate that the module 
is in the process of unloading, which is when we *do* want the attempt to 
module_get() to fail.  I think the process out to basically be:

load module into mem
set module->live = 1
call module_init
export module syms
done loading module

on module exit:
unexport module syms
set module->live 0
call module_exit
free module memory
done unloading.

That *should* solve all the races Rusty is trying to solve without the 
problems we've had so far, but this is only after a few minutes of 
thinking....

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
