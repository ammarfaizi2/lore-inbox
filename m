Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUFRJG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUFRJG2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265058AbUFRJEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:04:21 -0400
Received: from ints.net ([194.44.58.85]:27407 "EHLO primus.ints.net")
	by vger.kernel.org with ESMTP id S265074AbUFRIwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:52:24 -0400
Date: Fri, 18 Jun 2004 11:51:53 +0300
From: "Vitaly V. Bursov" <vitalyvb@ukr.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: linux-2.6.7 Equalizer Load-balancer.  eql.c. local non-privileged
 DoS
Message-Id: <20040618115153.3ad2dc32.vitalyvb@ukr.net>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__18_Jun_2004_11_51_53_+0300_Bw+0oR6rgwEHlkXf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__18_Jun_2004_11_51_53_+0300_Bw+0oR6rgwEHlkXf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello,

there are multiple vulns in drivers/net/eql.c

====
static int eql_g_slave_cfg(struct net_device *dev, slave_config_t __user *scp)
{
...
        if (copy_from_user(&sc, scp, sizeof (slave_config_t)))
                return -EFAULT;

        slave_dev = dev_get_by_name(sc.slave_name);

        ret = -EINVAL;

        spin_lock_bh(&eql->queue.lock);
        if (eql_is_slave(slave_dev)) {
...
====

and

====
static int eql_s_slave_cfg(struct net_device *dev, slave_config_t __user *scp)  
{
....
        if (copy_from_user(&sc, scp, sizeof (slave_config_t)))
                return -EFAULT;

        eql = dev->priv;
        slave_dev = dev_get_by_name(sc.slave_name);

        ret = -EINVAL;

        spin_lock_bh(&eql->queue.lock);
        if (eql_is_slave(slave_dev)) {
====

if there is no such device, dev_get_by_name returns NULL and everything dies.
Exploiting this is trivial.


Hopefully somebody will check this file carefully and fix it.

I am not in a list.
-- 
Thanks,
Vitaly
GPG Key ID: F95A23B9

--Signature=_Fri__18_Jun_2004_11_51_53_+0300_Bw+0oR6rgwEHlkXf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0q0t73PAj/laI7kRAnHHAKCnvwUFjZf7J5wPYYEbgRRLVw4jKACfSZ0A
oNU9Uxo0goyxa8/LlrRKS0c=
=q+Pi
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Jun_2004_11_51_53_+0300_Bw+0oR6rgwEHlkXf--
