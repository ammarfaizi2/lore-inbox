Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVAYEua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVAYEua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVAYEu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:50:29 -0500
Received: from fsmlabs.com ([168.103.115.128]:25314 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261820AbVAYEtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:49:19 -0500
Date: Mon, 24 Jan 2005 21:49:41 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1 Random related problems
In-Reply-To: <20050125044538.GJ12076@waste.org>
Message-ID: <Pine.LNX.4.61.0501242149260.3010@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501242134390.3010@montezuma.fsmlabs.com>
 <20050125044538.GJ12076@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, Matt Mackall wrote:

> On Mon, Jan 24, 2005 at 09:36:37PM -0700, Zwane Mwaikambo wrote:
> > I'm having trouble booting here, were those random-* patches tested?
> 
> Works here, can you send me a copy of your init script?

#!/bin/bash
#
# random	Script to snapshot random state and reload it at boot time.
#
# Author:       Theodore Ts'o <tytso@mit.edu>
#
# chkconfig: 2345 20 80
# description: Saves and restores system entropy pool for higher quality \
#              random number generation.

. /etc/init.d/functions

random_seed=/var/lib/random-seed

# See how we were called.
case "$1" in
  start)
	# Carry a random seed from start-up to start-up
	# Load and then save 512 bytes, which is the size of the entropy pool
	if [ -f $random_seed ]; then
		cat $random_seed >/dev/urandom
	else
		touch $random_seed
	fi
	action $"Initializing random number generator: " /bin/true
	chmod 600 $random_seed
	dd if=/dev/urandom of=$random_seed count=1 bs=512 2>/dev/null
	touch /var/lock/subsys/random

	;;
  stop)
	# Carry a random seed from shut-down to start-up
	# Save 512 bytes, which is the size of the entropy pool
	touch $random_seed
	chmod 600 $random_seed
	action $"Saving random seed: " dd if=/dev/urandom of=$random_seed count=1 bs=512 2>/dev/null
	
	rm -f /var/lock/subsys/random
	;;
  status)
	# this is way overkill, but at least we have some status output...
	if [ -c /dev/random ] ; then
		echo $"The random data source exists"
	else
		echo $"The random data source is missing"
	fi
	;;
  restart|reload)
	# do not do anything; this is unreasonable
	:
	;;
  *)
	# do not advertise unreasonable commands that there is no reason
	# to use with this device
	echo $"Usage: $0 {start|stop|status|restart|reload}"
	exit 1
esac

exit 0
