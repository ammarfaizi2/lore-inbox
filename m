Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWDMXgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWDMXgU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWDMXgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:36:20 -0400
Received: from cantor2.suse.de ([195.135.220.15]:26579 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965048AbWDMXgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:36:20 -0400
Date: Thu, 13 Apr 2006 16:35:18 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
Subject: modprobe bug for aliases with regular expressions
Message-ID: <20060413233518.GA7597@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently it's been pointed out to me that the modprobe functionality
with aliases doesn't quite work properly for some USB modules.
Specifically, the usb-storage driver has a lot of aliases with regular
expressions for the bcd ranges.  Here's an example of it failing with a
real device:

$ modprobe -n -v --first-time usb:v054Cp0010d0410dc00dsc00dp00ic08iscFFip01
FATAL: Module usb:v054Cp0010d0410dc00dsc00dp00ic08iscFFip01 not found.

yet if we change the bcd range by replacing the first 0 with a 1 it
somehow works:

$ modprobe -n -v --first-time usb:v054Cp0010d0400dc00dsc00dp00ic08iscFFip01
insmod /lib/modules/2.6.17-rc1-gkh/kernel/drivers/usb/storage/libusual.ko

(yet this isn't a solution as the device does not have a 1 in that
position...)

If you look at the aliases for this driver, it looks like it should all
work properly:

$ modinfo libusual | grep v054Cp0010
alias:          usb:v054Cp0010d010[6-9]dc*dsc*dp*ic*isc*ip*
alias:          usb:v054Cp0010d0450dc*dsc*dp*ic*isc*ip*
alias:          usb:v054Cp0010d01[1-9]*dc*dsc*dp*ic*isc*ip*
alias:          usb:v054Cp0010d04[0-4]*dc*dsc*dp*ic*isc*ip*
alias:          usb:v054Cp0010d0[2-3]*dc*dsc*dp*ic*isc*ip*
alias:          usb:v054Cp0010d0600dc*dsc*dp*ic*isc*ip*
alias:          usb:v054Cp0010d05*dc*dsc*dp*ic*isc*ip*


I tried a simple fnmatch() call with the string and pattern, and it
works just fine:

#include <fnmatch.h>
#include <stdio.h>

int main (void)
{
	char *pattern = "usb:v054Cp0010d010[6-9]dc*dsc*dp*ic*isc*ip*";
	char *string = "usb:v054Cp0010d0410dc00dsc00dp00ic08iscFFip01";
	int result;

	result = fnmatch(pattern, string, 0);
	printf("result = %d\n", result);
	return 0;
}


$ gcc test.c -o test
$ ./test
result = 0

I tried to dig through the module-init-tools code (am using version
3.2.2 here) and try to track it down, but failed badly.  Any thoughts as
to what would be wrong here?

thanks,

greg k-h
