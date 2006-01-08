Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWAHVqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWAHVqi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWAHVqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:46:37 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:2946 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1161219AbWAHVqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:46:36 -0500
Date: Sun, 08 Jan 2006 16:45:55 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: [PATCH updated]: How to be a kernel driver maintainer
In-reply-to: <1136736455.24378.3.camel@grayson>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Message-id: <1136756756.1043.20.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1136736455.24378.3.camel@grayson>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an updated document. I integrated the suggestions. For Arjan, I
added a new section at the end. Hopefully that addresses the concerns
for cvs-mentality.

--- /dev/null	2006-01-05 16:54:17.144000000 -0500
+++ b/Documentation/HOWTO-KernelMaintainer	2006-01-08 16:35:48.000000000 -0500
@@ -0,0 +1,206 @@
+                  How to be a kernel driver maintainer
+                  ------------------------------------
+
+
+This document explains what you must know before becoming the maintainer
+of a portion of the Linux kernel. Please read SubmittingPatches,
+SubmittingDrivers and CodingStyle, also in the Documentation/ directory.
+
+With the large amount of hardware available for Linux, it's becoming
+increasingly common for drivers for new or rare hardware to be maintained
+outside of the main kernel tree. Usually these drivers end up in the
+kernel tree once they are stable, but many times users and distribution
+maintainers are left with collecting these external drivers in order to
+support the required hardware.
+
+The purpose of this document is to provide information for the authors of
+these drivers to eventually have their code in the mainline kernel tree.
+
+
+Why should I submit my driver?
+------------------------------
+
+This is often the question a driver maintainer is faced with. Most driver
+authors really don't see the benefit of having their code in the main
+kernel. Some even see it as giving up control of their code. This is
+simply not the case, and then end result is always beneficial to users and
+developers alike.
+
+The primary benefit is availability. When people want to compile a kernel,
+they want to have everything there in the kernel tree. No one (not even
+kernel developers) likes having to search for, download, and build
+external drivers out-of-tree (outside the stock kernel source). It's often
+difficult to find the right driver (one known to work correctly), and is
+even harder to find one that works on the kernel version they are
+building.
+
+The benefit to users compiling their own kernel is immense. The benefit to
+distributions is even greater. Linux distributions already have a large
+amount of work to provide a kernel that works for most users. If a driver
+has to be provided for users that isn't in the primary kernel source, it
+adds additional work to maintaining (tracking the external driver,
+patching it into the build system, often times fixing build problems).
+With a driver in the kernel source, it's as simple as tracking the main
+kernel tree.
+
+This assumes that the distribution finds your driver worth the time of
+doing all this. If they don't, then the few users needing your driver will
+probably never get it (since most users are not capable of compiling their
+own modules).
+
+Another benefit of having the driver in the kernel tree is to promote the
+hardware that it supports. Many companies who have written drivers for
+their hardware to run under Linux have not yet taken the leap to placing
+the driver in the main kernel. The "Old Way" of providing downloadable
+drivers doesn't work as well for Linux, since it's almost impossible to
+provide pre-compiled versions for any given system. Having the driver in
+the kernel tree means it will always be available. It also means that
+users wishing to purchase hardware that "Just Works" with Linux will have
+more options. A well written and stable driver is a good reason for a user
+to choose that particular type of hardware.
+
+Having drivers in the main kernel tree benefits everyone.
+
+
+What should I do to prepare for code submission?
+------------------------------------------------
+
+First you need to inspect your code and make sure it meets criteria for
+inclusion. Read Documentation/CodingStyle for help on proper coding format
+(indentation, comment style, etc). It is strongly suggested that your
+driver builds cleanly when checked by the "sparse" tool. You will probably
+need to annotate the driver so sparse can tell that it is following the
+kernel's rules for address space accesses and endianness.  Adding these
+annotations is a simple, but time-consuming, operation that often exposes
+real portability problems in drivers.
+
+Once you have properly formatted the code, you also need to check a few
+other areas. Most drivers include backward compatibility for older kernels
+(usually ifdef's with LINUX_VERSION_CODE). This backward compatibility
+needs to be removed. It's considered a waste of code for the driver to be
+backward compatible within the kernel source tree, since it is going to be
+compiled with a known version of the kernel.
+
+Proper location in the kernel source needs to be determined. Find drivers
+similar to yours, and use the same location. For example, USB network
+drivers go in drivers/usb/net/, and filesystems go in fs/.
+
+The driver should then be prepared for building from the main source tree
+in this location.  A proper Makefile and Kconfig file in the Kbuild format
+should be provided. Most times it is enough to just add your entries to
+existing files. Here are some good rules to follow:
+
+ - If your driver is a single source file (or single .c with a single .h),
+   then it's typical to place the driver in an existing directory. Also,
+   modify existing Makefile/Kconfig for that directory.
+
+ - If your driver is made up of several source files, then it is typical
+   to create a subdirectory for it under the existing directory where it
+   applies. Separate Makefile should be included, with a reference in the
+   parent Makefile to make sure to descend into the one you created.
+
+   + In this case, it is usually still correct to just add the Kconfig
+     entry to the existing one. Unless your driver has 2 or more config
+     options (debug options, extra features, etc), then creating a
+     standalone Kconfig may be best. Make sure to source this new Kconfig
+     from the parent directory.
+
+  - When creating the Kconfig entries be sure to keep in mind the criteria
+    for the driver to be build. For example, a wireless network driver may
+    need to "depend on NET && IEEE80211". Also, if you driver is specific
+    to a certain architecture, be sure the Kconfig entry reflects this. DO
+    NOT force your driver to a specific architecture simply because the
+    driver is not written portably.
+
+Lastly, you'll need to create an entry in the MAINTAINERS file. It should
+reference you or the team responsible for the code being submitted (this
+should be the same person/team submitting the code).
+
+
+Code review
+-----------
+
+Once your patches are ready, you can submit them to the linux-kernel
+mailing list. However, since most drivers fall under some subsystem (net,
+usb, etc), then it is often required that you also Cc the mailing list for
+this subsystem (see MAINTAINERS file for help finding the correct
+address).
+
+The code review process is there for two reasons. First, it ensures that
+only good code, that follows current API's and coding practices, gets into
+the kernel. The kernel developers know you have good intentions of
+maintaining your driver, but too often a driver is submitted to the
+kernel, and some time later becomes unmaintained. Then developers who are
+not familiar with the code or it's purpose are left with keeping it
+compiling and working. So the code needs to be readable, and easily
+modified.
+
+Secondly, the code review helps you to make your driver better. The folks
+looking at your code have been doing Linux kernel work for years, and are
+intimately familiar with all the nuances of the code. They can help with
+locking issues as well as big-endian/little-endian and 64-bit portability.
+
+Be prepared to take some heavy criticism. It's very rare that anyone comes
+out of this process without a scratch. Usually code review takes several
+tries. You'll need to follow the suggested changes, and make these to your
+code, or have clear, acceptable reasons for *not* following the
+suggestions. Code reviewers are generally receptive to reasoned argument.
+If you do not follow a reviewer's initial suggestions, you should add
+descriptive comments to the appropriate parts of the driver, so that
+future contributors can understand why things are in a possibly unexpected
+state. Once you've made the changes required, resubmit. Try not to take it
+personally. The suggestions are meant to help you, your code, and your
+users (and is often times seen as a rite of passage).
+
+
+What is expected of me after my driver is accepted?
+---------------------------------------------------
+
+The real work of maintainership begins after your code is in the tree.
+This is where some maintainers fail, and is the reason the kernel
+developers are so reluctant to allow new drivers into the main tree.
+
+There are two aspects of maintaining your driver in the kernel tree. The
+obvious first duty is to keep your code synced to the kernel source. This
+means submitting regular patch updates to the linux-kernel mailing list
+and to the particular tree maintainer (e.g. Linus or Andrew). Now that
+your code is included and properly styled and coded (with that shiny new
+driver smell), it should be fairly easy to keep it that way.
+
+The other side of the coin is keeping changes in the kernel synced to your
+code. Often times, it is necessary to change a kernel API (driver model,
+USB stack changes, networking subsystem change, etc). These sorts of
+changes usually affect a large number of drivers. It is not feasible for
+these changes to be individually submitted to the driver maintainers. So
+instead, the changes are made together in the kernel tree. If your driver
+is affected, you are expected to pick up these changes and merge them with
+your primary code (e.g. if you have a CVS repo for maintaining your code).
+Usually this job is made easier if you use the same source control system
+that the kernel maintainers use (currently, git), but this is not
+required.
+
+There are times where changes to your driver may happen that are not the
+API type of changes described above. A user of your driver may submit a
+patch directly to Linus to fix an obvious bug in the code. Sometimes these
+trivial and obvious patches will be accepted without feedback from the
+driver maintainer. Don't take this personally. We're all in this together.
+Just pick up the change and keep in sync with it. If you think the change
+was incorrect, try to find the mailing list thread or log comments
+regarding the change to see what was going on. Then email the patch author
+about the change to start discussion.
+
+
+How should I maintain my code after it's in the kernel tree?
+------------------------------------------------------------
+
+The suggested, and certainly the easiest method, is to start a git tree
+cloned from the primary kernel tree. In this way, you are able to
+automatically track the kernel changes by pulling from Linus' tree. You
+can read more about maintaining a kernel git tree at
+http://linux.yyz.us/git-howto.html.
+
+Whatever you decide to use for keeping your kernel tree, just remember
+that the kernel tree source is the primary code. Your repository should
+mainly be used for queuing patches, and doing development. Users should
+not have to regularly go to your source in order to get a stable and
+usable driver.


-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

