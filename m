Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbTB1Vq1>; Fri, 28 Feb 2003 16:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268232AbTB1VpO>; Fri, 28 Feb 2003 16:45:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64132 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268215AbTB1VoA>; Fri, 28 Feb 2003 16:44:00 -0500
Date: Fri, 28 Feb 2003 13:45:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, levon@movementarian.org
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <364250000.1046468708@flay>
In-Reply-To: <20030228113041.0d0dd772.rddunlap@osdl.org>
References: <8550000.1046419962@[10.10.2.4]><20030228093632.7bf053ed.rddunlap@osdl.org><28510000.1046455878@[10.10.2.4]><3E5FA6DF.8070909@us.ibm.com> <20030228113041.0d0dd772.rddunlap@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, fixed a couple of things ... thanks for the feedback everyone.

diff -purN -X /home/mbligh/.diff.exclude virgin/Documentation/basic_profiling.txt prof_docs/Documentation/basic_profiling.txt
--- virgin/Documentation/basic_profiling.txt	Wed Dec 31 16:00:00 1969
+++ prof_docs/Documentation/basic_profiling.txt	Fri Feb 28 13:44:11 2003
@@ -0,0 +1,44 @@
+These instructions are deliberately very basic. If you want something clever,
+go read the real docs ;-) Please don't add more stuff, but feel free to 
+correct my mistakes ;-)    (mbligh@aracnet.com)
+Thanks to John Levon and Dave Hansen for help writing this.
+
+<test> is the thing you're trying to measure.
+Make sure you have the correct System.map / vmlinux referenced!
+IMHO it's easier to use "make install" for linux and hack /sbin/installkernel
+to copy config files, system.map, vmlinux to /boot.
+
+Readprofile
+-----------
+get readprofile binary fixed for 2.5 / akpm's 2.5 patch from 
+ftp://ftp.kernel.org/pub/linux/people/mbligh/tools/readprofile/
+add "profile=2" to the kernel command line.
+
+clear		readprofile -r
+		<test>
+dump output	readprofile -m /boot/System.map > catured_profile
+
+Oprofile
+--------
+get source (I use 0.5) from http://oprofile.sourceforge.net/
+add "poll=idle" to the kernel command line 
+Configure with CONFIG_PROFILING=y and CONFIG_OPROFILE=y & reboot on new kernel
+./configure --with-kernel-support
+make install
+
+One time setup (pick appropriate one for your CPU):
+P3		opcontrol --setup --vmlinux=/boot/vmlinux \
+		--ctr0-event=CPU_CLK_UNHALTED --ctr0-count=100000
+Athlon/x86-64	opcontrol --setup --vmlinux=/boot/vmlinux \
+		--ctr0-event=RETIRED_INSNS --ctr0-count=100000
+P4		opcontrol --setup --vmlinux=/boot/vmlinux \
+		--ctr0-event=GLOBAL_POWER_EVENTS \
+		--ctr0-unit-mask=1 --ctr0-count=100000
+
+start daemon	opcontrol --start-daemon
+clear		opcontrol --reset
+start		opcontrol --start
+		<test>
+stop		opcontrol --stop
+dump output	oprofpp -dl -i /boot/vmlinux  >  output_file
+

