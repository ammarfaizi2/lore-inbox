Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318359AbSG3RXx>; Tue, 30 Jul 2002 13:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318360AbSG3RXx>; Tue, 30 Jul 2002 13:23:53 -0400
Received: from ns.itep.ru ([193.124.224.35]:25863 "EHLO ns.itep.ru")
	by vger.kernel.org with ESMTP id <S318359AbSG3RXw>;
	Tue, 30 Jul 2002 13:23:52 -0400
Date: Tue, 30 Jul 2002 21:27:07 +0400
From: Roman Kagan <Roman.Kagan@itep.ru>
To: linux-kernel@vger.kernel.org
Cc: "T.Raykoff" <traykoff@snet.net>
Subject: Re: 2.4.18 IDE channels block each other under load?
Message-ID: <20020730172707.GE30271@panda.itep.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

I'm by no means an expert in this, just a guess:

On Tue, Jul 30, 2002 at 05:09:22PM +0000, T.Raykoff wrote:
> This lockup only happens under write load.  Heavy reads don't cause the 
> prob.  Hmmmm.
> 
> Not sure that it really is memory thrashing.  The box is unloaded and 
> really has about 1GB free, to use for buffer as it sees fit.  No I/O to 
> the swap file going on, cause there is no mounted swap.
> 
> Check this out:
> 
> dd if=/dev/zero of=/dev/hda bs=1024
> 
> then:
> 
> fdisk /dev/hdc
> 
> "q"
> 
> fdisk blocks in the close() call.... for well over 15 minutes!
> 
> As soon as dd ends cause /dev/hda is at EOF, fisk::close() returns in a 
> moment.

When you quit from fdisk it does a sync() right after the close().  I
suspect that fdisk gets stuck in that sync() rather than close().  (You
said strace reported close() as the last syscall - it's the last one
completed.)  The write on one of the channels doesn't let sync() return.

To make sure I'd try to check (e.g. with /proc/<pid>/fd) if fdisk still
has /dev/hdc open during the dd.

  Cheers,
  	Roman.
