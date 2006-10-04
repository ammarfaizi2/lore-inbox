Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbWJDQTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbWJDQTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161495AbWJDQTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:19:22 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:4620 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161190AbWJDQTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:19:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GqE6IQEXaFX9JEdpSXjjvRNjhFqxZQ2SOIFrbNRA0lDVdg3uPvbfRhzXnaFLzRTvddyZWqm8VoAbPRv2cSoJkT/KQjxqEZGZ2CLX+kxnV7R8MfWZZuShpLuzjKN167dVwMJuYHxJiEu8wjVdXwfO3UaZbZokzgZfu2WlJkuax0k=
Message-ID: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
Date: Wed, 4 Oct 2006 17:19:20 +0100
From: "Alex Owen" <r.alex.owen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: forcedeth net driver: reverse mac address after pxe boot
Cc: c-d.hailfinger.kernel.2004@gmx.net, aabdulla@nvidia.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I an issue with the forcedeth driver when used after the BIOS PXE routines.
When booting directly from disk the ethernet MAC address is normal.
eg: 00:16:17:xx:yy:zz
But is the BIOS PXE boot stack loads pxelinux which then boots the
local disk, or if pxelinux loads a kernel/initrd, then the MAC address
detected by the forcedeth linux driver is reversed.
eg zz:yy:xx:17:16:00

This is obviously causes me a problem with automated installs started
via PXE boot as the installed cannot DHCP as the MAC address is wrong.

I have read some of the bug reports and LKML threads on WOL and
forcedeth and I have looked at the code of the driver... most closely
forcedeth v57 as per comment #22 of
http://bugzilla.kernel.org/show_bug.cgi?id=6604

My understanding of the code is that the driver determines the cards
MAC address by reading from registers in the ethernet controller, but
that for reasons best known to nvidia this  address backwards and so
the driver "fixes" this by itself reversing the read values and
writing them back to the controller.

This normally works ok and there has been some work to put the old
"wrong" MAC address back at close down to get WOL to work to.

Enter PXE... Booting from PXE (in BIOS) seems to "fixup" the "wrong"
MAC address so when the driver determines the cards MAC address by
reading from registers in the ethernet controller then MAC address
there is now CORRECT. The driver however assumes it is reversed and in
trying to "fix" the MAC address is infact writes back the
revesed/broken MAC back to the controller.

The obvious fix for this is to try and read the MAC address from the
canonical location... ie where is the source of the address writen
into the controlers registers at power on? But do we know where that
may be?

The other solution would be unconditionally reset the controler to
it's power on state then use the current logic? can we reset the
controller via software?
There does seem to be an nv_mac_reset function... and this does seem
to be called if the card has a capability DEV_HAS_POWER_CONTROL but it
is called in nv_open() while the MAC is read in nv_probe().

Perhaps we need to unconditionally run nv_mac_reset just before
reading the MAC in nv_probe() ?

Anyway I hope that someone who knows kernel internals and this driver
inparticular feels the urge to look at this!

Thanks for reading this far!
Alex Owen
