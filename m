Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUJNN2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUJNN2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUJNN2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:28:38 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:58926 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S264648AbUJNN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:28:35 -0400
Message-ID: <416E7E39.4040102@myrealbox.com>
Date: Thu, 14 Oct 2004 18:55:13 +0530
From: Ganesan R <rganesan@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Stoffel <stoffel@lucent.com>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       torsten.scherer@uni-bielefeld.de
Subject: Re: Linux 2.6.x wrongly recognizes USB 2.0 DVD writer
References: <ckln33$c3e$1@sea.gmane.org> <16750.30914.666243.108593@gargle.gargle.HOWL>
In-Reply-To: <16750.30914.666243.108593@gargle.gargle.HOWL>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:

>Ganesan> I have a NEC ND-2500A DVD writer in a ByteCC USB 2.0 external
>Ganesan> enclosure.  It's recognized perfectly in 2.4.27 (Debian
>Ganesan> kernel-image-2.4.27-1-686 package)
>
>I've got a ByteCC external enclosure too, and I can't get it to work
>reliably under Linux or Windows under Firewire.  I'd return it and get
>something better.
>
Thanks for the info. As I mentioned, the enclosure works flawlessly for 
me under 2.4.27. It's getting detected incorrectly only in 2.6.x. 
Another user reported a similar problem but was able to get dvd burning 
working by removing the checks from the writing tool. So, it looks like 
detection has been messed up only in 2.6.x.

Once again, 2.6.8 reports it as

======
scsi3 : SCSI emulation for USB Mass Storage devices
  Vendor: Revoltec  Model: USB/IDE Bridge (  Rev: 0103
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdb at scsi3, channel 0, id 0, lun 0
======

whereas 2.4.27 correctly reports

========                                                               
scsi2 : SCSI emulation for USB Mass Storage                            
   Vendor: _NEC      Model: DVD_RW ND-2500A                            
   Type:   CD-ROM    ANSI SCSI revision: 02                            
Attached scsi CD-ROM sr1 at scsi2, channel 0, id 0, lun 0              
sr1: scsi-1 drive                                                      
USB Mass Storage support registered.                                   
========                                                               

I checked the kernel sources. Sure enough, 
drivers/usb/storage/unusual_devs.h
has a new entry in the 2.6 tree:

========
/* <torsten.scherer@uni-bielefeld.de>: I don't know the name of the bridge
 * manufacturer, but I've got an external USB drive by the Revoltec company
 * that needs this. otherwise the drive is recognized as /dev/sda, but any
 * access to it blocks indefinitely.
 */
UNUSUAL_DEV(  0x0402, 0x5621, 0x0103, 0x0103,
        "Revoltec",
        "USB/IDE Bridge (ATA/ATAPI)",
        US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_FIX_INQUIRY),
========

I have not yet tested after removing this entry, but this looks to be 
the likely problem. The enclosure actually supports both 3.5 IDE hard 
disks as well as 5.25 CD/DVD drives. I have no clue why this entry 
should cause the drive to be wrongly detected. CCing linux-usb-devel for 
help.

Please CC me on replies to linux-usb-devel since I am not subscribed to 
that list. Thanks.

Ganesan
