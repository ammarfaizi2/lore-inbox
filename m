Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSIJQVu>; Tue, 10 Sep 2002 12:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSIJQVu>; Tue, 10 Sep 2002 12:21:50 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29896 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317673AbSIJQVq>; Tue, 10 Sep 2002 12:21:46 -0400
Date: Tue, 10 Sep 2002 09:27:31 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020910162731.GA1249@beaverton.ibm.com>
Mail-Followup-To: Lars Marowsky-Bree <lmb@suse.de>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20020909095652.A21245@eng2.beaverton.ibm.com> <200209091734.g89HY5p11796@localhost.localdomain> <20020909184026.GD1334@beaverton.ibm.com> <20020910130201.GO2992@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020910130201.GO2992@marowsky-bree.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree [lmb@suse.de] wrote:
> On 2002-09-09T11:40:26,
>    Mike Anderson <andmike@us.ibm.com> said:
> 
> > When you get into networking I believe we may get into path failover
> > capability that is already implemented by the network stack. So the
> > paths may not be visible to the block layer.
> 
> It depends. The block layer might need knowledge of the different paths for
> load balancing.
> 
> > The utility does transcend SCSI, but transport / device specific
> > characteristics may make "true" generic implementations difficult.
> 
> I disagree. What makes "generic" implementations difficult is the absolutely
> mediocre error reporting and handling from the lower layers.
> 

Where working on it. I have done a mid scsi_error cleanup patch for 2.5
so that we can better view where we are at currently. Hopefully soon we
can do some actual useful improvements.

My main point on the previous comment though was that some transports may
decide not to expose there paths (i.e. the may manage them at the
transport layer) and the block layer would be unable to attach to
individual paths.

The second point I was trying to make is that if you look at most
multi-path solutions across different operating systems once they have
failover capability and move to support more performant / advanced
multi-path solutions they need specific attributes of the device or
path. These attributes have sometimes been called personalities. 

Examples of these personalities are path usage models (failover,
transparent failover, active load balancing), ports per controller
config,  platform memory latency (NUMA), cache characteristics, special
error decoding for device events, etc.

I mention a few in these in this document.
http://www-124.ibm.com/storageio/multipath/scsi-multipath/docs/index.html

These personalities could be acquired at any level of the IO stack, but
involve some API if we want to try and get as close as possible to
"generic".

> With multipathing, you want the lower level to hand you the error
> _immediately_ if there is some way it could be related to a path failure and
> no automatic retries should take place - so you can immediately mark the path
> as faulty and go to another. 
> 

Agreed, In a past O/S we worked hard to have our error policy structure
so that transports worried about transport errors and devices worried
about device errors. If a transport received a completion of an IO its
job was done (we did have some edge case and heuristics to stop paths
from cycling from disabled to enabled)

> However, on a "access beyond end of device" or a clear read error, failing a
> path is a rather stupid idea, but instead the error should go up immediately.
> 

Agreed, each layer should only deal with error in there domain.

> This will need to be sorted regardless of the layer it is implemented in.
> 
> How far has this been already addressed in 2.5 ?

See previous comment.

> 
> > > > For sd, this means if you have n paths to each SCSI device, you are
> > > > limited to whatever limit sd has divided by n, right now 128 / n.
> > > > Having four paths to a device is very reasonable, limiting us to 32
> > > > devices, but with the overhead of 128 devices. 
> > > 
> > > I really don't expect this to be true in 2.6.
> > > 
> > While the device space may be increased in 2.6 you are still consuming
> > extra resources, but we do this in other places also.
> 
> For user-space reprobing of failed paths, it may be vital to expose the
> physical paths too. Then "reprobing" could be as simple as
> 
> 	dd if=/dev/physical/path of=/dev/null count=1 && enable_path_again
> 
> I dislike reprobing in kernel space, in particular using live requests as
> the LVM1 patch by IBM does it.
> 


In the current mid-mp patch the paths are exposed through the proc
interface and can be activated / state changed through a echo command. 

While live requests are sometimes viewed as a bad things to activate a
path very small IO sizes in optical networks a unreliable in
determining anything but completely dead paths. The size of the payload
is important.

I believe the difference in views here is what to expose and what
size/type of structure represents each piece of the nexus (b:c:t:l).

-Mike

-- 
Michael Anderson
andmike@us.ibm.com

