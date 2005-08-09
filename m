Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVHIXXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVHIXXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 19:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVHIXXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 19:23:41 -0400
Received: from dvhart.com ([64.146.134.43]:62337 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932192AbVHIXXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 19:23:40 -0400
Date: Tue, 09 Aug 2005 16:23:27 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       bugme-daemon@kernel-bugs.osdl.org
Subject: Re: [Bugme-new] [Bug 5003] New: Problem with symbios	driver	on	recent	-mm trees
Message-ID: <1200490000.1123629807@flay>
In-Reply-To: <1123606536.5170.27.camel@mulgrave>
References: <135040000.1123216397@[10.10.2.4]> <20050804233927.2d3abb16.akpm@osdl.org> <1123251892.5003.6.camel@mulgrave> <179280000.1123252564@[10.10.2.4]> <1123254086.5003.10.camel@mulgrave> <453380000.1123562466@[10.10.2.4]> <1123597604.5170.10.camel@mulgrave> <531000000.1123599581@[10.10.2.4]> <1123606536.5170.27.camel@mulgrave>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, August 09, 2005 11:55:36 -0500 James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Tue, 2005-08-09 at 07:59 -0700, Martin J. Bligh wrote:
>> Dear novice test examiner,
>> 
>> It's in http://test.kernel.org with everything else ;-)
>> 2.6.13-rc4-mm1+jejb_fix ... drills down to:
>> 
>> http://test.kernel.org/10080/debug/console.log
> 
> Well, OK, apparently some novice coder made an error converting from a
> stack allocated buffer to a kmalloc'd one in the sense handling
> routines.
> 
> I think this patch should fix it (or at least restore it to the level of
> bugginess it had before).


Wheeeeeee! that fixed it. Thanks very much. Log is here if you want to
peek at it:


http://test.kernel.org/10431/debug/console.log

Triples all round!

M.
 
> James
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -342,12 +342,12 @@ int scsi_execute_req(struct scsi_device 
>  		sense = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
>  		if (!sense)
>  			return DRIVER_ERROR << 24;
> -		memset(sense, 0, sizeof(*sense));
> +		memset(sense, 0, SCSI_SENSE_BUFFERSIZE);
>  	}
>  	result = scsi_execute(sdev, cmd, data_direction, buffer, bufflen,
>  				  sense, timeout, retries, 0);
>  	if (sshdr)
> -		scsi_normalize_sense(sense, sizeof(*sense), sshdr);
> +		scsi_normalize_sense(sense, SCSI_SENSE_BUFFERSIZE, sshdr);
>  
>  	kfree(sense);
>  	return result;
> 
> 
> 
> 


