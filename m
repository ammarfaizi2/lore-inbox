Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbUD1X3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUD1X3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUD1X1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:27:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:22511 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261891AbUD1X04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:26:56 -0400
Message-ID: <40903DBD.1000704@us.ibm.com>
Date: Wed, 28 Apr 2004 18:26:53 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: userspace pci config space accesses
References: <409026CE.8050905@us.ibm.com> <20040428225236.GA27250@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Apr 28, 2004 at 04:49:02PM -0500, Brian King wrote:
> 
>>I recently ran into a problem where lspci was trying to read pci config 
>>space
>>of a pci adapter while the device driver for that adapter was running BIST
>>on it. On ppc64, this resulted in a PCI error and puts the slot into an 
>>error state making it unusable for the remainder of that system boot.
>>Should there be some blocking in place so that userspace pci config
>>reads will not occur in these windows or is using tools like lspci
>>user beware?
> 
> 
> There already is a pci_config_lock that should be grabbed when accessing
> pci config space.  It sounds like the driver needs to play a bit nicer
> when it's running a self test :)

Found the lock. Unfortunately, its not exported, so a device driver can't use
it without changing that. Additionally, its a spinlock, and it takes 2 seconds
to complete BIST, which seems a bit too long to hold a spinlock.

> What driver is doing this?

The ipr driver, a scsi device driver for ppc64.

http://marc.theaimsgroup.com/?l=linux-scsi&m=108144942527994&w=2

The driver runs BIST at device initialization time to ensure that the device
is in a clean state. It will also run BIST on module unload, and in various
error scenarios.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

