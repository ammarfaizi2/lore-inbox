Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319108AbSIJNLz>; Tue, 10 Sep 2002 09:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319112AbSIJNK6>; Tue, 10 Sep 2002 09:10:58 -0400
Received: from gate.in-addr.de ([212.8.193.158]:31507 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S319110AbSIJNKs>;
	Tue, 10 Sep 2002 09:10:48 -0400
Date: Tue, 10 Sep 2002 15:02:01 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020910130201.GO2992@marowsky-bree.de>
References: <20020909095652.A21245@eng2.beaverton.ibm.com> <200209091734.g89HY5p11796@localhost.localdomain> <20020909184026.GD1334@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020909184026.GD1334@beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-09T11:40:26,
   Mike Anderson <andmike@us.ibm.com> said:

> When you get into networking I believe we may get into path failover
> capability that is already implemented by the network stack. So the
> paths may not be visible to the block layer.

It depends. The block layer might need knowledge of the different paths for
load balancing.

> The utility does transcend SCSI, but transport / device specific
> characteristics may make "true" generic implementations difficult.

I disagree. What makes "generic" implementations difficult is the absolutely
mediocre error reporting and handling from the lower layers.

With multipathing, you want the lower level to hand you the error
_immediately_ if there is some way it could be related to a path failure and
no automatic retries should take place - so you can immediately mark the path
as faulty and go to another. 

However, on a "access beyond end of device" or a clear read error, failing a
path is a rather stupid idea, but instead the error should go up immediately.

This will need to be sorted regardless of the layer it is implemented in.

How far has this been already addressed in 2.5 ?

> > > For sd, this means if you have n paths to each SCSI device, you are
> > > limited to whatever limit sd has divided by n, right now 128 / n.
> > > Having four paths to a device is very reasonable, limiting us to 32
> > > devices, but with the overhead of 128 devices. 
> > 
> > I really don't expect this to be true in 2.6.
> > 
> While the device space may be increased in 2.6 you are still consuming
> extra resources, but we do this in other places also.

For user-space reprobing of failed paths, it may be vital to expose the
physical paths too. Then "reprobing" could be as simple as

	dd if=/dev/physical/path of=/dev/null count=1 && enable_path_again

I dislike reprobing in kernel space, in particular using live requests as
the LVM1 patch by IBM does it.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

