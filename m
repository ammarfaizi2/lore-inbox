Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTADCDn>; Fri, 3 Jan 2003 21:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbTADCDn>; Fri, 3 Jan 2003 21:03:43 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:59627 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S265008AbTADCDk>; Fri, 3 Jan 2003 21:03:40 -0500
Message-ID: <3E164390.4040305@torque.net>
Date: Sat, 04 Jan 2003 13:14:40 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: inquiry in scsi_scan.c
References: <UTC200301040021.h040LB128544.aeb@smtp.cwi.nl> <20030103170404.D4315@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:
> Actually, 5 isn't minimal... it's sub-minimal.  That's an error in the
> INQUIRY data.  The minimum (by spec) is 36 bytes.
> 
> There should probably be a sanity check to never ask for INQUIRY less than
> 36 bytes.  I thought there used to be such a thing....

Matt,
The scan code does a 36 byte INQUIRY first and then does
a second INQUIRY if the response indicates more (than 36
bytes) is available. In this case _less_ than 36 bytes
was supplied. So either the scsi scan code or usb-storage **
needs to make some pro forma vendor, model and rev strings.

We found previously that doing a longer INQUIRY (254
or 255 bytes) locked up some [arguably broken] usb devices.
Hence we switched to the twin INQUIRY strategy. Evidentally
FreeBSD does the same thing.

Throwing away such broken devices is not an option I guess.
What does that device look like under Windows?


** Assuming the usb device in question is using usb-storage,
shouldn't it make sure at least 36 (valid) bytes of response
data is supplied by an INQUIRY? Andrew Morton had to do this
(perhaps at a lower level in the usb stack) to make some device
he had play with the scsi subsystem.

Doug Gilbert

> On Sat, Jan 04, 2003 at 01:21:11AM +0100, Andries.Brouwer@cwi.nl wrote:
> 
>>Got a new USB device and noticed some scsi silliness while playing with it.
>>
>>A bug in scsi_scan.c is
>>
>>        sdev->inquiry = kmalloc(sdev->inquiry_len, GFP_ATOMIC);
>>        memcpy(sdev->inquiry, inq_result, sdev->inquiry_len);
>>        sdev->vendor = (char *) (sdev->inquiry + 8);
>>        sdev->model = (char *) (sdev->inquiry + 16);
>>        sdev->rev = (char *) (sdev->inquiry + 32);
>>
>>since it happens that inquiry_len is short (in my case it is 5)
>>and the vendor/model/rev pointers are wild.
>>Catting /proc/scsi/scsi now yields random garbage.
>>
>>I made a patch but hesitated between a small patch and a larger one.
>>Why do we have this malloced inquiry field? As far as I can see
>>nobody uses it. And the comment in scsi_add_lun() advises us
>>not to save the inquiry, precisely what we did until recently.
>>So, should this change from 2.5.11 be reverted?
>>
>>Andries
>>
>>
>>[My present scsi_scan.c differes quite a lot from a stock one.
>>Already fixed the scsi_check_id_size() some time ago.

