Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSCROuT>; Mon, 18 Mar 2002 09:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311026AbSCROuJ>; Mon, 18 Mar 2002 09:50:09 -0500
Received: from jalon.able.es ([212.97.163.2]:53202 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S311025AbSCROty>;
	Mon, 18 Mar 2002 09:49:54 -0500
Date: Mon, 18 Mar 2002 15:49:46 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: paulus@samba.org
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug
Message-ID: <20020318144946.GA7052@werewolf.able.es>
In-Reply-To: <15509.51214.495427.580341@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.03.18 Paul Mackerras wrote:
>Recently CERT published an advisory, warning about a bug in zlib where
>a chunk of memory could get freed twice, depending on the data being
>decompressed, which could potentially give a way to attack a system
>using zlib.  The reference is
>
>	http://www.cert.org/advisories/CA-2002-07.html
>
>All 3 of the versions of zlib in the current 2.4 kernel have this bug.
>The version in 2.5 doesn't because it handles memory allocation in a
>different way.
>
>The patch below fixes this bug in each of the three copies of zlib.c,
>in the same way that it is fixed in the zlib-1.1.4 release (basically
>by making sure that s->sub.trees.blens is always freed whenever, and
>only when, s->mode is changed from BTREE or DTREE to some other value).
>
>In the longer term I recommend that the 2.5.x changes to use a single
>copy of zlib in lib/zlib_{deflate,inflate} should be back-ported to
>2.4.  For now, this patch should be applied to 2.4.x since the bug is
>a potential security hole if you are using PPP with Deflate
>compression.
>

Someone posted it was here:

ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/shared-zlib/

The only rest it leaves in 19-pre3 are:

./arch/ppc/boot/lib/zlib.c
./arch/ppc/boot/include/zlib.h

Patch already does:

--- linux-2.4.19-pre2-ac2/arch/ppc/config.in    Sun Mar  3 18:54:31 2002
+++ linux-2.4.19-pre2-ac2-zlib/arch/ppc/config.in   Tue Mar  5 08:57:31 2002
@@ -396,6 +396,8 @@
    source net/bluetooth/Config.in
 fi
 
+source lib/Config.in
+  
 mainmenu_option next_comment
 comment 'Kernel hacking'
 

So wouldn't it be better to kill ppc/.../zlib and make it use also the
shared copy ?

BTW, it is the ONLY file in arch/ppc/boot/lib, so whole dir could be killed
(at least in standard tree, do not know in ppc branch...)


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Bluebird) for i586
Linux werewolf 2.4.19-pre3-jam3 #1 SMP Fri Mar 15 01:16:08 CET 2002 i686
