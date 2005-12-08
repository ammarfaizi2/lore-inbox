Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVLHO1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVLHO1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVLHO1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:27:48 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:29 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932126AbVLHO1s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:27:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Mp3Mk6nrFTPvATnJrEG0p5YIshXCQHd1dNFGnErWDcvpdMAT/zPDX387uUU+WjeAUB0cD9KICZow4A/VGSnOcRCbKNtKAhIfyQB0vYKq+fZaYRoO1y64DXV7a35m0Pk259bgoqPYT7IYA0l+FZT2oOeRub6YVP4ti50Em8GGmKI=
Message-ID: <7d40d7190512080627m702dfed6q@mail.gmail.com>
Date: Thu, 8 Dec 2005 15:27:43 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Preferred method to export info to userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody:

I am writing a module for analyzing packets in kernel space. In SMP
systems, the module creates as many kernel threads as CPUs, each bound
to a processor. When a new packet arrives, if it comes from the
capture interface, it is enqueued in a global skb queue (this is done
from netif_receive_skb()). The kernel threads will thereafter get the
packets from that queue and analyze them.

To test the module, as well as to gain some flexibility in its working
mode, the module has to communicate with user space. Configuration
options are:

* Turn ON/OFF the packet capturing, as well as change the way it captures them
   [I do this with a "flags" variable, which is changed from userspace
via ioctl]
* Change some configuration parameters: maximum length of the skb queue,
   capture interface i.e. eth0
   [I do this via read-write /proc files]
* Export statistics to userspace
   [I do this via a read-only /proc file]

This all works, but I would like to code it more ellegantly. I've been
reading some kernel code, and people use to do this kind of things in
different ways. For example, in the packet generator module (pktgen),
it uses some /proc files for all the configuration, for example, to
set/clear a flag:

set a flag:        echo "flag  IPDST_RND" > /proc/net/pktgen/eth1
clear a flag:     echo "flag !IPDST_RND" > /proc/net/pktgen/eth1

In contrast, in dev_ioctl() (net/core/dev.c), flags are set or cleared
via two ioctl commands (set: SIOCSIFFLAGS, get: SIOCGIFFLAGS).

If this weren't enough, it seems that there is a new filesystem for
exporting information to userspace: sysfs. This is similar to /proc
but with more constraints.
I mean, each file (attribute) should contain just one value. In my
module I export quite a lot information just calling
/proc/ksensor/stats:

$ cat /proc/ksensor/stats:
iface: eth1
captured: 18233
processed: 3334
dropped: 15003
errors: 34
cur_queue_len: 56
max_queue_len: 1024
(...)

So, I would have to create as many files as values I want to export in
sysfs? that would be quite a lot files, no?

And the last question, how should I configure the "flags" variable I
told before? Currently, I have three flags:

KSF_UP: whether the capture device is running or not
KSF_CONCTRL: whether it is used congestion control for incoming packets
KSF_TRANSP: whether it is made a copy of the packet so that the kernel
can continue processing the packet later (if not, the packet is
captured, analyzed and dropped).

Possible options are:

* I do this with a ioctl command for setting the flags and another one
for getting them.
* Another possibility would be to create as many files as flags in
/proc/ksensor and echo 1 to turn it on or echo 0 to turn it off.
* Another more possibility would be to use a command as I told before
what is done with pktgen module.
* And the last one, would be to do this in sysfs.

Which option do you think is better? I would thank any replies, or
ideas to these questions.
Regards

Aritz Bastida
