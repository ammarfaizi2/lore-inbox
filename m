Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVC2L3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVC2L3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVC2L3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:29:04 -0500
Received: from host24-107.pool8255.interbusiness.it ([82.55.107.24]:40426 "EHLO
	alpt.dyndns.org") by vger.kernel.org with ESMTP id S262179AbVC2L2l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:28:41 -0500
Date: Tue, 29 Mar 2005 13:27:33 +0200
From: Alpt <alpt@freaknet.org>
To: linux-net@vger.kernel.org
Cc: craig@zhatt.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       bridge@lists.osdl.org
Subject: Re: [PATCH bridge-2.6.11] bridge hub_enabled option
Message-ID: <20050329112733.GA6274@darkalpt.hinezumilabs.org>
Mail-Followup-To: Alpt <alpt@freaknet.org>, linux-net@vger.kernel.org,
	craig@zhatt.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	bridge@lists.osdl.org
References: <20050327092700.GA19972@nihil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <20050327092700.GA19972@nihil>
User-Agent: hahaSRY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 27, 2005 at 11:27:00AM +0200, Alpt after a spiritual call wrote=
  :
~> Bridge hub_enabled patch:
~> this patch adds the hub_enabled option for bridge.
~>=20
~> By default the hub_enabled flag is set to 1. In this case nothing change=
s, the
~> bridge, as usually, acts as a hub and flood_forward the input pkts to al=
l its
~> ports. When hun_enabled is set to 0, the bridge stops to flood_forward t=
he input
~> traffic and takes only the pkts sent to it.
~> Disabling the hub option is useful to join multiple interfaces into a un=
ique virtual
~> one, thus becomes possible to have easily an ad-hoc network topology usi=
ng multiple
~> interfaces.=20
~>=20

[...]

The document describing this patch is here:
http://www.freaknet.org/alpt/src/bridge-hub/readme

There is a small correction for this patch. The new version is attached
here and be be found also here:
http://www.freaknet.org/alpt/src/bridge-hub/bridge-2.6.11-hub.patch

The patch for the bridge-utils:
http://www.freaknet.org/alpt/src/bridge-hub/bridge-utils-1.0.6-hub.patch

Thanks go to Craig Robson.

Regards,
let me know.
--=20
:wq!
"I don't know nothing" The One Who reached the Thinking Matter   '.'

[ Alpt --- Freaknet Medialab ]
[ GPG Key ID 441CF0EE ]
[ Key fingerprint =3D 8B02 26E8 831A 7BB9 81A9  5277 BFF8 037E 441C F0EE ]

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bridge-2.6.11-hub.patch"
Content-Transfer-Encoding: quoted-printable

diff -ru a-2.6.11/include/linux/if_bridge.h b-2.6.11/include/linux/if_bridg=
e.h
--- a-2.6.11/include/linux/if_bridge.h	2005-03-02 08:38:09.000000000 +0100
+++ b-2.6.11/include/linux/if_bridge.h	2005-03-25 23:57:19.000000000 +0100
@@ -44,6 +44,7 @@
 #define BRCTL_SET_PORT_PRIORITY 16
 #define BRCTL_SET_PATH_COST 17
 #define BRCTL_GET_FDB_ENTRIES 18
+#define BRCTL_SET_BRIDGE_HUB_STATE 19
=20
 #define BR_STATE_DISABLED 0
 #define BR_STATE_LISTENING 1
@@ -65,6 +66,7 @@
 	__u8 topology_change;
 	__u8 topology_change_detected;
 	__u8 root_port;
+	__u8 hub_enabled;
 	__u8 stp_enabled;
 	__u32 ageing_time;
 	__u32 gc_interval;
diff -ru a-2.6.11/net/bridge/br_if.c b-2.6.11/net/bridge/br_if.c
--- a-2.6.11/net/bridge/br_if.c	2005-03-02 08:38:33.000000000 +0100
+++ b-2.6.11/net/bridge/br_if.c	2005-03-25 23:56:56.000000000 +0100
@@ -155,6 +155,8 @@
 	br->bridge_id.prio[1] =3D 0x00;
 	memset(br->bridge_id.addr, 0, ETH_ALEN);
=20
+	br->hub_enabled =3D 1;
+=09
 	br->stp_enabled =3D 0;
 	br->designated_root =3D br->bridge_id;
 	br->root_path_cost =3D 0;
diff -ru a-2.6.11/net/bridge/br_input.c b-2.6.11/net/bridge/br_input.c
--- a-2.6.11/net/bridge/br_input.c	2005-03-02 08:37:50.000000000 +0100
+++ b-2.6.11/net/bridge/br_input.c	2005-03-29 13:07:04.000000000 +0200
@@ -65,7 +65,8 @@
 	}
=20
 	if (dest[0] & 1) {
-		br_flood_forward(br, skb, !passedup);
+		if(br->hub_enabled)
+			br_flood_forward(br, skb, !passedup);
 		if (!passedup)
 			br_pass_frame_up(br, skb);
 		goto out;
@@ -80,12 +81,13 @@
 		goto out;
 	}
=20
-	if (dst !=3D NULL) {
+	if (dst !=3D NULL && br->hub_enabled) {
 		br_forward(dst->dst, skb);
 		goto out;
 	}
=20
-	br_flood_forward(br, skb, 0);
+	if(br->hub_enabled)
+		br_flood_forward(br, skb, 0);
=20
 out:
 	return 0;
diff -ru a-2.6.11/net/bridge/br_ioctl.c b-2.6.11/net/bridge/br_ioctl.c
--- a-2.6.11/net/bridge/br_ioctl.c	2005-03-02 08:37:49.000000000 +0100
+++ b-2.6.11/net/bridge/br_ioctl.c	2005-03-25 23:56:56.000000000 +0100
@@ -135,6 +135,7 @@
 		b.topology_change =3D br->topology_change;
 		b.topology_change_detected =3D br->topology_change_detected;
 		b.root_port =3D br->root_port;
+		b.hub_enabled =3D br->hub_enabled;
 		b.stp_enabled =3D br->stp_enabled;
 		b.ageing_time =3D jiffies_to_clock_t(br->ageing_time);
 		b.hello_timer_value =3D br_timer_value(&br->hello_timer);
@@ -247,6 +248,13 @@
 		return 0;
 	}
=20
+	case BRCTL_SET_BRIDGE_HUB_STATE:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+
+		br->hub_enabled =3D args[1]?1:0;
+		return 0;
+
 	case BRCTL_SET_BRIDGE_STP_STATE:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
diff -ru a-2.6.11/net/bridge/br_private.h b-2.6.11/net/bridge/br_private.h
--- a-2.6.11/net/bridge/br_private.h	2005-03-02 08:37:50.000000000 +0100
+++ b-2.6.11/net/bridge/br_private.h	2005-03-25 23:56:56.000000000 +0100
@@ -93,6 +93,8 @@
 	struct hlist_head		hash[BR_HASH_SIZE];
 	struct list_head		age_list;
=20
+	unsigned char			hub_enabled;
+=09
 	/* STP */
 	bridge_id			designated_root;
 	bridge_id			bridge_id;
diff -ru a-2.6.11/net/bridge/br_sysfs_br.c b-2.6.11/net/bridge/br_sysfs_br.c
--- a-2.6.11/net/bridge/br_sysfs_br.c	2005-03-02 08:38:08.000000000 +0100
+++ b-2.6.11/net/bridge/br_sysfs_br.c	2005-03-25 23:56:56.000000000 +0100
@@ -136,6 +136,28 @@
=20
 static CLASS_DEVICE_ATTR(ageing_time, S_IRUGO | S_IWUSR, show_ageing_time,
 			 store_ageing_time);
+
+static ssize_t show_hub_state(struct class_device *cd, char *buf)
+{
+	struct net_bridge *br =3D to_bridge(cd);
+	return sprintf(buf, "%d\n", br->hub_enabled);
+}
+
+static void set_hub_state(struct net_bridge *br, unsigned long val)
+{
+	br->hub_enabled =3D val;
+}
+
+static ssize_t store_hub_state(struct class_device *cd,
+			       const char *buf, size_t len)
+{
+	return store_bridge_parm(cd, buf, len, set_hub_state);
+}
+
+static CLASS_DEVICE_ATTR(hub_state, S_IRUGO | S_IWUSR, show_hub_state,
+			 store_hub_state);
+
+
 static ssize_t show_stp_state(struct class_device *cd, char *buf)
 {
 	struct net_bridge *br =3D to_bridge(cd);
@@ -246,6 +268,7 @@
 	&class_device_attr_hello_time.attr,
 	&class_device_attr_max_age.attr,
 	&class_device_attr_ageing_time.attr,
+	&class_device_attr_hub_state.attr,
 	&class_device_attr_stp_state.attr,
 	&class_device_attr_priority.attr,
 	&class_device_attr_bridge_id.attr,

--vkogqOf2sHV7VnPd--

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCSTulv/gDfkQc8O4RAoc0AJ0Uxoh6vCyara03hJZDu/K3+Wg1BwCgpomW
G8B8yQ/iriQ3HUBERwJV0QA=
=rLLg
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
