Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbRGXKIA>; Tue, 24 Jul 2001 06:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267148AbRGXKHv>; Tue, 24 Jul 2001 06:07:51 -0400
Received: from [213.82.86.194] ([213.82.86.194]:24328 "EHLO fatamorgana.net")
	by vger.kernel.org with ESMTP id <S267135AbRGXKHn>;
	Tue, 24 Jul 2001 06:07:43 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_6X2ZYB2XULLA3LNNXPI9"
From: Roberto Arcomano <berto@fatamorgana.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch suggestion for proxy arp on shaper interface
Date: Tue, 24 Jul 2001 12:10:18 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01072222314006.01071@berto.casa.it>
In-Reply-To: <01072222314006.01071@berto.casa.it>
MIME-Version: 1.0
Message-Id: <01072412101804.01562@berto.casa.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--------------Boundary-00=_6X2ZYB2XULLA3LNNXPI9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Il 22:31, domenica 22 luglio 2001, Roberto Arcomano ha scritto:
> Hi all,
> Recently I have had a problem with Linux proxy arp feature (using with
> shaper interface): when I machine starts up it was receiving a "IP
> conflits". The problem is that Linux proxy_arp routine doesn't make
> difference between real interface (i.e. eth0) and shaper interface (i.e.
> shaper0 which has been attached to eth0).
> I attach a first beta solution to the problem, which could be far from
> optimal! (I use a "strncmp", cause I didn't found another method to know if
> the device is a "shaper" device).
>
>
> --- arp.c.orig  Wed May 16 19:21:45 2001
> +++ arp.c       Sun Jul 22 19:31:20 2001
> @@ -111,7 +111,7 @@
>
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
> -
> +#include <linux/if_shaper.h>
>
>
>  /*
> @@ -767,10 +767,17 @@
>                         }
>                         goto out;
>                 } else if (IN_DEV_FORWARD(in_dev)) {
> +                        char shflag=0;
> +                        if ( (rt->u.dst.dev) &&
> +                            (rt->u.dst.dev->priv) &&
> +                            (((struct shaper *) rt->u.dst.dev->priv)->dev)
> && +                           
> (strncmp(rt->u.dst.dev->name,"shaper",6)==0) ) +                        
> shflag=1;
>                         if ((rt->rt_flags&RTCF_DNAT) ||
> -                           (addr_type == RTN_UNICAST  && rt->u.dst.dev !=
> dev &&
> +                           (addr_type == RTN_UNICAST  &&
> +                           ( ((shflag) && ( ((struct shaper *)
> rt->u.dst.dev->priv)->dev != dev)) || ((!shflag) && (rt->u.dst.dev != dev))
> ) &&
>                              (IN_DEV_PROXY_ARP(in_dev) ||
> pneigh_lookup(&arp_tbl, &tip, dev, 0)))) {
> -                               n = neigh_event_ns(&arp_tbl, sha, &sip,
> dev); +                               n = neigh_event_ns(&arp_tbl, sha,
> &sip, dev); if (n)
>
>
> The patch declare a variable (flag to know if the interface is
> shaper-like), investigate on private data of shaper device (where we can
> know what is the attached interface) and set the flag. After we consider
> the "attached" interface if flag is set.
>
> I tested it under 2.4.6 on RedHat 7.1 with success (there is no more IP
> conflit).
> Hope it'll useful.
>
> Best Regards
> Roberto Arcomano

Please someone takes a look at it! This is a bug of proxy arp feature (when 
talking with shaper interface) could be correct (for example using my patch).
Thank you for your help

Best Regards
Roberto Arcomano




--------------Boundary-00=_6X2ZYB2XULLA3LNNXPI9
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="diff.c"
Content-Transfer-Encoding: base64
Content-Description: Diff file for arp.c
Content-Disposition: attachment; filename="diff.c"

LS0tIGFycC5jLm9yaWcJV2VkIE1heSAxNiAxOToyMTo0NSAyMDAxCisrKyBhcnAuYwlTdW4gSnVs
IDIyIDE5OjMxOjIwIDIwMDEKQEAgLTExMSw3ICsxMTEsNyBAQAogCiAjaW5jbHVkZSA8YXNtL3N5
c3RlbS5oPgogI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+Ci0KKyNpbmNsdWRlIDxsaW51eC9pZl9z
aGFwZXIuaD4KIAogCiAvKgpAQCAtNzY3LDEwICs3NjcsMTcgQEAKIAkJCX0KIAkJCWdvdG8gb3V0
OwogCQl9IGVsc2UgaWYgKElOX0RFVl9GT1JXQVJEKGluX2RldikpIHsKKyAgICAgICAgICAgICAg
ICAgICAgICAgIGNoYXIgc2hmbGFnPTA7CisgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIChy
dC0+dS5kc3QuZGV2KSAmJgorCQkJICAgICAocnQtPnUuZHN0LmRldi0+cHJpdikgJiYKKwkJCSAg
ICAgKCgoc3RydWN0IHNoYXBlciAqKSBydC0+dS5kc3QuZGV2LT5wcml2KS0+ZGV2KSAmJgorCQkJ
ICAgICAoc3RybmNtcChydC0+dS5kc3QuZGV2LT5uYW1lLCJzaGFwZXIiLDYpPT0wKSApCisJCQkg
IHNoZmxhZz0xOwogCQkJaWYgKChydC0+cnRfZmxhZ3MmUlRDRl9ETkFUKSB8fAotCQkJICAgIChh
ZGRyX3R5cGUgPT0gUlROX1VOSUNBU1QgICYmIHJ0LT51LmRzdC5kZXYgIT0gZGV2ICYmCisJCQkg
ICAgKGFkZHJfdHlwZSA9PSBSVE5fVU5JQ0FTVCAgJiYgCisJCQkgICAgKCAoKHNoZmxhZykgJiYg
KCAoKHN0cnVjdCBzaGFwZXIgKikgcnQtPnUuZHN0LmRldi0+cHJpdiktPmRldiAhPSBkZXYpKSB8
fCAoKCFzaGZsYWcpICYmIChydC0+dS5kc3QuZGV2ICE9IGRldikpICkgJiYKIAkJCSAgICAgKElO
X0RFVl9QUk9YWV9BUlAoaW5fZGV2KSB8fCBwbmVpZ2hfbG9va3VwKCZhcnBfdGJsLCAmdGlwLCBk
ZXYsIDApKSkpIHsKLQkJCQluID0gbmVpZ2hfZXZlbnRfbnMoJmFycF90YmwsIHNoYSwgJnNpcCwg
ZGV2KTsKKwkJCSAgICAgICAgbiA9IG5laWdoX2V2ZW50X25zKCZhcnBfdGJsLCBzaGEsICZzaXAs
IGRldik7CiAJCQkJaWYgKG4pCiAJCQkJCW5laWdoX3JlbGVhc2Uobik7CiAK

--------------Boundary-00=_6X2ZYB2XULLA3LNNXPI9--
