Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLSHUO>; Tue, 19 Dec 2000 02:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLSHUE>; Tue, 19 Dec 2000 02:20:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12301 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129410AbQLSHTv>;
	Tue, 19 Dec 2000 02:19:51 -0500
Date: Tue, 19 Dec 2000 06:49:21 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random: really secure?
Message-ID: <20001219064921.F21944@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20001217225057.A8897@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001217225057.A8897@atrey.karlin.mff.cuni.cz>; from clock@atrey.karlin.mff.cuni.cz on Sun, Dec 17, 2000 at 10:50:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2000 at 10:50:57PM +0100, Karel Kulhavy wrote:
> I noticed peculiarities in the behaviour of the delta-delta-3 system for
> entropy estimation in the random.c code./ When I hold right alt or control, I
> get about 8 bits of entropy per repeat fro the /dev/random which is
> overestimated. I think the real entropy is 0 bits because it is absolutely
> deterministic when the interrupt comes. Am I right or is there any hidden

not absolutely, but we should ignore repeated keys that generate more than 
one scancode.

tytso, here's the patch to do it again:

--- linux/drivers/char/random.c	Sun Jul 30 18:01:23 2000
+++ linux-prumpf/drivers/char/random.c	Thu Sep 28 17:07:03 2000
@@ -763,10 +763,15 @@
 
 void add_keyboard_randomness(unsigned char scancode)
 {
-	static unsigned char last_scancode = 0;
-	/* ignore autorepeat (multiple key down w/o key up) */
-	if (scancode != last_scancode) {
-		last_scancode = scancode;
+	static unsigned char last_scancode[2] = { 0, 0 };
+
+	/* ignore autorepeat (multiple key down w/o key up).
+	 * add_keyboard_randomness is called twice for certain AT keyboard
+	 * keys, so we keep a longer history. */
+	if (scancode != last_scancode[0] &&
+	    scancode != last_scancode[1]) {
+		last_scancode[0] = last_scancode[1];
+		last_scancode[1] = scancode;
 		add_timer_randomness(&keyboard_timer_state, scancode);
 	}
 }

If we want to rely solely on the add_timer_randomness checks, we should
remove the autorepeat check completely.

	Philipp Rumpf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
