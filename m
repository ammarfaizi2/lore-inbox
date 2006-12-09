Return-Path: <linux-kernel-owner+w=401wt.eu-S936334AbWLIOZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936334AbWLIOZm (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936316AbWLIOZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:25:41 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:27453 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936342AbWLIOZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:25:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rQEWhE5QZqRCxr1ZD+eEFbQHLYC9SmbomHfWRKq6XEYZRL6kT8VD72m2Az1BXnsFHyyA8MriH95dh9Me+8yMVdZmk+Gn0MMn9VfrV4+RnpTIMQnm+il6iac9yOQiciYv9QXY7G2l8UnNBS0D+HryWZB8ttch+RIi8GYDnqAduPw=
Message-ID: <6c64c0b90612090625k473f09f7uebd56bacfcb6ed38@mail.gmail.com>
Date: Sat, 9 Dec 2006 15:25:39 +0100
From: "Sylvain Goletto" <sygoletto@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: HPET behavior and one-shot timer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am trying to use one-shot timers with the HPET as described in the
Intel specs (http://www.intel.com/hardwaredesign/hpetspec_1.pdf).
The linux hpet driver (2.6.17.13) has no API to do that (only periodic
timers at that time) an I am looking for the best way to add this
possibility to the kernel.

At this time I have developed a module that uses
hpet_register/hpet_control to get a hpet timer and uses hpet registers
to set a one-shot timer and wait for the interrupt.
My tests gave strange results : the interrupt comes as soon as I set
the interrupt enable bit for the timer.

So I made other tests with the original driver (kernel 2.6.17.13) and
the demo code in Documentation/hpet.txt and here is what I get: the
behavior is different between the first time I launch the test and the
others.
The following hpet_test polls for 2 interrupt and the frequency is set
to 1Hz so the expired time should be around 1000000us but it is only
true for the first time I use the timer after a fresh boot :

First run after fresh boot :

[HPET]# ./hpet_test poll /dev/hpet 1 2
-hpet: executing poll
hpet_poll: expired time = 1000008     <=== 1s, good
hpet_poll: revents = 1
hpet_poll: data 0x1
hpet_poll: expired time = 999997     <=== 1s, good
hpet_poll: revents = 1
hpet_poll: data 0x1

Second run :

[HPET]# ./hpet_test poll /dev/hpet 1 2
-hpet: executing poll
hpet_poll: expired time = 2     <=== 2us, BAD !!!
hpet_poll: revents = 1
hpet_poll: data 0x1
hpet_poll: expired time = 999992     <=== 1s, good
hpet_poll: revents = 1
hpet_poll: data 0x1

As you can see, the first run gives 1s for expiration time for the all
IT, but all other runs give 2/3 us for first IT !!!
If I want to reproduce, I have to reboot.

Is this the normal behavior ?
It looks like something (driver value, hpet register, ...) is not
re-set to the initial parameters.

I am trying to find what's wrong in the hpet.c file but I can't figure
out at the moment.

I also want to add aperiodic/one-shot interrupt possibility to the
driver so the the user can tell the hpet timer to send one IT in XXX
us from now or from a timeval parameter. But this will only be
possible if the previous problem is solved. I have a working module
the sets the comparator register with the right value for but the
interrupt fires immediately so it is unusable at the time.

Thank you in advance for the help.

- Sylvain
