Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132232AbQK2X55>; Wed, 29 Nov 2000 18:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132248AbQK2X5h>; Wed, 29 Nov 2000 18:57:37 -0500
Received: from rf-mail1.echostar.com ([205.172.144.40]:37390 "EHLO
        rf-exch2.echostar.com") by vger.kernel.org with ESMTP
        id <S132232AbQK2X5f>; Wed, 29 Nov 2000 18:57:35 -0500
Message-ID: <3A2590C8.34459BF9@echostar.com>
Date: Wed, 29 Nov 2000 16:27:04 -0700
From: "Ian S. Nelson" <ian.nelson@echostar.com>
Reply-To: ian.nelson@echostar.com
Organization: Echostar
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test10.isn i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Octal vs. Hex war o' death
Content-Type: multipart/mixed;
 boundary="------------0EC9A04C9F50E3DDD0C34900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0EC9A04C9F50E3DDD0C34900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I'm sure this is a religious issue... but I'm going to suggest it
anyways because I spent a few minutes on it.

So I was hacking away trying to get my embedded box to run the correct
stuff after booting up and I ran into an octal speed bump.  You see, all
throughout rd.c there are these hex constants, like there should be.  In
fact most constants in the kernel are in the 2 friendliest number
formats known, hex and dec.

in rd.c there is an:
memset(buf, 0xe5, size);

a:
 printk("%c\b", rotator[rotate & 0x3]);

and a:
#define WSIZE 0x8000

and several others, all in hex.

Then I ran into this black sheep:
 if (buf[0] == 037 && ((buf[1] == 0213) || (buf[1] == 0236))) {


I vote that we make this consistent and fix it.  So I've included a
handy patch to correct this "bug."  My rationale is that a) most
constants are in hex or dec already,  b) my editor doesn't sport an
octal mode but it has a really handy hex mode that let's me do things
like load up an initrd and check to see that the first 2 bytes are set
correctly,  c) octals were invented for UNIX file permissions and not
programming, putting an extra "0" in there just doesn't make sense and
shouldn't change the meaning of the following digits, "0x" on the other
hand clearly denotes that you are not looking at a base 10 number.  In
math they teach you that you can arbitrarily add zeros to the front of a
number and not change it's meaning, such as the military frequently does
with time ("0700 hours.." which translates to "7:00" and not  "4:48")
and math goes together hand in hand with programming.  lastly, d) octal
numbers just don't have a good feeling to them, it's like your stuck at
half-duplex or something..



Ian


--------------0EC9A04C9F50E3DDD0C34900
Content-Type: text/plain; charset=us-ascii;
 name="minutia.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="minutia.patch"

diff -urP virgin-linux/drivers/block/rd.c linux/drivers/block/rd.c
--- virgin-linux/drivers/block/rd.c	Fri Nov 17 17:46:55 2000
+++ linux/drivers/block/rd.c	Wed Nov 29 15:45:33 2000
@@ -497,7 +497,7 @@
 	/*
 	 * If it matches the gzip magic numbers, return -1
 	 */
-	if (buf[0] == 037 && ((buf[1] == 0213) || (buf[1] == 0236))) {
+	if (buf[0] == 0x1f && ((buf[1] == 0x8b) || (buf[1] == 0x9e))) {
 		printk(KERN_NOTICE
 		       "RAMDISK: Compressed image found at block %d\n",
 		       start_block);

--------------0EC9A04C9F50E3DDD0C34900--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
