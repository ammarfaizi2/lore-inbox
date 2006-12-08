Return-Path: <linux-kernel-owner+w=401wt.eu-S1761238AbWLHWpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761238AbWLHWpu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 17:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761245AbWLHWpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 17:45:50 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53435 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761238AbWLHWpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 17:45:49 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4579EAE7.9030201@s5r6.in-berlin.de>
Date: Fri, 08 Dec 2006 23:44:55 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Jiri Kosina <jikos@jikos.cz>, linux-kernel@vger.kernel.org,
       kernel-discuss@handhelds.org
Subject: Re: parallel boot device initialisation (kernel-space not userspace)
References: <4758137481lkcl@lkcl.net> <Pine.LNX.4.64.0612081737510.1665@twin.jikos.cz> <20061208174221.GE4666@lkcl.net>
In-Reply-To: <20061208174221.GE4666@lkcl.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton wrote:
> On Fri, Dec 08, 2006 at 05:38:47PM +0100, Jiri Kosina wrote:
>> On Fri, 8 Dec 2006, Luke Kenneth Casson Leighton wrote:
>>
>>> I Have A Great Idea(tm) and would like to describe it concisely to see 
>>> if anyone likes it and hopefully hasn't thought of it before so i'm not 
>>> consuming people's time. The idea is: parallel device initialisation of 
>>> built-in modules, to reduce kernel boot time.
>> Have you looked at CONFIG_PCI_MULTITHREAD_PROBE which is already present 
>> in recent kernels?
>  
>   ah _ha_.  thank you!
> 
>  honestly? no - because the small devices i'm compiling for don't have a
>  pci bus, ha ha :)
> 
>  but seriously - thank you for pointing that out, i'll definitely
>  investigate it.

Parallelized initialization needs to be added for one bus after another.
The driver core has infrastructure for it (struct
device_driver.multithread_probe; it has been suggested to move this flag
into struct bus_type). CONFIG_PCI_MULTITHREAD_PROBE actually just enables
this flag for the generic driver part of PCI drivers. The SCSI core as
another example has now infrastructure for parallelized asynchronous bus
scanning too and SCSI low-level drivers are being be converted to it.

Your thought to pick one subsystem and implement multithreaded probing is
exactly the way to go. If the subsystem is already properly using the
driver core, part of what's needed is already in place. You "merely" have
to look out for proper access to shared resources, and maybe synchronization
of the final step in initialization... (Like in case of the SCSI subsystem.
People usually want to wait for all scanning threads to finish before the
system proceeds to mount filesystems.)
-- 
Stefan Richter
-=====-=-==- ==-- -=---
http://arcgraph.de/sr/
