Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291673AbSBAKcK>; Fri, 1 Feb 2002 05:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291674AbSBAKbf>; Fri, 1 Feb 2002 05:31:35 -0500
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:33616 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S291681AbSBAKac>; Fri, 1 Feb 2002 05:30:32 -0500
Date: Thu, 31 Jan 2002 13:35:52 +0000
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Joe Thornber <thornber@fib011235813.fsnet.co.uk>, lvm-devel@sistina.com,
        Jim McDonald <Jim@mcdee.net>, Andreas Dilger <adilger@turbolabs.com>,
        linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020131133552.A9076@fib011235813.fsnet.co.uk>
In-Reply-To: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com> <20020131125211.A8934@fib011235813.fsnet.co.uk> <20020201045518.A10893@devserv.devel.redhat.com> <20020131130913.A8997@fib011235813.fsnet.co.uk> <20020201051251.B10893@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201051251.B10893@devserv.devel.redhat.com>; from arjanv@redhat.com on Fri, Feb 01, 2002 at 05:12:51AM -0500
From: Joe Thornber <thornber@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 05:12:51AM -0500, Arjan van de Ven wrote:
> On Thu, Jan 31, 2002 at 01:09:13PM +0000, Joe Thornber wrote:
> > 
> > Now our hero decides to PV move PV2 to PV4:
> > 
> > 1. Suspend our LV (254:3), this starts queueing all io, and flushes
> >    all pending io. 
> 
> But "flushes all pending io" is *far* from trivial. there's no current
> kernel functionality for this, so you'll have to do "weird shit" that will
> break easy and often.

Here's the weird shit.  If you can see how to break it, I'd like to
know.

Whenever the dm driver maps a buffer_head, I increment a 'pending'
counter for that device, and hook the bh->b_end_io, bh->b_private
function so that this counter is decremented when the io completes.
This doesn't work with ext3 on 2.4 kernels since ext3 believes the
b_private pointer is for general filesystem use rather than just
b_end_io, however Stephen Tweedie and I have been discussing ways to
get round this.  On 2.5 this works fine since the bio->bi_private
isn't abused in this way.

> Also "suspending" is rather dangerous because it can deadlock the machine
> (think about the VM needing to write back dirty data on this LV in order to
>  make memory available for your move)...

You are correct, this is the main flaw IMO with the LVM1 version of
pvmove (which was userland with locking on a per extent basis).

However for LVM2 the device will only be suspended while a table
is loaded, *not* while the move takes place.  I will however allocate
the struct deferred_io objects from a mempool in 2.5.

- Joe
