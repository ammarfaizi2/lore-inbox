Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132883AbREBMZM>; Wed, 2 May 2001 08:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132909AbREBMYw>; Wed, 2 May 2001 08:24:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:40324 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132883AbREBMYo> convert rfc822-to-8bit; Wed, 2 May 2001 08:24:44 -0400
Date: Wed, 2 May 2001 08:24:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
cc: Ofer Fryman <ofer@shunra.co.il>,
        liste noyau linux <linux-kernel@vger.kernel.org>,
        liste dev network device <netdev@oss.sgi.com>
Subject: Re: ioctl call for network device
In-Reply-To: <20010502131920.478e50be.sebastien.person@sycomore.fr>
Message-ID: <Pine.LNX.3.95.1010502075944.14806A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, [ISO-8859-1] sébastien person wrote:

> Le Wed, 2 May 2001 13:55:34 +0200 
> Ofer Fryman <ofer@shunra.co.il> à écrit :
> 
> > The definition of ioctl is "extern int __ioctl __P ((int __fd, unsigned long
> > int __request, ...));" on Linux 2.0.x, and I believe it is also on any other
> > Linux version.
> 
> yes but I use an network device specific ioctl call wich perform interface-specific
> ioctl commands.
> the prototype of the ioctl reception in the module is (as described in rubini book,
> O reilly, linux device drivers):
> 
> int (*do_ioctl) (struct device *dev, struct ifreq *ifr, int cmd);
> 
> so can I pass over the limitations of the definition ?
> I do ioctl that use private ioctl flags (e.g. SIOCDEVPRIVATE)
> 

struct ifreq has a member called ifr_data. It is a pointer. You can
put a pointer to any of your data, including the most complex structure
you might envision, in that area. This allows you to pass anything
to and from your module. This pointer can be properly dereferenced
in kernel space but you should use copy_to/from_user and friends so a
user-space coding bug won't panic the kernel.

Also, the value of the commands that you want to use for the ioctl() can
(probably should), start at SIOCDEVPRIVATE.

In other words, given the commands DEV_START, DEV_STOP, DEV_DESTROY,
they should be defined as:

#define DEV_START   SIOCDEVPRIVATE
#define DEV_STOP    SIOCDEVPRIVATE + 1
#define DEV_DESTROY SIOCDEVPRIVATE + 2

Given a user-space aggregate of type FOO, to be accessed by the
module, it would be coded as:

FOO foo;
struct ifreq ifr;

    strcpy(ifr.ifr_name, "eth0");
    ifr.ifr_data = (char *) &foo;
    ioctl(sock, DEV_DESTROY, &ifr);
    
So, as you can see, there are no limitations of the definition.
In fact, it's a really well designed interface.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


