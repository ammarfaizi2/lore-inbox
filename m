Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319147AbSIJP7a>; Tue, 10 Sep 2002 11:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSIJP7a>; Tue, 10 Sep 2002 11:59:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:32726 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317622AbSIJP72>;
	Tue, 10 Sep 2002 11:59:28 -0400
Date: Tue, 10 Sep 2002 09:03:57 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020910090357.A7765@eng2.beaverton.ibm.com>
References: <20020909095652.A21245@eng2.beaverton.ibm.com> <200209091734.g89HY5p11796@localhost.localdomain> <20020909184026.GD1334@beaverton.ibm.com> <20020910130201.GO2992@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020910130201.GO2992@marowsky-bree.de>; from lmb@suse.de on Tue, Sep 10, 2002 at 03:02:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 03:02:01PM +0200, Lars Marowsky-Bree wrote:
> On 2002-09-09T11:40:26,

> With multipathing, you want the lower level to hand you the error
> _immediately_ if there is some way it could be related to a path failure and
> no automatic retries should take place - so you can immediately mark the path
> as faulty and go to another. 
> 
> However, on a "access beyond end of device" or a clear read error, failing a
> path is a rather stupid idea, but instead the error should go up immediately.
> 
> This will need to be sorted regardless of the layer it is implemented in.
> 
> How far has this been already addressed in 2.5 ?
> 

The current scsi multi-path code handles the above cases. There is
a scsi_path_decide_disposition() that fails paths independent of the
result of the IO. It is similiar to the current scsi_decide_disposition,
except it also fails the path. So for a check condition of media error,
the IO might be marked as SUCCESS (meaning completed with an error),
but the path would not be modified (there are more details than this).

> For user-space reprobing of failed paths, it may be vital to expose the
> physical paths too. Then "reprobing" could be as simple as
> 
> 	dd if=/dev/physical/path of=/dev/null count=1 && enable_path_again
> 

Yes, that is a good idea, I was thinking that this should be done
via sg, and modify sg to allow path selection - so no matter what, sg
could be used to probe a path.  I have no plans to expose a user level
device for each path, but a device model "file" could be exposed for
the state of each path, and its state controlled via driverfs.

> I dislike reprobing in kernel space, in particular using live requests as
> the LVM1 patch by IBM does it.
> 
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>

-- Patrick Mansfield
