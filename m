Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUDGBqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 21:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUDGBqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 21:46:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:2293 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263424AbUDGBqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 21:46:48 -0400
Message-ID: <40735D7E.2090304@us.ibm.com>
Date: Tue, 06 Apr 2004 20:46:38 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: call_usermodehelper hang
References: <4072F2B7.2070605@us.ibm.com> <20040406174150.D22989@build.pdx.osdl.net>
In-Reply-To: <20040406174150.D22989@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Brian King (brking@us.ibm.com) wrote:
> 
>>I have been running into some kernel hangs due to call_usermodehelper. Looking
>>at the backtrace, it looks to me like there are deadlock issues with adding
>>devices from work queues. Attached is a sample backtrace from one of the
>>hangs I experienced. My question is why does call_usermodehelper do 2 different
>>things depending on whether or not it is called from the kevent task? It appears
>>that the simple way to fix the hang would be to never have call_usermodehelper
>>use a work_queue since it must be called from process context anyway, or
>>am I missing something?
> 
> 
> It does two different things because it's trying to run from keventd.
> In the case that current is not keventd, it schedules the work, so
> keventd will pick that work up later to run in it's process context.
> 
> How early is this hang?  

Pretty early. Boot time, loading scsi drivers. While initializing the
third scsi adapter on the system a device shows up dynamically on the
first adapter, the LLD schedules work to call scsi_add_device and we
end up with the hang.


It looks like init thread adds work and waits
> for it's completion while holding a semaphore.  It is never woken up by
> keventd which is sleeping waiting for wakeup from semaphore that init
> thread took.
> 
> Seems troubling to hold the sem while calling call_usermodehelper, as that
> could go off for a long time.

I agree. There is another similar hang I ran into recently with the scsi 
core in that I was calling scsi_add_device from keventd, which ended up 
sleeping on the scan_mutex since the module load process was calling 
scsi_scan_host. scsi_scan_host was in the same kobject hotplug code, 
calling call_usermodehelper. I figured my LLD shouldn't be doing that, 
so I synchronized the events. Perhaps that was the wrong fix... I 
suppose I could have changed the LLD to always call 
scsi_scan_host/scsi_add_device/etc. from keventd...

-Brian


