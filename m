Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVL0KPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVL0KPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 05:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVL0KPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 05:15:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:53658 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932284AbVL0KPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 05:15:43 -0500
Date: Tue, 27 Dec 2005 15:45:22 +0530 (IST)
From: Sripathi Kodi <sripathik@in.ibm.com>
X-X-Sender: sripathi@sripathi.in.ibm.com
To: benh@kernel.crashing.org
cc: linux-kernel@vger.kernel.org
Subject: Problem due to removing ppc64 rtc.c?
Message-ID: <Pine.LNX.4.63.0512271505030.3537@sripathi.in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I am seeing a problem on a PPC64  machine due to your patch "kill ppc64 rtc.c,
use  genrtc   instead"  (http://patchwork.ozlabs.org/linuxppc64/patch?id=3336)
that went into 2.6.15-rc2.

I see  that RTC_RD_TIME ioctl  returns wrong  values. This is  making commands
like 'hwclock' loop forever.

[root@hv42-lp2 ~]# cat /proc/driver/rtc
rtc_time        : 165:165:165
rtc_date        : 2065-165-165
rtc_epoch       : 1900
alarm           : **:**:**
DST_enable      : yes
BCD             : no
24hr            : yes
square_wave     : yes
alarm_IRQ       : yes
update_IRQ      : yes
periodic_IRQ    : yes
periodic_freq   : 0
batt_status     : okay

Portion of  strace on 'hwclock'  command. The time it  reads does not  seem to
change and so the command does not return even after a number of minutes:

write(1, "/dev/rtc does not have interrupt"..., 93/dev/rtc does not have
interrupt functions. Waiting in loop for time from /dev/rtc to change
) = 93
ioctl(4, RTC_RD_TIME, {tm_sec=165, tm_min=165, tm_hour=165, tm_mday=165,
tm_mon=164, tm_year=165, ...}) = 0
ioctl(4, RTC_RD_TIME, {tm_sec=165, tm_min=165, tm_hour=165, tm_mday=165,
tm_mon=164, tm_year=165, ...}) = 0
ioctl(4, RTC_RD_TIME, {tm_sec=165, tm_min=165, tm_hour=165, tm_mday=165,
tm_mon=164, tm_year=165, ...}) = 0

Before your changes,  rtc_ioctl was implemented in the PPC  specific rtc.c and
it used  to call ppc_md.get_rtc_time  for RTC_RD_TIME,  which I think  used to
end  up  in  rtas_get_rtc_time.  After  your changes,  time  is  now  read  in
rtc_get_rtc_time using CMOS_READ calls, which apparently is resulting in wrong
values being  read. I changed  rtc_do_ioctl to make it  call rtas_get_rtc_time
for RTC_RD_TIME call and the problem went away.

Have I  missed something or  does this  need fixing? Do  we really need  a PPC
specific rtc_ioctl call that calls into rtas_get_rtc_time?

Thanks,
Sripathi.
