Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWJJSFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWJJSFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWJJSFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:05:07 -0400
Received: from tla.xelerance.com ([193.110.157.130]:38664 "EHLO
	tla.xelerance.com") by vger.kernel.org with ESMTP id S964957AbWJJSFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:05:04 -0400
Date: Tue, 10 Oct 2006 20:08:32 +0200 (CEST)
From: Paul Wouters <paul@xelerance.com>
To: fedora-xen@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: more random device badness in 2.6.18 :(
Message-ID: <Pine.LNX.4.63.0610101944010.21866@tla.xelerance.com>
X-Message-Flag: You should stop using Outlook and switch to Thunderbird
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-From: paul@xelerance.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running 2.6.18-1.2741.fc6xen in dom0, I end up with the "intel_rng"
loaded and thus a /dev/hw_random (/dev/hwrng) device.

Since hardware random is not transparently added to /dev/random's entropy,
applications such as Openswan need to test for the availability of the
seperate device file (not a good design imho). So Openswan will use
/dev/hw_random if available. My guess is that we will need to change that
to /dev/hwrng, but we need to stay compatible for the earlier 2.6 kernels
that did not have /dev/hwrng. (let's hope the softlink stays there until
everything gets folded into a single /dev/random device again).

So I noticed Openswan was blocking indefinately on reading from /dev/hw_random.
By design, stock openswan generates a new default hostkey in a subshell,
so nothing too bad happens (bug filed against fedora openswan package to
not generate a hostkey in %post, support for fedora style hostkey added in
openswan-2.4.7dr2)

It seems my board has either no intel_rng on board, or a bad driver for it.
The intel_rng module gets loaded and the /dev/hw_random and /dev/hwrng
device nodes are create. But using these results in a hanging read:

# hexdump -C /dev/hw_random
00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*

Every call to /dev/hw_random gives that one (not very random!) line of output,
and then nothing more ever. A call to /dev/random still works:

# hexdump -C /dev/random
00000000  67 de a9 63 cf 2a 14 49  24 50 ec 1f 81 a7 4f b2  |g..c.*.I$P....O.|
00000010  b5 9d 8e 99 a3 d7 0d d5  45 ea 55 5a 70 4b 07 aa  |........E.UZpK..|
00000020  4a e1 20 e3 2f 03 0a 89  43 b0 49 3c cb 01 3a 76  |J. ./...C.I<..:v|
00000030  10 4c c5 db d5 32 ff b1  8a 35 21 69 e0 1a 1a e2  |.L...2...5!i....|
[...]

We really don't want to have to verify the validity and availability of
hardware random. Bugs in the past with the padlock caused us to not even be
able to use /dev/random if the random code from the padlock module was loaded,
so this is becoming quite ugly. We can't ignore the hardware random, nor can
we assume it works if present.

So, this is a bug report against 2.6.18-1.2741.fc6xen to report broken
random. It is also a request for a better random device design, possibly
integrated with the Open Cryptographic Framework (OCF) code that handles
various crypto related hardware offloads.

I hope that the Linux kernel will soon go back to a single /dev/random
device that will use hardware random if available, and fall back to
software random if the hardware is not providing random, so that we don't
need to add all this complexity to find a working random device within the
applications.

Related to this is that random in a xen guest has also never been very good.
Perhaps it needs to be able to pull directly from the dom0's random pool.

Paul
