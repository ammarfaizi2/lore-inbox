Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSIJQQq>; Tue, 10 Sep 2002 12:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSIJQQq>; Tue, 10 Sep 2002 12:16:46 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:11149 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317611AbSIJQQj>;
	Tue, 10 Sep 2002 12:16:39 -0400
Date: Tue, 10 Sep 2002 09:20:15 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020910092015.B7765@eng2.beaverton.ibm.com>
References: <patmans@us.ibm.com> <200209091734.g89HY5p11796@localhost.localdomain> <20020909170847.A24352@eng2.beaverton.ibm.com> <10209100055.ZM65139@classic.engr.sgi.com> <20020910130427.GP2992@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020910130427.GP2992@marowsky-bree.de>; from lmb@suse.de on Tue, Sep 10, 2002 at 03:04:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 03:04:27PM +0200, Lars Marowsky-Bree wrote:
> On 2002-09-10T00:55:58,
>    Jeremy Higdon <jeremy@classic.engr.sgi.com> said:
> 
> > Is there any plan to do something for hardware RAIDs in which two different
> > RAID controllers can get to the same logical unit, but you pay a performance
> > penalty when you access the lun via both controllers? 
> 
> This is implemented in the md multipath patch in 2.4; it distinguishes between
> "active" and "spare" paths.
> 
> The LVM1 patch also does this by having priorities for each path and only
> going to the next priority group if all paths in the current one have failed,
> which IMHO is slightly over the top but there is always someone who might need
> it ;-)
> 
> This functionality is a generic requirement IMHO.
> 
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>

The current scsi multi-path has a default setting of "last path used", so
that it will always work with such controllers (I refer to such controllers
as fail-over devices). You have to modify the config, or boot with a
flag to get round-robin path selection. Right now, all paths will start
out on the same adapter (initiator), this is bad if you have more than
a few arrays attached to and adapter.

I was planning on implementing something similiar to what you describe 
for LVM1, with path weighting. Yes, it seems a bit heavy, but if there
are only two weights or priorities, it looks just like your active/spare
code, and is a bit more flexible.

Figuring out what ports are active or spare is not easy, and varies
from array to array. This is a (another) good canidate for user level
probing/configuration. I will likely probably hard-code device
personallity information into the kernel for now, and hopefully in
2.7 we could move SCSI to user level probe/scan/configure.

I have heard that some arrays at one time had a small penalty for
switching controllers, and it was best to use the last path used,
but it was still OK to use both at the same time (cache warmth). I
was trying to think of a way to allow good load balancing in such
cases, but didn't come up with a good solution. Like use last path
used selection, and once a path is too "busy" move to another path
- but then all devices might switch at the same time; some hearistics
or timing could probably be added to avoid such problems. The code
allows for path selection in a single function, so it should not
be difficult to add more complex path selection.

I have also put NUMA path selection into the latest code. I've tested
it with 2.5.32, and a bunch of NUMA + NUMAQ patches on IBM/Sequent
NUMAQ systems.

-- Patrick Mansfield
