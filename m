Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264589AbRFTT47>; Wed, 20 Jun 2001 15:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264591AbRFTT4t>; Wed, 20 Jun 2001 15:56:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10758 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264589AbRFTT4f>; Wed, 20 Jun 2001 15:56:35 -0400
Date: Wed, 20 Jun 2001 16:56:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
Cc: Alan Cox <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac15
In-Reply-To: <20010619232328.A19241@frodo.uni-erlangen.de>
Message-ID: <Pine.LNX.4.33.0106201654570.1376-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Walter Hofmann wrote:
> On Sun, 17 Jun 2001, Walter Hofmann wrote:
>
> > I had already two crashes with ac15. The system was still ping-able, but
> > login over the network didn't work anymore.
> >
> > The first crash happened after I started xosview and noticed that the
> > system almost used up the swap (for no apparent reason). The second
> > crash happened shortly after I started fsck on a crypto-loop device.
>
> FWIW, here is the vmstat output for the second (short) hang. Taken with
> ac14, vmstat 1 was started (long) before the hang and interrupted about
> five seconds after it. The machine has 128MB RAM and 256MB swap.

>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  1  0  0  77000   1464  18444  67324   8   0   152   224  386  1345  26  19  55
>  2  4  2  77084   1524  18396  66904   0 1876   108  2220 2464 66079   1  98   1

Does the following patch help with this problem, or are
you both experiencing something unrelated to this particular
buglet ?

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


--- linux/mm/swapfile.c.~1~	Thu May  3 16:34:46 2001
+++ linux/mm/swapfile.c	Thu May  3 16:36:07 2001
@@ -67,8 +67,14 @@
 	}
 	/* No luck, so now go finegrined as usual. -Andrea */
 	for (offset = si->lowest_bit; offset <= si->highest_bit ; offset++) {
-		if (si->swap_map[offset])
+		if (si->swap_map[offset]) {
+			/* Any full pages we find we should avoid
+			 * looking at next time. */
+			if (offset == si->lowest_bit)
+				si->lowest_bit++;
 			continue;
+		}
+
 	got_page:
 		if (offset == si->lowest_bit)
 			si->lowest_bit++;
@@ -79,6 +85,7 @@
 		si->cluster_next = offset+1;
 		return offset;
 	}
+	si->highest_bit = 0;
 	return 0;
 }


