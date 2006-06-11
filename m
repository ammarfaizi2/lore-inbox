Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWFKQX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWFKQX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 12:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWFKQX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 12:23:28 -0400
Received: from trinity.phys.uwm.edu ([129.89.57.159]:5338 "EHLO
	trinity.phys.uwm.edu") by vger.kernel.org with ESMTP
	id S1750970AbWFKQX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 12:23:27 -0400
Date: Sun, 11 Jun 2006 11:22:37 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
X-X-Sender: ballen@trinity.phys.uwm.edu
To: Theodore Tso <tytso@mit.edu>
cc: apiszcz@solarrain.com,
       Smartmontools Mailing List 
	<smartmontools-support@lists.sourceforge.net>,
       "Theodore Ts'o" <tytso@alum.mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Remy Card <Remy.Card@linux.org>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>,
       David Beattie <dbeattie@softhome.net>
Subject: Re: [smartmontools-support] The Death and Diagnosis of a Dying Hard
 Drive - Is S.M.A.R.T. useful?
In-Reply-To: <20060611125929.GA8438@thunk.org>
Message-ID: <Pine.LNX.4.62.0606111113001.10540@trinity.phys.uwm.edu>
References: <Pine.LNX.4.64.0606100615500.15475@p34.internal.lan>
 <20060610105141.GE30775@lug-owl.de> <Pine.LNX.4.64.0606100658130.26702@p34.internal.lan>
 <Pine.LNX.4.62.0606102212060.17718@trinity.phys.uwm.edu> <20060611125929.GA8438@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:

> The real question though is whether the disk continues to work OK from 
> this point forward, or whether it is a prelude to an ever-increasing 
> number of bad blocks.  If it is the latter, and S.M.A.R.T. still didn't 
> give any warning, then it would certainly be an indictment of that 
> particular manufacturer's S.M.A.R.T. implementation.

I have a practical suggestion. Most recent disk drives have a new type of 
self-test option called 'selective self-tests'.  This allows you to run a 
self-test on up to five user-defined ranges of LBAs.  For example, if you 
suspect that LBA=12345678 is failing, then instead of having to wait an 
hour or two for the entire disk surface to be scanned, you can tell the 
disk to scan (say) the range LBA_1=12345000 to LBA_2=12345999 five times 
in a row, which takes only a few seconds.  By repeating this process many 
times you can scan a trouble area on the disk a few thousands of times in 
an hour.

For a couple of years, smartmontools smartctl has had the functionality to 
invoke these selective self-tests if the disk supports them.  But (until 
just last week) it was awkward: it required a kernel built with TASKFILE 
support enabled, and only worked with (some of the) ide drivers. This has 
changed. Thanks to hard work by Doug Gilbert and Jeff Garzik to built a 
SAT (SCSI to ATA Translation) layer in libata and to put a SAT interface 
into smartmontools, anyone can easily access this functionality with any 
SATA disk that supports selective self-test via libata.

Note: no smartmontools release incorporates this yet.  You have to build 
from CVS.  Here are the instructions (4 lines):

cvs -d:pserver:anonymous@smartmontools.cvs.sourceforge.net:/cvsroot/smartmontools login (when prompted for a password, just press Enter)
cvs -d:pserver:anonymous@smartmontools.cvs.sourceforge.net:/cvsroot/smartmontools co sm5
cd sm5
./autogen.sh && ./configure && make

Here is an example of running a selective self-test five times on the 
same range of LBAs as above:

[slave0123 ~]# ./smartctl -d sat -t select,12345000-12345999 -t select,12345000-12345999 -t select,12345000-12345999 -t select,12345000-12345999 -t select,12345000-12345999 /dev/sda
smartctl version 5.37 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION ===
Sending command: "Execute SMART Selective self-test routine immediately in 
off-line mode".
SPAN         STARTING_LBA           ENDING_LBA
    0             12345000             12345999
    1             12345000             12345999
    2             12345000             12345999
    3             12345000             12345999
    4             12345000             12345999
Drive command "Execute SMART Selective self-test routine immediately in 
off-line mode" successful. Testing has begun.


Wait a few seconds, then see the results of the selective self-testing:
[slave0123 ~]# ./smartctl -d sat -l selective -l selftest /dev/sda
smartctl version 5.37 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF READ SMART DATA SECTION ===
SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Selective offline   Completed without error       00%      1473         -
# 2  Selective offline   Completed without error       00%      1473         -
# 3  Extended offline    Completed without error       00%      1467         -

SMART Selective self-test log data structure revision number 1
  SPAN   MIN_LBA   MAX_LBA  CURRENT_TEST_STATUS
     1  12345000  12345999  Not_testing
     2  12345000  12345999  Not_testing
     3  12345000  12345999  Not_testing
     4  12345000  12345999  Not_testing
     5  12345000  12345999  Not_testing

Justin, I hope that this is of some help to you and others with similar 
issues.

Cheers,
 	Brucce
