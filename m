Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTJ2Eu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 23:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTJ2Eu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 23:50:59 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:23442 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261820AbTJ2Euz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 23:50:55 -0500
Message-ID: <3F9F46A6.3090901@cyberone.com.au>
Date: Wed, 29 Oct 2003 15:48:38 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Amit Patel <patelamitv@yahoo.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: as_arq scheduler alloc with 2.6.0-test8-mm1
References: <20031029043423.41171.qmail@web13004.mail.yahoo.com>
In-Reply-To: <20031029043423.41171.qmail@web13004.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Amit Patel wrote:

>--- Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>No, you're on the right track. Actually, in the
>>block device
>>you will allocate the queue, and the queue will then
>>allocate
>>the elevator. First see if the queue is being
>>properly allocated
>>and freed. If it is not, then the problem is in the
>>SCSI layer.
>>
>>
>>
>
>Hi Nick,
>
>During scsi_scan.c:scsi_probe_and_add_lun it allocates
>scsi device and request_queue to send the
>scsi_request. If during this scan it finds no device
>attached to target it will deallocate request__queue.
>But since there was no disk found it never called
>add_disk and so it never go through blk_register_queue
>function to register elevator queue. So during clean
>up it just calles blk_cleanup_queue which does _not_
>clean up elevator_data. 
>
>This is just what I think is happening by looking at
>the code. I might be missing something. But in this
>case either blk_cleanup_queue should clean elevator
>also as part of cleanup instead of it getting cleaned
>up through blk_unregister_queue or scsi  layer needs
>to make some changes during scan. I do not know what
>implication it might have if cleanup is done as part
>of blk_cleanup_queue on other kind of block devices. I
>will try to put this cleanup as part of
>blk_cleanup_queue to see if it works. 
>

Yeah that sounds right. This is due to elv-select.patch. Its
quite a rats nest in there though :(

What should be happening is blk_alloc_queue should register
the queue kobject, and blk_init_queue should allocate the
the elevator kobject (which should be registered in the process).

add_disk should just be taking a reference on the queue, and
add a symlink in sysfs to the real queue (I think). I have a
patch to do this, but it is a bit ugly because I don't know
where in sysfs to put the queue object.

Anyway, if this isn't going to be done before 2.6.0, I guess
Andrew you should drop by elv-select patches for now. That
doesn't fix anything, but it hides some of the problems.


