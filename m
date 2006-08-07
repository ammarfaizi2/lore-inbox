Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWHGFQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWHGFQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWHGFQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:16:53 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:43440 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP
	id S1751054AbWHGFQx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:16:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: error in kernel version check in pcmciautils installation
Date: Mon, 7 Aug 2006 10:46:49 +0530
Message-ID: <24ED22E506B5A042BF5B05B6B017D86C0A9077@PNE-HJN-MBX01.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: error in kernel version check in pcmciautils installation
Thread-Index: Aca54K+mne8rN2yLSLqDximUMiwaYg==
From: <bhuvan.kumarmital@wipro.com>
To: <linux-pcmcia@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Aug 2006 05:16:50.0609 (UTC) FILETIME=[B02B7A10:01C6B9E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
 
Hi,

	There seems to a problem in the kernel version checking in the
shell
code used in the pcmciautils version 13.
The file (pcmciautils-013/doc/cardmgr-to-pcmciautils.txt) mentions the
following way of kernel version checking:

	  KVERREL=`uname -r`
        KVER=${KVERREL%-*}
        KVER_MAJOR=${KVER%.*}
        KVER_MINOR=${KVER##*.}

        if [ "$KVER_MAJOR" == "2.6" ]; then
                # kernel 2.6.13-rc1 and higher have pcmcia via
/sbin/hotplug
                if [ $KVER_MINOR -ge 13 ]; then
                        # uncomment the following line if the driver for
your
                        # controller is not auto-loaded. or if you want
to be
                        # able to say /etc/init.d/pcmcia stop
                        /etc/init.d/pcmcia-new $1
                        exit 0
                fi
        fi

The problem is that this checking would fail on kernel versions
2.6.15.4( the one i use )or versions which have a subminor version as
well. This checking is very specific to kernel versions 2.6.x-rc1. The
current checking fails in my case, even though i'm using 2.6.15.4 (where
the minor number > 13).This is because KVER gets the string preceeding
the '-' (whether it exists or not in uname -r). In my case KVER would
assume the value 2.6.15.4 and subsequently KVER_MAJOR would become
2.6.15 which would never equate with 2.6 (in the if condtion) and always
lead to failure to run /etc/init.d/pcmcia-new $1.
The result is that the pcmcia-new script is not executed and the cardmgr
continues to get used.
This error checking has not been rectified in pcmciautils version 14 as
well.

I wonder how pccard daemon has been working for people using the above
code
on kernel 2.6.x.y

I would suggest the following replacement for the above checking:

        KVER_MAJOR1=`uname -r | cut -d "." -f1`
        KVER_MAJOR2=`uname -r | cut -d "." -f2`
        KVER_MAJOR=$KVERMAJOR1.$KVER_MAJOR2
        KVER_MINOR=`uname -r | cut -d "." -f3`

        if [ "$KVER_MAJOR" == "2.6" ]; then
                # kernel 2.6.13-rc1 and higher have pcmcia via
/sbin/hotplug
                if [ $KVER_MINOR -ge 13 ]; then
                        # uncomment the following line if the driver for
your
                        # controller is not auto-loaded. or if you want
to be
                        # able to say /etc/init.d/pcmcia stop
                        #/etc/init.d/pcmcia-new $1
                        exit 0
                fi
        fi


I had posted this message some time back but i realised i had used the
wrong 
mail-posting convention.As a result i didn't get any feedback. Therefore
i am 
putting up this post again. Sorry for reposting.
 
Bhuvan Mital
Wipro Technologies

