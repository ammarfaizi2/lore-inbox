Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUKWTZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUKWTZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUKWTWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:22:54 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:47761 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261507AbUKWTWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:22:09 -0500
Subject: SELinux performance issue with large systems (32 cpus)
From: keith <kmannth@us.ibm.com>
To: devnull@us.ibm.com, djwong <djwong@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1101237725.27848.301.camel@knk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Nov 2004 11:22:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I work with i386 16-way systems.  When hyperthreading is enabled they
have 32 "cpus".  I recently did a quick performance check on with 2.6
(as it turn out with a SElinux enabled) doing kernel builds.  

My basic test was timing kernel makes using -j16 and -j32.  I saw
tremendous differences between these two times. 

 for -j16  
real	0m52.450s
user	6m24.572s
sys	2m25.331s

 for -j32
real	2m56.743s
user	9m28.781s
sys	73m50.536s 
   
This performance was not seen without hyperthreading.  I have only seen
this on 16-way with HT.  2.6.10-rc1 was used to evaluate the problem. 

Notice the system time goes through the roof.  From 2.5 min to almost 74
min!  We looked at schedstat data and tried various scheduler / numa
options without much to point at.  We then did some oprofiling and saw 

31999102 83.2007  _spin_lock_irqsave

for make -j32.  

After some lock profiling (keeping track of what locks were last used
and how many cycles were spent waiting) it became quite clean the the
avc_lock was to blame.  The avc_lock is a SELinux lock.  

The theory was proved by booting with selinux=0.  The performance with
make -j32 is now within an acceptable level (within 20%) when compared
to a make -j16. 

It appears that SELinux only scales to somewhere between 16 and 32
cpus.  I now very little about SELinux and it's workings but I wanted to
report what I have seen on my system.  I can't say I am really happy
about this performance. 

I would like to thank Derrick Wong and Rick Lindsley for helping to
identify this issue.  

Keith Mannthey 
LTC xSeries 

Please cc me as I am not a regular subscriber to this list. 
 

