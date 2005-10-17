Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVJQWHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVJQWHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVJQWHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:07:00 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:28042 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S932229AbVJQWG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:06:59 -0400
Message-ID: <4354207D.5070500@ens-lyon.org>
Date: Tue, 18 Oct 2005 00:06:53 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
References: <20051016154108.25735ee3.akpm@osdl.org> <43539762.2020706@ens-lyon.org> <20051017204410.GA3861@kroah.com>
In-Reply-To: <20051017204410.GA3861@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------000605070908010704020703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000605070908010704020703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 17.10.2005 22:44, Greg KH a écrit :
> Odd, what userspace program is wanting to see the proc input stuff?
> 
> What distro and version of it are you running?
> 
> And did this oops happen after init started, or before?

My distro is a Debian testing/sid.
hotplug is 0.0.20040329-25
udev is 0.70-2

This occurs after init started.

>From what I see, it's during hotplug, when it scans isapnp devices.
hotplug finds PNP0800 in /sys/bus/pnp/devices/00:07/id and then
loads pcspkr. The oops occurs during "modprobe -s -q -q pcspkr"
in the isapnp.rc script.
This script is attached in case there's something specific in Debian.

I don't see how I could investigate further.
Let me know if you have any idea to debug the modprobe.

Regards,
Brice



--------------000605070908010704020703
Content-Type: text/plain;
 name="isapnp.rc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isapnp.rc"

#!/bin/sh -e
#
# isapnp.rc	synthesizes isapnp hotplug events at boot time
#		it requires a 2.6 kernel with CONFIG_ISAPNP defined
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#	
#  Copyright (C) 2004 Simone Gotti <simone.gotti@email.it>
#  Copyright (C) 2004 Marco d'Itri <md@linux.it>
#

# only 2.6 kernels are supported
[ -d /sys/bus/pnp/devices/ ] || exit 0

cd /etc/hotplug
. ./hotplug.functions

isapnp_boot_events()
{
    if [ "$(echo /sys/bus/pnp/devices/*/id)" = "/sys/bus/pnp/devices/*/id" ];
    then
	return 0
    fi

    cat /sys/bus/pnp/devices/*/id \
    | while read PNPID; do
	# get the name of the module which should be loaded
	MODULE=$(modprobe --show-depends -q pnp:d$PNPID \
		| sed -e '$!d;s/.*\/\(.*\)\.ko .*/\1/')

	case "$MODULE" in
	"")			# continue if there is no alias available
	    continue
	    ;;
	install*)		# skip the blacklist check if install is used
	    MODULE="pnp:d$PNPID"
	    ;;
	*)			# ignore blacklisted devices
	    if is_blacklisted $MODULE; then
		mesg "     $MODULE: blacklisted"
		continue
	    fi
	    ;;
	esac

	# see do_pnp_entry() in /usr/src/linux/scripts/file2alias.c
	if $MODPROBE -q $MODULE; then
	    mesg "     $MODULE: loaded successfully"
	else
	    mesg "     $MODULE: can't be loaded"
	fi
    done
}

# See how we were called.
case "$1" in
    start|restart)
	isapnp_boot_events
	;;
    stop)
	# echo "isapnp stop -- ignored"
	;;
    status)
	# echo "isapnp status -- ignored"
	;;
    *)
	echo "Usage: $0 {start|stop|status|restart}"
	exit 1
esac


--------------000605070908010704020703--
