Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWI3HxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWI3HxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 03:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWI3HxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 03:53:13 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:41668
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751122AbWI3HxL (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 03:53:11 -0400
Message-Id: <200609300750.k8U7oihQ008628@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: jt@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
In-Reply-To: Your message of "Fri, 29 Sep 2006 23:31:07 EDT."
             <200609300331.k8U3V71c008874@turing-police.cc.vt.edu>
From: Valdis.Kletnieks@vt.edu
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu> <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu> <20060929124558.33ef6c75.akpm@osdl.org> <200609300001.k8U01sPI004389@turing-police.cc.vt.edu> <20060929182008.fee2a229.akpm@osdl.org> <20060930013348.GA10905@bougret.hpl.hp.com>
            <200609300331.k8U3V71c008874@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159602643_8054P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 30 Sep 2006 03:50:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159602643_8054P
Content-Type: text/plain; charset=us-ascii

On Fri, 29 Sep 2006 23:31:07 EDT, Valdis.Kletnieks@vt.edu said:
> Fair enough,  I'm going to try reverting the 2 commits and see if things
> behave better.

OK, it's definitely something in those 2 commits - I reverted them and the
resulting 2.6.18-mm2 kernel has been up and stable for 4 hours, even with
the problem gkrellm updating once a second the whole time.

I'm not *seeing* how those changes can cause trouble - unless it's this:

diff --git a/drivers/net/wireless/orinoco.c b/drivers/net/wireless/orinoco.c
index 1840b69..9e19a96 100644
--- a/drivers/net/wireless/orinoco.c
+++ b/drivers/net/wireless/orinoco.c
@@ -3037,7 +3037,7 @@ static int orinoco_ioctl_getessid(struct
        }
 
        erq->flags = 1;
-       erq->length = strlen(essidbuf) + 1;
+       erq->length = strlen(essidbuf);

Does some other code go batshit if length ==0?  My current config doesn't
try to actually ifup the wireless if I also have connectivity via copper (in
order to avoid chewing up a DHCP lease in crowded address space if not needed).

% iwconfig eth5
eth5      IEEE 802.11b  ESSID:""  Nickname:"HERMES I"
          Mode:Managed  Frequency:2.457 GHz  Access Point: Not-Associated   
          Bit Rate:11 Mb/s   Sensitivity:1/3  
          Retry limit:4   RTS thr:off   Fragment thr:off
          Power Management:off
          Link Quality=0/92  Signal level=134/153  Noise level=134/153
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

That ESSID the source of the trouble?


--==_Exmh_1159602643_8054P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFHiHTcC3lWbTT17ARAo7OAJ9gqj5InOTJqNR2vTw88Z45y9EjmwCeMHwW
W8JqCgJYtBD5wRKIJCwJ4kk=
=Pio6
-----END PGP SIGNATURE-----

--==_Exmh_1159602643_8054P--
