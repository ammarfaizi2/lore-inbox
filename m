Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267781AbTB1ICi>; Fri, 28 Feb 2003 03:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267782AbTB1ICi>; Fri, 28 Feb 2003 03:02:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:60313 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267781AbTB1ICe>; Fri, 28 Feb 2003 03:02:34 -0500
Date: Fri, 28 Feb 2003 00:12:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: cliffw@osdl.org, Andrew Morton <akpm@zip.com.au>,
       Steven Pratt <slpratt@austin.ibm.com>,
       John Levon <levon@movementarian.org>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH] documentation for basic guide to profiling
Message-ID: <8550000.1046419962@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to write some simple docs on how to do profiling for people 
to use for really basic stuff. I got it all wrong, but John's kindly 
corrected  it ;-) Andrew asked me to do this as a patch for the 
documentation directory ... feedback would be much appreciated 
(yes, it's oversimplified - it's meant to be).

diff -urpN -X /home/fletch/.diff.exclude virgin/Documentation/basic_profiling.txt oprofile_doc/Documentation/basic_profiling.txt
--- virgin/Documentation/basic_profiling.txt	Wed Dec 31 16:00:00 1969
+++ oprofile_doc/Documentation/basic_profiling.txt	Fri Feb 28 00:05:59 2003
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
+clear		echo 2 > /proc/profile
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
+Athalon		opcontrol --setup --vmlinux=/boot/vmlinux \
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

