Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSBTHCT>; Wed, 20 Feb 2002 02:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290550AbSBTHCK>; Wed, 20 Feb 2002 02:02:10 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:41660 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S286647AbSBTHBz>;
	Wed, 20 Feb 2002 02:01:55 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HDLC patch for 2.5.5 (0/3)
In-Reply-To: <20020217193005.B14629@se1.cogenit.fr>
	<m3zo27outs.fsf@defiant.pm.waw.pl>
	<20020218143448.B7530@fafner.intra.cogenit.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Feb 2002 12:02:08 +0100
In-Reply-To: <20020218143448.B7530@fafner.intra.cogenit.fr>
Message-ID: <m34rkdohu7.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> I agree there's a way for an application to cause binary incompatibility if
> it does:
> 
> struct userspace_foo {
>         struct if_settings frob;
>         int nitz;
> } bar;
> 
> If size of struct if_settings changes (increases OR decreases), access to 
> bar.nitz doesn't work as expected.

I assumed it's union and not a struct, you're right.

> But:
> in hdlc_xxx_ioctl, only knowledge of the protocol-related member of the
> union 
> hdlcs_hdlcu is required. Nowhere does the code depend on size of if_settings.

I see now, t seems I haven't read the patches carefully enough.

Now... You just want to introduce an artificial struct which contains
only the union... Why? We could use just the union instead (?).

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

Still, te1_settings are interface-related :-) Ok, I assume it goes
to the following:

> include/linux/whatever/ioctl.h:
> [...]
> struct whatever_settings {
>         union {
> 		/* sync_serial_settings is back */
>                 sync_serial_settings    sync;
>                 fancy_settings          fancy;
>         }
> };
> 
> include/linux/if.h:
> [...]
> struct if_settings
> {
>         unsigned int type;      /* Type of physical device or protocol */
>         union {
>                 struct hdlc_settings ifsu_hdlc;
>                 struct whatever_settings ifsu_whatever;
>         } ifs_ifsu;
> };
> 
> As long as the application only accesses its data and doesn't try to embed 
> the variable sized kernel structure into its own, it won't break here either.

Yes, the compiler would compile that. Anyway, don't you think it's
a little messy? Void * pointers are IMHO not that evil.

Not sure about that, I have to think on it...
-- 
Krzysztof Halasa
Network Administrator
