Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUK3AMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUK3AMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUK3AMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:12:30 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:59845 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261879AbUK3AMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:12:22 -0500
Message-ID: <41ABB93F.8060206@google.com>
Date: Mon, 29 Nov 2004 16:05:19 -0800
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
       Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
Subject: Re: usage of WIN_SMART
References: <1101290068.3787.26.camel@myLinux> <8783be6604112611137bcbfb61@mail.gmail.com>
In-Reply-To: <8783be6604112611137bcbfb61@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have seen SMART system's code containing WIN_SMART directive in ioctl
> sprinkled through out the code? What does that mean? What is its proper
> usage? Is there a proper documentation for it?
> 
> Thanks in advance for all replies

Hi Jagadeesh; I'm not entirely sure what your question is, so I'll see 
if I can provide a vague enough answer to cover it :)

Executive summary:  The SMART data is used to obtain information about 
the state of the drive hardware, for the purpose of predicting or 
diagnosing failures.  What little documentation there is exists in the 
ATA/ATAPI specification, but most of the data is vendor-specific and 
undocumented.  The easiest way to access SMART data is by cat'ing the 
appropriate file in /proc/ide/hdX




Long answer:

Many (all?) modern disk drives provide what is known as "SMART" 
(Self-Monitoring, Analysis, and Reporting Technology) data.  This 
includes information about the performance of the drive, including how 
many errors the drive has corrected, what the drive temperature has 
been, and so on.  The WIN_SMART command has a number of sub-commands 
(specified through the features register), which are described in the 
ATA spec under "Command descriptions".

AFAIK, there are no ioctls directly corresponding to the SMART commands, 
but the SMART commands can be accessed via the HDIO_DRIVE_TASKFILE 
ioctl.  (NOTE:  do not attempt this without a copy of the ATA spec in 
front of you.)

An even easier way to obtain the SMART data is to cat 
/proc/ide/hdX/smart_values or /proc/ide/hdX/smart_thresholds.

(At Google, we've added "smart_logs" and "smart_status" entries to 
/proc.  We'll be submitting those patches Real Soon Now.)

The interesting SMART subcommands are:

SMART READ DATA

   Read and return the 512-byte SMART data structure.
   The ATA spec describes this structure, but most of the
   interesting fields are vendor-specific.  Several of the
   vendors have adopted a number of common data fields,
   such as spinup time, reallocation count, seek error
   rate, and so on.  In general though, the information is
   really private to the vendor, intended for the vendor
   to diagnose the drive.

SMART READ LOG

   Returns one of a number of available logs, including log
   directory, summary error log, comprehensive error log,
   and so on, including a few vendor-specific logs.

SMART WRITE LOG

   Write data to a log.

SMART RETURN STATUS

   Returns a simple yes/no status indicating whether or
   not any of the device's thresholds have been exceeded.



I hope this helps answer your questions.

	-ed falk
