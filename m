Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269670AbUICMQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269670AbUICMQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269666AbUICMNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:13:17 -0400
Received: from the-village.bc.nu ([81.2.110.252]:24467 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269643AbUICMKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:10:40 -0400
Subject: Re: Crashed Drive, libata wedges when trying to recover data
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Stark <gsstark@mit.edu>
Cc: Brad Campbell <brad@wasp.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <87u0ugt0ml.fsf@stark.xeocode.com>
References: <87oekpvzot.fsf@stark.xeocode.com>
	 <4136E277.6000408@wasp.net.au>  <87u0ugt0ml.fsf@stark.xeocode.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094209696.7533.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 12:08:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 05:52, Greg Stark wrote:
> I get the same message and the same basic symptom -- any process touching the
> bad disk goes into disk-wait for a long time. But whereas before as far as I
> know they never came out, now they seem to come out of disk-wait after a good
> long time. But then maybe I just never waited long enough with 2.6.6.

This looks hopeful. You are now seeing the IDE layer error dump. Right
now it doesn't decode the LBA block number although that data is
available in the taskfile so I can knock up a test patch for you to try
if you want.

> This means I would be able to do the recovery in theory, but in practice it'll
> just take an infeasible length of time. I have gigs of data to go through and
> at the amount of time it takes to time out after each error it'll take me many
> days (years I think) to just to figure out which blocks to avoid.

Open the disk device directly with O_DIRECT, read in something like 64K
chunks. That won't do readahead so it gets easier to work out the
problem areas. You can now sit in a loop doing

		if(pread() failed)
			write blank
			log
		else
			write data

then go back and binary search the holes it logs the next morning.

Alan

