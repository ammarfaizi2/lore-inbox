Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSGOMiB>; Mon, 15 Jul 2002 08:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317450AbSGOMiA>; Mon, 15 Jul 2002 08:38:00 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:7793 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S315717AbSGOMiA>; Mon, 15 Jul 2002 08:38:00 -0400
Date: Mon, 15 Jul 2002 13:40:35 +0100
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: Re: [Announce] device-mapper beta3 (fast snapshots)
Message-ID: <20020715124035.GA4609@fib011235813.fsnet.co.uk>
References: <3D2F6464.60908@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2F6464.60908@us.ibm.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Fri, Jul 12, 2002 at 06:21:08PM -0500, Andrew Theurer wrote:
> Thanks for the results.  I tried the same thing, but with the latest 
> release (beta 4) and I am not observing the same behavior.

I've just read through the evms 1.1-pre4 code.

You (or Kevin Corry rather) have obviously looked at the
device-mapper snapshot code and tried to reimplement it.  I think it
might have been better if you'd actually used the relevent files from
device-mapper such as the kcopyd daemon.

Also I have serious concerns about the correctness of your
implementation, for example:

i) It is possible for the exception table to be updated *before* the
   copy on write of the data actually occurs.  This means that briefly
   the on disk state of the snapshot is inconsistent.  Users of EVMS
   that experience a machine failure will therefor have no option but to
   delete all snapshots.

ii) The exception table is only written out every
    (EVMS_VSECTOR_SIZE/sizeof(u_int64_t)) exceptions.  Surely I've misread
    the code here ?  This would mean I could have a machine that
    triggers 1 fewer exceptions than this, then does nothing to this
    volume, at no point would the exception table get written to disk?
    Or do you periodically flush the exception table as well ?
    Again if the machine crashed the snapshot would be useless.

iii) EVMS is writing the exception table data to the cow device
     asynchronously, you *cannot* do this without risking deadlocks with
     the VM system.

- Joe
