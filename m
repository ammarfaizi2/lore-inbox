Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVFOILz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFOILz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 04:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVFOILz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 04:11:55 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:3214 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S261300AbVFOILw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 04:11:52 -0400
Message-ID: <42AFE432.8000204@aitel.hist.no>
Date: Wed, 15 Jun 2005 10:17:54 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nico Schottelius <nico-kernel@schottelius.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why is one sync() not enough?
References: <20050614094141.GE1467@schottelius.org>
In-Reply-To: <20050614094141.GE1467@schottelius.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:

>Hello again!
>
>When my system shuts down and init calls sync() and after that
>umount and then reboot, the filesystem is left in an unclean state.
>
>If I do sync() two times (one before umount, one after umount) it
>seems to work.
>
>Can someboy explain that to me?
>  
>
You shouldn't need those syncs, as umount does its own
syncing.  There may be other explanations:

* Your reboot actually powers down (or resets) the disk.
   IDE disks are known for caching stuff, they may indicate
   that data is written slightly before it actually happens.
   (The same applies to scsi - if you enable caching there for
   the little extra performance it buys.)
 
   Rebooting really quickly after umount in such a case can cut
   power to the disk before it finishes writing.  If this is the case,
   then a few seconds of sleep after umount before reboot
   will work just as well as that sync.  I don't recommend this
   as a solution, but it is an easy diagnostic!

* Your startup script accidentally mounted the fs twice.
  (Yes - linux support that, and the first umount won't undo
   both mounts.)  This simply means the fs isn't umounted
  when you reboot, but an extra sync and you might get lucky.
 
  Check to see that nothing at all is mounted as you reboot.

Helge Hafting
