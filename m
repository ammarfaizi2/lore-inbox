Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbTAUGTk>; Tue, 21 Jan 2003 01:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbTAUGTk>; Tue, 21 Jan 2003 01:19:40 -0500
Received: from [24.68.68.53] ([24.68.68.53]:12673 "EHLO kruhft")
	by vger.kernel.org with ESMTP id <S266307AbTAUGTg>;
	Tue, 21 Jan 2003 01:19:36 -0500
Date: Mon, 20 Jan 2003 22:28:32 -0800
From: Burton Samograd <kruhft@kruhft.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] /proc/net/if device/address information module
Message-ID: <20030121062832.GC1736@kruhft.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
X-GPG-key: http://kruhftwerk.dyndns.org/kruhft.pubkey.asc
X-Operating-System: Linux kruhft.dyndns.org 2.4.20 
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: multipart/mixed; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I asked a couple of weeks ago if there was a way to get the network
interface information from the proc file system for each network
device on the system and recieved little response.  After browsing the
code a bit I decided to write a small module which gives acts as a
minimal replacement for the output of ifconfig, since it seemed that
this information should be easy to find in the /proc/net hierarchy but
wasn't available.  After writing it for inet (IP) devices, I decided
to add IPV6 and ATalk since it wasn't much more work.

I've included the code attached (it's not very big) since I know that
at least one person wrote me back saying they wanted this feature.
I'm also interested in comments on the code as I've never written any
kernel code before and would like to know what changes would be needed
(if any) before it would be considered for inclusion in the kernel.

Hope someone finds this useful and any comments appreciated.

--=20
burton samograd
kruhft@kruhft.dyndns.org
http://kruhftwerk.dyndns.org

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Makefile

KERNELDIR=/usr/src/linux-2.4.20-devel
CFLAGS = -D__KERNEL__ -DMODULE -I$(KERNELDIR)/include -Os -Wall

all: proc_net_if.o

clean:
	rm -f *.o *~ core
--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc_net_if.c"
Content-Transfer-Encoding: quoted-printable

/*
 * net/proc_if.c
 *
 * Adds /proc/net/if/[inet,ipv6,atalk], which contain basic network
 * device information for each protocol if supported by the kernel.
 * Only tested with inet since that's all I use.
 *
 * Author: Burton Samograd <kruhft@kruhft.dyndns.org>
 */

#include <linux/config.h>
#include <linux/types.h>
#include <linux/module.h>
#include <linux/proc_fs.h>
#include <linux/netdevice.h>
#include <linux/inetdevice.h>
#include <linux/ipv6.h>
#include <net/if_inet6.h>
#include <linux/atalk.h>
#include <linux/string.h>

#ifdef CONFIG_NET
#ifdef CONFIG_PROC_FS

struct proc_dir_entry *proc_net_if;
static int proc_net_if_init(void);
static void proc_net_if_cleanup(void);

#ifdef CONFIG_IPV6
static struct proc_dir_entry *proc_net_if_ipv6;
static int proc_net_if_ipv6_info(char *page, char**start, off_t off, int co=
unt)
{
  int len =3D 0;
  struct net_device *device =3D dev_base;
 =20
  _raw_read_lock(&dev_base_lock);
  MOD_INC_USE_COUNT;
 =20
  len +=3D sprintf(page+len, "iface\taddr\n");
  while(device) {
    struct inet6_dev *iface =3D
      (struct inet6_dev*)device->ip6_ptr;
    while(iface) {
      struct inet6_ifaddr *addrlst =3D iface->addr_list;
      while(addrlst) {
	struct in6_addr *addr =3D &addrlst->addr;
	/* correct? i'm not too familiar with ipv6 */
	len +=3D printk(page+len, "%s\t%x%x:%x%x:%x%x:%x%x:%x%x:%x%x:%x%x:%x%x\n",
		      device->name,
		      addr->s6_addr[0], addr->s6_addr[1],
		      addr->s6_addr[2], addr->s6_addr[3],
		      addr->s6_addr[4], addr->s6_addr[5],
		      addr->s6_addr[6], addr->s6_addr[7],
		      addr->s6_addr[8], addr->s6_addr[9],
		      addr->s6_addr[10], addr->s6_addr[11],
		      addr->s6_addr[12], addr->s6_addr[13],
		      addr->s6_addr[14], addr->s6_addr[15]
		      );
	addrlst =3D addrlst->if_next;
      }
      iface =3D iface->next;
    }
    device =3D device->next;
  }
 =20
  _raw_read_unlock(&dev_base_lock);
  MOD_DEC_USE_COUNT;
  return len;
}
#endif /* CONFIG_IPV6 */

#ifdef CONFIG_INET
static struct proc_dir_entry *proc_net_if_inet;
static int proc_net_if_inet_info(char *page, char**start, off_t off, int co=
unt)
{
  int len =3D 0;
  struct net_device *device =3D dev_base;
 =20
  _raw_read_lock(&dev_base_lock);
  MOD_INC_USE_COUNT;
 =20
  len +=3D sprintf(page+len, "iface\taddr\t\tbcast\t\tmask\n");
  while(device) {
    if(device->ip_ptr) {
      struct in_ifaddr *iface =3D
	((struct in_device*)device->ip_ptr)->ifa_list;
      while(iface) {
	len +=3D sprintf(page+len,
		       "%s\t%8.8x\t%8.8x\t%8.8x\n",
		       iface->ifa_label, iface->ifa_address,
		       iface->ifa_broadcast, iface->ifa_mask);
	iface =3D iface->ifa_next;
      }
    }
    device =3D device->next;
  }
 =20
  _raw_read_unlock(&dev_base_lock);
  MOD_DEC_USE_COUNT;
  return len;
}
#endif /* CONFIG_INET */

#ifdef CONFIG_ATALK
static struct proc_dir_entry *proc_net_if_atalk;
static int proc_net_if_atalk_info(char *page, char**start, off_t off, int c=
ount)
{
  int len =3D 0;
  struct net_device *device =3D dev_base;

  _raw_read_lock(&dev_base_lock);
  MOD_INC_USE_COUNT;

  len +=3D sprintf(page+len, "name\tnet\tnode\n");
  while(device) {
      /* only ip device for now */
      if(device->atalk_ptr) {
	  struct atalk_iface *iface =3D atalk_find_dev(device);
	  while(iface) {
	      struct at_addr* addr =3D atalk_find_dev_addr(device);
	      if(addr) {
		len +=3D sprintf(page+len,
			       "%s\t%8.8x\t%8.8x\n",
			       iface->dev->name, addr->s_net, addr->s_node);
	      }
	      iface =3D iface->next;
	  }
      }
      device =3D device->next;
  }
 =20
  _raw_read_unlock(&dev_base_lock);
  MOD_DEC_USE_COUNT;
  return len;
}
#endif /* CONFIG_ATALK */

static int proc_net_if_init(void)
{
  if(dev_base =3D=3D NULL)
    return -1;

  proc_net_if =3D proc_mkdir("if", proc_net);
  if(!proc_net_if) {
      proc_net_if_cleanup();
      return -1;
    }
  proc_net_if->owner =3D THIS_MODULE;

#ifdef CONFIG_INET =20
  proc_net_if_inet =3D create_proc_info_entry("inet", (mode_t)0444,
					    proc_net_if,
					    proc_net_if_inet_info);
  if(proc_net_if_inet =3D=3D NULL) {
      proc_net_if_cleanup();
      return -1;
    }
  proc_net_if_inet->owner =3D THIS_MODULE;
#endif /* CONFIG_INET */ =20

#ifdef CONFIG_IPV6 =20
  proc_net_if_ipv6 =3D create_proc_info_entry("ipv6", (mode_t)0444,
					    proc_net_if,
					    proc_net_if_ipv6_info);
  if(proc_net_if_ipv6 =3D=3D NULL) {
      proc_net_if_cleanup();
      return -1;
    }
  proc_net_if_ipv6->owner =3D THIS_MODULE;
#endif /* CONFIG_IPV6 */
 =20
#ifdef CONFIG_ATALK =20
  proc_net_if_atalk =3D create_proc_info_entry("atalk", (mode_t)0444,
					     proc_net_if,
					     proc_net_if_atalk_info);
  if(proc_net_if_atalk =3D=3D NULL) {
      proc_net_if_cleanup();
      return -1;
    }
  proc_net_if_atalk->owner =3D THIS_MODULE;
#endif /* CONFIG_ATALK */ =20

  return 0;
}

static void proc_net_if_cleanup(void)
{
#ifdef CONFIG_INET =20
  if(proc_net_if_inet)
    remove_proc_entry("inet", proc_net_if_inet);
#endif  /* CONFIG_INET */
#ifdef CONFIG_IPV6
  if(proc_net_if_ipv6)
    remove_proc_entry("ipv6", proc_net_if_ipv6);
#endif /* CONFIG_IPV6 */
#ifdef CONFIG_ATALK
  if(proc_net_if_atalk)
    remove_proc_entry("atalk", proc_net_if_atalk);
#endif /* CONFIG_ATALK */
  if(proc_net_if)
    remove_proc_entry("if", proc_net);
 =20
  return;
}

#ifdef CONFIG_MODULES
module_init(proc_net_if_init);
module_exit(proc_net_if_cleanup);

MODULE_AUTHOR("Burton Samograd <kruhft@kruhft.dyndns.org>");
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("IPv4 network information listing system network devices=
");
EXPORT_NO_SYMBOLS;
#endif /* CONFIG_MODULES */

#endif /* CONFIG_PROC_FS */
#endif /* CONFIG_NET */

--p4qYPpj5QlsIQJ0K--

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+LOiQLq/0KC7fYbURApSVAKCgnnNwT8GXRAj5zO77PoRGx847cgCeIO8N
9zc7hQCeurR5LHSlqfInzag=
=+qeE
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
