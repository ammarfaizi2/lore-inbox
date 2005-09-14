Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbVINM26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbVINM26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVINM25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:28:57 -0400
Received: from magic.adaptec.com ([216.52.22.17]:30109 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965129AbVINM2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:28:55 -0400
Message-ID: <4328176D.80307@adaptec.com>
Date: Wed, 14 Sep 2005 08:28:29 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: Douglas Gilbert <dougg@torque.net>,
       James Bottomley <James.Bottomley@SteelEye.com>, ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com> <1126368081.4813.46.camel@mulgrave> <4325997D.3050103@adaptec.com> <20050912162739.GA11455@us.ibm.com> <4326964B.9010503@torque.net> <20050913224215.GB1308@us.ibm.com>
In-Reply-To: <20050913224215.GB1308@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2005 12:28:35.0529 (UTC) FILETIME=[D3A05390:01C5B927]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/05 18:42, Patrick Mansfield wrote:
> On Tue, Sep 13, 2005 at 07:05:15PM +1000, Douglas Gilbert wrote:
> 
>>Patrick Mansfield wrote:
>>
>>>On Mon, Sep 12, 2005 at 11:06:37AM -0400, Luben Tuikov wrote:
>>
>><snip>
>>
>>>IMO adding well known LUNs at this point to the standard added nothing of
>>>value, the target firmware has to check for special paths no matter what,
>>>adding a well known LUN does not change that. And most vendors will
>>>(likely) have support for use without a well known LUN. (This does not
>>>mean we should not support it in linux, I just don't know why this went
>>>into the standard.)
>>>
>>>Using well known LUNs will be another code path that will have to live
>>>alongside existing ones, and will likely require further black listing
>>>(similar to REPORT LUN vs scanning for LUNs).
>>
>>Patrick,
>>The technique of supporting REPORT_LUNS on lun 0 of
>>a target in the case where there is no such device
>>(logical unit) is a pretty ugly. It also indicates what
>>is really happening: the target device intercepts
>>REPORT_LUNS, builds the response and replies on behalf
>>of lun 0.
> 
> 
> It should ignore the lun value for REPORT LUNS.

Notice that Doug is _right_.  To convince yourself of this,
please look up _who_ would execute REPORT LUNS on the target
device.

>>Turns out there are other reasons an application may want
>>to "talk" to a target device rather than one of its logical
>>units (e.g. access controls and log pages specific to
>>the target's transport). Well known lus can be seen with the
>>REPORT_LUNS (select_report=1) but there is no mechanism (that
>>I am aware of) that allows anyone to access them
>>from the user space with linux.

Doug is right here too.

> What I mean is that the target has to intercept the command whether it is
> a REPORT LUN or for the well known (W_LUN).
> 
> The target (firmware) code has to have code today like:
> 
> 	if (cmd == REPORT_LUN) {
> 		do_report_lun();
> 	}
> 
> For only W_LUN support, the code might be something like:
> 
> 	if (lun == W_LUN) {
> 		if (cmd == REPORT_LUN) {
> 			do_report_lun();
> 		}
> 	}
> 
> But the first case above already covers even the W_LUN case.

_Except_, that what the firmware actually does is, it routes
the tasks by LUN first, _before_ looking up with what the command
is.*  This is crucial.

You can convince yourlelf of this taking a look at the SCSI Target
architecture in SAM.

(*) Notice how according to your code above, the initiator may
assume that a LUN exists where it actually _does_not_.

> So adding a W_LUN at this point does not add any value ... maybe it looks
> nice in the spec and in someones firmware, but it does not add anything
> that I can see.

I wonder if the maintainer of the SCSI Core would listen or ignore your
opinion here.

I wonder _who_ decides here where speculation ends and industry
opinion starts?

As Documentation/ManagamentStyle points out, the Manager does _not_
have to know everything -- in fact this is encouraged in that document.
What she/he has to know is _who_ to listen to, and how to make
decisions.

> Kind of like an 8 byte lun, it adds no meaningful functionallity. [I mean,
> who would want 2^64 LUs on one target? Yeh, let's give everyone in the
> world ... no in the universe their own private LUN on a single target. The
> LUN hiearchy is a bad idea, I have not seen a device that supports it,
> kind of like trying to implement network routing inside your storage box.
> Don't let those storage or database experts design your network hardware.]

Well, what can I say...
	"No one will ever need more than 64K in their computer."

  Luben



