Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTDKVUC (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTDKVUC (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:20:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:24729 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261819AbTDKVUA convert rfc822-to-8bit (for <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:20:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
       "Riley Williams" <Riley@Williams.Name>,
       "Linux Kernel List" <Linux-Kernel@vger.kernel.org>,
       "Robert White" <rwhite@casabyte.com>
Subject: Re: kernel support for non-English user messages
Date: Fri, 11 Apr 2003 14:31:14 -0700
User-Agent: KMail/1.4.1
References: <PEEPIDHAKMCGHDBJLHKGMEPICGAA.rwhite@casabyte.com> <5.2.0.9.0.20030411220326.0258e5d0@mailhost.ivimey.org>
In-Reply-To: <5.2.0.9.0.20030411220326.0258e5d0@mailhost.ivimey.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304111431.14346.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 April 2003 02:04 pm, Ruth Ivimey-Cook wrote:
> At 10:21 11/04/2003, Riley Williams wrote:
> >It would also have to handle all the cases of...
> >
> >         #define CMD_PRINT(x...)   printk(KERN_INFO x)
> >
> >
> >         CMD_PRINT("This is some useless information");
>
> Personally, I feel there ought to be a standard set of these macros that
> can be used. Everyone keeps reinventing the same wheel :-(


We are trying to add standard logging macros to the kernel. Our first goal is 
to work with device driver writers to create useful macros that help prefix 
important information to messages logged from device drivers. We feel it 
would be useful for normal users, administrators, and service engineers to 
link a specific message with a specific device: so you can identify which 
device is erroring, for example. 

A first set of these macros is already in the 2.5 kernel. At the bottom of 
include/linux/device.h you'll find a set of dev_* macros:

/* debugging and troubleshooting/diagnostic helpers. */
#define dev_printk(level, dev, format, arg...)  \
        printk(level "%s %s: " format , (dev)->driver->name , (dev)->bus_id , 
## arg)

#ifdef DEBUG
#define dev_dbg(dev, format, arg...)            \
        dev_printk(KERN_DEBUG , dev , format , ## arg)
#else
#define dev_dbg(dev, format, arg...) do {} while (0)
#endif

#define dev_err(dev, format, arg...)            \
        dev_printk(KERN_ERR , dev , format , ## arg)
#define dev_info(dev, format, arg...)           \
        dev_printk(KERN_INFO , dev , format , ## arg)
#define dev_warn(dev, format, arg...)           \
        dev_printk(KERN_WARNING , dev , format , ## arg)


The idea behind the dev_printk macros is to identify the message with a 
specific device and the driver it manages. The dev_printk macro prints a 
corresponding driver name and bus id to identify the device and the driver. 
One can easily use that bus_id to search sysfs for the specific device the to 
which the message refers.

The dev_printk is a start. We could see separate macros for specific 
subsystems. Another example could be a netdev_printk macro that identifies 
not only the physical device by bus_id but adds the device interface 
information to the message as well. So, if you were working on a system with 
4 network devices, you'd know in the error message the network interface - 
eth3 - and which physical device - bus_id. 

Comments and suggestions are welcome. 

Thanks,

Dan
