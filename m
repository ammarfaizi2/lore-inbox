Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVCYFix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVCYFix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVCYFix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:38:53 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:47810 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261319AbVCYFis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:38:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=d3Jf0Z13Kq9u1D7y2Qok7aQBAiyZxqP5UsP+xKMgE0yvQyxAPe2G0pE61DVfOG86c/dKSk9gHYz5mQglaZDNzKqkMu+VAFG5Zjvad96Ypelie/rv/ttE0/ZYdiVyGlIcl3cX+5a6mnrtrR8jKVVQgMMPi/NwC9elB3PiS1UwIW4=
Date: Fri, 25 Mar 2005 14:38:43 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
Message-ID: <20050325053842.GA24499@htj.dyndns.org>
References: <20050323021335.960F95F8@htj.dyndns.org> <20050323021335.4682C732@htj.dyndns.org> <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com> <20050323071920.GJ24105@suse.de> <1111591213.5441.19.camel@mulgrave> <20050323152550.GB16149@suse.de> <1111711558.5612.52.camel@mulgrave> <20050325031511.GA22114@htj.dyndns.org> <1111726965.5612.62.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111726965.5612.62.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

On Thu, Mar 24, 2005 at 11:02:45PM -0600, James Bottomley wrote:
> On Fri, 2005-03-25 at 12:15 +0900, Tejun Heo wrote:
> >  I think I found the cause.  Special requests submitted using
> > scsi_do_req() never initializes ->end_io().  Normally, SCSI midlayer
> > terminates special requests inside the SCSI midlayer without passing
> > through the blkdev layer.  However, if a device is going away or taken
> > offline, blkdev layer gets to terminate special requests and, as
> > ->end_io() is never set-up, nothing happens and the completion gets
> > lost.
> 
> The analysis is exactly correct, well done!  I think your patch is a bit
> overly complex, though.  We can achieve the same effect simply by
> executing the completion without changing the rq_status like the patch
> below.
> 
> Jens,  To go back to the original problem, except when I hit the usb-
> storage error handling oops, I can plug and unplug to my hearts content
> and everything works.

 We have users of scsi_do_req() other than scsi_wait_req() and they
use different done() functions to do different things.  I've checked
other done functions and none uses contents inside the passed
scsi_cmnd, so using a dummy command should be okay with them.  Am I
missing something here?

 Oh, and I would really appreciate if you can fill me in / give a
pointer about the scsi_request/scsi_cmnd distinction.

 Thanks a lot.

-- 
tejun

