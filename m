Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWELSUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWELSUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 14:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWELSUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 14:20:09 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:43983
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751217AbWELSUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 14:20:08 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: Which process context does /sbin/hotplug run in?
Date: Fri, 12 May 2006 14:20:59 -0400
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605121421.00044.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stupid question bout the interaction of initramfs, hotplug, and per-process 
filesystem namespaces:

I do this from initramfs:

  echo /sbin/mdev > /proc/sys/kernel/hotplug

At the moment I do that, the first "/" in /sbin/mdev points to rootfs.  
Shortly thereafter I do a switch_root, which does a chroot.  Does hotplug 
still point into rootfs?  Or does it point to whatever "/" for PID 1 points 
to now?

Since every process could be in a different chroot environment, how do I know 
which process context the kernel_thread that call_usermodehelper() runs in 
was parented from?  It seems random: the x86 implementation of 
call_usermodehelper() is calling do_fork(), and seems to be using the 
namespace of whatever process it's running in.  Which could be a chroot 
process that doesn't have the hotplug I pointed it at visible in its 
namespace at all...

Anybody know this one?  Now that filesystem namespaces are per-process, and 
move/bind mounts let us have cycles in our trees, as far as I can tell we 
could actually have two completely detached namespaces with different sets of 
processes in each.  A path to hotplug isn't 

Rob

P.S:  mount a filesystem under itself.  Fun for the whole family:
mount -t tmpfs /tmp /tmp
cd /tmp
mkdir sub
mount --bind sub /var
cd /var
mkdir sub2
mount --move /tmp sub2
-- 
Never bet against the cheap plastic solution.
