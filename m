Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUIMNWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUIMNWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUIMNWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:22:42 -0400
Received: from [194.151.80.102] ([194.151.80.102]:41436 "EHLO
	mail.research.newtrade.nl") by vger.kernel.org with ESMTP
	id S266717AbUIMNW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:22:26 -0400
From: Duncan Sands <baldrick@free.fr>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Writable module parameters - should be volatile?
Date: Mon, 13 Sep 2004 13:58:44 +0200
User-Agent: KMail/1.6.2
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
References: <200409121357.25915.baldrick@free.fr> <200409121452.49139.arnd@arndb.de>
In-Reply-To: <200409121452.49139.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409131358.44426.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 September 2004 14:52, Arnd Bergmann wrote:
> On Sonntag, 12. September 2004 13:57, Duncan Sands wrote:
> > I declare a writable module parameter as follows:
> > 
> > static unsigned int num_rcv_urbs = UDSL_DEFAULT_RCV_URBS;
> > 
> > module_param (num_rcv_urbs, uint, S_IRUGO | S_IWUSR);
> > 
> > Shouldn't I declare num_rcv_urbs volatile?  Otherwise compiler
> > optimizations could (for example) stick it in a register and miss
> > any changes made by someone writing to it...
> 
> Even worse, AFAICS there is no guarantee that writes are atomic,
> which can give unpredictable results in case of strings or arrays.
> Both problems can be solved by serializing access to writable
> module parameters.
> 
> Maybe we could have a global module_param_rwsem. Making the
> parameter volatile does not sound like the right solution, in
> fact volatile is almost always a bad idea.

Another possibility is for a module to make an explicit "flush" call when it
is happy to have parameters updated.  I'll call the parameter "p".  The
moduleparam code would need keep a copy "p_current" of p as well
as a pointer "&p" to the actual parameter p.  Writes to p would only update
p_current, not p, so would not immediately be seen by the module's code. 
A call to flush would then write p_current to the actual parameter *(&p).  This has
the advantage of centralizing locking in the common moduleparam code,
which needs to ensure that p_current is updated atomically.
It has the down side that driver writers will have to call flush at appropriate
times, which could be a maintenance burden (I'm thinking of
drivers/usb/core/devio.c which has a writeable parameter usbfs_snoop
which causes usbfs ioctls to be logged when set; it doesn't hurt if usbfs_snoop
changes at any time; but when adding a new use of usbfs_snoop it would be
easy to forget to put a flush call in every code path leading there).  Still, this
is much lighter weight that having drivers take a module_param_rwsem
whenever they access parameters.

All the best,

Duncan.
