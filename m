Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263235AbVCDXne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbVCDXne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbVCDXkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:40:45 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:55229 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S263220AbVCDVpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:45:06 -0500
Date: Fri, 4 Mar 2005 22:45:04 +0100
To: linux-kernel@vger.kernel.org
Subject: useless check in port-allocation code?
Message-ID: <20050304214501.GK6156@vanheusden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
Organization: www.unixexpert.nl
Read-Receipt-To: <folkert@vanheusden.com>
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Sat Mar  5 18:55:34 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

In the 2.6.11 code, I found this:
static int tcp_v6_get_port(struct sock *sk, unsigned short snum)
also in:
static int tcp_v4_get_port(struct sock *sk, unsigned short snum)
{
...
        if (snum == 0) {
                int low = sysctl_local_port_range[0];
                int high = sysctl_local_port_range[1];

                spin_lock(&tcp_portalloc_lock);
		rover = tcp_port_rover;
                do {    rover++;
                        if ((rover < low) || (rover > high))
                                rover = low;

Now I wonder: is that 'rover < low' check not redundant?
ints are bigger then the maximum portnumber (65535) so when
rover++ gets too high, the check for 'rover > high' will truncate
it to low (in the next line) waaay before the int itself wraps.
Maybe it is needed because tcp_port_rover is < low before the
function starts, in that case the check for <low can be taken out
of the loop.

Patch:
diff -uNr net/ipv4/tcp_ipv4.c.org net/ipv4/tcp_ipv4.c
--- net/ipv4/tcp_ipv4.c.org     2005-03-04 22:39:37.340950747 +0100
+++ net/ipv4/tcp_ipv4.c 2005-03-04 22:40:35.570059217 +0100
@@ -222,10 +222,13 @@
                int rover;

                spin_lock(&tcp_portalloc_lock);
-               rover = tcp_port_rover;
+               if (tcp_port_rover < low)
+                       rover = low;
+               else
+                       rover = tcp_port_rover;
                do {
                        rover++;
-                       if (rover < low || rover > high)
+                       if (rover > high)
                                rover = low;
                        head = &tcp_bhash[tcp_bhashfn(rover)];
                        spin_lock(&head->lock);

diff -uNr net/ipv6/tcp_ipv6.c.org net/ipv6/tcp_ipv6.c
--- net/ipv6/tcp_ipv6.c.org     2005-03-04 22:41:44.043007791 +0100
+++ net/ipv6/tcp_ipv6.c 2005-03-04 22:42:17.604728073 +0100
@@ -139,9 +139,12 @@
                int rover;

                spin_lock(&tcp_portalloc_lock);
-               rover = tcp_port_rover;
+               if (tcp_port_rover < low)
+                       rover = low;
+               else
+                       rover = tcp_port_rover;
                do {    rover++;
-                       if ((rover < low) || (rover > high))
+                       if (rover > high)
                                rover = low;
                        head = &tcp_bhash[tcp_bhashfn(rover)];
                        spin_lock(&head->lock);

Signed-off-by: Folkert van Heusden <folkert@vanheusden.com>


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCKNbdMBkOjB8o2K4RAkOlAJsEClMujzHCoiT/scerxinCAP7seQCbBeAw
QqYqJN4ULvlUt3npUjOTgTY=
=q7pr
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
