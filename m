Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWFTLY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWFTLY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWFTLY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:24:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29478 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932599AbWFTLY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:24:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=rRwa9y0IS5UbT0H9P31dXX7UQjglCvK2uLZfpB1lBWkYulUizPH5rMLWwbDnDkUMYJ/VJtUEahYhSOhemhHJmpiv7+gJ+slvaprnWhdq32sHBBHIwajonDrXJ04CLMDIvs3+FIoj8D8QXmHO7sbmdp6Acr7a5dc5spt9Fypw7os=
Message-ID: <cc723f590606200424i53cd30edre8f9292dbcde843b@mail.gmail.com>
Date: Tue, 20 Jun 2006 16:54:25 +0530
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sparse and devinet_ioctl
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_157787_873439.1150802665683"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_157787_873439.1150802665683
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

How do i make sure i can call devinet_ioctl from kernel without having
a sparse warning.

The call i want to use was SIOCGIFADDR

Right now i am patching it as below

_devinet_ioctl(SIOCGIFADDR, &ifr)

Is this the correct way ? But then I don't want to patch any core
kernel files. In that case how will i achieve the results.


-aneesh

------=_Part_157787_873439.1150802665683
Content-Type: text/x-patch; name=devinet.c.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_eoo64ifh
Content-Disposition: attachment; filename="devinet.c.diff"

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 54419b2..e8e9eaa 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -532,11 +532,10 @@ static __inline__ int inet_abc_len(u32 a
 }
=20
=20
-int devinet_ioctl(unsigned int cmd, void __user *arg)
+int _devinet_ioctl(unsigned int cmd,  struct ifreq *ifr)
 {
-=09struct ifreq ifr;
 =09struct sockaddr_in sin_orig;
-=09struct sockaddr_in *sin =3D (struct sockaddr_in *)&ifr.ifr_addr;
+=09struct sockaddr_in *sin =3D (struct sockaddr_in *)&ifr->ifr_addr;
 =09struct in_device *in_dev;
 =09struct in_ifaddr **ifap =3D NULL;
 =09struct in_ifaddr *ifa =3D NULL;
@@ -545,23 +544,17 @@ int devinet_ioctl(unsigned int cmd, void
 =09int ret =3D -EFAULT;
 =09int tryaddrmatch =3D 0;
=20
-=09/*
-=09 *=09Fetch the caller's info block into kernel space
-=09 */
-
-=09if (copy_from_user(&ifr, arg, sizeof(struct ifreq)))
-=09=09goto out;
-=09ifr.ifr_name[IFNAMSIZ - 1] =3D 0;
+=09ifr->ifr_name[IFNAMSIZ - 1] =3D 0;
=20
 =09/* save original address for comparison */
 =09memcpy(&sin_orig, sin, sizeof(*sin));
=20
-=09colon =3D strchr(ifr.ifr_name, ':');
+=09colon =3D strchr(ifr->ifr_name, ':');
 =09if (colon)
 =09=09*colon =3D 0;
=20
 #ifdef CONFIG_KMOD
-=09dev_load(ifr.ifr_name);
+=09dev_load(ifr->ifr_name);
 #endif
=20
 =09switch(cmd) {
@@ -602,7 +595,7 @@ #endif
 =09rtnl_lock();
=20
 =09ret =3D -ENODEV;
-=09if ((dev =3D __dev_get_by_name(ifr.ifr_name)) =3D=3D NULL)
+=09if ((dev =3D __dev_get_by_name(ifr->ifr_name)) =3D=3D NULL)
 =09=09goto done;
=20
 =09if (colon)
@@ -617,7 +610,7 @@ #endif
 =09=09=09   This is checked above. */
 =09=09=09for (ifap =3D &in_dev->ifa_list; (ifa =3D *ifap) !=3D NULL;
 =09=09=09     ifap =3D &ifa->ifa_next) {
-=09=09=09=09if (!strcmp(ifr.ifr_name, ifa->ifa_label) &&
+=09=09=09=09if (!strcmp(ifr->ifr_name, ifa->ifa_label) &&
 =09=09=09=09    sin_orig.sin_addr.s_addr =3D=3D
 =09=09=09=09=09=09=09ifa->ifa_address) {
 =09=09=09=09=09break; /* found */
@@ -630,7 +623,7 @@ #endif
 =09=09if (!ifa) {
 =09=09=09for (ifap =3D &in_dev->ifa_list; (ifa =3D *ifap) !=3D NULL;
 =09=09=09     ifap =3D &ifa->ifa_next)
-=09=09=09=09if (!strcmp(ifr.ifr_name, ifa->ifa_label))
+=09=09=09=09if (!strcmp(ifr->ifr_name, ifa->ifa_label))
 =09=09=09=09=09break;
 =09=09}
 =09}
@@ -662,11 +655,11 @@ #endif
 =09=09=09if (!ifa)
 =09=09=09=09break;
 =09=09=09ret =3D 0;
-=09=09=09if (!(ifr.ifr_flags & IFF_UP))
+=09=09=09if (!(ifr->ifr_flags & IFF_UP))
 =09=09=09=09inet_del_ifa(in_dev, ifap, 1);
 =09=09=09break;
 =09=09}
-=09=09ret =3D dev_change_flags(dev, ifr.ifr_flags);
+=09=09ret =3D dev_change_flags(dev, ifr->ifr_flags);
 =09=09break;
=20
 =09case SIOCSIFADDR:=09/* Set interface address (and family) */
@@ -679,7 +672,7 @@ #endif
 =09=09=09if ((ifa =3D inet_alloc_ifa()) =3D=3D NULL)
 =09=09=09=09break;
 =09=09=09if (colon)
-=09=09=09=09memcpy(ifa->ifa_label, ifr.ifr_name, IFNAMSIZ);
+=09=09=09=09memcpy(ifa->ifa_label, ifr->ifr_name, IFNAMSIZ);
 =09=09=09else
 =09=09=09=09memcpy(ifa->ifa_label, dev->name, IFNAMSIZ);
 =09=09} else {
@@ -767,9 +760,26 @@ out:
 =09return ret;
 rarok:
 =09rtnl_unlock();
-=09ret =3D copy_to_user(arg, &ifr, sizeof(struct ifreq)) ? -EFAULT : 0;
 =09goto out;
 }
+int devinet_ioctl(unsigned int cmd, void __user *arg)
+{
+=09struct ifreq ifr;
+=09int ret;
+
+=09/*
+=09 *=09Fetch the caller's info block into kernel space
+=09 */
+
+=09if (copy_from_user(&ifr, arg, sizeof(struct ifreq)))
+=09=09return -EFAULT;
+
+=09if ((ret =3D _devinet_ioctl(cmd, &ifr)) =3D=3D 0 ) {
+=09=09ret =3D copy_to_user(arg, &ifr, sizeof(struct ifreq)) ? -EFAULT : 0;
+=09}
+=09return ret;
+
+}
=20
 static int inet_gifconf(struct net_device *dev, char __user *buf, int len)
 {

------=_Part_157787_873439.1150802665683--
