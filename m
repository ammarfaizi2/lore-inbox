Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318384AbSGaO6B>; Wed, 31 Jul 2002 10:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318387AbSGaO6A>; Wed, 31 Jul 2002 10:58:00 -0400
Received: from mail3.alphalink.com.au ([202.161.124.59]:4619 "EHLO
	mail3.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S318384AbSGaO56>; Wed, 31 Jul 2002 10:57:58 -0400
Message-ID: <3D47FB68.94B9D871@alphalink.com.au>
Date: Thu, 01 Aug 2002 00:59:52 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Michael Elizabeth Chastain <mec@shout.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch for xconfig
References: <3D43E623.B8496CB5@alphalink.com.au> <20020729191554.A17617@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

sorry about the delay, I had to deal with a major drama in the day job.

Pete Zaitcev wrote:
> 
> > Date: Sun, 28 Jul 2002 22:40:03 +1000
> > From: Greg Banks <gnb@alphalink.com.au>
> 
> BTW, what I sent was a low hanged fruit that I picked.
> The main bug is worse, and I have no idea how to fix it.
> This is what we have in configuration:
> 
> tristate 'ISO ...' CONFIG_ISO9660_FS
> dep_bool ' Tranparent ...' CONFIG_ZISOFS $CONFIG_ISO9660_FS
> if [ "$CONFIG_ZISOFS" = "y" ]; then
>    define_tristate CONFIG_ZISOFS_FS $CONFIG_ISO9660_FS
> else
>    define_tristate CONFIG_ZISOFS_FS n
> fi
> 
> [...]it seems that tkparse
> chokes on the very innocently looking first part. 

Actually, it's not innocent at all, the documentation does not allow
the construction "define_tristate CONFIG_FOO $CONFIG_BAR".  The last
argument has to be a tristate literal, one of "y" "m" or "n".  It might
look ok but that's because you're thinking shell not config language.

Remember, config language is *not* shell.

The relevant section from Documentation/kbuild/config-language.txt is:

> === define_tristate /symbol/ /word/
> 
> This verb assigns the value of /word/ to /symbol/.  Legal input values
> are "n", "m", and "y".

If you're trying to do what I think you're trying to do, the correct
construct is this:

dep_mbool ' Tranparent ...' CONFIG_ZISOFS $CONFIG_ISO9660_FS
if [ "$CONFIG_ZISOFS" = "y" ]; then
    if [ "$CONFIG_ISO9660_FS" = "y" ]; then
	define_tristate CONFIG_ZISOFS_FS y
    else
	define_tristate CONFIG_ZISOFS_FS m
    fi
else
   define_tristate CONFIG_ZISOFS_FS n
fi

If it's any consolation, you're not the only one to get it wrong.

arch/m68k/config.in:498:   define_tristate CONFIG_SERIAL $CONFIG_DN_SERIAL
drivers/isdn/capi/Config.in:11:      define_tristate CONFIG_ISDN_CAPI_CAPIFS $CONFIG_ISDN_CAPI_CAPI20
drivers/parport/Config.in:18:         define_tristate CONFIG_PARPORT_PC_CML1 $CONFIG_PARPORT_PC
fs/Config.in:133:   define_tristate CONFIG_EXPORTFS $CONFIG_NFSD
fs/Config.in:158:   define_tristate CONFIG_ZISOFS_FS $CONFIG_ISO9660_FS
net/ipv4/netfilter/Config.in:58:          define_tristate CONFIG_IP_NF_NAT_IRC $CONFIG_IP_NF_NAT
net/ipv4/netfilter/Config.in:67:          define_tristate CONFIG_IP_NF_NAT_FTP $CONFIG_IP_NF_NAT

> The code in the menu part of kconfig.tk fixes the problem.
> In other words, the bug is only visible if someone does "make xconfig",
> loads a canned configuration which we ship, then does "save
> and exit" immediately. If he visits any menus, everything is ok.

Ah.  I had reproduced your other problem differently, with this:

mainmenu_option next_comment
comment 'xconfig needs this menu'

tristate 'Set this symbol to ON' CONFIG_FOO

dep_tristate 'this is a dep_tristate' CONFIG_BAR $CONFIG_FOO m

endmenu

Open the menu, set FOO=m, save, kaboom.  Your patch fixes that.



-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
