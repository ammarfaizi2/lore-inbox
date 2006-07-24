Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWGXPYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWGXPYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWGXPYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:24:07 -0400
Received: from csmail1.brookes.ac.uk ([161.73.1.23]:1190 "EHLO brookes.ac.uk")
	by vger.kernel.org with ESMTP id S1751097AbWGXPYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:24:05 -0400
Message-ID: <008301c6af35$14f9f1d0$0100a8c0@serty1>
From: "Damien Pacaud" <05087635@brookes.ac.uk>
To: <linux-kernel@vger.kernel.org>
References: <20060721211341.5366.93270.sendpatchset@pipe> <200607212209.05254.dtor@insightbb.com> <20060724151159.GA5082@fooishbar.org>
Subject: Odd values in /proc
Date: Mon, 24 Jul 2006 16:23:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-MailScanner-Information: Oxford Brookes University MailScanner
X-MailScanner: Clean
X-MailScanner-From: 05087635@brookes.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I was recently fooling with /proc for a school project and found out
that ps and top are not doing the same calculation about memory load.

For instance :


ps aux | grep X
3323  1.5  5.9  64948 53996


ok, so the value for the VSS size read by ps is : 64948 and the value
for the RSS size is 53996


Let's look at top now :

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND


 3323 root      15   0  191m  52m 7284 S 11.9  6.0  39:05.93 X


Ok, so for Top , the Virtual mem size is 191m.
This is somewhat different to the 64948Kb found by Ps.


Am I wrong by thinking that these two values should be the same ?


I've done the same test with other programs and most of the times, the
values are the same.
I really don't understand it ;)

I digged a bit deeper to see where the difference comes from.


There are at least two different files in /proc that gives you the mem
load of a particular process.


Those files are : /proc/[PID]/statm and /proc/[PID]/status


let's look at those files for this example


serty2@serty2 ~ $ more /proc/3323/status
Name:   X
State:  S (sleeping)
SleepAVG:       98%
Tgid:   3323
Pid:    3323
PPid:   3320
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 256
Groups:
VmSize:    65080 kB
VmLck:         0 kB
VmRSS:     54128 kB
VmData:    46772 kB
VmStk:        84 kB
VmExe:      1532 kB
VmLib:     13124 kB
VmPTE:       224 kB
Threads:        1
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 0000000000001000
SigCgt: 00000001d1806ecb
CapInh: 00000000fffffeff
CapPrm: 00000000fffffeff
CapEff: 00000000fffffeff


Ok , so the VmSize is 65080 , that really looks like the value we got
from ps ;)
(not the exact same because of the time delay between the two tests)


Let's look at the other file :


serty2@serty2 ~ $ more /proc/3323/statm
49166 13532 1821 383 0 11714 0


as stated in proc's man , the first value is the  total program size in
mem pages.


then : (49166 * 4096) / (1024²) =192Mb


We're pretty close to the value given by Top .


I don't understand why there is a difference for those values for some
programs.
And most important of it, I really don't know what value to use ;)


I think I would go for the value in /proc/[PID]/statm because the
/proc/[PID]/status is supposed to be only a aggregate of information
found in other files and made "human-readable".
But then, I'm not sure.


Does anyone know which file holds the right value ?


Thanks for any comments


Damien


PS : please excuse my english mistakes ;)


