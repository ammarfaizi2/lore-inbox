Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLSRWa>; Tue, 19 Dec 2000 12:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLSRWU>; Tue, 19 Dec 2000 12:22:20 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:4501 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129257AbQLSRWF>;
	Tue, 19 Dec 2000 12:22:05 -0500
Date: Tue, 19 Dec 2000 11:51:24 -0500
Message-Id: <200012191651.LAA02207@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Kurt Garloff <garloff@suse.de>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: Kurt Garloff's message of Tue, 19 Dec 2000 12:49:48 +0100,
	<20001219124948.P17777@garloff.suse.de>
Subject: Re: /dev/random: really secure?
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 19 Dec 2000 12:49:48 +0100
   From: Kurt Garloff <garloff@suse.de>

   On Mon, Dec 18, 2000 at 04:33:13PM -0500, Theodore Y. Ts'o wrote:
   > Note that writing to /dev/random does *not* update the entropy estimate,
   > for this very reason.  The assumption is that inputs to the entropy
   > estimator have to be trusted, and since /dev/random is typically
   > world-writeable, it is not so trusted.

   It should not be world-writeable, IMHO. So the only one who can feed entropy
   there is root, who should know aht (s)he's doing ...
   Here (SuSE Linux 7.x), it is 644:
   crw-r--r--    1 root     root       1,   8 Dec 17 22:41 /dev/random
   crw-r--r--    1 root     root       1,   9 Dec 17 22:41 /dev/urandom

No, writing to /dev/random does not feed update entropy estimate.  It
does mix data into the pool, but the mixing algorithm is designed so
that you can do no harm by mixing any data into the pool --- even nasty
data chosen by an attacker.  Hence, allowing someone to write into
/dev/random is perfectly safe; it can cause no damage, and might improve
things.  That's why /dev/random should be world-writeable.

There is a separate ioctl which requires root privs to atomically mix
data into the pool and update the entropy estimate.  That's the
interface which is supposed to be used by trusted daemons which pull
data from various hardware devices, and feed them into /dev/random.

Note that in this case, the trusted daemon is supposed to estimate the
amount of entropy which it is feeding into the system.  That's because
the daemon may be able to use much more sophisticated entropy estimation
systems, including ones which may require large amounts of CPU time (for
example, to do FFT's, trial compression of the data, etc.).

					- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
