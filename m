Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVFIPX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVFIPX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 11:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVFIPX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 11:23:58 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:57355 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261849AbVFIPXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 11:23:53 -0400
Message-Id: <200506091523.j59FNmsr008443@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: tcp_bic (was Re: 2.6.12-rc6-mm1 OOPS in tcp_push_one() 
In-Reply-To: Your message of "Wed, 08 Jun 2005 22:58:17 PDT."
             <20050608.225817.112619139.davem@davemloft.net> 
From: Valdis.Kletnieks@vt.edu
References: <200506090423.j594NWts004829@turing-police.cc.vt.edu>
            <20050608.225817.112619139.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118330628_3931P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Jun 2005 11:23:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118330628_3931P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <8426.1118330609.1@turing-police.cc.vt.edu>

On Wed, 08 Jun 2005 22:58:17 PDT, "David S. Miller" said:
> From: Valdis.Kletnieks@vt.edu
> Date: Thu, 09 Jun 2005 00:23:32 -0400
> 
> > (On a related note, how did tcp_bic get loaded? I requested all the new
> > congestion stuff be built as modules, didn't specifically request any of
> > them to actually be loaded....
> 
> It's the default algorithm, so when you open the first TCP
> socket it tries to load it.

Ahh.. I was reading the Kconfig, which says this:

menu "TCP congestion control"
# TCP Reno is builtin (required as fallback)
        
config TCP_CONG_BIC
        tristate "Binary Increase Congestion (BIC) control"
        depends on INET
        default y

and I built with:

CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_SCALABLE=m

so what I *expected* was a kernel with Reno built-in, and the others as
modules if I got ambitious and loaded one or another.

How do people feel about this:

--- linux-2.6.12-rc6-mm1/net/ipv4/Kconfig.bic	2005-06-07 12:55:41.000000000 -0400
+++ linux-2.6.12-rc6-mm1/net/ipv4/Kconfig	2005-06-09 11:12:26.000000000 -0400
@@ -425,6 +425,10 @@ config TCP_CONG_BIC
 	increase provides TCP friendliness.
 	See http://www.csc.ncsu.edu/faculty/rhee/export/bitcp/
 
+	This is the default TCP congestion control and the kernel will
+	attempt to load it if possible.  If it is unable to initialize
+	tcp_bic, the TCP Reno algorithms will be used as a fallback.
+
 config TCP_CONG_WESTWOOD
 	tristate "TCP Westwood+"
 	select IP_TCPDIAG

(although that *still* doesn't document what's really going on with
the tcp_init_congestion_control() function, and how that sysctl value
interacts with things....




--==_Exmh_1118330628_3931P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCqF8EcC3lWbTT17ARAk5GAKCzjeGzsCyi0hBWcMQo9FK4k0sytgCg5TDe
uwHHr63Nw5oH4/5oVZuQ+RE=
=AB5D
-----END PGP SIGNATURE-----

--==_Exmh_1118330628_3931P--
