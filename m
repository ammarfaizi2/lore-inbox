Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752826AbVHGVnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbVHGVnz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbVHGVnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:43:55 -0400
Received: from hermes.domdv.de ([193.102.202.1]:16392 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1752826AbVHGVny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:43:54 -0400
Message-ID: <42F68098.5010203@domdv.de>
Date: Sun, 07 Aug 2005 23:43:52 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux@dominikbrodowski.net, pavel@ucw.cz
Subject: Re: 2.6.13-rc4: yenta_socket and swsusp
References: <42EE9A60.5050700@domdv.de> <20050804171514.01028a67.akpm@osdl.org>
In-Reply-To: <20050804171514.01028a67.akpm@osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------000006090700040001080907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006090700040001080907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> OK so we have one solid regression there.  Are the other problems also new
> since 2.6.11?
> 
> Could you please retest 2.6.13-rc6 when it's out and if problems remain,
> raise a bugzilla.kernel.org entry so we can keep track of the problem? 
> Thanks.

After retesting with 2.6.13-rc6 quite some of the problems are gone.
There are, however, still problems:

1. It is necessary to do the following or suspend will hang:

   cardctl eject
   killproc cardmgr
   remove all pcmcia modules

   In 2.6.11 it was sufficient to call 'cardctl eject'. I'll create a
   bug report.

2. The attached script can produce all sorts of pcmcia related
   problems if it is modified where stated - the attached version
   seems to work without problems if not modified. Do you want
   a bug report filed for this, too?
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------000006090700040001080907
Content-Type: application/x-sh;
 name="pcmcia.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcmcia.sh"

#!/bin/sh
#
# The following script shows all sorts of problems
# with pcmcia for the 2.6.13-rc6 kernel.
#
# In my case the following cards are inserted:
#
# 3com 3CRWB6096B Bluetooth card (serial_cs)
# Pretec ATA Flash Disk 16MB (ide_cs)
#
# There are are no accesses to the pcmcia cards
# except from this script.
#
while [ 1 ]
do
	echo tic
	#
	# comment the following command and the modules of
	# the inserted pcmcia cards (e.g. serial_cs) will
	# stay in use after cardmgr is terminated thus making
	# removal of the pcmcia modules impossible
	#
	/sbin/cardctl eject
	/sbin/killproc /sbin/cardmgr
	for i in pcmcia yenta_socket rsrc_nonstatic pcmcia_core
	do
		rmmod $i
	done
	#
	# comment the following delay and you can get
	# oopses for ide_cs if a pcmcia flash disk is
	# inserted (e.g. at ide_do_request+82)
	#
	usleep 1000000
	echo tac
	for i in pcmcia_core rsrc_nonstatic yenta_socket pcmcia
	do
		modprobe $i
	done
	/sbin/cardmgr > /dev/null 2>&1
	#
	# comment the following delay or change it to
	# 100000 and rmmod of yenta_socket will hang
	# with 'users' of the module even as there are
	# none - alternatively modules like serial_cs
	# will hang with 'users' and thus can't be
	# removed
	#
	usleep 10000000
done

--------------000006090700040001080907--
