Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269267AbUJQTdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269267AbUJQTdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269285AbUJQTdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:33:45 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:15734 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S269267AbUJQTdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:33:22 -0400
Date: Sun, 17 Oct 2004 23:33:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Cc: Martin Waitz <tali@admingilde.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1: initramfs build fix [u]
Message-ID: <20041017213334.GA8214@mars.ravnborg.org>
Mail-Followup-To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
	Martin Waitz <tali@admingilde.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20041011032502.299dc88d.akpm@osdl.org> <20041017161554.GD10532@admingilde.org> <1098034147.879.21.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098034147.879.21.camel@nosferatu.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin.

Can you submit a new version based on Linus' tree with the following modifications:
1) Propoer changelog
2) Document use of .shipped somewhere

And the following small comments.


>  # or set INITRAMFS_LIST to another filename.
> -INITRAMFS_LIST ?= $(obj)/initramfs_list
> +INITRAMFS_LIST := $(obj)/initramfs_list

Kbuild style is to reser all-uppercase to external visible variables.

>  # initramfs_data.o contains the initramfs_data.cpio.gz image.
>  # The image is included using .incbin, a dependency which is not
> @@ -23,6 +23,23 @@ $(obj)/initramfs_data.o: $(obj)/initramf
>  # Commented out for now
>  # initramfs-y := $(obj)/root/hello
>  
> +quiet_cmd_gen_list = GEN_INITRAMFS_LIST $@
Please aling output properly with rest of kbuild output.
> +quiet_cmd_gen_list = GEN     $@
Should be enough - the filename give some context as well

> +      cmd_gen_list = $(shell \
> +        if test -f "$(CONFIG_INITRAMFS_SOURCE)"; then \
> +	  if [ "$(CONFIG_INITRAMFS_SOURCE)" != $@ ]; then \
> +	    echo 'cp -f "$(CONFIG_INITRAMFS_SOURCE)" $@'; \
> +	  else \
> +	    echo 'cp -f "$(srctree)/$(INITRAMFS_LIST).shipped" $@'; \
Test for .shipped to be present first?


> +	  fi; \
> +	elif test -d "$(CONFIG_INITRAMFS_SOURCE)"; then \
> +	  echo 'scripts/gen_initramfs_list.sh "$(CONFIG_INITRAMFS_SOURCE)" > $@'; \
> +	else \
> +	  echo 'cp -f "$(srctree)/$(INITRAMFS_LIST).shipped" $@'; \
Same here.

> +	fi)
> +
> +$(INITRAMFS_LIST): FORCE
> +	$(call cmd,gen_list)

How do you secure that the list gets updated when some of the above logic changes?
Likewise avoid the list to be generated unles required.

	Sam
