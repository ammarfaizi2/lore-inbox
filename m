Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbUDGOAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbUDGOAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:00:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:29867 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263627AbUDGOAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:00:33 -0400
Message-ID: <4074096E.9090202@us.ibm.com>
Date: Wed, 07 Apr 2004 09:00:14 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: call_usermodehelper hang
References: <4072F2B7.2070605@us.ibm.com> <20040406172903.186dd5f1.akpm@osdl.org> <20040407061146.GA10413@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Apr 06, 2004 at 05:29:03PM -0700, Andrew Morton wrote:
> 
>>Brian King <brking@us.ibm.com> wrote:
>>
>>>I have been running into some kernel hangs due to call_usermodehelper. Looking
>>>at the backtrace, it looks to me like there are deadlock issues with adding
>>>devices from work queues. Attached is a sample backtrace from one of the
>>>hangs I experienced. My question is why does call_usermodehelper do 2 different
>>>things depending on whether or not it is called from the kevent task? It appears
>>>that the simple way to fix the hang would be to never have call_usermodehelper
>>>use a work_queue since it must be called from process context anyway, or
>>>am I missing something?
>>>
>>
>>swapper is running call_usermodehelper() while holding
>>down_write(&bus->subsys.rwsem); via bus_add_driver().
>>
>>Meanwhile, keventd is blocked on the same lock in bus_add_device().
>>
>>I'd say that the bug lies in the kobject code - we should not call
>>call_usermodehelper() while holding any locks which keventd may ever
>>acquire.
> 
> 
> How is keventd calling sysfs code?  Is scsi using it to drive device
> detection somehow?  I don't see how the kobject core code itself can do
> this on its own.

scsi_add_device is being called from keventd by the ipr LLD. I am assuming this
is a reasonable thing to do. If not, then I would argue the scsi_add_device API
is broken as it must be called from task level, and if a LLD cannot use keventd,
then every LLD that wants to use it would need to create its own workqueue thread.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

