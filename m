Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWBYKIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWBYKIV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 05:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWBYKIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 05:08:21 -0500
Received: from tag.witbe.net ([81.88.96.48]:3491 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1030194AbWBYKIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 05:08:20 -0500
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <linux.nics@intel.com>, <cramerj@intel.com>,
       <john.ronciak@intel.com>, <Ganesh.Venkatesan@intel.com>
Subject: [2.4.32 - 2.6.15.4] e1000 - Fix mii interface
Date: Sat, 25 Feb 2006 11:08:49 +0100
Organization: AS2917.net
Message-ID: <007801c639f3$79388060$2001a8c0@cortex>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0079_01C639FB.DAFCE860"
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060225085409.GA22456@infradead.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcY56RND9SkFqPmJQTuTCq0pWsJPVwABmUsg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0079_01C639FB.DAFCE860
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hello,

This patch is based on Linux 2.4.32, and I've verified the same problem
exists on 2.6.15.4.
Working on a machine with a 2.4.32 kernel, I was surprised to see the driver
complaining when setting the speed to 100FD using mii-tool, but accepting
the setting with ethtool.
Digging into the code, I found that there is some confusion with :
 - DUPLEX_FULL and FULL_DUPLEX,
 - DUPLEX_HALF and HALF_DUPLEX
in the code :
...
                           spddplx += (mii_reg & 0x100)
                                       ? FULL_DUPLEX :
                                       HALF_DUPLEX;
                           retval = e1000_set_spd_dplx(adapter,
                                                       spddplx);
...
and
int
e1000_set_spd_dplx(struct e1000_adapter *adapter, uint16_t spddplx)
{
        adapter->hw.autoneg = 0;

        switch(spddplx) {
        case SPEED_10 + DUPLEX_HALF:
                adapter->hw.forced_speed_duplex = e1000_10_half;
                break;
....
when the constants don't have the same value.

This patch is simply changing the code in the e1000_set_spd_dplx to use the
same constants as does the caller of the function : FULL_DUPLEX and
HALF_DUPLEX
whose values are not 0, to make sure we have had a successfull init
(DUPLEX_HALF value is 0, and the DUPLEX_xxx are defined in ethtool.h, thus
are probably not meant to be used in the mii interface).

Signed-off-by: Paul Rolland <rol@as2917.net>

diff -urN linux-2.4.32-orig/drivers/net/e1000/e1000_main.c
linux-2.4.32/drivers/net/e1000/e1000_main.c
--- linux-2.4.32-orig/drivers/net/e1000/e1000_main.c    Mon Apr  4 01:42:19
2005
+++ linux-2.4.32/drivers/net/e1000/e1000_main.c Sat Feb 25 09:36:23 2006
@@ -2944,23 +2944,23 @@
        adapter->hw.autoneg = 0;
 
        switch(spddplx) {
-       case SPEED_10 + DUPLEX_HALF:
+       case SPEED_10 + HALF_DUPLEX:
                adapter->hw.forced_speed_duplex = e1000_10_half;
                break;
-       case SPEED_10 + DUPLEX_FULL:
+       case SPEED_10 + FULL_DUPLEX:
                adapter->hw.forced_speed_duplex = e1000_10_full;
                break;
-       case SPEED_100 + DUPLEX_HALF:
+       case SPEED_100 + HALF_DUPLEX:
                adapter->hw.forced_speed_duplex = e1000_100_half;
                break;
-       case SPEED_100 + DUPLEX_FULL:
+       case SPEED_100 + FULL_DUPLEX:
                adapter->hw.forced_speed_duplex = e1000_100_full;
                break;
-       case SPEED_1000 + DUPLEX_FULL:
+       case SPEED_1000 + FULL_DUPLEX:
                adapter->hw.autoneg = 1;
                adapter->hw.autoneg_advertised = ADVERTISE_1000_FULL;
                break;
-       case SPEED_1000 + DUPLEX_HALF: /* not supported */
+       case SPEED_1000 + HALF_DUPLEX: /* not supported */
        default:
                DPRINTK(PROBE, ERR, 
                        "Unsupported Speed/Duplexity configuration\n");


Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur 
"Some people dream of success... while others wake up and work hard at it" 

"I worry about my child and the Internet all the time, even though she's too 
young to have logged on yet. Here's what I worry about. I worry that 10 or 15 
years from now, she will come to me and say 'Daddy, where were you when they 
took freedom of the press away from the Internet?'"
--Mike Godwin, Electronic Frontier Foundation 
 

------=_NextPart_000_0079_01C639FB.DAFCE860
Content-Type: application/octet-stream;
	name="e1000.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="e1000.patch"

diff -urN linux-2.4.32-orig/drivers/net/e1000/e1000_main.c =
linux-2.4.32/drivers/net/e1000/e1000_main.c=0A=
--- linux-2.4.32-orig/drivers/net/e1000/e1000_main.c    Mon Apr  4 =
01:42:19 2005=0A=
+++ linux-2.4.32/drivers/net/e1000/e1000_main.c Sat Feb 25 09:36:23 2006=0A=
@@ -2944,23 +2944,23 @@=0A=
        adapter->hw.autoneg =3D 0;=0A=
 =0A=
        switch(spddplx) {=0A=
-       case SPEED_10 + DUPLEX_HALF:=0A=
+       case SPEED_10 + HALF_DUPLEX:=0A=
                adapter->hw.forced_speed_duplex =3D e1000_10_half;=0A=
                break;=0A=
-       case SPEED_10 + DUPLEX_FULL:=0A=
+       case SPEED_10 + FULL_DUPLEX:=0A=
                adapter->hw.forced_speed_duplex =3D e1000_10_full;=0A=
                break;=0A=
-       case SPEED_100 + DUPLEX_HALF:=0A=
+       case SPEED_100 + HALF_DUPLEX:=0A=
                adapter->hw.forced_speed_duplex =3D e1000_100_half;=0A=
                break;=0A=
-       case SPEED_100 + DUPLEX_FULL:=0A=
+       case SPEED_100 + FULL_DUPLEX:=0A=
                adapter->hw.forced_speed_duplex =3D e1000_100_full;=0A=
                break;=0A=
-       case SPEED_1000 + DUPLEX_FULL:=0A=
+       case SPEED_1000 + FULL_DUPLEX:=0A=
                adapter->hw.autoneg =3D 1;=0A=
                adapter->hw.autoneg_advertised =3D ADVERTISE_1000_FULL;=0A=
                break;=0A=
-       case SPEED_1000 + DUPLEX_HALF: /* not supported */=0A=
+       case SPEED_1000 + HALF_DUPLEX: /* not supported */=0A=
        default:=0A=
                DPRINTK(PROBE, ERR, =0A=
                        "Unsupported Speed/Duplexity configuration\n");=0A=
=0A=

------=_NextPart_000_0079_01C639FB.DAFCE860--

