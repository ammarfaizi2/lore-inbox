Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSDBME5>; Tue, 2 Apr 2002 07:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311582AbSDBMEi>; Tue, 2 Apr 2002 07:04:38 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:19090 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S311424AbSDBMEd>; Tue, 2 Apr 2002 07:04:33 -0500
Message-ID: <3CA99EA0.1B2391FF@wipro.com>
Date: Tue, 02 Apr 2002 17:35:52 +0530
From: "Madhavan N.S." <madhavan.nair@wipro.com>
Organization: Wipro Global R&D
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Frame Relay stack on Linux
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-48dc53fa-4623-11d6-a219-0000e22173f5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-48dc53fa-4623-11d6-a219-0000e22173f5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

We are developing  Frame Relay stack on Linux 2.4 kernel.
It's implemented as a dynamically loadable software module and it is
registered
as a network driver.  Frame Relay module uses the services of lower
layer
hardware driver module for transmission & reception of data packets.

Working of Frame Relay stack:

FR task is initiated after loading the module using socket
ioctl interface. Once initiated FR task goes to sleep waiting
for events. It uses interruptible_sleep_on kernel function.

There can be 3 different events which can wake up the FR task.

1. When the Frame Relay NIC gets packet from network ,lower driver
    process it as part of interrupt processing and wake up the FR task
using        wake_up_interruptible kernel function.  FR task will
process the packet and call netif_rx function to give the packet to IP
layer.

2. When IP layer sends packet through FR stack it invokes Frame Relay
   transmit function which will wake up the FR task
using                    wake_up_interruptible kernel function. FR task
will process it and
   send it using lower hardware driver.

3. After transmitting the packet FR NIC card interrupts the lower driver
which  will again wake up the FR task using  wake_up_interruptible
kernel function. This indicates transmit  completion to the FR task and
it schedules next packet to be  transmitted.

   After processing the event FR task again go back to the main loop
   again waiting for events.



Problem Description :

FR stack is crashing when TELNET/FTP application is run.
It's crashing on the server side i.e., machine which accepts the
connection.

It panics when FR task goes to sleep (by calling interruptible_sleep_on
function ) after calling netif_rx fuction. This kernel function in turn
calls schedule() and while executing schdule() function  do_page_fault()
is getting invoked and system panics.


But PING through FR stack is working absolutely fine. We have written
socket application program for data transfer through FR stack. For UDP
socket (SOCK_DGRAM) data transfer goes fine , but when data transfer
goes through TCP socket (SOCK_STREAM) it panics at the same place as
when we run telnet/ftp application i.e.,  in schedule function.

For testing the stack Uniprocessor machine is used.
Can anyone help me to solve this problem?

Please do CC to madhavan.nair@wipro.com as I have not registered in the
Mailing List.


Madhavan











------=_NextPartTM-000-48dc53fa-4623-11d6-a219-0000e22173f5
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited
is 'privileged' and 'confidential' and intended for use only by the
individual or entity to which it is addressed. You are notified that any
use, copying or dissemination of the information contained in the E-MAIL
in any manner whatsoever is strictly prohibited.


 ********************************************************************

------=_NextPartTM-000-48dc53fa-4623-11d6-a219-0000e22173f5--
