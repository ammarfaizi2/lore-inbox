Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264359AbUDTXLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUDTXLG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbUDTXK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:10:28 -0400
Received: from pochacco.sd.dreamhost.com ([66.33.206.17]:9601 "EHLO
	pochacco.sd.dreamhost.com") by vger.kernel.org with ESMTP
	id S264357AbUDTWOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 18:14:32 -0400
Message-ID: <12837.24.6.86.122.1082499261.spork@webmail.coverity.com>
Date: Tue, 20 Apr 2004 15:14:21 -0700 (PDT)
Subject: [CHECKER] Security reports involving isspace()
From: ken@coverity.com
To: linux-kernel@vger.kernel.org
Cc: linux@coverity.com
User-Agent: DreamHost Webmail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more static analysis reports from Coverity.  These are
places where the kernel gets a scalar from the user and then uses it as an
array index with out bounds checking it.

All of the reports below deal with the isspace macro.  It expands to an
access to a static array with 256 entries.  If we use an unsigned char to
index into the array, there are no problems.  However, when that char is
signed, we can index off the left of the array.

It seems like this isn't a big deal, but if the isspace array is located
after some important data structure, we could leak information.

thanks for your feedback,
Ken Ashcraft
PS - See hundreds of bugs in the Linux kernel found by Coverity:
http://linuxbugs.coverity.com

---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/net/sunrpc/sysctl.c:78:proc_dodebug:
ERROR:TAINT: 78:78:Using user value "c" without first performing bounds
checks [SOURCE_MODEL=(lib,__get_user,user,taint)] [PATH=]  [MINOR]


	if (write) {
		if (!access_ok(VERIFY_READ, buffer, left))
			return -EFAULT;
		p = (char *) buffer;

Error --->
		while (left && __get_user(c, p) >= 0 && isspace(c))
			left--, p++;
		if (!left)
			goto done;
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/kernel/sysctl.c:1484:do_proc_dointvec:
ERROR:TAINT: 1482:1484:Using user value "c" without first performing
bounds checks [SOURCE_MODEL=(lib,get_user,user,taint)] [PATH=]  [MINOR]

	}
	if (write) {
		p = (char *) buffer;
		while (left) {
			char c;
Start --->
			if (get_user(c, p++))
				return -EFAULT;
Error --->
			if (!isspace(c))
				break;
			left--;
		}
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/kernel/sysctl.c:1719:do_proc_doulongvec_minmax:
ERROR:TAINT: 1717:1719:Using user value "c" without first performing
bounds checks [SOURCE_MODEL=(lib,get_user,user,taint)] [PATH=]  [MINOR]

	}
	if (write) {
		p = (char *) buffer;
		while (left) {
			char c;
Start --->
			if (get_user(c, p++))
				return -EFAULT;
Error --->
			if (!isspace(c))
				break;
			left--;
		}
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/kernel/sysctl.c:1658:do_proc_doulongvec_minmax:
ERROR:TAINT: 1656:1658:Using user value "c" without first performing
bounds checks [SOURCE_MODEL=(lib,get_user,user,taint)] [PATH=]  [MINOR]


	for (; left && vleft--; i++, min++, max++, first=0) {
		if (write) {
			while (left) {
				char c;
Start --->
				if (get_user(c, (char __user *) buffer))
					return -EFAULT;
Error --->
				if (!isspace(c))
					break;
				left--;
				buffer++;
---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/kernel/sysctl.c:1420:do_proc_dointvec:
ERROR:TAINT: 1418:1420:Using user value "c" without first performing
bounds checks [SOURCE_MODEL=(lib,get_user,user,taint)] [PATH=]  [MINOR]


	for (; left && vleft--; i++, first=0) {
		if (write) {
			while (left) {
				char c;
Start --->
				if (get_user(c,(char __user *) buffer))
					return -EFAULT;
Error --->
				if (!isspace(c))
					break;
				left--;
				buffer++;

---------------------------------------------------------
[BUG]
/home/kash/linux/linux-2.6.5/lib/bitmap.c:238:bitmap_parse: ERROR:TAINT:
235:238:Using user value "c" without first performing bounds checks
[SOURCE_MODEL=(lib,get_user,user,taint)] [PATH=]

		chunk = ndigits = 0;

		/* Get the next chunk of the bitmap */
		while (ubuflen) {
			old_c = c;
Start --->
			if (get_user(c, ubuf++))
				return -EFAULT;
			ubuflen--;
Error --->
			if (isspace(c))
				continue;

			/*

