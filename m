Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262293AbSI1SQd>; Sat, 28 Sep 2002 14:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbSI1SQd>; Sat, 28 Sep 2002 14:16:33 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:11399 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S262293AbSI1SQb>;
	Sat, 28 Sep 2002 14:16:31 -0400
Date: Sat, 28 Sep 2002 20:21:38 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Generic HDLC interface continued
Message-ID: <20020928202138.A17244@se1.cogenit.fr>
References: <m3y99nrtsu.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3y99nrtsu.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Fri, Sep 27, 2002 at 11:45:05PM +0200
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<disclaimer>
It's ok for me to trim the Cc: list if noboy objects.
Don't hesistate to ask for clarification if my english comes from Mars.
</disclaimer>

Krzysztof Halasa <khc@pm.waw.pl> :
[...]
> Addressing the second problem (unknown data length) requires the caller
> (user-space utils) to supply allocated space size. The kernel would
> update the size to reflect the actual amount of data required, allowing
> the caller to allocate more space and try again (or ignore the unknown
> interface).

If size/limit of an underlying object is in a structure for other purpose
than debygging, it means something (S) is working with an object and it (S)
doesn't know what it is. Design proble: always work with an object whose 
identity you know or simply pass a reference to someone knowing better.

I don't see why a 'size' parameter is required. Thus I'm fine with the
following (we are lucky enough that there is enough space in union ifr_ifru 
to hold ifru_settings):

struct ifreq
{
#define IFHWADDRLEN 6
#define IFNAMSIZ    16
    union
    {
        char    ifrn_name[IFNAMSIZ];        /* if name, e.g. "en0" */
    } ifr_ifrn;

    union {
        struct  sockaddr ifru_addr;
        struct  sockaddr ifru_dstaddr;
        struct  sockaddr ifru_broadaddr;
        struct  sockaddr ifru_netmask;
        struct  sockaddr ifru_hwaddr;
        short   ifru_flags;
        int ifru_ivalue;
        int ifru_mtu;
        struct  ifmap ifru_map;
        char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
        char    ifru_newname[IFNAMSIZ];
        char *  ifru_data;
        struct {
             int type;
             union {
                 raw_hdlc_proto *;
                 ...
                 sync_serial_settings *;
                 etc_line_settings *;
			}
		} ifru_settings;
    } ifr_ifru;
};

Note however that struct ifreq on amphetamin (wrt lines of code) doesn't 
improve readability for everybody. That's a slightly different problem.

> What is important here is that inner union consists of pointers
> to *_proto / *_settings structs and not of the structs themselves.

Agree on this.

> Another solution - using a different ifreq structs for different tasks
> (something like the sockaddr_*) - sort of:
[...]

I am not too fond of this and, again, what are these 'size' for ?
If it's supposed to replace/duplicate ifreq, the 'settings' part should
be a pointer imho. Same reason as before: size change => compatibility 
problems for tools (we have sources but downgrading tools when returning to
previous kernel sucks).

-- 
Ueimor
