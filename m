Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbTCERR3>; Wed, 5 Mar 2003 12:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267528AbTCERQ7>; Wed, 5 Mar 2003 12:16:59 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62879 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267292AbTCERP4>; Wed, 5 Mar 2003 12:15:56 -0500
Date: Wed, 05 Mar 2003 09:26:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 5/6 Provide basic documentation for profiling
Message-ID: <159550000.1046885183@[10.10.2.4]>
In-Reply-To: <159190000.1046885136@[10.10.2.4]>
References: <157940000.1046884990@[10.10.2.4]> <158450000.1046885053@[10.10.2.4]> <158830000.1046885093@[10.10.2.4]> <159190000.1046885136@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People keep asking for this info, and Andrew asked me to put it under the
Documentation directory ... provides really simple instructions for taking
a profile so that users can report performance changes in a useful way.

diff -urpN -X /home/fletch/.diff.exclude 015-numaq_zholes_warning/Documentation/basic_profiling.txt 020-prof_docs/Documentation/basic_profiling.txt
--- 015-numaq_zholes_warning/Documentation/basic_profiling.txt	Wed Dec 31 16:00:00 1969
+++ 020-prof_docs/Documentation/basic_profiling.txt	Wed Mar  5 07:48:44 2003
@@ -0,0 +1,48 @@
+These instructions are deliberately very basic. If you want something clever,
+go read the real docs ;-) Please don't add more stuff, but feel free to 
+correct my mistakes ;-)    (mbligh@aracnet.com)
+Thanks to John Levon, Dave Hansen, et al. for help writing this.
+
+<test> is the thing you're trying to measure.
+Make sure you have the correct System.map / vmlinux referenced!
+IMHO it's easier to use "make install" for linux and hack /sbin/installkernel
+to copy config files, system.map, vmlinux to /boot.
+
+Readprofile
+-----------
+You need a fixed readprofile command for 2.5 ... either get hold of
+a current version from:
+http://www.kernel.org/pub/linux/utils/util-linux/
+or get readprofile binary fixed for 2.5 / akpm's 2.5 patch from 
+ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/tools/readprofile/
+
+Add "profile=2" to the kernel command line.
+
+clear		readprofile -r
+		<test>
+dump output	readprofile -m /boot/System.map > captured_profile
+
+Oprofile
+--------
+get source (I use 0.5) from http://oprofile.sourceforge.net/
+add "idle=poll" to the kernel command line 
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

