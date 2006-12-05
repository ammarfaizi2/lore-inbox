Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757055AbWLEXun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055AbWLEXun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756952AbWLEXun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:50:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38861 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092AbWLEXul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:50:41 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "David Brownell" <david-b@pacbell.net>,
       "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, "Greg KH" <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linuxbios@linuxbios.org,
       "Andi Kleen" <ak@suse.de>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
References: <5986589C150B2F49A46483AC44C7BCA490728A@ssvlexmb2.amd.com>
Date: Tue, 05 Dec 2006 16:50:05 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA490728A@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Tue, 5 Dec 2006 15:29:32 -0800")
Message-ID: <m13b7t7viq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> -----Original Message-----
> From: linuxbios-bounces@linuxbios.org
> [mailto:linuxbios-bounces@linuxbios.org] On Behalf Of
> ebiederm@xmission.com
> Sent: Tuesday, December 05, 2006 3:01 AM
>
>>+static int ehci_wait_for_port(int port)
>>+{
>>+	unsigned status;
>>+	int ret, reps;
>>+	for (reps = 0; reps >= 0; reps++) {
>>+		status = readl(&ehci_regs->status);
>>+		if (status & STS_PCD) {
>>+			ret = ehci_reset_port(port);
>>+			if (ret == 0)
>>+				return 0;
>>+		}
>>+	}
>>+	return -ENOTCONN;
>>+}
>>+
>
> What do you mean by
> +	for (reps = 0; reps >= 0; reps++) {
> ?

If you will not reps is negative.  Roughly it is a loop
that will timeout eventually if a usb debug cable is not present.
Putting some deliberate delays in there so I could be certain
of timing out after a second or two would probably be better, but
I don't have anything that resembles a good timer at that point.

The problem is you have to wait until the ehci notices your usb
debug cable before you reset it and get it going and that can be a
non-trivial amount of time.  So the loop is 100% necessary.

So since I didn't know how many loop iterations made sense I allowed
it to loop for 2^31 times or until reps goes negative.

Eric
