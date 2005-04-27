Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVD0TOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVD0TOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 15:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVD0TOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 15:14:10 -0400
Received: from alog0427.analogic.com ([208.224.222.203]:35744 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261960AbVD0TOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 15:14:01 -0400
Date: Wed, 27 Apr 2005 15:12:59 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: mike.miller@hp.com
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, brace@hp.com
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
In-Reply-To: <20050427184022.GA16129@beardog.cca.cpqcorp.net>
Message-ID: <Pine.LNX.4.61.0504271502040.22947@chaos.analogic.com>
References: <20050427184022.GA16129@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005 mike.miller@hp.com wrote:

> Hello All,
> I have observed some behavior under certain failure conditions that seems
> as if the kernel may be ignoring write errors to disk.
> During very heavy read/write io if we force a disk to fail requests
> continue to be submitted until the controllers queue is full.
> Ultimately, the requests are timed out by the controller. When this
> happens we see filesystem corruption. Sometimes it's the file data,
> other times it's filesystem metadata that has been timed out and
> failed. Either way its obviously undesirable behavior.
> It looks like the OS/filesystem (ext2/3 and reiserfs) does not
> wait for for a successful completion. Is this assumption correct?
>
> Thanks,
> mikem

It depends. Obviously if you disconnect your hard drive, the writes
will fail with a time-out. But they fail after a number of retries
(it depends upon the type of disk and its driver). So, if you
"force" a timeout by disconnecting a drive, you don't have
the same situtation as a normally failed write.

Disk/file writes go like this (assuming no sync() or fsync()).

(1)  File data gets flushed to a queue.
(2)  When the queue gets nearly full, based upon a LRU mechanism,
      data are written to the disk.
(3)  If the disk-write fails, the driver retries the write.
(4)  If the write continues to fail, i.e., timeout, no disk, etc.
      the kernel gives up and does not hang forever. If you have
      disconnected the drive, you won't have any syslog writes to
      the device so your next boot won't show the event. It looks
      as though it was ignored.

You can observe the behavior by mounting a floppy disk and
then removing it while it is being written. There are many
attempts to write to the device and then that write is discarded.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
