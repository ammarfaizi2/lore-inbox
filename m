Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTBGPYj>; Fri, 7 Feb 2003 10:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTBGPYj>; Fri, 7 Feb 2003 10:24:39 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6621 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265361AbTBGPYh>;
	Fri, 7 Feb 2003 10:24:37 -0500
Date: Fri, 7 Feb 2003 21:09:28 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkcd-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: [PATCH][WIP] Using kexec for crash dumps in LKCD
Message-ID: <20030207210928.A3819@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <m1smwql3av.fsf@frodo.biederman.org> <20021231200519.A2110@in.ibm.com> <m11y2w557p.fsf@frodo.biederman.org> <20030204142426.A1950@in.ibm.com> <m1d6m81ttu.fsf@frodo.biederman.org> <20030206212615.A2733@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030206212615.A2733@in.ibm.com>; from suparna@in.ibm.com on Thu, Feb 06, 2003 at 09:26:15PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just checked in the changes for kexec based dumping
into lkcd cvs after tagging the earlier code as "linux2559".

Brief Description/Recap from CVS log:
------------------------------------
Initial release of code to implement an option to save dump
in memory and write it out later (CONFIG_CRASH_DUMP_MEMDEV).

In case of a panic dump, if CONFIG_CRASH_DUMP_SOFTBOOT is
enabled and CONFIG_KEXEC is on, this would use Eric Biederman's
kexec implementation to delay the actual writeout of the dump
to disk to happen after a memory preserving reboot of a new
kernel (along the lines of Mission Critical Linux's mcore
implementation). 
-------------------------------------

The first call to lkcd config after a boot would trigger 
the actual writeout to the dump disk/partition. And then 
lkcd save works as usual to copy the dump into /var/log/dump/<n>/

This is still in a somewhat raw/experimental form, made
available for anyone who'd like to play with it early.
To use it you'd need to apply the kexec patches along
with lkcd. I'll try to put out a TODO list soon for
some things that need to be done to stabilize, complete
and simplify this.

The following patches to sbin.lkcd script and the 
sysconfig.dump file should be used with this.
(kexec preloading gets automatically handled 
once you specify the image and kernel command line 
to use).

I've held back on checking in these particular changes 
for now as I wanted to be sure not to break anything 
for 2.4 lkcd users.  

(BTW, is that also why the lkcd script still uses 227 
as the dump device number rather than 221 ?)

Any suggestions on how to handle this best would be
appreciated.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


--- sbin.lkcd	Mon Dec 16 15:52:51 2002
+++ /home/suparna/suparna/ras/dump/sbin.lkcd	Fri Feb  7 19:28:16 2003
@@ -14,6 +14,7 @@
 KERNTYPES=/boot/Kerntypes
 DUMPCONFIG=/sbin/lkcd_config
 DUMPSYSDEVICE=/dev/dump
+KEXEC=/sbin/kexec
 
 ###########################################################################
 # Functions
@@ -65,8 +66,37 @@
 
 	if [ $? -ne 0 ] ; then
 		echo "$DUMPCONFIG failed!" >&2
+		exit 1
+	fi
+
+	# Set things up for kexec based dumping if applicable
+
+	if [ ! -e /proc/sys/kernel/dump/addr ] ; then
+		return
+	fi
+
+	DUMP_ADDR=`cat /proc/sys/kernel/dump/addr`
+
+	if [ $DUMP_ADDR != 0 ] ; then
+		echo "Preloading kernel for kexec based dumping"
+	else
+		return
 	fi
 
+	if [ ! -e "$KEXEC_IMAGE" ] ; then
+		echo "KEXECIMAGE does not exist!" >&2
+		exit 1
+	fi
+
+	# Preload the kernel image to switch to on panic
+	echo $KEXEC -l \
+	--command-line="$KEXEC_CMDLINE crashdump=$DUMP_ADDR" \
+	$KEXEC_IMAGE
+
+	$KEXEC -l \
+	--command-line="$KEXEC_CMDLINE crashdump=$DUMP_ADDR" \
+	$KEXEC_IMAGE
+
 	return
 }
 
@@ -256,7 +286,7 @@
 
 # make sure system dump device exists -- otherwise, make it
 if [ ! -e $DUMPSYSDEVICE ] ; then
-	mknod $DUMPSYSDEVICE c 227 0
+	mknod $DUMPSYSDEVICE c 221 0
 	chmod 644 $DUMPSYSDEVICE
 fi
 
--- sysconfig.dump	Wed Dec  4 15:20:45 2002
+++ /home/suparna/suparna/ras/dump/sysconfig.dump	Fri Feb  7 20:32:39 2003
@@ -117,11 +117,15 @@
 DUMPDEV=/dev/vmdump
 DUMPDIR=/var/log/dump
 DUMP_SAVE=1
-DUMP_LEVEL=8
-DUMP_FLAGS=0x80000000 # disruptive disk dump is default
-DUMP_COMPRESS=0
+DUMP_LEVEL=2
+DUMP_FLAGS=0x80000002 # disruptive disk dump is default
+DUMP_COMPRESS=2
 PANIC_TIMEOUT=5
 
+# Only relevant for dumping via kexec
+KEXEC_IMAGE=/boot/kexec	
+KEXEC_CMDLINE="root=806 console=tty0 console=ttyS0,38400"
+
 # Network dump configuration parameters
 TARGET_HOST=hostname # set this to vaild hostname/IP
 TARGET_PORT=6666
