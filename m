Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUKRViL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUKRViL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUKRVds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:33:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21142 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262992AbUKRVdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:33:19 -0500
Date: Thu, 18 Nov 2004 22:32:47 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2 OOPS on boot with 3ware + reiserfs
Message-ID: <20041118213246.GH2009@suse.de>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041117165851.GA18044@tentacle.sectorb.msk.ru> <Pine.LNX.4.58.0411170935040.2222@ppc970.osdl.org> <20041118103526.GC26240@suse.de> <20041118160248.GA5922@tentacle.sectorb.msk.ru> <20041118183920.GL26240@suse.de> <20041118191002.GO26240@suse.de> <1100805744.1574.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100805744.1574.3.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18 2004, James Bottomley wrote:
> On Thu, 2004-11-18 at 13:10, Jens Axboe wrote:
> > It is a double requeue. The SCSI path looks really messy (and buggy
> > there). What happens is that the host queuecommand sets DID_ERROR and
> > calls scsi_done() on the command, which may decide the commands need
> > retrying and thus requeue it. Upon return from queuecommand, the SCSI
> > layer initiates a requeue of the request because queuecommand returned
> > 1. Double requeue, request list is now screwed.
> > 
> > James, it looks like the queuecommand returns need an overhaul so it's
> > clear who does what and when.
> 
> Hmm, I thought the Documentation/scsi/scsi_mid_low_api.txt was quite
> clear on this:
> 
>  *      Command ownership.  If the driver returns zero, it owns the
>  *      command and must take responsibility for ensuring the 'done'
>  *      callback is executed.  Note: the driver may call done before
>  *      returning zero, but after it has called done, it may not
>  *      return any value other than zero.  If the driver makes a
>  *      non-zero return, it must not execute the command's done
>  *      callback at any time.
> 
> The 3ware driver is clearly in violation by calling done and then
> returning one.

It's clearly not the only one, the first 3 I looked at all did it.
That's the big mess. I'll do an audit.

-- 
Jens Axboe

