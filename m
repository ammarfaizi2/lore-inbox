Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbTCMXHN>; Thu, 13 Mar 2003 18:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbTCMXHN>; Thu, 13 Mar 2003 18:07:13 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:5274 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262620AbTCMXHL>; Thu, 13 Mar 2003 18:07:11 -0500
Message-ID: <3E711194.9010505@redhat.com>
Date: Thu, 13 Mar 2003 18:17:40 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Haverkamp <markh@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, dougg@torque.net,
       Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
References: <20030228133037.GB7473@jiffies.dk>	 <1047510381.12193.28.camel@markh1.pdx.osdl.net>	 <1047514681.23725.35.camel@irongate.swansea.linux.org.uk>	 <3E6FC8D6.7090005@torque.net>	 <1047517604.23902.39.camel@irongate.swansea.linux.org.uk> <1047570132.30105.7.camel@markh1.pdx.osdl.net>
In-Reply-To: <1047570132.30105.7.camel@markh1.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Haverkamp wrote:

> Does the cmd_per_lun element of the Scsi_Host_Template structure serve
> more than one purpose? 

Only when inappropriately abused by LLDD authors.  The cmd_per_lun value 
is suppossed to be for untagged devices only!  If you have a tape drive 
that doesn't support tagged commands but you want to be able to 
internally have the next command queued up and ready to go when the 
current command completes (in order to keep it streaming better), then 
you can set cmd_per_lun to 2 and you will get two outstanding commands 
for this device at a time.  I used that so that in my interrupt handler 
I could send the next command to the device before I passed the 
completed command up to the SCSI layer.

> In scsi_alloc_sdev it is passed into
> scsi_adjust_queue_depth.  In the aacraid case this is 512.  Later the
> aacraid driver (in aac_slave_configure) sets the queue depth to either
> 128 for tagged or 1 if not.

That's where you are suppossed to set the queue depth on tagged devices.


-- 
   Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
          Red Hat, Inc.
          1801 Varsity Dr.
          Raleigh, NC 27606


