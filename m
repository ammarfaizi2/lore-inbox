Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbULPSVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbULPSVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbULPSVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:21:15 -0500
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:64995
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S261967AbULPSUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:20:51 -0500
Message-ID: <41C1D1DB.2000106@pbl.ca>
Date: Thu, 16 Dec 2004 12:20:11 -0600
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug in sym53c8xx? [Was: RAID1 + LVM not detected during boot
 on 2.6.9]
References: <DBFABB80F7FD3143A911F9E6CFD477B0033AE3D6@hqemmail02.nvidia.com> <41C0935B.7060509@pbl.ca> <cpr51c$gc4$1@sea.gmane.org>
In-Reply-To: <cpr51c$gc4$1@sea.gmane.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:
> I am not sure how to classify this bug properly. 
> 
> First, the driver correctly follows the behaviour described by Greg KH: it
> should load successfully even if there is no corresonding hardware. Then
> (in already-loaded state) it should generate hotplug events when the
> hardware says it's present (and that's slow). Greg KH says that in hotplug
> world (i.e., in reality) nothing else is possible. From this viewpoint, the
> bug is in the linuxrc script provided by RedHat. It should really either
> poll and sleep and wait or use udev to get notification when the disk is
> really accessible.

I've just stumbled at another problem that seems to boil down to the 
same thing.  This time modules were not PCI related.  They were file 
system modules: jbd and ext3.

The ext3.ko needs some symbols that are defined in jbd.ko.  The linuxrc 
(init) script first loads jbd.ko, and than ext3.ko.  ext3.ko complains 
about unknown symbols (journal_*) that are defined in jbd.ko and fails 
to load.  Again, inserting sleep between invocations of insmod solves 
the problem.

The problem was first referenced on Fedora Users mailing list, under 
thread "FC3 SMP builds do NOT contain ext3 drivers in the build!!!!" 
(kind of incorrect subject line, ext3 driver was included, but it failed 
to load due to unknown symbols).  It seems that OP migrated his file 
systems back to ext2 in order to be able to boot.  There were couple of 
people that experienced this race condition problem.

Now, this might be the linuxrc (init) script problem.  But if in order 
to boot reliably we need to add "sleep 10" lines after each and every 
module from initrd image is loaded, it becomes ridicilus.  Shouldn't 
there be a way to load module and wait until it signals "I'm done with 
initialization" before insmod command exits?  This would solve problems 
with hot-pluggable devices too (driver would scan the bus, than signal 
it is initialized, and after that it would continue doing its 
hot-pluggable agenda).

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
