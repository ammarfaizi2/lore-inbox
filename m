Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUJRTCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUJRTCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUJRTCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:02:19 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:49500 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267521AbUJRTBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:01:01 -0400
Date: Mon, 18 Oct 2004 23:01:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: using cc-option in arch/ppc64/boot/Makefile
Message-ID: <20041018210128.GA16283@mars.ravnborg.org>
Mail-Followup-To: Hollis Blanchard <hollisb@us.ibm.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200410141611.32198.hollisb@us.ibm.com> <20041017095700.GB16186@mars.ravnborg.org> <200410181347.55746.hollisb@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410181347.55746.hollisb@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 01:47:55PM +0000, Hollis Blanchard wrote:
> On Sunday 17 October 2004 09:57, Sam Ravnborg wrote:
> > Something like this should do the trick?
> > You could also include everything in your Makefile but I prefer
> > Makefile.lib to make it a bit more general.
> 
> That's what I had tried. I'm having strange problems though. This patch:
> 
> --- 1.25/arch/ppc64/boot/Makefile       Sun Oct  3 12:23:50 2004
> +++ edited/arch/ppc64/boot/Makefile     Mon Oct 18 14:03:40 2004
> @@ -20,6 +20,8 @@
>  #      CROSS32_COMPILE is setup as a prefix just like CROSS_COMPILE
>  #      in the toplevel makefile.
> 
> +include scripts/Makefile.lib
> +
This is wrong. kbuild will include Makefile.lib for you.

>  CROSS32_COMPILE ?=
>  #CROSS32_COMPILE = /usr/local/ppc/bin/powerpc-linux-
> 
> @@ -72,7 +74,12 @@
>  quiet_cmd_stripvm = STRIP $@
>        cmd_stripvm = $(STRIP) -s $< -o $@
> 
> +HAS_BIARCH      := $(call cc-option-yn, -lalala)
so HAS_BIARCH will evaluate to 'n'

> +
>  vmlinux.strip: vmlinux FORCE
> +       echo $(cc-option-yn)
$(cc-option-yn) should not evaluate to 'y' - so you did something else wrong.
> +       echo $(HAS_BIARCH)
This should have been 'n' - but the 'y' is explained by the above bug.

> +       $(call cc-option-yn, -m64)
Here you try to execute 'y', this will fail.

>         $(call if_changed,stripvm)
>  $(obj)/vmlinux.initrd: vmlinux.strip $(obj)/addRamDisk 
> $(obj)/ramdisk.image.gz FORCE
>         $(call if_changed,ramdisk)
> 
> ... yields the following output:
> 
> make -f scripts/Makefile.build obj=arch/ppc64/boot arch/ppc64/boot/zImage
> echo y
> y
> echo y
> y
> y
> make[1]: y: Command not found

Skip the include of Mafilefile.lib and try again. If you still has troubles
try posting a complete diff.

	Sam
