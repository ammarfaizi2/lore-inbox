Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310586AbSBRNfb>; Mon, 18 Feb 2002 08:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310587AbSBRNfV>; Mon, 18 Feb 2002 08:35:21 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:11735 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S310586AbSBRNfK>;
	Mon, 18 Feb 2002 08:35:10 -0500
Date: Mon, 18 Feb 2002 14:34:48 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, torvalds@transmeta.com,
        jgarzik@mandrakesoft.com
Subject: Re: [PATCH] HDLC patch for 2.5.5 (0/3)
Message-ID: <20020218143448.B7530@fafner.intra.cogenit.fr>
In-Reply-To: <20020217193005.B14629@se1.cogenit.fr> <m3zo27outs.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3zo27outs.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Mon, Feb 18, 2002 at 01:09:19PM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
[...]
> 
> > [1/3]:
> > - struct if_settings in struct ifreq becomes struct if_settings *;
> > - anonymous data pointer in struct if_settings is now a pointer to a
> >   union of struct containing l2 parameters. These structs can be of
> >   arbitrary size. So far, hdlc_settings is the only one available;
> 
> These two are IMHO bad :-(
> The union would then be as big as the largest struct.

-> Does it hurt ? Why ?

> What's worse, the size would change when we add larger struct (i.e.
> new protocol), causing binary incompatibility. With my patch, if we
> add a new protocol (struct), existing utils would work.

I agree there's a way for an application to cause binary incompatibility if
it does:

struct userspace_foo {
        struct if_settings frob;
        int nitz;
} bar;

If size of struct if_settings changes (increases OR decreases), access to 
bar.nitz doesn't work as expected.

But:
in hdlc_xxx_ioctl, only knowledge of the protocol-related member of the union 
hdlcs_hdlcu is required. Nowhere does the code depend on size of if_settings.

-> Why would an application need to depend on it ?

Something like this comment in the kernel sources may help: 
/*
 * The size of this structure MAY change. If your code depends on it, it's
 * broken. It doesn't need to depend on it. Change your mind.
 */

With this patch, only loosely written utils would break in the future.
Others wouldn't notice a new protocol has been added.

[...]
> Remember that i.e. sync_serial_settings are not related to any HDLC
> protocol - that's just a physical interface which could be used for
> things like SDLC, transparent transmissions etc. - or even for async
> things (the synchronous interface can work in async mode as well).

/me runs to the closer phone box and turns into Solution Man

include/linux/hdlc/ioctl.h:
[...]
struct hdlc_settings {
     union {
             /* sync_serial_settings removed */
             raw_hdlc_proto          raw_hdlc;
             cisco_proto             cisco;
             fr_proto                fr;
             fr_proto_pvc            fr_pvc;
             te1_settings            te1;
     } hdlcs_hdlcu;
};

include/linux/whatever/ioctl.h:
[...]
struct whatever_settings {
        union {
		/* sync_serial_settings is back */
                sync_serial_settings    sync;
                fancy_settings          fancy;
        }
};

include/linux/if.h:
[...]
struct if_settings
{
        unsigned int type;      /* Type of physical device or protocol */
        union {
                struct hdlc_settings ifsu_hdlc;
                struct whatever_settings ifsu_whatever;
        } ifs_ifsu;
};

As long as the application only accesses its data and doesn't try to embed 
the variable sized kernel structure into its own, it won't break here either.

[...]
> > [3/3]:
> > - some device are converted (c101.c/dscc4.c/farsync.c/n2.c).
> 
> IMHO we could wait with the real code until the interface is stable.

It helps me to see how the interface behaves. :o)

-- 
Ueimor
