Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318772AbSIFQKm>; Fri, 6 Sep 2002 12:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319155AbSIFQKl>; Fri, 6 Sep 2002 12:10:41 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:8855 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S318772AbSIFQKf>; Fri, 6 Sep 2002 12:10:35 -0400
Subject: Re: Linux 2.4.20-pre5-ac4
From: Steven Cole <elenstev@mesatop.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Alan Cox <alan@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0209061735390.7218-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0209061735390.7218-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: multipart/mixed; boundary="=-5LcKxdX0UK946yTvyJDo"
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Sep 2002 10:11:45 -0600
Message-Id: <1031328705.2799.168.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--=-5LcKxdX0UK946yTvyJDo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2002-09-06 at 09:40, Adrian Bunk wrote:
> 
> FYI:
> 
> while doing a "make oldconfig" I noticed that there are some new options
> without a Configure.help entry:
> 
> CONFIG_X86_LONGHAUL_SCALE_VOLTAGE
> CONFIG_SUMMIT
> CONFIG_HOTPLUG_PCI_H2999
> CONFIG_BLK_DEV_IDECD_BAILOUT
> CONFIG_BLK_DEV_GENERIC
> CONFIG_BLK_DEV_NFORCE
> CONFIG_BLK_DEV_PDC202XX_OLD
> CONFIG_BLK_DEV_PDC202XX_NEW
> CONFIG_BLK_DEV_SIIMAGE
> CONFIG_ALIM1535_WDT
> CONFIG_AMD7XX_TCO
> CONFIG_AMD_PM768
> CONFIG_VIDEO_LS220
> CONFIG_VIDEO_MARGI
> CONFIG_FB_RADEON_VAIO_LCD
> CONFIG_USB_SERIAL_KEYSPAN_USA19QW
> CONFIG_USB_SERIAL_KEYSPAN_USA19QI
> CONFIG_USB_LCD
> 

For an even longer list, run the attached ach (Analyse Configure.help)
script.  There are some false positives, but this may be a help to
someone.  The list of options without help entries will be in
ach_no_help.

[steven@spc9 linux-2.4.20-pre5-ac4]$ ach
Number of config options (total)                    :    2831
Number of config options (setable)                  :    2625
Number of config options (derived)                  :     210
Number of config options with help text (total)     :    2451
Number of config options with help text (unique)    :    2446
Number of config options with duplicated help text  :       5
Number of config options without any help text      :     304
Number of help entries without valid config options :     125

Steven


--=-5LcKxdX0UK946yTvyJDo
Content-Disposition: attachment; filename=ach
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-sh; charset=ISO-8859-1

#!/bin/sh
# Analyse Documentation/Configure.help
# Adopted from a script by Paul Gortmaker 01/2001.
# Modified greatly by Steven Cole 03/2001.
#
# Please note that config options written to ach_orphans may well
# be harbingers of coming attractions, having been added to Configure.help
# prior to inclusion in a [cC]onfig.in file.
# That is why this script does not remove those entries,
# as did Paul's, on which this script is based.
# Many, however are just old cruft.
#
# Run this from the top of your tree.
# The ach script will make files prefixed with ach_ for easy deletion.

if [ ! -r Documentation/Configure.help ]; then
	echo Cant read or find Documentation/Configure.help
	exit
fi

FILES=3D`find . -name [cC]onfig.in`

grep '^CONFIG_[0-9A-Za-z_]' Documentation/Configure.help|\
	sort|uniq>ach_unique_help

grep '^CONFIG_[0-9A-Za-z_]' Documentation/Configure.help|\
	sort>ach_all_help

# Tab and space inside [  ]
cat $FILES|grep -v "^[ 	]*#"| \
	sed 's/.*[ 	]\(CONFIG_[A-Za-z0-9_]\+\)[ 	]*.*$/\1/;t;d'|\
	sort|uniq>ach_all_options

cat $FILES|grep -v define_|grep -v "^#"| \
	sed 's/.*[ 	]\(CONFIG_[A-Za-z0-9_]\+\)[ 	]*.*$/\1/;t;d'|\
	sort|uniq>ach_setable_options

diff -u ach_setable_options ach_unique_help|\
	grep '^\+CONFIG_'|sed 's/^\+//'>ach_orphans

diff -u ach_unique_help ach_setable_options|grep '^\+'|grep CONFIG|sed 's/+=
//'>ach_no_help

diff -u ach_setable_options ach_all_options|grep +CONFIG|sed 's/+//'>ach_de=
rived_options

diff -u ach_unique_help ach_all_help|grep +CONFIG|sed 's/+//'|uniq>ach_dup_=
options

echo -ne 'Number of config options (total)                    : '
cat ach_all_options | wc -l

echo -ne 'Number of config options (setable)                  : '
cat ach_setable_options | wc -l

echo -ne 'Number of config options (derived)                  : '
cat ach_derived_options | wc -l

echo -ne 'Number of config options with help text (total)     : '
cat ach_all_help | wc -l

echo -ne 'Number of config options with help text (unique)    : '
cat ach_unique_help | wc -l

echo -ne 'Number of config options with duplicated help text  : '
cat ach_dup_options | wc -l

echo -ne 'Number of config options without any help text      : '
cat ach_no_help | wc -l

echo -ne 'Number of help entries without valid config options : '
cat ach_orphans | wc -l


--=-5LcKxdX0UK946yTvyJDo--

