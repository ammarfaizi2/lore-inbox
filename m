Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266804AbTAORpe>; Wed, 15 Jan 2003 12:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTAORpe>; Wed, 15 Jan 2003 12:45:34 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:27656 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S266804AbTAORpd>; Wed, 15 Jan 2003 12:45:33 -0500
Message-ID: <3E25A009.6010402@google.com>
Date: Wed, 15 Jan 2003 09:53:13 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>
Subject: [RFC]: Changes to ide_task_request
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Seagate has been kind enough to tell me how to update the firmware on 
their drives (under NDA of course).  I believe adding a timeout field, a 
recovery time field and an error handling field to ide_task_request_t 
(and of course appropriate kernel handling code) would be enough to 
allow a userspace program to update the drive firmware.  I am hoping 
that if I write such a program and send the source back to Seagate that 
they will support it.  I'm also hoping that the other manufacturers 
firmware update methods are similiar enough to be handled by the same 
system.

I'd like to make the following changes to hdreg.h:

#define ERROR_IGNORE 0  /* Just ignore it. */
#define ERROR_NORMAL 1  /* Just call the device error handler */
#define ERROR_SRST 2    /* Just do an SRST */
#define ERROR_RETRY_ONCE 3 /* Retry Once */
#define ERROR_RETRY  4   /* Retry until it suceedes. */
.
.
.


typedef struct ide_task_request_s {
    task_ioreg_t    io_ports[8];
    task_ioreg_t    hob_ports[8];
    ide_reg_valid_t    out_flags;
    ide_reg_valid_t    in_flags;
    int        data_phase;
    int        req_cmd;
    unsigned long    out_size;
    unsigned long    in_size;
    int timeout;                 /* How long in HZ to wait for the 
command to complete. */
    int recovery_time;           /* How long in HZ to wait after
                                    command completion or an error
                                    before issuing a new command. */
    int error_handling;
                 

} ide_task_request_t;

I chose HZ instead of microseconds for the timeouts because I envision a 
kernel specific shared library that does the translatation and actual 
ioctl and HZ should make the kernel side of things a bit easier.

    Ross


