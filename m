Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSFTNZw>; Thu, 20 Jun 2002 09:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSFTNZv>; Thu, 20 Jun 2002 09:25:51 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:41413 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S314422AbSFTNZt>; Thu, 20 Jun 2002 09:25:49 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: (2.5.23) buffer layer error at buffer.c:2326
Date: Thu, 20 Jun 2002 23:22:41 +1000
User-Agent: KMail/1.4.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206192007210.1263-100000@netfinity.realnet.co.sz> <3D10E358.D82DB604@zip.com.au> <20020620125036.B3824@redhat.com>
In-Reply-To: <20020620125036.B3824@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_THA0PP89ZUGVF7P6G1ZE"
Message-Id: <200206202322.41275.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_THA0PP89ZUGVF7P6G1ZE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Thu, 20 Jun 2002 21:50, Stephen C. Tweedie wrote:
> Hi,
>
> On Wed, Jun 19, 2002 at 01:02:32PM -0700, Andrew Morton wrote:
> > What this says is: I still need to get down and set up a fault simulator
> > and make sure that we're doing all the right things when I/O errors
> > occur.
>
> I've got one for 2.4:
>
> 	http://people.redhat.com/sct/patches/testdrive/
>
> The testdrive-1.1-for-2.4.19pre10.patch can do random fault injection,
> at pseudo-random intervals of selectable frequency, on reads or writes
> or both.  It's a modified loop.o which requires a separate
> testdrive.o, and you just losetup it over a block device (or, more
> easily, "mount -o loop /dev/foo /mnt/bar".)
I've often thought that more "in kernel" test features should be available for 
those who'd like to do a bit of torture testing, but don't have all the 
patches to hand.
In addition to this, maybe tests to:
1. Fail kmalloc occasionally
2. Corrupt network data packets
3. Test USB hardware  (there was a kernel patch for isoc bandwidth tests, that 
allowed writing to a non-existent endpoint - bitrotted now)
and probably lots more.

I'd like to see all of these enabled seperately as CONFIG_ options. They also 
need to be protected by something like CONFIG_EXPERIMENTAL, so people don't 
unwittingly enable them on production systems.
An example (not meant to be applied) of this is attached. You'd then just 
dep_(m)bool on CONFIG_TESTONLY for whatever CONFIG_KMALLOC_TESTMODE type 
thing you've added.

Thoughts?

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
--------------Boundary-00=_THA0PP89ZUGVF7P6G1ZE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="testonly-example.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="testonly-example.patch"

diff -Naur -X dontdiff linux-2.5.23-clean/init/Config.help linux-2.5.23-testonly/init/Config.help
--- linux-2.5.23-clean/init/Config.help	Wed Jun 19 12:11:47 2002
+++ linux-2.5.23-testonly/init/Config.help	Thu Jun 20 22:49:21 2002
@@ -27,6 +27,21 @@
   you say Y here, you will be offered the choice of using features or
   drivers that are currently considered to be in the alpha-test phase.
 
+CONFIG_TESTONLY
+  The kernel has certain options that are intended only for testing
+  and should never be enabled on production systems. These options
+  may intentionally cause failures and prevent proper operation of
+  your system.
+
+  If you are trying to perform particular testing of the system, then
+  you need to enable this option, and whatever specific tests you
+  are interested in. Note that this option doesn't actually enable
+  any of the test-only features, it simply protects you from seeing
+  them in subsequent configuration questions.
+
+  You should say N, unless you understand absolutely everything
+  this might affect.
+
 CONFIG_NET
   Unless you really know what you are doing, you should say Y here.
   The reason is that some programs need kernel networking support even
diff -Naur -X dontdiff linux-2.5.23-clean/init/Config.in linux-2.5.23-testonly/init/Config.in
--- linux-2.5.23-clean/init/Config.in	Wed Jun 19 12:11:48 2002
+++ linux-2.5.23-testonly/init/Config.in	Thu Jun 20 23:12:30 2002
@@ -1,6 +1,7 @@
 mainmenu_option next_comment
 comment 'Code maturity level options'
 bool 'Prompt for development and/or incomplete code/drivers' CONFIG_EXPERIMENTAL
+bool 'Prompt for options that are intended only for testing' CONFIG_TESTONLY
 endmenu
 
 mainmenu_option next_comment

--------------Boundary-00=_THA0PP89ZUGVF7P6G1ZE--

