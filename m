Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268277AbTB1XLZ>; Fri, 28 Feb 2003 18:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268291AbTB1XLY>; Fri, 28 Feb 2003 18:11:24 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:53720 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268277AbTB1XLK>; Fri, 28 Feb 2003 18:11:10 -0500
Date: Fri, 28 Feb 2003 15:11:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, cliffw@osdl.org, akpm@zip.com.au,
       slpratt@austin.ibm.com, levon@movementarian.org, haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <447430000.1046473881@flay>
In-Reply-To: <20010101052723.GB22212@krispykreme>
References: <8550000.1046419962@[10.10.2.4]> <20030228002935.256ffa98.akpm@digeo.com> <20030228112238.GJ4911@codemonkey.org.uk> <20030228152838.GB32449@gtf.org> <20010101052723.GB22212@krispykreme>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, fixed a couple more things (spelling, and pointer to new tools).
I don't really want to add a list of 200 arches, but I'll do a script
with any info people email me the cpuinfo output and correct oprofile
setting for ... I'll do that for the existing ones instead of what's
there now as well.

diff -purN -X /home/mbligh/.diff.exclude virgin/Documentation/basic_profiling.txt prof_docs/Documentation/basic_profiling.txt
--- virgin/Documentation/basic_profiling.txt	Wed Dec 31 16:00:00 1969
+++ prof_docs/Documentation/basic_profiling.txt	Fri Feb 28 15:04:17 2003
@@ -0,0 +1,48 @@
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

