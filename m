Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbTLaSv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 13:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbTLaSv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 13:51:58 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:29691 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265233AbTLaSv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 13:51:56 -0500
Date: Wed, 31 Dec 2003 10:51:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Cc: ricklind@us.ibm.com
Subject: Iostats reporting problems was: Linux 2.4.24-pre3
Message-ID: <20031231185135.GD1882@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, ricklind@us.ibm.com
References: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 11:13:57AM -0200, Marcelo Tosatti wrote:
> <mfedyk:matchmail.com>:
>   o Use "%u" when printing extended /proc/partitions statistics
>   o extended stats correction: Field rd_ios can be negative

Without the patch any of the 10 of 11 fields can go negative after enough
activity, not just rd_ios

With or without these patches, when there is activity on a partition
ios_in_flight[1] looks sane for the individual partition statistics since
ios_in_flight doesn't go negative, but the same activity causes
ios_in_flight on the drive (hda instead of hda1 for example) to be
consistantly negative (usually -2 or -3 in my case) with brief periods of
being positive.  This causes use and aveq (hd->io_ticks and hd->aveq in the
kernel) to have bogus numbers.

I'm hoping that there is a nice patch that has been waiting around
somewhere, and that it's trivial enough for 2.4.24 inclusion.

Here's[2] an example from my test box.  There is activity on md0 which
consists of hd[aei]3 and almost no activity on the other partitions.  Look at
use and aveq on hdi.  There is no correlation to use and aveq on hdi3 since
it has overflowed so many more times than hdi3.

ricklind@us.ibm.com seems to be involved in the 2.6 diskstats code, is he
also involved in the 2.4 code?  Unfortunately he seems to be on vacation at
the moment.  There is no maintainer mentioned in the 2.4 MAINTAINERS file...

[1]
Field 9 of 11 extended stats, also named "running" on the first line of
/proc/partitions

[2]
major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq

   9     0  319388032 md0 0 0 0 0 0 0 0 0 0 0 0
   9     1      96256 md1 0 0 0 0 0 0 0 0 0 0 0
  56     0  160086528 hdi 12445625 129240636 1133491186 33009450 3073895 34157474 297865278 40222780 -3 14691417 20205468
  56     1      96358 hdi1 10 0 26 80 16 4 46 910 0 990 990
  56     2     289170 hdi2 0 0 0 0 0 0 0 0 0 0 0
  56     3  159694132 hdi3 12445614 129240633 1133491152 33009370 3073879 34157470 297865232 40221870 0 22143300 30342807
  33     0  160086528 hde 12445856 129292490 1133907210 39358300 2649553 34633443 298317376 4828091 -3 15578977 34204292
  33     1     289138 hde1 0 0 0 0 0 0 0 0 0 0 0
  33     2  159790522 hde2 12445855 129292487 1133907202 39358300 2649553 34633443 298317376 4828091 0 24374320 1392968
   3     0  160086528 hda 12442218 129213975 1133246908 30940880 3455815 33853910 298489894 21997450 -3 14945507 42837721
   3     1      96358 hda1 25 618 1292 220 16 4 46 980 0 1140 1200
   3     2     289170 hda2 291 886 9416 2930 20 163 1528 460 0 2170 3390
   3     3  159694132 hda3 12441901 129212468 1133236192 30937730 3455779 33853743 298488320 21996010 0 20007780 10021807
'
