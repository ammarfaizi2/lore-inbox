Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVG0SS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVG0SS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVG0SS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:18:26 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26844 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262127AbVG0SRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:17:12 -0400
Date: Wed, 27 Jul 2005 13:17:32 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050727181732.GA22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The set of patches to follow introduces support for stacking LSMs.  This
is its third posting to lkml.  I am sending it out in the hopes of
soliciting more widespread feedback and testing, with the obvious eventual
goal of mainline adoption.

Any feedback from people actually using this patch is appreciated.  Even
better would be posts of (stackable) LSMs for upstream inclusion :)

The patches mainly do the following:

   1. Introduce the stacker LSM.
   2. Change the kernel object void * security fields to be hlists,
      and introduce an api for modules to share these.
   3. Modify SELinux to make use of stacker.
   4. Modify seclvl to use stacker.

Motivation:

The purpose of these patches is to enable stacking multiple security
modules.  There are several cases where this would be very useful.  It
eases the testing of new modules with distro kernels, as it makes it
possible to stack new modules with selinux and capabilities -- for
instance if a user is running fedora.  Second, it enables running
selinux (or LIDS, etc) with integrity verification modules.  (Digsig is
an example of these, and within a few months hopefully the TPM-enabled
slim+evm modules, which verifies integrity of file contents and extended
attributes such as selinux contexts
(http://www.acsac.org/2004/workshop/David-Safford.pdf) will be released
for mainline inclusion).  Thirdly, there are systems where running
selinux is not practical for footprint reasons, and the security goals
are easily expressed as a very small module.  For instance, it might
be desirable to confine a web browser on a zaurus, or to implement a
site security policy on old hardware as per
http://mail.wirex.com/pipermail/linux-security-module/2005-May/6071.html

Performance impact of the actual stacker module is negligable.  The
security_{get,set,del,add}_value API does have a small performance
impact.  Please see
http://marc.theaimsgroup.com/?l=linux-security-module&m=111820455332752&w=2
and
http://marc.theaimsgroup.com/?l=linux-security-module&m=111824326500837&w=2
if interested in the performance results.  I am certainly interested in
ways to further speed up security_get_value.

This version adds support for safe unloading of LSMs.  This is documented
in the stacker-doc.patch.  Included below are performance results
comparing the last version of stacker to this version.

Tests run were dbench, kernbench, reaim, and tbench.  These were run
in the following configurations:
	16-way ppc with old patchset ("16-plain")
	16-way ppc with this patchset ("16-new")
	16-way ppc with this patchset, but without the
		security_{del,unlink}_value race fix ("16-test")
		(note - there may be a faster way to do this anyway)
	4-way P-III with old patchset ("4-plain")
	4-way P-III with this patchset ("4-new")
dbench and tbench were run 50 times each (48 for tbench for 16-new due to
mis-set timeout), kernbench and reaim 10 times.  The numbers here are
mean +/- 95% confidence half-interval.

Results:

dbench (throughput, larger is better):
	16-plain: 1560.825000 +/- 9.844956
	16-new:   1555.401800 +/- 4.083806        
	16-test:  1558.164400 +/- 4.685493
	4-plain:  351.299100 +/- 5.941376
	4-new:    361.487720 +/- 1.624589
	
tbench (throughput, larger is better)
	16-plain: 142.822420 +/- 2.504416
	16-new:   142.671510 +/- 3.149260
	16-test:  147.186280 +/- 3.548984
	4-plain:  37.011122 +/- 0.038450
	4-new:    37.014408 +/- 0.038272

kernbench (smaller is better):
	16-plain: 52.376000 +/- 0.108133
	16-new:   52.378000 +/- 0.119692
	16-test:  52.368000 +/- 0.173884
	4-plain:  91.739000 +/- 0.349240
	4-new:    91.437000 +/- 0.443560

reaim (number of clients versus jobs/minute (+/- CI, larger is better):
16-plain:
1 104040.000000 4614.800612
3 306000.000000 0.000000
5 480857.144000 26914.062669
7 673200.000000 37679.689215
9 878657.142000 45316.443392
11 977742.861000 36259.146697
13 1122364.287000 32138.790300
15 1233107.142000 76974.633465

16-new:
1 100542.857000 3296.286475
3 306000.000000 0.000000
5 495428.572000 21975.240148
7 673200.000000 37679.689215
9 813085.712000 39555.434680
11 961714.290000 0.000000
13 1065535.715000 53564.650500
15 1134750.000000 28842.503826

16-test:
1 104622.857000 7448.926210
3 306000.000000 0.000000
5 495428.572000 21975.240148
7 693600.000000 30765.337414
9 813085.712000 39555.434680
11 1025828.574000 59210.938611
13 1122364.287000 32138.790300
15 1163892.857000 37083.218881

4-plain:
1 45104.176000 1612.185481
3 126771.430000 3296.287229
5 124676.143000 4423.046551
7 154852.416000 4062.286334
9 148950.244000 2664.391611
11 164234.214000 1911.366919
13 161290.790000 4651.698507
15 165440.327000 1813.071866

4-new:
1 46068.131000 1161.957518
3 125022.858000 3021.097148
5 126014.348000 2531.399484
7 158797.437000 3438.066799
9 148186.835000 3186.764542
11 164234.214000 1911.366919
13 160272.056000 4139.820526
15 165748.837000 2045.298142

thanks,
-serge
