Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWINOmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWINOmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWINOmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:42:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:3728 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750865AbWINOmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:42:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=n7huy75gG2jQJkNpIF8iQ4esTvaqeXhRI1osr5O0HIaHE+z/k4bMh9hyg/GvFMPYlYtBA+GQXxQmGarkwwkaLz6LvpedokE/967WuexI5Kp293rbgPYRj7r47Zhj1/4Y+vq0GyqiX1IQiYqI0J412uwVk664CuL+z5UdRy7srf0=
Message-ID: <45096A52.40706@gmail.com>
Date: Thu, 14 Sep 2006 18:42:26 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: pm list <linux-pm@lists.osdl.org>
CC: Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [RFC] CPUFreq PowerOP integration, Intro 0/3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Integrating CPUFreq and PowerOP was discussed at the Linux PM summit
and in recent emails exchanges.  Some say keep them separate and some
say they must be integrated.  There is actually a very natural point
where integration makes sense - cpufreq_driver. This patchset presents
that integration point and is submitted for discussion.

The patches do not change the functionality of the cpufreq core.
Instead the idea is to redesign the tightly coupled interfaces of
cpufreq to clearly separate the arch dependent and independent pieces
layers.  This enables cpufreq to become arch independent and can start
to use the named operating points in all its layers.

PowerOP  replaces cpufreq driver as the h/w independent interface for
operating points.  PM core handles the h/w specific details for
defining the power parameters and setting the power parameters in h/w
registers.  Operating point definition/registration is now independent
of cpufreq.

Please note, that all userspace/kernel governor concepts, legacy sysfs cpufreq
interface remain untouched and SMP case is accounted in the resulting code as
well.

Highlights:

cpufreq.c
- get rid of cpufreq driver calls. the calls are replaced be calls to arch
independent freq_helpers (freq_helpers.c)
- available frequencies sysfs interface now can be handled in arch independent
way
- cpufreq_sysdev_driver now serves only cpufreq core internal needs upon cpu
add/remove events (since all hw related is handled by PM Core)
- cpufreq_powerop_call() is added to handle operating point registration in the
kernel by an independent module at arbitrary moment

freq_table.c (now freq_helpers.c)
- get rid of cpufreq_frequency_table structures as input parameter and made the
code arch independent by leveraging PowerOP interface
- routine remain the same but are no longer used by arch dependent code but by
cpufreq core arch independent code instead
- all routines are arch independent; the only shared knowledge is platform
power parameter names (string)
- target() method expects power parameter names "freqN", "vN" are supported by
PM Core for cpu N
- setpolisy() method expects power parameter names "hfreqN", "lfreqN", "vN" are
supported by PM Core for cpu N

