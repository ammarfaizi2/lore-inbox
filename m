Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSHAR7e>; Thu, 1 Aug 2002 13:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSHAR7e>; Thu, 1 Aug 2002 13:59:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:50574 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316289AbSHAR7d>; Thu, 1 Aug 2002 13:59:33 -0400
Message-ID: <3D4977C3.7050806@us.ibm.com>
Date: Thu, 01 Aug 2002 11:02:43 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>
Subject: Re: [RFC] Push BKL into chrdev opens
References: <3D490BF2.2000709@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> This patch adds the BKL to each character device's open() function. The 
> BKL will remain in chrdev_open() until the module unload races are 
> fixed, but this makes it unnecessary there for any other reason.

Greg KH noticed that I'd touched USB, and wondered about the places 
where get/put_fops were used to make sure the driver gets called 
directly the next time, instead of going through the subsystem.  I 
don't believe that the BKL is needed in the devices in this case, only 
in the subsystem itself.

During inode init (init_special_inode) f_op is set to def_chr_fops, 
which contains chrdev_open
First open of char device file:
         if (f->f_op && f->f_op->open) {
                 error = f->f_op->open(inode,f);
         }
The ->open() call goes to chrdev_open
USB is determined to handle the device
BKL is grabbed in chrdev_open
generic USB ->open() called (usb_open())
driver ->open() is called
f_op is replaced with the driver's f_op struct.
BKL is released

Subsequent calls:
         if (f->f_op && f->f_op->open) {
                 error = f->f_op->open(inode,f);
         }
->open() goes directly to driver.  No BKL grabbed after first call. 
The drivers were only protected during the first call, not during 
subsequent ones.  The addition of the BKL to usb_open() alone 
duplicates this behavior.  Adding BKL to individual devices in cases 
like this is not required.

The tree is available for pulling from:
http://linux-bkl.bkbits.net/linux-2.5-bkl
-- 
Dave Hansen
haveblue@us.ibm.com

