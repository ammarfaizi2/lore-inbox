Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262852AbTC1J4A>; Fri, 28 Mar 2003 04:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbTC1J4A>; Fri, 28 Mar 2003 04:56:00 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.26]:1494 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262852AbTC1Jz7>; Fri, 28 Mar 2003 04:55:59 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] second pass at fixing atm spinlock
Date: Fri, 28 Mar 2003 11:07:07 +0100
User-Agent: KMail/1.5.1
References: <200303272228.h2RMSSGi009141@locutus.cmf.nrl.navy.mil>
In-Reply-To: <200303272228.h2RMSSGi009141@locutus.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303281107.07586.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chas, good work.  A few comments below

On Thursday 27 March 2003 23:28, chas williams wrote:
> ok, here is a further attempt at fixing the smp problems in the linux-atm
> stack.  things have been moved around in net/atm:
>
> . atm sk's are reference counted.  this makes the vcc_release (renamed
>   from atm_release_vcc for consistency) and svc_release easier to write
>   since you dont need to explicity free the sk
> . vcc's are stored as a list of sockets, like other protocols
> . atm drivers should use vcc_hold/vcc_put to modify reference counts.  the
>   driver should read_lock(vcc_sklist_lock) before doing a vcc_hold() if
>   they are in their 'bottom half'.  i converted eni, idt77252 (untested --
>   no hardware), fore200e (untest -- lazy) and nicstar.  i also included the
>   he driver.  the eni driver is special, since the bottom half is a tasklet
>   you can simply stop the bottom half and be sure the bottom half
>   isnt holding a reference.  the he just grabs the vcc_sklist_lock and
>   processes all the vcc's needing serviced.  a vcc cant disappear while
>   the lock is held (since the vcc_release needs to do a write_lock to
> unhash the socket/vcc before dropping the refcnt to 0).

I'm kind of confused about this.  It seems to me that you should only
need to read_lock(vcc_sklist_lock) if you are going to traverse (or
otherwise examine the structure of) the list.  There should be no need
to do it if you are just taking a reference.  After all, you should only take a
reference to a vcc (ok, to the socket) if the vcc you are going to use/copy
already has a reference taken [Example: if the ATM layer calls you and
passes you a vcc, it must have taken a reference to the vcc before calling
you, otherwise the vcc might vanish under you; then you take a reference
to this vcc -> ref count = 2].  So no-one is going to delete the vcc under
you, so why take a lock?  As I said, I'm kind of confused here.

> . the nodev list has been removed and bind_vcc/unlink have been changed to
>   just insert/remove vcc list operations.  this makes things a bit clearer.
> . driver's check_ci() routine have been removed in favor of the one in
>   atm_misc.c.  very few were actually any faster, and this functionality is
>   rarely used.

Why does this exist at all?  I mean, if someone has already opened a vcc for
a given vpi/vci pair, the ATM layer could detect this itself and return an error,
without ever calling the driver's open method.  Is it sometimes useful to open
more than one vcc for the same vpi/vci pair?  Also, calling check_ci then
claiming the vpi/vci pair is racy.  If you want to have something like this,
shouldn't there be a routine "claim_ci", which either returns an error if that
vpi/vci pair was already in use, or marks it as in use if not (done atomically
of course).

> . there is a new function, vcc_lookup(), used mostly by the fore200e and he
>   driver.  vcc's returned by this function will need a vcc_put() or the
>   ref count will be wrong.  in the future, most drivers should probably
>   use this function to find the vcc for their newly arrived data.  there
>   possibly could be a routine atmif_rx(atmdev, skb, vpi, vci) which
>   just does the right thing.  ideally, atm would use netif_rx() but one
>   would need to dummy up a ethernet header on each of the pdu's.  comments
>   on that idea?
> . all the stuff from the previous version: atmdev ref counting, atm and
>   clip can now build as modules.
>
> ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_5_64_atm_dev_lock.patch
>
> [i will try to get a 2.5.65 version available this weekend]

Good stuff!

Ciao,

Duncan.
