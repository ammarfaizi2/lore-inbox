Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282948AbRLWPGa>; Sun, 23 Dec 2001 10:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbRLWPGJ>; Sun, 23 Dec 2001 10:06:09 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:44813 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282948AbRLWPGE>;
	Sun, 23 Dec 2001 10:06:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: harri@synopsys.COM
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: Support for grub at installation time 
In-Reply-To: Your message of "Sun, 23 Dec 2001 15:39:59 BST."
             <3C25ECBF.AF0E819C@Synopsys.COM> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Dec 2001 02:05:51 +1100
Message-ID: <24997.1009119951@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001 15:39:59 +0100, 
Harald Dunkel <harri@synopsys.COM> wrote:
>Below you can find a tiny patch to add 2 new targets to the top level 
>Makefile: bzgrub and zgrub. This is a suggestion about how the Grub 

I am removing all the special targets that have crept into kbuild,
including zlilo, I do not want to add any new boot targets.  It is the
job of the kernel makefiles to build the kernel, install the kernel and
modules and that is all.  Anything after the kernel and modules have
been installed is not the job of kbuild.  There is too much special
case code in the kernel makefiles, some of which only works for a few
users.

All is not lost, however.  kbuild 2.5 has a config option to run a
post-install script.  You can specify any script that you want and that
script is responsible for doing whatever you want after the kernel and
modules install.  There is a sample in scripts/lilo_new_kernel:

#!/bin/sh
#
#  This is a sample script to add a new kernel to /etc/lilo.conf.  If it
#  does not do what you want, copy this script to somewhere outside the
#  kernel, change the copy and point your .config at the modified copy.
#  Then you do not need to change the script when you upgrade your kernel.
#

label=$(echo "$KERNELRELEASE" | cut -c1-15)
if ! grep "label=$label\$" /etc/lilo.conf > /dev/null
then
  ed /etc/lilo.conf > /dev/null 2>&1 <<EODATA 
/^image/
i
image=$CONFIG_INSTALL_PREFIX_NAME$CONFIG_INSTALL_KERNEL_NAME
	label=$label
	optional

.
w
q
EODATA
  if [ ! $? ]
  then
    echo edit of /etc/lilo.conf failed
    exit 1
  fi
fi
lilo


The problem with embedding boot loader data in kbuild is that everybody
wants their boot to do something slightly different.  In the past they
had to patch the kernel makefiles to do what they wanted, which shows
it was a bad design.

In kbuild 2.5, lilo users invoke scripts/lilo_new_kernel as the post
install script.  If they want something different, copy lilo_new_kernel
to their own directory and tell kbuild to use the local copy.  No more
patching kernel makefiles for local changes.

grub will be handled the same.  kbuild 2.5 can supply a sample
scripts/grub_new_kernel which users can use as is or copy and change to
their own requirements.  I will take a sample grub script, I will not
take a new target in the makefiles.

