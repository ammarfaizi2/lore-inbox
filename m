Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318112AbSG2XMq>; Mon, 29 Jul 2002 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSG2XMq>; Mon, 29 Jul 2002 19:12:46 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25298 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318112AbSG2XMp>; Mon, 29 Jul 2002 19:12:45 -0400
Date: Mon, 29 Jul 2002 19:15:54 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg Banks <gnb@alphalink.com.au>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Michael Elizabeth Chastain <mec@shout.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch for xconfig
Message-ID: <20020729191554.A17617@devserv.devel.redhat.com>
References: <3D43E623.B8496CB5@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D43E623.B8496CB5@alphalink.com.au>; from gnb@alphalink.com.au on Sun, Jul 28, 2002 at 10:40:03PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 28 Jul 2002 22:40:03 +1000
> From: Greg Banks <gnb@alphalink.com.au>

> I don't claim to be knowledgeable, but I can confirm that this is a
> real bug and the patch fixes it.  Here is the patch re-jigged to apply
> cleanly to 2.5.29.
>[...]

BTW, what I sent was a low hanged fruit that I picked.
The main bug is worse, and I have no idea how to fix it.
This is what we have in configuration:

tristate 'ISO ...' CONFIG_ISO9660_FS
dep_bool ' Tranparent ...' CONFIG_ZISOFS $CONFIG_ISO9660_FS
if [ "$CONFIG_ZISOFS" = "y" ]; then
   define_tristate CONFIG_ZISOFS_FS $CONFIG_ISO9660_FS
else
   define_tristate CONFIG_ZISOFS_FS n
fi

if [ "$CONFIG_CRAMFS" = "y" -o \
     "$CONFIG_PPP_DEFLATE" = "y" -o \
     "$CONFIG_JFFS2_FS" = "y" -o \
     "$CONFIG_ZISOFS_FS" = "y" ]; then
   define_tristate CONFIG_ZLIB_INFLATE y
else
  if [ "$CONFIG_CRAMFS" = "m" -o \
       "$CONFIG_PPP_DEFLATE" = "m" -o \
       "$CONFIG_JFFS2_FS" = "m" -o \
       "$CONFIG_ZISOFS_FS" = "m" ]; then
     define_tristate CONFIG_ZLIB_INFLATE m
  else
     tristate 'zlib decompression support' CONFIG_ZLIB_INFLATE
  fi
fi

As far as I can tell, tkgen.c does an acceptable job on the
second part; though it refuses to generate "else" and uses
de Morgan transformation instead. However, it seems that tkparse
chokes on the very innocently looking first part. The result
is that xconfig insist on zlib to be a module when it should
be compiled into the kernel; it all ends with undefined symbols.
Naturally, "make oldconfig" works correctly.

The code in the menu part of kconfig.tk fixes the problem.
In other words, the bug is only visible if someone does "make xconfig",
loads a canned configuration which we ship, then does "save
and exit" immediately. If he visits any menus, everything is ok.

-- Pete
