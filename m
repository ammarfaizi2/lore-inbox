Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWAJNBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWAJNBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWAJNBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:01:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:61648 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750843AbWAJNBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:01:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: spereira@tusc.com.au
Subject: Re: [PATCH 2/2 - 2.6.15]net:32 bit (socket layer) ioctl emulation for 64 bit kernels
Date: Tue, 10 Jan 2006 13:00:40 +0000
User-Agent: KMail/1.9.1
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Andi Kleen <ak@muc.de>,
       linux-kenel <linux-kernel@vger.kernel.org>,
       x25 maintainer <eis@baty.hanse.de>, netdev <netdev@vger.kernel.org>,
       SP <pereira.shaun@gmail.com>
References: <1136871083.5742.27.camel@spereira05.tusc.com.au>
In-Reply-To: <1136871083.5742.27.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101300.41351.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 05:31, Shaun Pereira wrote:
> --- linux-2.6.15-vanilla/include/net/x25.h	2006-01-03 14:21:10.000000000
> +1100
> +++ linux-2.6.15/include/net/x25.h	2006-01-10 16:15:16.000000000 +1100
> @@ -223,6 +223,18 @@ extern struct x25_route *x25_get_route(s
>  extern struct net_device *x25_dev_get(char *);
>  extern void x25_route_device_down(struct net_device *dev);
>  extern int  x25_route_ioctl(unsigned int, void __user *);
> +
> +#ifdef CONFIG_COMPAT
> +#include <linux/compat.h>

Don't hide #include <...> inside #ifdef, just add this in the beginning.

> +
> +struct x25_route_struct32{
> +	struct x25_address address;
> +	compat_uint_t   sigdigits;
> +	char    device[200];
> +};
> +extern int  compat_x25_route_ioctl(unsigned int, struct
> x25_route_struct32 __user *);
> +#endif
> +

Hmm. Declarations should not be hidden by #ifdef either, but of course
compat_uint_t is not defined on 32 bit systems.
Actually, the structure should already be the same on all 32 and 64 bit
systems, there is no 'long' or  pointer in there. 

I'm pretty sure you can simply call x25_route_ioctl instead of
introducing a new compat_x25_route_ioctl(), or did you have a different
reason to do this?

>  extern void x25_route_free(void);
>  
>  static __inline__ void x25_route_hold(struct x25_route *rt)
> diff -uprN -X dontdiff linux-2.6.15-vanilla/net/x25/af_x25.c
> linux-2.6.15/net/x25/af_x25.c
> --- linux-2.6.15-vanilla/net/x25/af_x25.c	2006-01-10 16:06:29.000000000
> +1100
> +++ linux-2.6.15/net/x25/af_x25.c	2006-01-10 16:15:16.000000000 +1100
> @@ -475,6 +475,12 @@ out:
>  
>  void x25_init_timers(struct sock *sk);
>  
> +#ifdef CONFIG_COMPAT
> +#include "x25_ioctl_compat.c"
> +#else
> +#define compat_x25_ioctl NULL
> +#endif
> +

No, this is not a good way to do it. It's good put it in a separate file,
if the compat code is large, but then better use Makefile magic to do
conditional compilation, like:

obj-$(CONFIG_X25) += x25.o
x25-$(CONFIG_COMPAT) += x25_ioctl_compat.o

[ OTOH, with the changes I propose below, it probably becomes so small
  that it's no longer worth doing a separate file. ]

>  static int x25_create(struct socket *sock, int protocol)
>  {
>  	struct sock *sk;
> @@ -1403,7 +1409,7 @@ static struct proto_ops SOCKOPS_WRAPPED(
>  	.getname =	x25_getname,
>  	.poll =		datagram_poll,
>  	.ioctl =	x25_ioctl,
> -	.compat_ioctl=  NULL,
> +	.compat_ioctl=  compat_x25_ioctl,
>  	.listen =	x25_listen,
>  	.shutdown =	sock_no_shutdown,
>  	.setsockopt =	x25_setsockopt,

Then this normally becomes

	.poll =		datagram_poll,
 	.ioctl =	x25_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl=  compat_x25_ioctl,
+#endif
 	.listen =	x25_listen,
 	.shutdown =	sock_no_shutdown,

or you change the declaration in the header file to become

#ifdef CONFIG_COMPAT
extern long compat_x25_ioctl(struct file *, unsigned int, unsigned long);
#else
#define compat_x25_ioctl NULL
#endif

> diff -uprN -X dontdiff linux-2.6.15-vanilla/net/x25/x25_ioctl_compat.c
> linux-2.6.15/net/x25/x25_ioctl_compat.c
> --- linux-2.6.15-vanilla/net/x25/x25_ioctl_compat.c	1970-01-01
> 10:00:00.000000000 +1000
> +++ linux-2.6.15/net/x25/x25_ioctl_compat.c	2006-01-10
> 16:15:16.000000000 +1100
> @@ -0,0 +1,264 @@
> +#include <linux/compat.h>
> +
> +struct x25_subscrip_struct32{
> +	char device[200-sizeof(compat_ulong_t)];
> +	compat_ulong_t global_facil_mask;
> +	compat_uint_t extended;
> +};

Please don't use a compat_ prefix instead of a 32 postfix,
i.e. compat_x25_subscrip_struct.

> +
> +struct x25_facilities32{
> +	compat_uint_t	winzize_in, winsize_out;
> +	compat_uint_t	pacsize_in, packsize_out;
> +	compat_uint_t	throughput;
> +	compat_uint_t   reverse;
> +};
> +
> +struct x25_calluserdata32 {
> +	compat_uint_t 	cudlength;
> +	unsigned char   cuddata[128];
> +};
> +
> +struct x25_subaddr32 {
> +	compat_uint_t 	cudmatchlength;
> +};

These should all be compatible and not need a conversion at all.

> +
> +static int compat_x25_subscr_ioctl(unsigned int cmd,
> +		struct x25_subscrip_struct32 __user *x25_subscr32)
> +{
> ...

that function looks good.

> +static int compat_x25_facility_ioctl(struct socket *sock, struct
> x25_facilities32 __user *facilities32)

> +static int compat_x25_get_facility_ioctl(struct socket *sock, struct
> x25_facilities32 __user *facility32)

> +static int compat_x25_cud_ioctl(struct socket *sock, struct
> x25_calluserdata32 __user *calluserdata32)

> +static int compat_x25_get_cud_ioctl(struct socket *sock, struct
> x25_calluserdata32 __user *calluserdata32)

> +static int compat_x25_cud_match_ioctl(struct socket *sock, struct
> x25_subaddr32 __user *sub_addr32)

> +static int compat_x25_accept_ctrl(struct socket *sock, unsigned int
> cmd)

All these appear pointless to me, as the arguments are the same as in
the native 64 bit case.

> +
> +static int compat_x25_ioctl(struct socket *sock, unsigned int cmd,
> unsigned long arg)
> ...
> +		case SIOCX25GFACILITIES:
> +			rc = compat_x25_get_facility_ioctl(sock, argp);
> +			break;
> +		case SIOCX25SFACILITIES:
> +			rc = compat_x25_facility_ioctl(sock, argp);
> +			break;
> +		case SIOCX25GCALLUSERDATA:
> +			rc = compat_x25_get_cud_ioctl(sock, argp);
> +			break;
> +		case SIOCX25SCALLUSERDATA:
> +			rc = compat_x25_cud_ioctl(sock, argp);
> +			break;
> +		case SIOCX25GCAUSEDIAG:
> +		case SIOCX25SCUDMATCHLEN:
> +			rc = compat_x25_cud_match_ioctl(sock,argp);
> +			break;
> +		case SIOCX25CALLACCPTAPPRV:
> +			rc = compat_x25_accept_ctrl(sock,SIOCX25CALLACCPTAPPRV);
> +				break;
> +		case SIOCX25SENDCALLACCPT:
> +			rc = compat_x25_accept_ctrl(sock,SIOCX25SENDCALLACCPT);
> +				break;

Then these could become
+		case SIOCX25GFACILITIES:
+		case SIOCX25SFACILITIES:
+		case SIOCX25GCALLUSERDATA:
+		case SIOCX25SCALLUSERDATA:
+		case SIOCX25GCAUSEDIAG:
+		case SIOCX25SCUDMATCHLEN:
+		case SIOCX25CALLACCPTAPPRV:
+		case SIOCX25SENDCALLACCPT:
+			rc = x25_ioctl(sock, cmd, (unsigned long)argp);
+			break;

The casting argp to unsigned long instead of using arg takes care of
the pointer type problem, so it even works on s390 (your code did as well).

> +#ifdef CONFIG_COMPAT
> +
> +int compat_x25_route_ioctl(unsigned int cmd, struct x25_route_struct32
> __user *rt32)
> +{

AFAICS; this function is identical to x25_route_ioctl, so just call that
one.

	Arnd <><
