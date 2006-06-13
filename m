Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWFMO0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWFMO0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWFMO0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:26:20 -0400
Received: from rtr.ca ([64.26.128.89]:41447 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751133AbWFMO0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 10:26:19 -0400
Message-ID: <448ECB09.3010308@rtr.ca>
Date: Tue, 13 Jun 2006 10:26:17 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17: networking bug??
References: <448EC6F3.3060002@rtr.ca>
In-Reply-To: <448EC6F3.3060002@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are packet traces from the working (2.6.16) and non-working (2.6.17) kernels.

The differences I see are widely varying "window sizes".
What would cause this?

Here's a partial trace of the working connection 2.6.16.18:

IP silvy.localnet.32776 > zippy.localnet.domain:  50718+ A? www.everymac.com. (34)
IP zippy.localnet.domain > silvy.localnet.32776:  50718 1/5/5 A 216-145-246-23.rev.dls.net (234)
IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: S 2933486277:2933486277(0) win 5840 <mss 1460,sackOK,timestamp 730285 0,nop,wscale 2>
IP 216-145-246-23.rev.dls.net.www > silvy.localnet.56224: S 2545625510:2545625510(0) ack 2933486278 win 65535 <mss 1452,nop,wscale 1,nop,nop,timestamp 134760199 730285>
IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: . ack 1 win 1460 <nop,nop,timestamp 730448 134760199>
IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 1460 <nop,nop,timestamp 730448 134760199>
IP 216-145-246-23.rev.dls.net.www > silvy.localnet.56224: P 1:206(205) ack 607 win 32798 <nop,nop,timestamp 134760217 730448>
IP silvy.localnet.56224 > 216-145-246-23.rev.dls.net.www: . ack 206 win 1728 <nop,nop,timestamp 730626 134760217>
IP silvy.localnet.32776 > zippy.localnet.domain:  24229+ A? www.everymac.com. (34)
IP zippy.localnet.domain > silvy.localnet.32776:  24229 1/5/5 A 216-145-246-23.rev.dls.net (234)
IP silvy.localnet.56225 > 216-145-246-23.rev.dls.net.www: S 2943511062:2943511062(0) win 5840 <mss 1460,sackOK,timestamp 730932 0,nop,wscale 2>
IP 216-145-246-23.rev.dls.net.www > silvy.localnet.56225: S 3806049331:3806049331(0) ack 2943511063 win 65535 <mss 1452,nop,wscale 1,nop,nop,timestamp 134760264 730932>
IP silvy.localnet.56225 > 216-145-246-23.rev.dls.net.www: . ack 1 win 1460 <nop,nop,timestamp 731095 134760264>
IP silvy.localnet.56225 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 1460 <nop,nop,timestamp 731095 134760264>
IP 216-145-246-23.rev.dls.net.www > silvy.localnet.56225: P 1:206(205) ack 607 win 32798 <nop,nop,timestamp 134760281 731095>
IP silvy.localnet.56225 > 216-145-246-23.rev.dls.net.www: . ack 206 win 1728 <nop,nop,timestamp 731274 134760281>
IP silvy.localnet.32776 > zippy.localnet.domain:  55754+ A? adserver.kylemedia.com. (40)
IP zippy.localnet.domain > silvy.localnet.32776:  55754 1/5/5 A 216-145-246-23.rev.dls.net (249)
IP silvy.localnet.56226 > 216-145-246-23.rev.dls.net.www: S 2940109661:2940109661(0) win 5840 <mss 1460,sackOK,timestamp 731360 0,nop,wscale 2>
IP 216-145-246-23.rev.dls.net.www > silvy.localnet.56226: S 388231707:388231707(0) ack 2940109662 win 65535 <mss 1452,nop,wscale 1,nop,nop,timestamp 134760306 731360>

And again, from the non-working connection 2.6.17-rc6-git2:

IP silvy.localnet.32770 > zippy.localnet.domain:  44986+ A? www.everymac.com. (34)
IP zippy.localnet.domain > silvy.localnet.32770:  44986 1/5/5 A 216-145-246-23.rev.dls.net (234)
IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: S 3000518105:3000518105(0) win 5840 <mss 1460,sackOK,timestamp 4294759165 0,nop,wscale 6>
IP 216-145-246-23.rev.dls.net.www > silvy.localnet.33472: S 3368494549:3368494549(0) ack 3000518106 win 65535 <mss 1452,nop,wscale 1,nop,nop,timestamp 134771817 4294759165>
IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: . ack 1 win 92 <nop,nop,timestamp 4294759337 134771817>
IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 92 <nop,nop,timestamp 4294759337 134771817>
IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: P 1:607(606) ack 1 win 92 <nop,nop,timestamp 4294760162 134771817>
IP 216-145-246-23.rev.dls.net.www > silvy.localnet.33472: . ack 607 win 32798 <nop,nop,timestamp 134771918 4294760162>
IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: F 607:607(0) ack 1 win 92 <nop,nop,timestamp 4294770176 134771817>
IP 216-145-246-23.rev.dls.net.www > silvy.localnet.33472: . ack 608 win 32798 <nop,nop,timestamp 134772918 4294770176>
IP 216-145-246-23.rev.dls.net.www > silvy.localnet.33472: F 206:206(0) ack 608 win 32798 <nop,nop,timestamp 134772918 4294770176>
IP silvy.localnet.33472 > 216-145-246-23.rev.dls.net.www: R 3000518713:3000518713(0) win 0

The client machine is "silvy", my firewall/dns box is "zippy",
and 216-145-246-23 is www.everymac.com.

The differences begin really early in these traces,
with 2.6.16.18 using a win size of 1460,
and 2.6.17-rc6 using a win size of 92 ???

