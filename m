Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268118AbTBNXgK>; Fri, 14 Feb 2003 18:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268120AbTBNXgK>; Fri, 14 Feb 2003 18:36:10 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:38298 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S268118AbTBNXgI>;
	Fri, 14 Feb 2003 18:36:08 -0500
Date: Fri, 14 Feb 2003 15:37:47 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Tim Pepper <tpepper@linux.ibm.com>, Lars Marowsky-Bree <lmb@suse.de>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Accessing the same disk via multiple channels
Message-ID: <20030214153747.A28502@beaverton.ibm.com>
References: <20030213194917.GA8479@quadpro.stupendous.org> <E18jS75-0007na-00@calista.inka.de> <20030214100316.GA3422@marowsky-bree.de> <20030214140155.A5344@jose.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030214140155.A5344@jose.vato.org>; from tpepper@vato.org on Fri, Feb 14, 2003 at 02:01:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 02:01:55PM -0800, Tim Pepper wrote:
> On Fri 14 Feb at 11:03:16 +0100 lmb@suse.de done said:
> > 
> > Doing it in the SCSI layer has the advantage of not being constrained to block
> > devices, but also working with tapes. Oh well, we'll see ;-)
> 
> Tape needs special multipathing logic.  Don't you think moving
> multipathing to the mid-layer requires the mid-layer to know much more
> about the upper layer and muddles up the scsi stack's layering?  To keep
> multipathing high and generic we need better error reporting than the
> one bit that hits the md layer in 2.4...
> 
> t.

If we want to be able to retry a tape read/write that actually might have
made it to the media it requires special handling (as compared to a random
access device) no matter where we put multi-path.

The scsi mid-layer is a bit muddled up already (but getting better).
Adding multi-path there does not make it worse. Much of the same code that
cleans up the scsi mid-layer also makes scsi multi-path easier (that is,
recent changes cleaning up the scsi mid-layer make it easier to implement
scsi multi-path).

Generic multi-path without the lower levels knowing anything can waste a
lot of resources. For example, for each extra path to a block device
(disk) we end up with an extra sd plus associated data structures, and an
extra scsi_device including multiple request queues.

The main thing scsi multi-path needs to know is that multiple nexuses
(i.e. host/channel/target/lun) correspond to the same unit. This has no
interactions with any upper layer drivers, and limits what the upper layer
drivers (and users) have to work with, and more closely matches the layout
of the actual hardware.

-- Patrick Mansfield
