Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbTLZCEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 21:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTLZCEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 21:04:34 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:45324 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264445AbTLZCEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 21:04:30 -0500
Message-ID: <3FEB972B.4010406@amberdata.demon.co.uk>
Date: Fri, 26 Dec 2003 02:04:27 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: handling an oddball PS/2 keyboard (w/ patch)
References: <3FEA5044.5090106@amberdata.demon.co.uk> <20031225063936.GA15560@win.tue.nl> <200312251316.hBPDG7LT000163@81-2-122-30.bradfords.org.uk> <3FEAFDF3.80008@amberdata.demon.co.uk>
In-Reply-To: <3FEAFDF3.80008@amberdata.demon.co.uk>
Content-Type: multipart/mixed;
 boundary="------------010202080508060400060004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010202080508060400060004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Monro wrote:
> John Bradford wrote:
> 
[..]
>> There might be no need for such a workaround - a lot of PS/2 
>> devices which were not intended for PCs work fine in set 3, 
>> particularly if
[..]

Ok I've turned my brain on and looked at the difference between set2 and
set3... and its trivial! The NCD N-97 returns set3 keycodes even when
its told to be in set2. Thanks very much for making me look at that!

So my first thought was to just pass the atkbd_set=3 option to the
kernel. Which doesn't work - I still get set2. Looking at atkbd.c it
really doesn't handle _translated_ set3 at all - for one thing
atkbd_set_3() forces set2 if we have a translating i8042 (ie normality),
and for another it still does e0/e1 translation for set3 - which imho is 
wrong.

Both of these can be avoided by passing the i8042_direct option to the
i8042 module however, since that puts the i8042 into non-translating 
mode. However this can have undesirable side effects - for example my 
bios appears to re-enable translating mode if I suspend/resume.

So. Short term solution is just to pass atkbd_set=3 and i8042_direct=1 
to the kernel, and live without suspend/resume (and that should work for 
John as well).

Longer term: fix atkbd.c to handle translated set3 correctly, and then 
just use atkbd_set=3. Vojtech: I've included a patch which I think does 
this, and works for me; do you think it looks reasonable? I've just done 
a couple of quick hacks to make this work (basically assume anyone who 
sets atkbd_set= knows what they are doing, and don't special-case e0/e1 
in set3) - but is that all there is to it? I've assumed that all other 
codes are still valid in set3. I also haven't done it very prettily :)

Even the above won't fix things for anyone who has a keyboard which a) 
needs set3 handling b) generates codes above 0x7F c) has a broken i8042 
translation implementation which mangles the codes above 0x7F and d) has 
a problem using the i8042 in raw mode because of suspend/resume... in 
which case, I think that will have to be fixed by getting the i8042 code 
to reset raw mode on resume.. if thats even possible. Fortunately I 
think this should be a very rare case :)

Cheers,

	David

--------------010202080508060400060004
Content-Type: text/plain;
 name="atkbd.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atkbd.c.diff"

--- atkbd.c.ORIG	Thu Dec 25 02:19:28 2003
+++ atkbd.c	Fri Dec 26 01:40:47 2003
@@ -196,8 +196,10 @@
 	if (atkbd->translated) do {
 
 		if (atkbd->emul != 1) {
-			if (code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1)
-				break;
+			if (atkbd->set != 3) {
+				if (code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1)
+					break;
+			}
 			if (code == ATKBD_RET_BAT) {
 				if (!atkbd->bat_xl)
 					break;
@@ -230,11 +232,19 @@
 			serio_rescan(atkbd->serio);
 			goto out;
 		case ATKBD_RET_EMUL0:
-			atkbd->emul = 1;
-			goto out;
+			if (atkbd->set != 3) {
+				atkbd->emul = 1;
+				goto out;
+			} else {
+				break;
+			}
 		case ATKBD_RET_EMUL1:
-			atkbd->emul = 2;
-			goto out;
+			if (atkbd->set != 3) {
+				atkbd->emul = 2;
+				goto out;
+			} else {
+				break;
+			}
 		case ATKBD_RET_RELEASE:
 			atkbd->release = 1;
 			goto out;
@@ -482,7 +492,7 @@
  * IBM RapidAccess / IBM EzButton / Chicony KBP-8993 keyboards.
  */
 
-	if (atkbd->translated)
+	if ((atkbd->translated) && (atkbd_set == 2))
 		return 2;
 
 	if (atkbd->id == 0xaca1) {

--------------010202080508060400060004--

