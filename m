Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267314AbRG3Tfo>; Mon, 30 Jul 2001 15:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbRG3Tfe>; Mon, 30 Jul 2001 15:35:34 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:16884 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267314AbRG3TfU>; Mon, 30 Jul 2001 15:35:20 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107301934.f6UJYSWI031975@webber.adilger.int>
Subject: Re: make rpm
In-Reply-To: <E15QeJf-0008O8-00@the-village.bc.nu> "from Alan Cox at Jul 29,
 2001 01:20:19 am"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 30 Jul 2001 13:34:28 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan writes:
> scripts/mkspec

Probably clearer to make it a "here" document (untested).  EXTRASHORT could
have been left inline (inside ``), but it is a bit clearer this way, I think.

#!/bin/sh
#
#	Output a simple RPM spec file that uses no fancy features requring
#	RPM v4. This is intended to work with any RPM distro.
#
#	The only gothic bit here is redefining install_post to avoid 
#	stripping the symbols from files in the kernel which we want
#
EXTRASHORT=`echo $EXTRAVERSION | sed -e "s/-//"`

cat - << EOT
Name: kernel
Summary: The Linux Kernel
Version: $VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRASHORT
Release: `cat .version`
Copyright: GPL
Group: System Environment/Kernel
Vendor: The Linux Community
URL: http://www.kernel.org
Source: kernel-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRASHORT.tar.gz
BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root
%define __spec_install_post /usr/lib/rpm/brp-compress || :

%description
The Linux Kernel, the operating system core itself

%prep
%setup -q

%build
make oldconfig dep clean bzImage modules

%install
mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules
INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install
cp arch/i386/boot/bzImage $RPM_BUILD_ROOT/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION

%clean
#echo -rf $RPM_BUILD_ROOT

%files
%defattr (-, root, root)
%dir /lib/modules
lib/modules/$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION

EOT

-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

