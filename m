Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTFUQZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 12:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTFUQZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 12:25:19 -0400
Received: from dm4-159.slc.aros.net ([66.219.220.159]:10943 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264933AbTFUQZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 12:25:11 -0400
Message-ID: <3EF48A30.3010203@aros.net>
Date: Sat, 21 Jun 2003 10:39:12 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Steven Whitehouse <steve@chygwyn.com>
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
References: <3EF3F08B.5060305@aros.net> <20030621073224.GJ6754@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030621073224.GJ6754@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Fri, Jun 20, 2003 at 11:43:39PM -0600, Lou Langholtz wrote:
>
>In addition to comments from Andrew:
>. . .
>  
>
>>+static nbd_device_t nbd_devs[MAX_NBD];
>>+static struct request_queue nbd_queue[MAX_NBD];
>>+static spinlock_t nbd_lock[MAX_NBD];
>>    
>>
>
>Why not put these into nbd_device?
>
I'd considered that and I'm reconsidering it again now. Not convinced 
which way to go... Putting something as large as struct request_queue 
within the nbd_device seems unbalanced somehow. Then again, until 2.5 
the request_queue was typically shared by multiple devices of the same 
MAJOR so part of the way the code is has to do with the legacy code. 
Like the nbd_lock spinlock array and the struct request_queue queue_lock 
field. Along the lines you're pushing for, why not have struct 
requests_queue's queue_lock field then be the spinlock itself instead of 
just being a pointer to a spinlock???

>>+static uint32_t request_magic;
>>    
>>
>
>???  htonl(NBD_REQUEST_MAGIC) is perfectly OK in the place where you
>use it and more likely than not will give better code.
>
>  
>
>>+static uint32_t reply_magic;
>>    
>>
>
>Ditto.
>
What's wrong with having an explicit cache of this value that we can 
rest assured doesn't in the worst case get compiled into multiple calls 
to the htonl code?? Possible waste of one 4 byte memory location in the 
worst compiler case or is there another problem?

>. . .
>  
>
>>+static void __init init_nbd_dev(nbd_device_t *dev)
>>+{
>>+#ifdef PARANOIA
>>+	dev->magic = LO_MAGIC;
>>+#endif
>>+	atomic_set(&dev->refcnt, 0);
>>+	dev->flags = 0;
>>+	spin_lock_init(&dev->lock);
>>+	dev->harderror = 0;
>>+	nbd_qsys_init(&dev->tx_queue);
>>+	nbd_qsys_init(&dev->rx_queue);
>>+	dev->file = NULL;
>>+	dev->sock = NULL;
>>+	memset(&dev->sin, 0, sizeof(dev->sin));
>>+	dev->errcnt = 0;
>>+	dev->lasterr = ENOTCONN;
>>+	dev->closed = (RCV_SHUTDOWN|SEND_SHUTDOWN);
>>+	dev->ss_thread.task = NULL;
>>+	dev->tx_thread.task = NULL;
>>+	dev->rx_thread.task = NULL;
>>+	atomic_set(&dev->num_io_threads, 0);
>>    
>>
>
>*Ugh*.  These suckers are already zero-filled.
>  
>
Yeah. I'm a bit to attracted perhaps to zero filling things explicitly 
in my coding style. Sigh.

>>+	requests_out = 0;
>>+	qhandler_loops = 0;
>>    
>>
>
>Static variables that do not have explicit initializer are initialized with 0.
>  
>
Ditto.

>>+/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>+ *
>>+ * End of definitions shared with user space.
>>+ * From here on out, these definitions are only for kernel (driver).
>>+ */
>>+
>>+#ifdef MAJOR_NR
>>    
>>
>
>a) that's ifdef __KERNEL__
>b) use separate headers.
>  
>
Historically, some code used MAJOR_NR this way (like the original nbd 
driver unfortunately), and I didn't change that. Seperating the header 
was something I'd thought about but in the end felt that just changing 
two existing files was bad enough without going off and adding a third 
or more files. It's worth reconsidering though also. Thanks!

