Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUGJPb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUGJPb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbUGJPb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:31:57 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:14490 "EHLO
	tp-timw.internal.splhi.com") by vger.kernel.org with ESMTP
	id S263448AbUGJPbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:31:55 -0400
Subject: rmmod st "hangs" - bad interaction with sg
From: Tim Wright <timw@splhi.com>
Reply-To: timw@splhi.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1089473460.1473.17.camel@tp-timw.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 10 Jul 2004 08:31:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was working on the qlogicisp/isp1020 driver in 2.6, as I still have
one of these antiques and the driver is a bit out of date (a patch is
forthcoming). In the process of testing my changes, I came across the
following:

I have a single DDS-2 tape drive attached to the SCSI bus. qlogicisp
loads, and pulls and the tape is found. However, when I tried to unload
st, the unload "hung" unkillable. I use the quotes for a reason. After
much searching, I found that there is still a reference count on the
sysfs scsi_device and that is because when the driver gets loaded, not
only does st get loaded, but sg also gets pulled in and increments the
refcount on the sysfs scsi_device. Running 'rmmod sg' in another window
allows the original 'rmmod st' to complete.

This seems bad to me - either the original rmmod should fail with EBUSY,
or it should complete. However, for it to do so, it seems that st needs
to know that sg has its hooks into the device it controls, and it needs
to be able to make it let go. My workaround is impractical if sg is in
use on other devices too.

So....
what do interested parties think? Would this be considered a bug? Should
I chase and see if I can find a way to make it behave, or does someone
already know what's wrong?

Regards,

Tim

BTW, if anyone is interested in the fixed-up qlogicisp, I can make it
available. Error-handling is in and seems to be working (the main
complaint that 2.6 has), and interfaces have been updated to 2.6
standards.

